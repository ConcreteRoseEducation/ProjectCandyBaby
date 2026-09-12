import { PoolClient } from "pg";
import { config } from "../config";
import { pool } from "../db/client";
import { StockRow } from "../types";
import { affectedStockIds, eventDeltaThisTick, loadActiveEvents, maybeFireRandomEvent, notifyPayload } from "./events";

function gaussian(): number {
  let u = 0;
  let v = 0;
  while (u === 0) u = Math.random();
  while (v === 0) v = Math.random();
  return Math.sqrt(-2.0 * Math.log(u)) * Math.cos(2.0 * Math.PI * v);
}

function clamp(value: number, min: number, max: number): number {
  return Math.min(max, Math.max(min, value));
}

function candleBucket(date: Date, timeframe: string): Date {
  const ms = date.getTime();
  const sizes: Record<string, number> = {
    "1m": 60_000,
    "5m": 5 * 60_000,
    "1h": 60 * 60_000,
    "1d": 24 * 60 * 60_000,
  };
  const size = sizes[timeframe] ?? 60_000;
  return new Date(Math.floor(ms / size) * size);
}

async function upsertCandle(
  client: PoolClient,
  stockId: number,
  price: number,
  volume: number,
  ts: Date,
  timeframe: string,
): Promise<void> {
  const bucket = candleBucket(ts, timeframe);
  await client.query(
    `INSERT INTO price_candles (stock_id, bucket_start, timeframe, open, high, low, close, volume)
     VALUES ($1, $2, $3, $4, $4, $4, $4, $5)
     ON CONFLICT (stock_id, timeframe, bucket_start)
     DO UPDATE SET
       high = GREATEST(price_candles.high, EXCLUDED.high),
       low = LEAST(price_candles.low, EXCLUDED.low),
       close = EXCLUDED.close,
       volume = price_candles.volume + EXCLUDED.volume`,
    [stockId, bucket.toISOString(), timeframe, price, volume],
  );
}

export async function seedPriceHistoryIfEmpty(): Promise<void> {
  await pool.query("SELECT pg_advisory_lock(872342)");
  try {
    const existing = await pool.query("SELECT 1 FROM price_ticks LIMIT 1");
    if ((existing.rowCount ?? 0) > 0) {
      return;
    }

    const stocks = await pool.query<StockRow>(
      `SELECT s.*, sec.key AS sector_key, sec.display_name AS sector_name
       FROM stocks s JOIN sectors sec ON sec.id = s.sector_id`,
    );
    const client = await pool.connect();
    try {
      await client.query("BEGIN");
      const now = Date.now();
      for (const stock of stocks.rows) {
        let price = stock.base_price;
        for (let i = 20; i >= 1; i--) {
          const change = gaussian() * 0.01;
          price = Math.max(0.01, price * (1 + change));
          const ts = new Date(now - i * 60_000);
          const volume = 80 + Math.random() * 40;
          await client.query(
            "INSERT INTO price_ticks (stock_id, ts, price, volume) VALUES ($1, $2, $3, $4)",
            [stock.id, ts.toISOString(), price, volume],
          );
          await upsertCandle(client, stock.id, price, volume, ts, "1m");
        }
        await client.query("UPDATE stocks SET current_price = $1 WHERE id = $2", [price, stock.id]);
      }
      await client.query("COMMIT");
      console.log("Seeded initial price history");
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  } finally {
    await pool.query("SELECT pg_advisory_unlock(872342)");
  }
}

export async function tickMarket(): Promise<void> {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const state = await client.query<{ market_factor: number; global_volatility: number }>(
      "SELECT market_factor, global_volatility FROM market_state WHERE id = 1 FOR UPDATE",
    );
    const market = state.rows[0];
    const marketShock = gaussian() * 0.008 * market.global_volatility;
    const nextMarketFactor = market.market_factor * 0.7 + marketShock * 0.3;

    const sectors = await client.query<{ sector_id: number; factor: number; volatility: number }>(
      "SELECT sector_id, factor, volatility FROM sector_state FOR UPDATE",
    );
    const sectorShockById = new Map<number, number>();
    for (const sector of sectors.rows) {
      const shock = gaussian() * sector.volatility * market.global_volatility;
      const nextFactor = sector.factor * 0.7 + shock * 0.3;
      sectorShockById.set(sector.sector_id, nextFactor);
      await client.query("UPDATE sector_state SET factor = $1 WHERE sector_id = $2", [
        nextFactor,
        sector.sector_id,
      ]);
    }

    const maybeEvent = await maybeFireRandomEvent(client, config.eventChancePerTick);
    const activeEvents = await loadActiveEvents(client);
    const eventDeltaByStock = new Map<number, number>();
    const appliedEffects: Array<{ eventId: number; stockId: number; delta: number }> = [];

    for (const event of activeEvents) {
      const delta = eventDeltaThisTick(event);
      const stockIds = await affectedStockIds(client, event);
      for (const stockId of stockIds) {
        eventDeltaByStock.set(stockId, (eventDeltaByStock.get(stockId) ?? 0) + delta);
        appliedEffects.push({ eventId: event.id, stockId, delta });
      }
      await client.query(
        "UPDATE events SET remaining_ticks = remaining_ticks - 1 WHERE id = $1",
        [event.id],
      );
    }

    const stocks = await client.query<StockRow>(
      `SELECT s.*, sec.key AS sector_key, sec.display_name AS sector_name
       FROM stocks s JOIN sectors sec ON sec.id = s.sector_id
       WHERE s.is_active = TRUE
       FOR UPDATE OF s`,
    );

    const now = new Date();
    const updates: Array<{
      symbol: string;
      name: string;
      sector: string;
      currentPrice: number;
      previousPrice: number;
      changePct: number;
    }> = [];

    for (const stock of stocks.rows) {
      const idioShock = gaussian() * stock.volatility * market.global_volatility;
      const nextVol = clamp(0.85 * stock.volatility + 0.15 * Math.abs(idioShock) + 0.004, 0.008, 0.06);
      const meanReversion = 0.015 * ((stock.base_price - stock.current_price) / stock.base_price);
      const sectorFactor = sectorShockById.get(stock.sector_id) ?? 0;
      const eventDelta = eventDeltaByStock.get(stock.id) ?? 0;
      const change = clamp(
        nextMarketFactor + sectorFactor + idioShock + meanReversion + eventDelta,
        -config.circuitBreaker,
        config.circuitBreaker,
      );
      const newPrice = Math.max(0.01, stock.current_price * (1 + change));
      const volume = Math.max(10, 100 + gaussian() * 25 + Math.abs(change) * 800);

      await client.query(
        "UPDATE stocks SET current_price = $1, volatility = $2 WHERE id = $3",
        [newPrice, nextVol, stock.id],
      );
      await client.query(
        "INSERT INTO price_ticks (stock_id, ts, price, volume) VALUES ($1, $2, $3, $4)",
        [stock.id, now.toISOString(), newPrice, volume],
      );
      for (const timeframe of ["1m", "5m", "1h", "1d"]) {
        await upsertCandle(client, stock.id, newPrice, volume, now, timeframe);
      }

      updates.push({
        symbol: stock.symbol,
        name: stock.name,
        sector: stock.sector_name,
        currentPrice: Number(newPrice.toFixed(4)),
        previousPrice: Number(stock.current_price.toFixed(4)),
        changePct: Number((change * 100).toFixed(3)),
      });
    }

    for (const effect of appliedEffects) {
      await client.query(
        "INSERT INTO event_effects (event_id, stock_id, applied_at, price_delta) VALUES ($1, $2, $3, $4)",
        [effect.eventId, effect.stockId, now.toISOString(), effect.delta],
      );
    }

    await client.query(
      "UPDATE market_state SET market_factor = $1, last_tick_at = $2 WHERE id = 1",
      [nextMarketFactor, now.toISOString()],
    );

    await snapshotPortfolios(client, now);
    await client.query("COMMIT");

    await notifyPayload("market_tick", { type: "tick", stocks: updates, at: now.toISOString() });
    if (maybeEvent) {
      await notifyPayload("market_event", { type: "event", event: maybeEvent });
    }
    console.log(`Market ticked ${updates.length} stocks${maybeEvent ? ` + event: ${maybeEvent.title}` : ""}`);
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
}

async function snapshotPortfolios(client: PoolClient, ts: Date): Promise<void> {
  await client.query(
    `INSERT INTO portfolio_snapshots (user_id, ts, total_value)
     SELECT u.id, $1,
       u.sugar_coins + COALESCE(SUM(h.quantity * s.current_price), 0)
     FROM users u
     LEFT JOIN holdings h ON h.user_id = u.id
     LEFT JOIN stocks s ON s.id = h.stock_id
     GROUP BY u.id, u.sugar_coins`,
    [ts.toISOString()],
  );
}

export async function listStocks(): Promise<StockRow[]> {
  return (await pool.query<StockRow>(
    `SELECT s.id, s.symbol, s.name, s.sector_id, sec.key AS sector_key, sec.display_name AS sector_name,
            s.base_price, s.current_price, s.description, s.is_active, s.volatility
     FROM stocks s
     JOIN sectors sec ON sec.id = s.sector_id
     WHERE s.is_active = TRUE
     ORDER BY s.symbol`,
  )).rows;
}

export async function getStock(symbol: string): Promise<StockRow | undefined> {
  const result = await pool.query<StockRow>(
    `SELECT s.id, s.symbol, s.name, s.sector_id, sec.key AS sector_key, sec.display_name AS sector_name,
            s.base_price, s.current_price, s.description, s.is_active, s.volatility
     FROM stocks s
     JOIN sectors sec ON sec.id = s.sector_id
     WHERE s.symbol = $1`,
    [symbol.toUpperCase()],
  );
  return result.rows[0];
}

export async function getCandles(symbol: string, timeframe = "1m", limit = 60) {
  return (
    await pool.query(
      `SELECT c.bucket_start, c.timeframe, c.open, c.high, c.low, c.close, c.volume
       FROM price_candles c
       JOIN stocks s ON s.id = c.stock_id
       WHERE s.symbol = $1 AND c.timeframe = $2
       ORDER BY c.bucket_start DESC
       LIMIT $3`,
      [symbol.toUpperCase(), timeframe, limit],
    )
  ).rows.reverse();
}

export async function getRecentTicks(symbol: string, limit = 50) {
  return (
    await pool.query(
      `SELECT t.ts, t.price, t.volume
       FROM price_ticks t
       JOIN stocks s ON s.id = t.stock_id
       WHERE s.symbol = $1
       ORDER BY t.ts DESC
       LIMIT $2`,
      [symbol.toUpperCase(), limit],
    )
  ).rows.reverse();
}

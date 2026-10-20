import path from "node:path";
import cors from "cors";
import express from "express";
import http from "node:http";
import { requireAdmin } from "./auth";
import { config } from "./config";
import { queryOne, waitForDatabase } from "./db/client";
import { migrate } from "./db/migrate";
import { fireCustomEvent, fireTemplateById, getTemplateCatalog, listEvents, notifyPayload } from "./engine/events";
import { getCandles, getRecentTicks, getStock, getServerType, setServerType, listStocks, seedPriceHistoryIfEmpty, tickMarket } from "./engine/market";
import { attachRealtime } from "./realtime";
import { authRouter } from "./routes/auth";
import { economyRouter } from "./routes/economy";

async function main(): Promise<void> {
  await waitForDatabase();
  await migrate();
  await seedPriceHistoryIfEmpty();

  const app = express();
  app.use(cors());
  app.use(express.json());
  app.use(express.static(path.join(__dirname, "../public")));

  app.get("/", (_req, res) => {
    res.redirect("/admin.html");
  });

  app.get("/health", async (_req, res) => {
    const state = await queryOne<{ last_tick_at: Date | null; global_volatility: number }>(
      "SELECT last_tick_at, global_volatility FROM market_state WHERE id = 1",
    );
    const serverType = await getServerType();
    res.json({
      ok: true,
      service: "sugar-market",
      lastTickAt: state?.last_tick_at ?? null,
      globalVolatility: state?.global_volatility ?? 1,
      serverType,
      tickIntervalMs: config.tickIntervalMs,
      authMode: config.authMode,
    });
  });

  app.get("/stocks", async (_req, res) => {
    const stocks = await listStocks();
    const serverType = await getServerType();
    res.json({
      serverType,
      stocks: stocks.map((stock) => ({
        symbol: stock.symbol,
        name: stock.name,
        sector: stock.sector_name,
        sectorKey: stock.sector_key,
        basePrice: stock.base_price,
        currentPrice: stock.current_price,
        description: stock.description,
        priceHistory: stock.priceHistory,
      })),
    });
  });

  app.get("/stocks/:symbol", async (req, res) => {
    const stock = await getStock(String(req.params.symbol));
    if (!stock) {
      res.status(404).json({ error: "Stock not found" });
      return;
    }
    const ticks = await getRecentTicks(stock.symbol, 50);
    const serverType = await getServerType();
    res.json({
      symbol: stock.symbol,
      name: stock.name,
      sector: stock.sector_name,
      sectorKey: stock.sector_key,
      basePrice: stock.base_price,
      currentPrice: stock.current_price,
      description: stock.description,
      priceHistory: ticks.map((tick) => Number(tick.price)),
      ticks,
      serverType,
    });
  });

  app.get("/stocks/:symbol/candles", async (req, res) => {
    const timeframe = String(req.query.timeframe ?? "1m");
    const limit = Number(req.query.limit ?? 60);
    if (!["1m", "5m", "1h", "1d"].includes(timeframe)) {
      res.status(400).json({ error: "timeframe must be 1m, 5m, 1h, or 1d" });
      return;
    }
    const stock = await getStock(String(req.params.symbol));
    if (!stock) {
      res.status(404).json({ error: "Stock not found" });
      return;
    }
    const candles = await getCandles(stock.symbol, timeframe, Number.isFinite(limit) ? limit : 60);
    res.json({ symbol: stock.symbol, timeframe, candles });
  });

  app.get("/events", async (_req, res) => {
    const events = await listEvents(50);
    res.json({ events });
  });

  app.get("/admin/event-templates", requireAdmin, async (_req, res) => {
    res.json({ templates: await getTemplateCatalog() });
  });

  app.post("/admin/events", requireAdmin, async (req, res) => {
    const templateId = req.body?.templateId ? String(req.body.templateId) : null;
    const title = req.body?.title ? String(req.body.title) : null;

    try {
      let event;
      if (templateId) {
        event = await fireTemplateById(templateId, "admin");
      } else if (title) {
        const scope = String(req.body?.scope ?? "market") as "stock" | "sector" | "market";
        const narrative = String(req.body?.narrative ?? title);
        const targetKey = req.body?.targetKey ? String(req.body.targetKey) : undefined;
        const magnitude = Number(req.body?.magnitude ?? 0.05);
        const durationTicks = Number(req.body?.durationTicks ?? 4);

        event = await fireCustomEvent(
          {
            title,
            narrative,
            scope,
            targetKey,
            magnitude,
            durationTicks,
          },
          "admin",
        );
      } else {
        res.status(400).json({ error: "Either templateId or title is required" });
        return;
      }

      await notifyPayload("market_event", { type: "event", event });
      res.status(201).json({ event });
    } catch (error) {
      res.status(400).json({ error: error instanceof Error ? error.message : "Failed to fire event" });
    }
  });

  app.get("/admin/server-type", requireAdmin, async (_req, res) => {
    const serverType = await getServerType();
    res.json({ serverType });
  });

  app.post("/admin/server-type", requireAdmin, async (req, res) => {
    const serverType = String(req.body?.serverType ?? "").toLowerCase();
    if (serverType !== "public" && serverType !== "private") {
      res.status(400).json({ error: "serverType must be 'public' or 'private'" });
      return;
    }
    await setServerType(serverType as "public" | "private");
    res.json({ serverType });
  });

  app.post("/admin/volatility", requireAdmin, async (req, res) => {
    const value = Number(req.body?.globalVolatility);
    if (!Number.isFinite(value) || value < 0.2 || value > 5) {
      res.status(400).json({ error: "globalVolatility must be between 0.2 and 5" });
      return;
    }
    await queryOne("UPDATE market_state SET global_volatility = $1 WHERE id = 1", [value]);
    res.json({ globalVolatility: value });
  });

  app.post("/admin/tick", requireAdmin, async (_req, res) => {
    try {
      await tickMarket();
      res.json({ ok: true, message: "Market ticked successfully" });
    } catch (error) {
      res.status(500).json({ error: error instanceof Error ? error.message : "Failed to tick market" });
    }
  });

  app.use(authRouter);
  app.use(economyRouter);

  // Background ticker loop (ticks every config.tickIntervalMs regardless of trades)
  console.log(`Starting background market ticker (interval: ${config.tickIntervalMs}ms / ${Math.round(config.tickIntervalMs / 1000)}s)`);
  setInterval(() => {
    tickMarket().catch((error) => {
      console.error("Scheduled market tick failed", error);
    });
  }, config.tickIntervalMs);

  const server = http.createServer(app);
  attachRealtime(server);

  server.listen(config.port, "0.0.0.0", () => {
    console.log(`Sugar Market API listening on :${config.port}`);
  });
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});

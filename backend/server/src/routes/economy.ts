import { Router } from "express";
import { pool, withTransaction } from "../db/client";
import { AuthedRequest, requireAuth } from "../auth";
import { TradeType, UserRow } from "../types";
import { config } from "../config";
import { upsertCandle } from "../engine/market";
import { notifyPayload } from "../engine/events";

export const economyRouter = Router();

function sanitizeProfile(row: UserRow) {
  const isMinor = row.is_child_account || (row.age != null && row.age < 13);
  return {
    id: row.id,
    displayName: row.display_name,
    username: row.username,
    fullName: row.full_name,
    // Do NOT expose listed age if under 13 (signify minor's account instead)
    age: isMinor ? null : row.age,
    isChildAccount: isMinor,
    accountType: isMinor ? "minor" : "standard",
    sugarCoins: Number(row.sugar_coins),
  };
}

economyRouter.get("/portfolio", requireAuth, async (req: AuthedRequest, res) => {
  const user = req.user!;
  const holdings = await pool.query(
    `SELECT s.symbol, s.name, sec.display_name AS sector, h.quantity, h.avg_purchase_price,
            s.current_price,
            (s.current_price - h.avg_purchase_price) * h.quantity AS profit_loss
     FROM holdings h
     JOIN stocks s ON s.id = h.stock_id
     JOIN sectors sec ON sec.id = s.sector_id
     WHERE h.user_id = $1
     ORDER BY s.symbol`,
    [user.id],
  );
  const holdingsValue = holdings.rows.reduce(
    (sum, row) => sum + Number(row.quantity) * Number(row.current_price),
    0,
  );
  res.json({
    user: sanitizeProfile(user),
    holdings: holdings.rows,
    holdingsValue,
    totalValue: Number(user.sugar_coins) + holdingsValue,
  });
});

economyRouter.get(["/profile", "/users/profile"], requireAuth, async (req: AuthedRequest, res) => {
  const user = req.user!;
  res.json({
    profile: sanitizeProfile(user),
  });
});

economyRouter.post(["/profile", "/users/profile", "/users"], requireAuth, async (req: AuthedRequest, res) => {
  const user = req.user!;
  const username = req.body?.username ? String(req.body.username).trim() : null;
  const fullName = req.body?.fullName ? String(req.body.fullName).trim() : null;
  const age = req.body?.age != null && req.body?.age !== "" ? Number(req.body.age) : null;

  if (username && !/^[a-zA-Z0-9_]{3,20}$/.test(username)) {
    res.status(400).json({ error: "Username must be 3-20 alphanumeric characters or underscores" });
    return;
  }

  if (username) {
    const existingUsername = await pool.query<{ id: number }>(
      "SELECT id FROM users WHERE LOWER(username) = LOWER($1) AND id != $2",
      [username, user.id],
    );
    if ((existingUsername.rowCount ?? 0) > 0) {
      res.status(400).json({ error: "Username is already taken by another trader" });
      return;
    }
  }

  if (age != null && (!Number.isInteger(age) || age < 5 || age > 120)) {
    res.status(400).json({ error: "Age must be between 5 and 120" });
    return;
  }

  const isChildAccount = age != null ? age < 13 : false;
  const displayName = username || fullName || user.display_name;

  try {
    const updated = await pool.query<UserRow>(
      `UPDATE users
       SET username = COALESCE($1, username),
           full_name = COALESCE($2, full_name),
           age = COALESCE($3, age),
           is_child_account = $4,
           display_name = COALESCE($5, display_name)
       WHERE id = $6
       RETURNING id, firebase_uid, display_name, username, full_name, age, is_child_account, sugar_coins`,
      [username, fullName, age, isChildAccount, displayName, user.id],
    );

    res.json({
      profile: sanitizeProfile(updated.rows[0]),
    });
  } catch (error) {
    res.status(400).json({ error: error instanceof Error ? error.message : "Profile update failed" });
  }
});

economyRouter.post("/trades", requireAuth, async (req: AuthedRequest, res) => {
  const user = req.user!;
  const symbol = String(req.body?.symbol ?? "").toUpperCase();
  const type = String(req.body?.type ?? "").toUpperCase() as TradeType;
  const quantity = Number(req.body?.quantity);

  if (!symbol || (type !== "BUY" && type !== "SELL") || !Number.isInteger(quantity) || quantity <= 0) {
    res.status(400).json({ error: "Expected { symbol, type: BUY|SELL, quantity }" });
    return;
  }

  try {
    const result = await withTransaction(async (client) => {
      const stock = await client.query(
        `SELECT s.id, s.symbol, s.name, s.current_price, sec.display_name AS sector_name
         FROM stocks s
         JOIN sectors sec ON sec.id = s.sector_id
         WHERE s.symbol = $1 AND s.is_active = TRUE FOR UPDATE OF s`,
        [symbol],
      );
      if (!stock.rows[0]) {
        throw new Error("Unknown stock");
      }
      const price = Number(stock.rows[0].current_price);
      const stockId = stock.rows[0].id as number;
      const cost = price * quantity;

      const userRow = await client.query(
        "SELECT sugar_coins FROM users WHERE id = $1 FOR UPDATE",
        [user.id],
      );
      const balance = Number(userRow.rows[0].sugar_coins);

      if (type === "BUY") {
        if (balance < cost) {
          throw new Error("Not enough Sugar Coins");
        }
        await client.query("UPDATE users SET sugar_coins = sugar_coins - $1 WHERE id = $2", [
          cost,
          user.id,
        ]);
        const existing = await client.query(
          "SELECT quantity, avg_purchase_price FROM holdings WHERE user_id = $1 AND stock_id = $2",
          [user.id, stockId],
        );
        if (existing.rows[0]) {
          const oldQty = Number(existing.rows[0].quantity);
          const oldAvg = Number(existing.rows[0].avg_purchase_price);
          const newQty = oldQty + quantity;
          const newAvg = (oldAvg * oldQty + cost) / newQty;
          await client.query(
            "UPDATE holdings SET quantity = $1, avg_purchase_price = $2 WHERE user_id = $3 AND stock_id = $4",
            [newQty, newAvg, user.id, stockId],
          );
        } else {
          await client.query(
            "INSERT INTO holdings (user_id, stock_id, quantity, avg_purchase_price) VALUES ($1, $2, $3, $4)",
            [user.id, stockId, quantity, price],
          );
        }
      } else {
        const existing = await client.query(
          "SELECT quantity FROM holdings WHERE user_id = $1 AND stock_id = $2 FOR UPDATE",
          [user.id, stockId],
        );
        const owned = Number(existing.rows[0]?.quantity ?? 0);
        if (owned < quantity) {
          throw new Error("Not enough shares");
        }
        await client.query("UPDATE users SET sugar_coins = sugar_coins + $1 WHERE id = $2", [
          cost,
          user.id,
        ]);
        const remaining = owned - quantity;
        if (remaining > 0) {
          await client.query(
            "UPDATE holdings SET quantity = $1 WHERE user_id = $2 AND stock_id = $3",
            [remaining, user.id, stockId],
          );
        } else {
          await client.query("DELETE FROM holdings WHERE user_id = $1 AND stock_id = $2", [
            user.id,
            stockId,
          ]);
        }
      }

      await client.query(
        `INSERT INTO transactions (user_id, stock_id, type, quantity, price_per_unit)
         VALUES ($1, $2, $3, $4, $5)`,
        [user.id, stockId, type, quantity, price],
      );

      // Real-time stock price update based on player buy & sell data
      const stateRow = await client.query<{ server_type: string }>(
        "SELECT COALESCE(server_type, 'public') AS server_type FROM market_state WHERE id = 1",
      );
      const serverType = (stateRow.rows[0]?.server_type ?? config.serverType) as "public" | "private";
      const impactPerShare = serverType === "private" ? config.privateImpactPerShare : config.publicImpactPerShare;
      const tradeImpactPct = (type === "BUY" ? 1 : -1) * quantity * impactPerShare;
      const newPrice = Math.max(0.01, Number((price * (1 + tradeImpactPct)).toFixed(4)));

      const buyVol = type === "BUY" ? quantity : 0;
      const sellVol = type === "SELL" ? quantity : 0;

      await client.query(
        `UPDATE stocks
         SET current_price = $1,
             pending_buy_volume = pending_buy_volume + $2,
             pending_sell_volume = pending_sell_volume + $3
         WHERE id = $4`,
        [newPrice, buyVol, sellVol, stockId],
      );

      const now = new Date();
      await client.query(
        "INSERT INTO price_ticks (stock_id, ts, price, volume) VALUES ($1, $2, $3, $4)",
        [stockId, now.toISOString(), newPrice, quantity],
      );
      for (const tf of ["1m", "5m", "1h", "1d"]) {
        await upsertCandle(client, stockId, newPrice, quantity, now, tf);
      }

      const updatePayload = {
        type: "tick",
        stocks: [
          {
            symbol: stock.rows[0].symbol,
            name: stock.rows[0].name,
            sector: stock.rows[0].sector_name,
            currentPrice: newPrice,
            previousPrice: price,
            changePct: Number((tradeImpactPct * 100).toFixed(3)),
          },
        ],
        at: now.toISOString(),
      };

      return {
        trade: { symbol, type, quantity, pricePerUnit: price, cost, newPrice },
        updatePayload,
      };
    });

    await notifyPayload("market_tick", result.updatePayload);
    res.status(201).json(result.trade);
  } catch (error) {
    res.status(400).json({ error: error instanceof Error ? error.message : "Trade failed" });
  }
});

economyRouter.get("/leaderboard", async (_req, res) => {
  const rows = await pool.query(
    `SELECT COALESCE(NULLIF(u.username, ''), u.display_name, 'Trader') AS display_name,
            u.sugar_coins + COALESCE(SUM(h.quantity * s.current_price), 0) AS total_value,
            u.sugar_coins
     FROM users u
     LEFT JOIN holdings h ON h.user_id = u.id
     LEFT JOIN stocks s ON s.id = h.stock_id
     WHERE u.firebase_uid != 'dev:guest'
     GROUP BY u.id, u.display_name, u.username, u.sugar_coins
     ORDER BY total_value DESC
     LIMIT 25`,
  );
  res.json({ leaderboard: rows.rows });
});

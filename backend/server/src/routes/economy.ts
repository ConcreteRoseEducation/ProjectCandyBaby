import { Router } from "express";
import { pool, withTransaction } from "../db/client";
import { AuthedRequest, requireAuth } from "../auth";
import { TradeType } from "../types";

export const economyRouter = Router();

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
    user: {
      id: user.id,
      displayName: user.display_name,
      sugarCoins: Number(user.sugar_coins),
    },
    holdings: holdings.rows,
    holdingsValue,
    totalValue: Number(user.sugar_coins) + holdingsValue,
  });
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
        "SELECT id, symbol, current_price FROM stocks WHERE symbol = $1 AND is_active = TRUE FOR UPDATE",
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

      return { symbol, type, quantity, pricePerUnit: price, cost };
    });
    res.status(201).json(result);
  } catch (error) {
    res.status(400).json({ error: error instanceof Error ? error.message : "Trade failed" });
  }
});

economyRouter.get("/leaderboard", async (_req, res) => {
  const rows = await pool.query(
    `SELECT u.display_name,
            u.sugar_coins + COALESCE(SUM(h.quantity * s.current_price), 0) AS total_value,
            u.sugar_coins
     FROM users u
     LEFT JOIN holdings h ON h.user_id = u.id
     LEFT JOIN stocks s ON s.id = h.stock_id
     GROUP BY u.id, u.display_name, u.sugar_coins
     ORDER BY total_value DESC
     LIMIT 25`,
  );
  res.json({ leaderboard: rows.rows });
});

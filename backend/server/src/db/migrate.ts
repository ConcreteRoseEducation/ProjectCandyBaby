import fs from "node:fs";
import path from "node:path";
import { pool } from "./client";

export async function migrate(): Promise<void> {
  await pool.query("SELECT pg_advisory_lock(872341)");
  try {
    await pool.query(`
      CREATE TABLE IF NOT EXISTS schema_migrations (
        id TEXT PRIMARY KEY,
        applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
      )
    `);

    const migrationsDir = path.join(__dirname, "../../migrations");
    const files = fs.readdirSync(migrationsDir).filter((file) => file.endsWith(".sql")).sort();

    for (const file of files) {
      const applied = await pool.query("SELECT 1 FROM schema_migrations WHERE id = $1", [file]);
      if ((applied.rowCount ?? 0) > 0) {
        continue;
      }

      const sql = fs.readFileSync(path.join(migrationsDir, file), "utf8");
      const client = await pool.connect();
      try {
        await client.query("BEGIN");
        await client.query(sql);
        await client.query("INSERT INTO schema_migrations (id) VALUES ($1)", [file]);
        await client.query("COMMIT");
        console.log(`Applied migration ${file}`);
      } catch (error) {
        await client.query("ROLLBACK");
        throw error;
      } finally {
        client.release();
      }
    }
  } finally {
    await pool.query("SELECT pg_advisory_unlock(872341)");
  }
}

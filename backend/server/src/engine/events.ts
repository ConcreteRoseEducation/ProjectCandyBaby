import { PoolClient } from "pg";
import { query } from "../db/client";
import { EventRow } from "../types";
import { EVENT_TEMPLATES, EventTemplate, pickWeightedTemplate } from "./templates";

export async function listEvents(limit = 50): Promise<EventRow[]> {
  return query<EventRow>(
    `SELECT id, type, scope, target_id, title, narrative, magnitude, decay_type,
            duration_ticks, remaining_ticks, starts_at, created_by
     FROM events
     ORDER BY starts_at DESC
     LIMIT $1`,
    [limit],
  );
}

export async function fireTemplate(
  client: PoolClient,
  template: EventTemplate,
  createdBy: string,
): Promise<EventRow> {
  let targetId: number | null = null;
  if (template.scope === "stock" && template.targetKey) {
    const stock = await client.query<{ id: number }>(
      "SELECT id FROM stocks WHERE symbol = $1",
      [template.targetKey],
    );
    targetId = stock.rows[0]?.id ?? null;
  }
  if (template.scope === "sector" && template.targetKey) {
    const sector = await client.query<{ id: number }>(
      "SELECT id FROM sectors WHERE key = $1",
      [template.targetKey],
    );
    targetId = sector.rows[0]?.id ?? null;
  }

  const inserted = await client.query<EventRow>(
    `INSERT INTO events
      (type, scope, target_id, title, narrative, magnitude, decay_type, duration_ticks, remaining_ticks, created_by)
     VALUES ($1, $2, $3, $4, $5, $6, 'linear', $7, $7, $8)
     RETURNING *`,
    [
      template.type,
      template.scope,
      targetId,
      template.title,
      template.narrative,
      template.magnitude,
      template.durationTicks,
      createdBy,
    ],
  );
  return inserted.rows[0];
}

export async function maybeFireRandomEvent(
  client: PoolClient,
  chance: number,
): Promise<EventRow | null> {
  if (Math.random() > chance) {
    return null;
  }
  return fireTemplate(client, pickWeightedTemplate(), "system");
}

export async function fireTemplateById(templateId: string, createdBy: string): Promise<EventRow> {
  const template = EVENT_TEMPLATES.find((item) => item.id === templateId);
  if (!template) {
    throw new Error(`Unknown event template: ${templateId}`);
  }
  const { pool } = await import("../db/client");
  const client = await pool.connect();
  try {
    await client.query("BEGIN");
    const event = await fireTemplate(client, template, createdBy);
    await client.query("COMMIT");
    return event;
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
}

export async function loadActiveEvents(client: PoolClient): Promise<EventRow[]> {
  const result = await client.query<EventRow>(
    `SELECT * FROM events WHERE remaining_ticks > 0 ORDER BY id`,
  );
  return result.rows;
}

export async function affectedStockIds(
  client: PoolClient,
  event: EventRow,
): Promise<number[]> {
  if (event.scope === "market") {
    const rows = await client.query<{ id: number }>("SELECT id FROM stocks WHERE is_active = TRUE");
    return rows.rows.map((row) => row.id);
  }
  if (event.scope === "sector" && event.target_id != null) {
    const rows = await client.query<{ id: number }>(
      "SELECT id FROM stocks WHERE is_active = TRUE AND sector_id = $1",
      [event.target_id],
    );
    return rows.rows.map((row) => row.id);
  }
  if (event.scope === "stock" && event.target_id != null) {
    return [event.target_id];
  }
  return [];
}

export function eventDeltaThisTick(event: EventRow): number {
  if (event.duration_ticks <= 0) {
    return 0;
  }
  return event.magnitude / event.duration_ticks;
}

export { EVENT_TEMPLATES };

export async function getTemplateCatalog() {
  return EVENT_TEMPLATES.map((template) => ({
    id: template.id,
    type: template.type,
    scope: template.scope,
    targetKey: template.targetKey ?? null,
    title: template.title,
    narrative: template.narrative,
    magnitude: template.magnitude,
    durationTicks: template.durationTicks,
  }));
}

export async function notifyPayload(channel: string, payload: unknown): Promise<void> {
  await query(`SELECT pg_notify($1, $2)`, [channel, JSON.stringify(payload)]);
}

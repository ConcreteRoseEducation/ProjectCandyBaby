import type { NextFunction, Request, Response } from "express";
import { config } from "./config";
import { queryOne } from "./db/client";
import { UserRow } from "./types";

export type AuthedRequest = Request & { user?: UserRow };

let firebaseReady = false;

async function initFirebase(): Promise<void> {
  if (firebaseReady || config.authMode !== "firebase") {
    return;
  }
  const admin = await import("firebase-admin");
  if (admin.apps.length === 0) {
    admin.initializeApp({
      projectId: config.firebaseProjectId || undefined,
    });
  }
  firebaseReady = true;
}

export async function ensureUser(firebaseUid: string, displayName?: string | null): Promise<UserRow> {
  const existing = await queryOne<UserRow>(
    "SELECT id, firebase_uid, display_name, sugar_coins FROM users WHERE firebase_uid = $1",
    [firebaseUid],
  );
  if (existing) {
    return existing;
  }
  const created = await queryOne<UserRow>(
    `INSERT INTO users (firebase_uid, display_name, sugar_coins)
     VALUES ($1, $2, $3)
     RETURNING id, firebase_uid, display_name, sugar_coins`,
    [firebaseUid, displayName ?? firebaseUid, config.startingSugarCoins],
  );
  if (!created) {
    throw new Error("Failed to create user");
  }
  return created;
}

export async function optionalAuth(req: AuthedRequest, _res: Response, next: NextFunction): Promise<void> {
  try {
    req.user = await resolveUser(req);
    next();
  } catch {
    next();
  }
}

export async function requireAuth(req: AuthedRequest, res: Response, next: NextFunction): Promise<void> {
  try {
    const user = await resolveUser(req);
    if (!user) {
      res.status(401).json({ error: "Authentication required" });
      return;
    }
    req.user = user;
    next();
  } catch (error) {
    res.status(401).json({ error: error instanceof Error ? error.message : "Authentication failed" });
  }
}

export function requireAdmin(req: Request, res: Response, next: NextFunction): void {
  const token = req.header("x-admin-token") ?? "";
  if (!config.adminToken || token !== config.adminToken) {
    res.status(403).json({ error: "Admin token required" });
    return;
  }
  next();
}

async function resolveUser(req: Request): Promise<UserRow | undefined> {
  if (config.authMode === "dev") {
    const devUser = req.header("x-dev-user") ?? "guest";
    const displayName = req.header("x-dev-name") ?? devUser;
    return ensureUser(`dev:${devUser}`, displayName);
  }

  const header = req.header("authorization") ?? "";
  const token = header.startsWith("Bearer ") ? header.slice(7) : "";
  if (!token) {
    return undefined;
  }
  await initFirebase();
  const admin = await import("firebase-admin");
  const decoded = await admin.auth().verifyIdToken(token);
  return ensureUser(decoded.uid, decoded.name ?? decoded.email ?? decoded.uid);
}

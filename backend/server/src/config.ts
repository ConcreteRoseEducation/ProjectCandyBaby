import dotenv from "dotenv";

dotenv.config();

function required(name: string, fallback?: string): string {
  const value = process.env[name] ?? fallback;
  if (!value) {
    throw new Error(`Missing required environment variable: ${name}`);
  }
  return value;
}

export const config = {
  port: Number(process.env.PORT ?? 3000),
  databaseUrl: required("DATABASE_URL", "postgres://candybaby:candybaby@localhost:5432/candybaby"),
  authMode: (process.env.AUTH_MODE ?? "dev") as "dev" | "firebase",
  adminToken: process.env.ADMIN_TOKEN ?? "changeme",
  firebaseProjectId: process.env.FIREBASE_PROJECT_ID ?? "",
  tickIntervalMs: Number(process.env.TICK_INTERVAL_MS ?? 30_000),
  eventChancePerTick: Number(process.env.EVENT_CHANCE_PER_TICK ?? 0.08),
  startingSugarCoins: Number(process.env.STARTING_SUGAR_COINS ?? 1000),
  circuitBreaker: Number(process.env.CIRCUIT_BREAKER ?? 0.05),
};

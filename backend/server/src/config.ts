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
  databaseUrl: required("DATABASE_URL", "postgresql://postgres:1Take2legs34@db.utndncqonkdexhxbrzua.supabase.co:5432/postgres"),
  supabaseUrl: process.env.SUPABASE_URL ?? "https://utndncqonkdexhxbrzua.supabase.co",
  supabaseAnonKey: process.env.SUPABASE_ANON_KEY ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV0bmRuY3FvbmtkZXhoeGJyenVhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg1MDM2MDAsImV4cCI6MjA1NDA3OTYwMH0.placeholder",
  authMode: (process.env.AUTH_MODE ?? "supabase") as "dev" | "firebase" | "supabase",
  adminToken: process.env.ADMIN_TOKEN ?? "changeme",
  firebaseProjectId: process.env.FIREBASE_PROJECT_ID ?? "",
  tickIntervalMs: Number(process.env.TICK_INTERVAL_MS ?? 30_000),
  eventChancePerTick: Number(process.env.EVENT_CHANCE_PER_TICK ?? 0.08),
  startingSugarCoins: Number(process.env.STARTING_SUGAR_COINS ?? 1000),
  circuitBreaker: Number(process.env.CIRCUIT_BREAKER ?? 0.05),
  serverType: (process.env.SERVER_TYPE ?? "public") as "public" | "private",
  privateImpactPerShare: Number(process.env.PRIVATE_IMPACT_PER_SHARE ?? 0.005),
  publicImpactPerShare: Number(process.env.PUBLIC_IMPACT_PER_SHARE ?? 0.0005),
};

import { config } from "./config";
import { waitForDatabase } from "./db/client";
import { migrate } from "./db/migrate";
import { seedPriceHistoryIfEmpty, tickMarket } from "./engine/market";

async function main(): Promise<void> {
  await waitForDatabase();
  await migrate();
  await seedPriceHistoryIfEmpty();

  console.log(`Tick worker starting; interval ${config.tickIntervalMs}ms`);
  await tickMarket();
  setInterval(() => {
    tickMarket().catch((error) => {
      console.error("Tick failed", error);
    });
  }, config.tickIntervalMs);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});

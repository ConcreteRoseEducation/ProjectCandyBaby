# CandyBaby Backend Plan — Stocks, Events & Statistics Server

## Decisions locked in

- **Stack**: Custom Node.js/Express API + PostgreSQL (with TimescaleDB extension for time-series data). Full control, no vendor lock-in.
- **Auth**: Keep Firebase Auth on the Android client. The new backend verifies Firebase ID tokens server-side (via `firebase-admin`, already a dependency in `backend/functions`) and maps them to internal user rows. No auth migration needed.
- **Economy authority**: Full server-authoritative from the start. Balances, holdings, and trades move out of the client's Room database and into Postgres, validated by the API. The Android app becomes a thin client for the trading ledger.
- **Scale target**: One classroom / dozens of concurrent users. Optimize for simplicity and reliability on a Raspberry Pi, not horizontal scale.
- **Hosting**: Raspberry Pi now (Docker Compose), designed so the exact same stack lifts onto a paid VPS later with just a `pg_dump`/`pg_restore` and a DNS/tunnel repoint.

This replaces the current split-brain setup where price ticking exists in two places (client-side `MarketEngine`, which is unused, and the Firebase Cloud Function `tickMarket`) and the trading ledger lives only on-device in Room. Firestore/Cloud Functions (`backend/functions`) will be retired once the new backend is live; Firebase Auth is the only piece of Firebase kept long-term.

---

## Phase 0 — Repo & infra scaffolding

- New `backend/server/` directory: the Node/Express API + tick worker + event/stats jobs (TypeScript recommended for a codebase this stateful).
- `docker-compose.yml` at repo root or under `backend/`: services for `postgres` (timescale/timescaledb image), `api`, `caddy` (reverse proxy).
- `.env` / `.env.example` for secrets: Firebase service account JSON, Postgres credentials, admin allowlist.
- Decide ORM/query layer (e.g. Prisma or Drizzle) vs. raw SQL + a migration tool (e.g. `node-pg-migrate`). Either is fine; pick one before Phase 1 so schema changes are tracked in version control from the start.

## Phase 1 — Database schema (Postgres + Timescale)

Core tables:

- `users` — mirrors Firebase UID, display name, sugar_coins balance, created_at.
- `sectors` — id, key, display_name (seed from the existing `Sector` enum).
- `stocks` — id, symbol, name, sector_id, base_price, current_price, description, is_active, created_at.
- `price_ticks` (Timescale hypertable, partitioned by time) — stock_id, ts, price, volume. Raw tick data.
- `price_candles` (continuous aggregate or rollup table) — stock_id, bucket_start, timeframe (1m/5m/1h/1d), open, high, low, close, volume.
- `events` — id, type, scope (stock/sector/market), target_id, title, narrative, magnitude, decay_type, duration_ticks, starts_at, created_by (system/admin uid).
- `event_effects` — event_id, stock_id, applied_at, price_delta (audit log of what an event actually did, feeds statistics + news feed).
- `holdings` — user_id, stock_id, quantity, avg_purchase_price.
- `transactions` — id, user_id, stock_id, type (BUY/SELL), quantity, price_per_unit, created_at.
- `portfolio_snapshots` (Timescale hypertable) — user_id, ts, total_value. Replaces client-side `PortfolioPoint`.
- `statistics_cache` — precomputed per-stock and per-user stats, refreshed on a schedule so API reads stay cheap.
- `classes` / `class_members` (optional, for the single-classroom MVP but cheap to include now) — groups users for a class-scoped leaderboard.

## Phase 2 — Stock engine (tick worker)

Runs on a schedule (e.g. every 30–60s), replacing both `MarketEngine.kt` and `tickMarket` in `backend/functions/index.js`:

- Per-stock idiosyncratic random shock + a shared **sector factor** + a shared **market factor**, so stocks visibly co-move with their sector instead of moving independently (current behavior).
- Slow mean-reversion pull toward a rolling trend line, plus simple volatility clustering (e.g. a GARCH(1,1)-style `vol_t = a·vol_{t-1} + b·shock²`) so the market alternates between calm and volatile periods instead of uniform noise every tick.
- Circuit breaker: clamp max % move per tick.
- Applies any active event effects (with decay) before finalizing the tick's price.
- Writes to `price_ticks`; a rollup job (or Timescale continuous aggregate) maintains `price_candles`.

## Phase 3 — Event engine

- Seed a library of event templates: company-specific (earnings beat/miss), sector-wide (input cost shock, regulation), market-wide (crash/rally), seasonal (Halloween demand spike), black-swan/random.
- Random scheduler: small probabilistic chance per tick cycle of a random event firing, weighted by severity.
- Admin/teacher-triggered events: protected endpoint to fire or schedule a specific event immediately — the key feature for the teaching use case (e.g. "today we're covering diversification" → crash a sector on cue).
- Narrative text per event (templated, no AI needed initially) so events double as a news feed / teaching hook.
- `GET /events` news feed endpoint for a future in-app news screen.

## Phase 4 — Statistics engine

- Scheduled job (e.g. every 5 min): per-stock volatility/moving averages, per-user return %/diversification score, leaderboard rankings (global and per-class).
- Results written to `statistics_cache` so reads don't recompute on every request.
- Endpoints: `GET /stocks/:symbol/stats`, `GET /users/:id/stats`, `GET /leaderboard`.

## Phase 5 — API layer

- REST: `GET /stocks`, `GET /stocks/:symbol`, `GET /stocks/:symbol/candles?range=`, `GET /events`, `POST /admin/events` (protected), `GET /portfolio`, `POST /trades` (server validates live price + sufficient funds inside a DB transaction), `GET /leaderboard`, `GET /health`.
- Realtime: WebSocket channel (e.g. `ws`/`socket.io`) broadcasting price ticks and new events to connected clients, replacing the Firestore `addSnapshotListener` pattern in `FirestoreMarketRepository.kt`.
- Auth middleware: verify Firebase ID token on every request via `firebase-admin`; auto-create the internal `users` row on first sight.

## Phase 6 — Android app migration

- New repository (Retrofit/OkHttp + a WebSocket client) replacing `FirestoreMarketRepository`.
- `MainViewModel.buyStock`/`sellStock` become API calls (`POST /trades`) instead of direct `HoldingDao`/`TransactionDao` writes; Room becomes a local cache (or is dropped) rather than the source of truth.
- Keep the existing Firebase Auth sign-in flow; additionally attach the ID token to backend requests.
- Handle latency/offline gracefully (loading states; optimistic UI is a nice-to-have, not required for MVP).

## Phase 7 — Admin/teacher tool

- Minimal internal page (static HTML+JS is enough for MVP) hitting the admin endpoints: list stocks, trigger/schedule events, view leaderboard, tweak a global volatility knob.
- Protect with a simple allowlist of Firebase UIDs/emails checked by the same auth middleware.

## Phase 8 — Pi deployment & ops

- `docker-compose.yml`: `postgres`/timescaledb (data volume on an external USB SSD, not the microSD card), `api`, `tick-worker` (can be the same image, different command), `caddy`.
- Expose via **Cloudflare Tunnel** or **Tailscale Funnel** — avoids port-forwarding and gets free TLS.
- Nightly `pg_dump` cron job pushed off-Pi (e.g. via `rclone` to cloud storage).
- `restart: unless-stopped` on all containers; a UPS is recommended so a power blip doesn't corrupt Postgres state.
- Lightweight monitoring (Uptime Kuma or a healthchecks.io ping from the tick worker) so a dead Pi is noticed quickly.

## Phase 9 — Migration path to a paid server

Because the stack is fully Dockerized and stateless aside from the Postgres volume: stand up the same `docker-compose.yml` on the new host, `pg_dump`/`pg_restore` (or set up logical replication for near-zero downtime), repoint the Cloudflare Tunnel/DNS. Document this as a short runbook once Phase 8 is stable.

---

## Suggested build order

1. Phase 0 + Phase 1 (scaffolding + schema) — nothing else can start without this.
2. Phase 2 (stock engine) — gets a live, correlated, semi-realistic market ticking in Postgres.
3. Phase 5 (API layer, read-only endpoints first) — lets the Android app start consuming real data.
4. Phase 6 (Android migration, read path only: stocks/candles) — validates the API end-to-end before touching money.
5. Phase 5/6 trading endpoints (`POST /trades`) — the highest-risk change (money + concurrency), done once the read path is proven.
6. Phase 3 (events) and Phase 4 (statistics) — layer in on top of a working core loop.
7. Phase 7 (admin tool) — as soon as events exist, so events are actually usable for lessons.
8. Phase 8 (Pi ops hardening: backups, monitoring, USB SSD) — before this is trusted with real classroom use.
9. Phase 9 (migration runbook) — once you're ready to move off the Pi.

## Open items to revisit (non-blocking)

- TypeScript vs. plain JS for `backend/server` (recommend TypeScript given the stateful ledger logic).
- ORM/migration tool choice (Prisma/Drizzle + a migration CLI) — pick before Phase 1 schema work starts.
- Whether the tick worker runs as a separate process/container from the API, or as an in-process scheduled job — separate process is cleaner but is an early decision, not a blocker.
- Retirement timeline for `backend/functions` (Firestore/Cloud Functions) — keep running in parallel until Phase 6's read path is validated, then decommission.

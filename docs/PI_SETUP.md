# Run Sugar Market on a Raspberry Pi 5

The market lives in `backend/`: Postgres/TimescaleDB, a Node API, and a tick worker.

## What you get after `docker compose up`

- Live prices for 300+ snack stocks across 6 sectors
- Real-time stock price updates on player buy and sell orders
- Sector + market correlation, mean reversion, and a 5% circuit breaker
- Random news events, plus custom and teacher-triggered lesson events
- REST API on port 3000 and a live WebSocket at `/ws`
- Teacher desk at `http://<pi-ip>:3000/admin.html`
- Server-authoritative paper trades (`POST /trades`)

## 1. On the Pi

```bash
git clone <your-repo-url> ProjectCandyBaby
cd ProjectCandyBaby/backend
cp .env.example .env
nano .env   # change POSTGRES_PASSWORD and ADMIN_TOKEN
docker compose up -d --build
docker compose logs -f
```

Wait until logs show `Sugar Market API listening on :3000`.

## 2. Remote Access via Cloudflare Tunnel (Cellular / Remote Testing)

To test the Android app from anywhere off your local Wi-Fi:

1. On the Raspberry Pi, run the tunnel helper script:
   ```bash
   cd ~/ProjectCandyBaby/backend
   ./start_tunnel.sh
   ```
2. Terminal output will show your secure public URL:
   `https://<your-custom-subdomain>.trycloudflare.com`
3. In Android Studio, open `app/build.gradle.kts` and update `MARKET_BASE_URL`:
   ```kotlin
   buildConfigField("String", "MARKET_BASE_URL", "\"https://<your-custom-subdomain>.trycloudflare.com\"")
   ```
4. Rebuild the Android app and run it on your mobile device!

## 3. Useful Teacher API

| Action | Request |
| --- | --- |
| Health | `GET /health` |
| Stocks | `GET /stocks` |
| One stock + history | `GET /stocks/FIZ` |
| Candles | `GET /stocks/FIZ/candles?timeframe=1m` |
| News | `GET /events` |
| Leaderboard | `GET /leaderboard` |
| Fire template event | `POST /admin/events` with header `x-admin-token` and body `{"templateId":"sugar_crash"}` |
| Fire custom event | `POST /admin/events` with header `x-admin-token` and body `{"title":"Pop Quiz Rush","scope":"market","magnitude":0.08,"durationTicks":4}` |
| Toggle Server Type | `POST /admin/server-type` `{"serverType":"private"}` |
| Force Market Tick | `POST /admin/tick` |
| Volatility | `POST /admin/volatility` `{"globalVolatility":1.5}` |

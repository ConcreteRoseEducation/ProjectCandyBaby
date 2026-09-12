# Run CandyBaby on a Raspberry Pi 5

The market now lives in `backend/`: Postgres/TimescaleDB, a Node API, and a tick worker. The Android app still talks to Firestore until we migrate it; this stack is the classroom server you can start today.

## What you get after `docker compose up`

- Live prices for FIZ, KRSP, COCO, GUM, SHK, and CNDY
- Sector + market correlation, mean reversion, and a 5% circuit breaker
- Random news events, plus teacher-triggered lesson events
- REST API on port 3000 and a live WebSocket at `/ws`
- Teacher desk at `http://<pi-ip>:3000/admin.html`
- Server-authoritative paper trades (`POST /trades`)

## 1. On the Pi

You already have Docker. From a laptop on the same network:

```bash
git clone <your-repo-url> ProjectCandyBaby
cd ProjectCandyBaby/backend
cp .env.example .env
nano .env   # change POSTGRES_PASSWORD and ADMIN_TOKEN
docker compose up -d --build
docker compose logs -f
```

If the project is not on GitHub yet, copy the folder with `scp` or a USB drive instead of cloning.

Wait until logs show `CandyBaby API listening` and `Market ticked 6 stocks`. Then from any device on the LAN:

```bash
curl http://<pi-ip>:3000/health
curl http://<pi-ip>:3000/stocks
```

Open `http://<pi-ip>:3000/admin.html`, paste the `ADMIN_TOKEN`, and fire a lesson event.

## 2. Find the Pi's IP

On the Pi:

```bash
hostname -I
```

Use the LAN address (usually `192.168.x.x`).

## 3. Try a paper trade (guest mode)

Dev auth is on by default. No Firebase service account is required yet.

```bash
curl -X POST http://<pi-ip>:3000/trades \
  -H 'Content-Type: application/json' \
  -H 'X-Dev-User: alex' \
  -H 'X-Dev-Name: Alex' \
  -d '{"symbol":"FIZ","type":"BUY","quantity":5}'

curl http://<pi-ip>:3000/portfolio -H 'X-Dev-User: alex'
```

## 4. Put Postgres on a USB SSD (recommended)

An always-writing database will wear out a microSD card. After the SSD is mounted (example: `/mnt/ssd`):

1. `docker compose down`
2. In `.env`, set `POSTGRES_DATA_DIR=/mnt/ssd/candybaby-pg`
3. `mkdir -p /mnt/ssd/candybaby-pg`
4. `docker compose up -d`

If you already have data in `backend/data/postgres`, copy that folder onto the SSD first.

## 5. Keep it running

```bash
docker compose ps
docker compose logs -f worker
```

Containers use `restart: unless-stopped`, so they come back after a reboot as long as Docker is enabled:

```bash
sudo systemctl enable docker
```

Nightly backup (add to `crontab -e` on the Pi):

```bash
0 3 * * * docker exec backend-postgres-1 pg_dump -U candybaby candybaby > /home/pi/candybaby-$(date +\%F).sql
```

The container name may be `backend-postgres-1` or `candybaby-postgres-1`. Check with `docker compose ps`.

## 6. Useful teacher API

| Action | Request |
| --- | --- |
| Health | `GET /health` |
| Stocks | `GET /stocks` |
| One stock + history | `GET /stocks/FIZ` |
| Candles | `GET /stocks/FIZ/candles?timeframe=1m` |
| News | `GET /events` |
| Leaderboard | `GET /leaderboard` |
| Fire event | `POST /admin/events` with header `x-admin-token` and body `{"templateId":"sugar_crash"}` |
| Volatility | `POST /admin/volatility` `{"globalVolatility":1.5}` |

Event template ids include `fiz_earnings_beat`, `coco_miss`, `gum_launch`, `krsp_recall`, `cocoa_shock`, `halloween_demand`, `soda_tax`, `sugar_rally`, `sugar_crash`, `shk_expansion`.

## 7. Later: expose beyond your house

Do not port-forward 3000 to the public internet. Use a Cloudflare Tunnel or Tailscale Funnel when you want phones off the school Wi-Fi to reach the Pi.

Firebase Auth can replace guest headers later: set `AUTH_MODE=firebase` and mount a service account. The Android app still needs a follow-up change to call this API instead of Firestore.

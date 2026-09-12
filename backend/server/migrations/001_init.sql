CREATE EXTENSION IF NOT EXISTS timescaledb;

CREATE TABLE sectors (
    id SERIAL PRIMARY KEY,
    key TEXT UNIQUE NOT NULL,
    display_name TEXT NOT NULL
);

CREATE TABLE stocks (
    id SERIAL PRIMARY KEY,
    symbol TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    sector_id INTEGER NOT NULL REFERENCES sectors(id),
    base_price DOUBLE PRECISION NOT NULL,
    current_price DOUBLE PRECISION NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    volatility DOUBLE PRECISION NOT NULL DEFAULT 0.02,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    firebase_uid TEXT UNIQUE NOT NULL,
    display_name TEXT,
    sugar_coins DOUBLE PRECISION NOT NULL DEFAULT 1000,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE price_ticks (
    stock_id INTEGER NOT NULL REFERENCES stocks(id),
    ts TIMESTAMPTZ NOT NULL,
    price DOUBLE PRECISION NOT NULL,
    volume DOUBLE PRECISION NOT NULL DEFAULT 0
);

SELECT create_hypertable('price_ticks', 'ts', if_not_exists => TRUE);

CREATE INDEX price_ticks_stock_ts_idx ON price_ticks (stock_id, ts DESC);

CREATE TABLE price_candles (
    stock_id INTEGER NOT NULL REFERENCES stocks(id),
    bucket_start TIMESTAMPTZ NOT NULL,
    timeframe TEXT NOT NULL,
    open DOUBLE PRECISION NOT NULL,
    high DOUBLE PRECISION NOT NULL,
    low DOUBLE PRECISION NOT NULL,
    close DOUBLE PRECISION NOT NULL,
    volume DOUBLE PRECISION NOT NULL DEFAULT 0,
    PRIMARY KEY (stock_id, timeframe, bucket_start)
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    type TEXT NOT NULL,
    scope TEXT NOT NULL,
    target_id INTEGER,
    title TEXT NOT NULL,
    narrative TEXT NOT NULL,
    magnitude DOUBLE PRECISION NOT NULL,
    decay_type TEXT NOT NULL DEFAULT 'linear',
    duration_ticks INTEGER NOT NULL,
    remaining_ticks INTEGER NOT NULL,
    starts_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by TEXT NOT NULL DEFAULT 'system'
);

CREATE INDEX events_starts_at_idx ON events (starts_at DESC);

CREATE TABLE event_effects (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL REFERENCES events(id),
    stock_id INTEGER NOT NULL REFERENCES stocks(id),
    applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    price_delta DOUBLE PRECISION NOT NULL
);

CREATE TABLE holdings (
    user_id INTEGER NOT NULL REFERENCES users(id),
    stock_id INTEGER NOT NULL REFERENCES stocks(id),
    quantity INTEGER NOT NULL,
    avg_purchase_price DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (user_id, stock_id)
);

CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    stock_id INTEGER NOT NULL REFERENCES stocks(id),
    type TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    price_per_unit DOUBLE PRECISION NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX transactions_user_created_idx ON transactions (user_id, created_at DESC);

CREATE TABLE portfolio_snapshots (
    user_id INTEGER NOT NULL REFERENCES users(id),
    ts TIMESTAMPTZ NOT NULL,
    total_value DOUBLE PRECISION NOT NULL
);

SELECT create_hypertable('portfolio_snapshots', 'ts', if_not_exists => TRUE);

CREATE TABLE statistics_cache (
    key TEXT PRIMARY KEY,
    payload JSONB NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE classes (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE class_members (
    class_id INTEGER NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (class_id, user_id)
);

CREATE TABLE market_state (
    id INTEGER PRIMARY KEY DEFAULT 1 CHECK (id = 1),
    market_factor DOUBLE PRECISION NOT NULL DEFAULT 0,
    global_volatility DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    last_tick_at TIMESTAMPTZ
);

CREATE TABLE sector_state (
    sector_id INTEGER PRIMARY KEY REFERENCES sectors(id),
    factor DOUBLE PRECISION NOT NULL DEFAULT 0,
    volatility DOUBLE PRECISION NOT NULL DEFAULT 0.015
);

-- Seed initial Google trader user accounts in Supabase
INSERT INTO users (firebase_uid, display_name, sugar_coins) VALUES
    ('dev:guest', 'Guest User', 1000.0),
    ('dev:google_trader_1', 'Sugar Trader (Google)', 1250.0),
    ('dev:google_trader_2', 'Candy Baby (Google)', 1100.0),
    ('dev:google_trader_3', 'Sweet Tooth (Google)', 950.0)
ON CONFLICT (firebase_uid) DO NOTHING;

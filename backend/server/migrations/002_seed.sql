INSERT INTO sectors (key, display_name) VALUES
    ('FIZZY_DRINKS', 'Fizzy Drinks'),
    ('KRISPY_KINGDOM', 'Krispy Kingdom'),
    ('COCOA_CORP', 'Cocoa Corp'),
    ('GUM_TECH', 'GumTech'),
    ('SUGAR_SHACK', 'Sugar Shack Chain'),
    ('CANDY_MART', 'Candy Mart')
ON CONFLICT (key) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FIZ', 'Fizzy Drinks Corp', id, 10.0, 10.0, 'Leader in carbonated sugar water.', 0.022
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'KRSP', 'Krispy Kingdom', id, 25.0, 25.0, 'The finest potato-based snacks.', 0.020
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'COCO', 'Cocoa Corp', id, 50.0, 50.0, 'Premium dark and milk chocolate.', 0.024
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GUM', 'GumTech', id, 100.0, 100.0, 'Chewing the future of connectivity.', 0.028
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SHK', 'Sugar Shack Chain', id, 40.0, 40.0, 'Your local source for donuts and shakes.', 0.018
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CNDY', 'Candy Mart', id, 15.0, 15.0, 'Retail giant for all things sweet.', 0.019
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO sector_state (sector_id, factor, volatility)
SELECT id, 0, 0.015 FROM sectors
ON CONFLICT (sector_id) DO NOTHING;

INSERT INTO market_state (id, market_factor, global_volatility)
VALUES (1, 0, 1.0)
ON CONFLICT (id) DO NOTHING;

INSERT INTO classes (id, name) VALUES (1, 'Classroom Demo')
ON CONFLICT (id) DO NOTHING;

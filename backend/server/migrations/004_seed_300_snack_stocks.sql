-- Seed 300 snack-based stocks across all 6 sectors

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CPC', 'Crunchy Potato Crisps', id, 64.12, 64.12, 'Popular maker of crunchy potato crisps, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'NCC', 'Nacho Cheese Crunch', id, 33.42, 33.42, 'Popular maker of nacho cheese crunch, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SPT', 'Salted Pretzel Twist', id, 30.46, 30.46, 'Popular maker of salted pretzel twist, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SJC', 'Spicy Jalapeno Chips', id, 52.94, 52.94, 'Popular maker of spicy jalapeno chips, loved by snack enthusiasts nationwide.', 0.038
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BPR', 'BBQ Pork Rinds', id, 9.81, 9.81, 'Popular maker of bbq pork rinds, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GPK', 'Golden Popcorn Kernels', id, 12.21, 12.21, 'Popular maker of golden popcorn kernels, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CPE', 'Cheesy Puff Empire', id, 57.52, 57.52, 'Popular maker of cheesy puff empire, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PCO', 'Pita Chip Oven', id, 19.87, 19.87, 'Popular maker of pita chip oven, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCC', 'Cassava Crunch Co', id, 22.56, 22.56, 'Popular maker of cassava crunch co, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TRB', 'Taro Root Bites', id, 38.70, 38.70, 'Popular maker of taro root bites, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SSRC', 'Sea Salt Rice Cakes', id, 6.71, 6.71, 'Popular maker of sea salt rice cakes, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCCW', 'Sour Cream Crisp Works', id, 26.98, 26.98, 'Popular maker of sour cream crisp works, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HMP', 'Honey Mustard Pretzel', id, 59.28, 59.28, 'Popular maker of honey mustard pretzel, loved by snack enthusiasts nationwide.', 0.035
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GBBC', 'Garlic Butter Bagel Chips', id, 24.42, 24.42, 'Popular maker of garlic butter bagel chips, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'WPC', 'Wasabi Pea Crunch', id, 24.01, 24.01, 'Popular maker of wasabi pea crunch, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RCS', 'Ranch Corn Snappers', id, 84.41, 84.41, 'Popular maker of ranch corn snappers, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SBR', 'Smoked Bacon Rinds', id, 21.44, 21.44, 'Popular maker of smoked bacon rinds, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SPW', 'Sweet Potato Waves', id, 82.03, 82.03, 'Popular maker of sweet potato waves, loved by snack enthusiasts nationwide.', 0.017
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'KCG', 'Kettle Cooked Gold', id, 19.50, 19.50, 'Popular maker of kettle cooked gold, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CLT', 'Chili Lime Tortillas', id, 47.39, 47.39, 'Popular maker of chili lime tortillas, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MUCR', 'Multi-Grain Crackers', id, 17.04, 17.04, 'Popular maker of multi-grain crackers, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SSS', 'Sesame Seed Sticks', id, 27.73, 27.73, 'Popular maker of sesame seed sticks, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BCR', 'Barbecue Corn Rings', id, 18.24, 18.24, 'Popular maker of barbecue corn rings, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCB', 'Cheddar Cheese Balls', id, 54.63, 54.63, 'Popular maker of cheddar cheese balls, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ZTS', 'Zesty Taco Shells', id, 47.09, 47.09, 'Popular maker of zesty taco shells, loved by snack enthusiasts nationwide.', 0.017
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CSC', 'Cajun Spice Chips', id, 74.75, 74.75, 'Popular maker of cajun spice chips, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CFB', 'Curry Flavour Bites', id, 11.69, 11.69, 'Popular maker of curry flavour bites, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DPPC', 'Dill Pickle Potato Chips', id, 73.35, 73.35, 'Popular maker of dill pickle potato chips, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BWC', 'Buffalo Wing Crunch', id, 61.96, 61.96, 'Popular maker of buffalo wing crunch, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TOC', 'Truffle Oil Crisps', id, 62.55, 62.55, 'Popular maker of truffle oil crisps, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HHB', 'Habanero Heat Bites', id, 19.12, 19.12, 'Popular maker of habanero heat bites, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SSM', 'Sriracha Snack Mix', id, 47.08, 47.08, 'Popular maker of sriracha snack mix, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'Sunde', 'Salt & Vinegar Straws', id, 82.85, 82.85, 'Popular maker of salt & vinegar straws, loved by snack enthusiasts nationwide.', 0.021
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCC1', 'Caramel Corn Crunch', id, 71.10, 71.10, 'Popular maker of caramel corn crunch, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CPN', 'Cheddar Pretzel Nuggets', id, 57.32, 57.32, 'Popular maker of cheddar pretzel nuggets, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CRS', 'Crispy Rice Squares', id, 46.75, 46.75, 'Popular maker of crispy rice squares, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PSC', 'Plantain Stix Corp', id, 15.98, 15.98, 'Popular maker of plantain stix corp, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BVS', 'Baked Veggie Straws', id, 54.85, 54.85, 'Popular maker of baked veggie straws, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ORD', 'Onion Ring Delights', id, 57.59, 57.59, 'Popular maker of onion ring delights, loved by snack enthusiasts nationwide.', 0.016
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PCC', 'Parmesan Cheese Crisps', id, 44.24, 44.24, 'Popular maker of parmesan cheese crisps, loved by snack enthusiasts nationwide.', 0.016
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PPB', 'Pepperoni Pizza Bites', id, 22.18, 22.18, 'Popular maker of pepperoni pizza bites, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SGW', 'Smoky Gouda Wafers', id, 7.34, 7.34, 'Popular maker of smoky gouda wafers, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SPP', 'Salty Peanut Pretzel', id, 9.01, 9.01, 'Popular maker of salty peanut pretzel, loved by snack enthusiasts nationwide.', 0.016
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BRC', 'Barbecue Rib Chips', id, 60.44, 60.44, 'Popular maker of barbecue rib chips, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCund', 'Sour Cream & Chive Sticks', id, 84.66, 84.66, 'Popular maker of sour cream & chive sticks, loved by snack enthusiasts nationwide.', 0.015
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TSC', 'Toasted Sesame Crackers', id, 38.85, 38.85, 'Popular maker of toasted sesame crackers, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SSC', 'Spicy Salsa Chips', id, 54.64, 54.64, 'Popular maker of spicy salsa chips, loved by snack enthusiasts nationwide.', 0.021
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HRM', 'Honey Roasted Mix', id, 47.33, 47.33, 'Popular maker of honey roasted mix, loved by snack enthusiasts nationwide.', 0.036
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GGC', 'Gluten-Free Grain Crunch', id, 42.60, 42.60, 'Popular maker of gluten-free grain crunch, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CLT1', 'Chili Lemon Tortillas', id, 44.66, 44.66, 'Popular maker of chili lemon tortillas, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'KRISPY_KINGDOM'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'VDC', 'Velvet Dark Chocolate', id, 27.53, 27.53, 'Popular maker of velvet dark chocolate, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SMC', 'Silk Milk Cocoa', id, 72.76, 72.76, 'Popular maker of silk milk cocoa, loved by snack enthusiasts nationwide.', 0.038
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HTG', 'Hazelnut Truffle Guild', id, 14.79, 14.79, 'Popular maker of hazelnut truffle guild, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FFI', 'Fudge Factory Inc', id, 84.99, 84.99, 'Popular maker of fudge factory inc, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BBW', 'Belgian Bonbon Works', id, 58.83, 58.83, 'Popular maker of belgian bonbon works, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CMD', 'Chocolate Melt Drops', id, 12.45, 12.45, 'Popular maker of chocolate melt drops, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PBCC', 'Peanut Butter Cup Co', id, 18.67, 18.67, 'Popular maker of peanut butter cup co, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'WCD', 'White Chocolate Dream', id, 49.95, 49.95, 'Popular maker of white chocolate dream, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MCC', 'Mint Cocoa Crunch', id, 47.89, 47.89, 'Popular maker of mint cocoa crunch, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SSCD', 'Sea Salt Caramel Dark', id, 15.32, 15.32, 'Popular maker of sea salt caramel dark, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ABC', 'Almond Bark Crunch', id, 29.90, 29.90, 'Popular maker of almond bark crunch, loved by snack enthusiasts nationwide.', 0.016
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DFBB', 'Double Fudge Brownie Bite', id, 17.55, 17.55, 'Popular maker of double fudge brownie bite, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MCB', 'Malt Chocolate Balls', id, 71.83, 71.83, 'Popular maker of malt chocolate balls, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'EBC', 'Espresso Bean Cocoa', id, 6.40, 6.40, 'Popular maker of espresso bean cocoa, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TCC', 'Toffee Crunch Chocolate', id, 62.18, 62.18, 'Popular maker of toffee crunch chocolate, loved by snack enthusiasts nationwide.', 0.025
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CTS', 'Coconut Truffle Spheres', id, 6.73, 6.73, 'Popular maker of coconut truffle spheres, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RCD', 'Ruby Cocoa Delights', id, 49.67, 49.67, 'Popular maker of ruby cocoa delights, loved by snack enthusiasts nationwide.', 0.040
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MWC', 'Matcha White Chocolate', id, 30.63, 30.63, 'Popular maker of matcha white chocolate, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'OPDB', 'Orange Peel Dark Bar', id, 39.78, 39.78, 'Popular maker of orange peel dark bar, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RCC', 'Raspberry Cocoa Cream', id, 77.01, 77.01, 'Popular maker of raspberry cocoa cream, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HMC', 'Honeycomb Milk Chocolate', id, 65.03, 65.03, 'Popular maker of honeycomb milk chocolate, loved by snack enthusiasts nationwide.', 0.025
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MCT', 'Marzipan Cocoa Treat', id, 9.80, 9.80, 'Popular maker of marzipan cocoa treat, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CWS', 'Chocolate Wafer Stack', id, 54.49, 54.49, 'Popular maker of chocolate wafer stack, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PCC1', 'Pecan Chocolate Cluster', id, 61.51, 61.51, 'Popular maker of pecan chocolate cluster, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CTD', 'Caramel Truffle Dome', id, 6.60, 6.60, 'Popular maker of caramel truffle dome, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CDC', 'Chili Dark Chocolate', id, 63.82, 63.82, 'Popular maker of chili dark chocolate, loved by snack enthusiasts nationwide.', 0.036
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GCB', 'Gourmet Cocoa Beans', id, 81.64, 81.64, 'Popular maker of gourmet cocoa beans, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HCBC', 'Hot Cocoa Bomb Co', id, 33.92, 33.92, 'Popular maker of hot cocoa bomb co, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCD', 'Strawberry Chocolate Dip', id, 35.05, 35.05, 'Popular maker of strawberry chocolate dip, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CDC1', 'Cookie Dough Cocoa', id, 64.62, 64.62, 'Popular maker of cookie dough cocoa, loved by snack enthusiasts nationwide.', 0.017
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'NCW', 'Nutella Cream Wafers', id, 20.51, 20.51, 'Popular maker of nutella cream wafers, loved by snack enthusiasts nationwide.', 0.040
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCA', 'Swiss Cocoa Alpine', id, 33.31, 33.31, 'Popular maker of swiss cocoa alpine, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PCB', 'Pistachio Chocolate Bar', id, 51.43, 51.43, 'Popular maker of pistachio chocolate bar, loved by snack enthusiasts nationwide.', 0.015
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BCT', 'Butterscotch Cocoa Twist', id, 32.63, 32.63, 'Popular maker of butterscotch cocoa twist, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'VBC', 'Vanilla Bean Cocoa', id, 28.26, 28.26, 'Popular maker of vanilla bean cocoa, loved by snack enthusiasts nationwide.', 0.025
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CRC', 'Crispy Rice Chocolate', id, 39.60, 39.60, 'Popular maker of crispy rice chocolate, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CMCC', 'Chocolate Molten Cake Co', id, 37.28, 37.28, 'Popular maker of chocolate molten cake co, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCB', 'S''mores Chocolate Bar', id, 57.39, 57.39, 'Popular maker of s''mores chocolate bar, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BDC', 'Bourbon Dark Cocoa', id, 41.67, 41.67, 'Popular maker of bourbon dark cocoa, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BCT1', 'Banana Caramel Truffle', id, 30.44, 30.44, 'Popular maker of banana caramel truffle, loved by snack enthusiasts nationwide.', 0.021
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CDB', 'Cranberry Dark Bark', id, 29.20, 29.20, 'Popular maker of cranberry dark bark, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MCB1', 'Macadamia Cocoa Bites', id, 80.82, 80.82, 'Popular maker of macadamia cocoa bites, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TCC1', 'Triple Chocolate Chunk', id, 11.92, 11.92, 'Popular maker of triple chocolate chunk, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SSCN', 'Sea Salt Cocoa Nib', id, 18.29, 18.29, 'Popular maker of sea salt cocoa nib, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FBC', 'Fudge Brownie Crunch', id, 55.76, 55.76, 'Popular maker of fudge brownie crunch, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MCP', 'Marshmallow Chocolate Pop', id, 15.47, 15.47, 'Popular maker of marshmallow chocolate pop, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CFS', 'Caramel Fudge Swirl', id, 18.57, 18.57, 'Popular maker of caramel fudge swirl, loved by snack enthusiasts nationwide.', 0.025
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HPD', 'Hazelnut Praline Drops', id, 34.03, 34.03, 'Popular maker of hazelnut praline drops, loved by snack enthusiasts nationwide.', 0.040
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MTS', 'Mint Truffle Squares', id, 20.07, 20.07, 'Popular maker of mint truffle squares, loved by snack enthusiasts nationwide.', 0.021
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DCS', 'Dark Cocoa Symphony', id, 75.94, 75.94, 'Popular maker of dark cocoa symphony, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'COCOA_CORP'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCW', 'Sparkling Cola Works', id, 58.61, 58.61, 'Popular maker of sparkling cola works, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'LLF', 'Lemon Lime Fizz', id, 7.13, 7.13, 'Popular maker of lemon lime fizz, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CSP', 'Cherry Soda Pop', id, 48.13, 48.13, 'Popular maker of cherry soda pop, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RBFC', 'Root Beer Float Co', id, 16.43, 16.43, 'Popular maker of root beer float co, loved by snack enthusiasts nationwide.', 0.015
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'OBS', 'Orange Burst Soda', id, 78.46, 78.46, 'Popular maker of orange burst soda, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GAS', 'Ginger Ale Springs', id, 69.30, 69.30, 'Popular maker of ginger ale springs, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'VCF', 'Vanilla Cream Fizz', id, 22.92, 22.92, 'Popular maker of vanilla cream fizz, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GSG', 'Grape Soda Galaxy', id, 79.05, 79.05, 'Popular maker of grape soda galaxy, loved by snack enthusiasts nationwide.', 0.036
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BRS', 'Blue Raspberry Slush', id, 26.50, 26.50, 'Popular maker of blue raspberry slush, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ESF', 'Energy Surge Fizz', id, 67.54, 67.54, 'Popular maker of energy surge fizz, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PST', 'Peach Sparkle Tonic', id, 10.45, 10.45, 'Popular maker of peach sparkle tonic, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TPS', 'Tropical Punch Soda', id, 6.59, 6.59, 'Popular maker of tropical punch soda, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CSB', 'Club Soda Bubbles', id, 73.39, 73.39, 'Popular maker of club soda bubbles, loved by snack enthusiasts nationwide.', 0.035
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'POSP', 'Pomegranate Sparkler', id, 63.94, 63.94, 'Popular maker of pomegranate sparkler, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MPF', 'Mango Passion Fizz', id, 69.39, 69.39, 'Popular maker of mango passion fizz, loved by snack enthusiasts nationwide.', 0.025
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCS', 'Strawberry Cream Soda', id, 7.56, 7.56, 'Popular maker of strawberry cream soda, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BFC', 'Blackberry Fizz Corp', id, 16.60, 16.60, 'Popular maker of blackberry fizz corp, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'WSS', 'Watermelon Soda Splash', id, 61.18, 61.18, 'Popular maker of watermelon soda splash, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PBF', 'Pineapple Breeze Fizz', id, 61.74, 61.74, 'Popular maker of pineapple breeze fizz, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'LBC', 'Limeade Bubble Co', id, 73.01, 73.01, 'Popular maker of limeade bubble co, loved by snack enthusiasts nationwide.', 0.036
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CEP', 'Citrus Energy Pop', id, 10.75, 10.75, 'Popular maker of citrus energy pop, loved by snack enthusiasts nationwide.', 0.038
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CSF', 'Cranberry Soda Fizz', id, 25.54, 25.54, 'Popular maker of cranberry soda fizz, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DPS', 'Dr Peppered Spice', id, 21.37, 21.37, 'Popular maker of dr peppered spice, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MDD', 'Mountain Dew Drop', id, 12.00, 12.00, 'Popular maker of mountain dew drop, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BTB', 'Bubble Tea Beverage', id, 20.94, 20.94, 'Popular maker of bubble tea beverage, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'IHF', 'Iced Hibiscus Fizz', id, 51.20, 51.20, 'Popular maker of iced hibiscus fizz, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GRSP', 'Grapefruit Sparkle', id, 60.51, 60.51, 'Popular maker of grapefruit sparkle, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'KSP', 'Kiwi Strawberry Pop', id, 77.19, 77.19, 'Popular maker of kiwi strawberry pop, loved by snack enthusiasts nationwide.', 0.015
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GSP', 'Guava Soda Punch', id, 46.55, 46.55, 'Popular maker of guava soda punch, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CLF', 'Coconut Lime Fizz', id, 70.73, 70.73, 'Popular maker of coconut lime fizz, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BCS', 'Banana Cream Soda', id, 60.79, 60.79, 'Popular maker of banana cream soda, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PFT', 'Plum Fizz Tonic', id, 30.50, 30.50, 'Popular maker of plum fizz tonic, loved by snack enthusiasts nationwide.', 0.036
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ACS', 'Apple Cider Sparkler', id, 62.46, 62.46, 'Popular maker of apple cider sparkler, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BOS', 'Blood Orange Soda', id, 40.28, 40.28, 'Popular maker of blood orange soda, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SAS', 'Sour Apple Surge', id, 53.35, 53.35, 'Popular maker of sour apple surge, loved by snack enthusiasts nationwide.', 0.021
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DBP', 'Dragonfruit Bubble Pop', id, 42.50, 42.50, 'Popular maker of dragonfruit bubble pop, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ETW', 'Eldeflower Tonic Water', id, 84.00, 84.00, 'Popular maker of eldeflower tonic water, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MLF', 'Mint Limeade Fizz', id, 47.72, 47.72, 'Popular maker of mint limeade fizz, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'EBS', 'Electric Berry Surge', id, 28.08, 28.08, 'Popular maker of electric berry surge, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'LSP', 'Lychee Sparkle Pop', id, 18.92, 18.92, 'Popular maker of lychee sparkle pop, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCS', 'Cotton Candy Soda', id, 27.74, 27.74, 'Popular maker of cotton candy soda, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MFD', 'Marshmallow Fizzy Drink', id, 52.80, 52.80, 'Popular maker of marshmallow fizzy drink, loved by snack enthusiasts nationwide.', 0.017
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BMTB', 'Boba Milk Tea Bottlers', id, 83.56, 83.56, 'Popular maker of boba milk tea bottlers, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MSS', 'Matcha Sparkle Soda', id, 55.91, 55.91, 'Popular maker of matcha sparkle soda, loved by snack enthusiasts nationwide.', 0.038
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SGB', 'Spiced Ginger Brew', id, 29.37, 29.37, 'Popular maker of spiced ginger brew, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BBF', 'Blueberry Bubble Fizz', id, 18.69, 18.69, 'Popular maker of blueberry bubble fizz, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'WCT', 'Wild Cherry Tonic', id, 30.63, 30.63, 'Popular maker of wild cherry tonic, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SPT1', 'Sparkling Peach Tea', id, 76.25, 76.25, 'Popular maker of sparkling peach tea, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MSR', 'Mandarin Soda Rush', id, 20.08, 20.08, 'Popular maker of mandarin soda rush, loved by snack enthusiasts nationwide.', 0.035
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ZSFL', 'Zero Sugar Fizz Lab', id, 49.44, 49.44, 'Popular maker of zero sugar fizz lab, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'FIZZY_DRINKS'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GBK', 'Gummy Bear Kingdom', id, 61.73, 61.73, 'Popular maker of gummy bear kingdom, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SWE', 'Sour Worm Empire', id, 84.74, 84.74, 'Popular maker of sour worm empire, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RJB', 'Rainbow Jelly Beans', id, 21.55, 21.55, 'Popular maker of rainbow jelly beans, loved by snack enthusiasts nationwide.', 0.025
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GILO', 'Gigantic Lollipops', id, 5.05, 5.05, 'Popular maker of gigantic lollipops, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RLT', 'Red Licorice Twist', id, 38.40, 38.40, 'Popular maker of red licorice twist, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'JACE', 'Jawbreaker Central', id, 67.95, 67.95, 'Popular maker of jawbreaker central, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RCC1', 'Rock Candy Crystals', id, 8.21, 8.21, 'Popular maker of rock candy crystals, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCF', 'Cotton Candy Fluff', id, 57.10, 57.10, 'Popular maker of cotton candy fluff, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCF1', 'Caramel Chew Factory', id, 38.90, 38.90, 'Popular maker of caramel chew factory, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FTW', 'Fruit Taffy Works', id, 81.95, 81.95, 'Popular maker of fruit taffy works, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SPB', 'Sour Patch Bites', id, 53.50, 53.50, 'Popular maker of sour patch bites, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCH', 'Candy Corn Harvesters', id, 66.89, 66.89, 'Popular maker of candy corn harvesters, loved by snack enthusiasts nationwide.', 0.021
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PRE', 'Pop Rock Explosion', id, 50.30, 50.30, 'Popular maker of pop rock explosion, loved by snack enthusiasts nationwide.', 0.035
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PCC2', 'Peppermint Candy Cane', id, 41.18, 41.18, 'Popular maker of peppermint candy cane, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MPC', 'Marshmallow Peeps Co', id, 82.58, 82.58, 'Popular maker of marshmallow peeps co, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GPR', 'Gummy Peach Rings', id, 17.18, 17.18, 'Popular maker of gummy peach rings, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SAB', 'Sour Apple Belts', id, 53.06, 53.06, 'Popular maker of sour apple belts, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BCD', 'Bubblegum Candy Drops', id, 35.09, 35.09, 'Popular maker of bubblegum candy drops, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'WGS', 'Watermelon Gummy Slice', id, 70.61, 70.61, 'Popular maker of watermelon gummy slice, loved by snack enthusiasts nationwide.', 0.035
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CNI', 'Candy Necklace Inc', id, 18.42, 18.42, 'Popular maker of candy necklace inc, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SSC1', 'Sugar Stix Candy', id, 5.70, 5.70, 'Popular maker of sugar stix candy, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'WBJ', 'Wax Bottle Juices', id, 67.26, 67.26, 'Popular maker of wax bottle juices, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CBC', 'Chocolate Button Candy', id, 37.85, 37.85, 'Popular maker of chocolate button candy, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GWS', 'Gummy Worm Safari', id, 78.84, 78.84, 'Popular maker of gummy worm safari, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BHC', 'Butterscotch Hard Candy', id, 60.87, 60.87, 'Popular maker of butterscotch hard candy, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CHD', 'Cinnamon Hard Drops', id, 21.14, 21.14, 'Popular maker of cinnamon hard drops, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'LIAL', 'Licorice Allsorts', id, 48.64, 48.64, 'Popular maker of licorice allsorts, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SLD', 'Sour Lemon Drops', id, 36.33, 36.33, 'Popular maker of sour lemon drops, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FCS', 'Fruity Chewy Squares', id, 57.44, 57.44, 'Popular maker of fruity chewy squares, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BRG', 'Blue Raspberry Gummy', id, 47.05, 47.05, 'Popular maker of blue raspberry gummy, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TJB', 'Tropical Jelly Beans', id, 52.83, 52.83, 'Popular maker of tropical jelly beans, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SPGU', 'Spiced Gumdrops', id, 49.41, 49.41, 'Popular maker of spiced gumdrops, loved by snack enthusiasts nationwide.', 0.021
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TCC2', 'Toffee Candy Chew', id, 66.23, 66.23, 'Popular maker of toffee candy chew, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MPC1', 'Marshmallow Puff Co', id, 9.44, 9.44, 'Popular maker of marshmallow puff co, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCB1', 'Sour Cherry Bombs', id, 5.87, 5.87, 'Popular maker of sour cherry bombs, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GCB1', 'Gummy Cola Bottles', id, 8.87, 8.87, 'Popular maker of gummy cola bottles, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GSA', 'Gummy Shark Attack', id, 76.05, 76.05, 'Popular maker of gummy shark attack, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HCC', 'Hard Candy Crystals', id, 5.11, 5.11, 'Popular maker of hard candy crystals, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FLP', 'Fruity Lolli Pops', id, 65.81, 65.81, 'Popular maker of fruity lolli pops, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PBW', 'Peanut Brittle Works', id, 32.49, 32.49, 'Popular maker of peanut brittle works, loved by snack enthusiasts nationwide.', 0.021
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'Sund1', 'Sweets & Treats Mart', id, 6.78, 6.78, 'Popular maker of sweets & treats mart, loved by snack enthusiasts nationwide.', 0.016
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GDW', 'Gummy Dinosaur World', id, 9.55, 9.55, 'Popular maker of gummy dinosaur world, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SGB1', 'Sour Grape Belts', id, 41.30, 41.30, 'Popular maker of sour grape belts, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SFB', 'Sour Fizz Balls', id, 40.97, 40.97, 'Popular maker of sour fizz balls, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCC2', 'Cotton Candy Clouds', id, 28.49, 28.49, 'Popular maker of cotton candy clouds, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BCD1', 'Bubblegum Chew Drops', id, 60.70, 60.70, 'Popular maker of bubblegum chew drops, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CTP', 'Caramel Toffee Pop', id, 9.09, 9.09, 'Popular maker of caramel toffee pop, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RHC', 'Rainbow Hard Candy', id, 35.36, 35.36, 'Popular maker of rainbow hard candy, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'LCF', 'Licorice Chew Factory', id, 42.96, 42.96, 'Popular maker of licorice chew factory, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'JBS', 'Jelly Bean Supreme', id, 72.69, 72.69, 'Popular maker of jelly bean supreme, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'CANDY_MART'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SGT', 'Spearmint Gum Tech', id, 5.26, 5.26, 'Popular maker of spearmint gum tech, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BBI', 'Bubblegum Blast Inc', id, 63.90, 63.90, 'Popular maker of bubblegum blast inc, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCL', 'Cinnamon Chew Labs', id, 34.69, 34.69, 'Popular maker of cinnamon chew labs, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PFC', 'Peppermint Fresh Co', id, 9.36, 9.36, 'Popular maker of peppermint fresh co, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SFCT', 'Sour Fruit Chew Tech', id, 36.05, 36.05, 'Popular maker of sour fruit chew tech, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'LLM', 'Long Lasting Mint', id, 10.30, 10.30, 'Popular maker of long lasting mint, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DCG', 'Dental Care Gum', id, 11.84, 11.84, 'Popular maker of dental care gum, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'NMC', 'Nicotine-Free Mint Chew', id, 69.71, 69.71, 'Popular maker of nicotine-free mint chew, loved by snack enthusiasts nationwide.', 0.040
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'WABU', 'Watermelon Bubblegum', id, 60.63, 60.63, 'Popular maker of watermelon bubblegum, loved by snack enthusiasts nationwide.', 0.016
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GFG', 'Grape Flavored Gum', id, 17.48, 17.48, 'Popular maker of grape flavored gum, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CMS', 'Cool Menthol Strips', id, 17.41, 17.41, 'Popular maker of cool menthol strips, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'EBT', 'Eucalyptus Breath Tabs', id, 49.72, 49.72, 'Popular maker of eucalyptus breath tabs, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TPG', 'Tropical Punch Gum', id, 46.48, 46.48, 'Popular maker of tropical punch gum, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SACT', 'Sour Apple Chew Tech', id, 64.74, 64.74, 'Popular maker of sour apple chew tech, loved by snack enthusiasts nationwide.', 0.038
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BBB', 'Berry Blast Bubblegum', id, 81.70, 81.70, 'Popular maker of berry blast bubblegum, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CIC', 'Caffeine Infused Chew', id, 65.43, 65.43, 'Popular maker of caffeine infused chew, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'VGS', 'Vitamin Gum Solutions', id, 75.79, 75.79, 'Popular maker of vitamin gum solutions, loved by snack enthusiasts nationwide.', 0.025
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BMC', 'Blueberry Mint Chew', id, 78.32, 78.32, 'Popular maker of blueberry mint chew, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PMS', 'Polar Mint Strips', id, 32.93, 32.93, 'Popular maker of polar mint strips, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CCG', 'Cotton Candy Gum', id, 67.51, 67.51, 'Popular maker of cotton candy gum, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SBC', 'Strawberry Bubble Co', id, 16.28, 16.28, 'Popular maker of strawberry bubble co, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CMR', 'Citrus Mint Refresh', id, 19.07, 19.07, 'Popular maker of citrus mint refresh, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'WCC', 'Wild Cherry Chew', id, 43.82, 43.82, 'Popular maker of wild cherry chew, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GTMT', 'Green Tea Mint Tabs', id, 70.07, 70.07, 'Popular maker of green tea mint tabs, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CIC1', 'CBD Infused Chews', id, 66.58, 66.58, 'Popular maker of cbd infused chews, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'WFG', 'Wintergreen Fresh Gum', id, 55.82, 55.82, 'Popular maker of wintergreen fresh gum, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'LMC', 'Licorice Mint Chew', id, 50.00, 50.00, 'Popular maker of licorice mint chew, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MABU', 'Matcha Bubblegum', id, 68.62, 68.62, 'Popular maker of matcha bubblegum, loved by snack enthusiasts nationwide.', 0.036
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DCT', 'Dragonfruit Chew Tech', id, 11.39, 11.39, 'Popular maker of dragonfruit chew tech, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PMG', 'Peach Mango Gum', id, 21.61, 21.61, 'Popular maker of peach mango gum, loved by snack enthusiasts nationwide.', 0.017
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'IMS', 'Ice Mint Strips', id, 45.11, 45.11, 'Popular maker of ice mint strips, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ECL', 'Energy Chew Labs', id, 20.70, 20.70, 'Popular maker of energy chew labs, loved by snack enthusiasts nationwide.', 0.038
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'EGT', 'Electrolyte Gum Tech', id, 31.58, 31.58, 'Popular maker of electrolyte gum tech, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SLC', 'Sour Lemon Chew', id, 24.28, 24.28, 'Popular maker of sour lemon chew, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PMG1', 'Pineapple Mint Gum', id, 50.85, 50.85, 'Popular maker of pineapple mint gum, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'VMC', 'Vanilla Mint Chew', id, 10.60, 10.60, 'Popular maker of vanilla mint chew, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'POGU', 'Pomegranate Gum', id, 54.59, 54.59, 'Popular maker of pomegranate gum, loved by snack enthusiasts nationwide.', 0.040
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ABC1', 'Acai Berry Chew', id, 5.88, 5.88, 'Popular maker of acai berry chew, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCG', 'Spiced Cinnamon Gum', id, 32.92, 32.92, 'Popular maker of spiced cinnamon gum, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FBD', 'Fresh Breath Drops', id, 77.13, 77.13, 'Popular maker of fresh breath drops, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BSDC', 'Baking Soda Dent Chew', id, 37.10, 37.10, 'Popular maker of baking soda dent chew, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'XTG', 'Xylitol Tooth Gum', id, 9.86, 9.86, 'Popular maker of xylitol tooth gum, loved by snack enthusiasts nationwide.', 0.029
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'JFT', 'Juicy Fruit Tech', id, 78.59, 78.59, 'Popular maker of juicy fruit tech, loved by snack enthusiasts nationwide.', 0.020
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DLC', 'Doublemint Leaf Co', id, 82.90, 82.90, 'Popular maker of doublemint leaf co, loved by snack enthusiasts nationwide.', 0.034
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BRCC', 'Big Red Cinnamon Chew', id, 41.83, 41.83, 'Popular maker of big red cinnamon chew, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HBL', 'Hubba Bubble Labs', id, 77.21, 77.21, 'Popular maker of hubba bubble labs, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TMC', 'Trident Mint Corp', id, 72.14, 72.14, 'Popular maker of trident mint corp, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'OCC', 'Orbit Clean Chew', id, 39.15, 39.15, 'Popular maker of orbit clean chew, loved by snack enthusiasts nationwide.', 0.030
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ELF', 'Extra Long Fresh', id, 59.55, 59.55, 'Popular maker of extra long fresh, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'AMG', 'Airwaves Menthol Gum', id, 38.26, 38.26, 'Popular maker of airwaves menthol gum, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'GUM_TECH'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GDD', 'Glazed Donut Dynasty', id, 39.00, 39.00, 'Popular maker of glazed donut dynasty, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CRS1', 'Cinnamon Roll Shack', id, 42.75, 42.75, 'Popular maker of cinnamon roll shack, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CSC1', 'Churro Stand Chain', id, 34.78, 34.78, 'Popular maker of churro stand chain, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'HCFS', 'Hot Chocolate Fudge Shack', id, 6.52, 6.52, 'Popular maker of hot chocolate fudge shack, loved by snack enthusiasts nationwide.', 0.038
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'VCE', 'Vanilla Custard Eclair', id, 7.35, 7.35, 'Popular maker of vanilla custard eclair, loved by snack enthusiasts nationwide.', 0.016
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SSB', 'Strawberry Shortcake Bar', id, 76.92, 76.92, 'Popular maker of strawberry shortcake bar, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'AFB', 'Apple Fritter Bakery', id, 75.82, 75.82, 'Popular maker of apple fritter bakery, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BMC1', 'Blueberry Muffin Co', id, 8.03, 8.03, 'Popular maker of blueberry muffin co, loved by snack enthusiasts nationwide.', 0.016
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CFB1', 'Chocolate Fudge Brownie', id, 67.59, 67.59, 'Popular maker of chocolate fudge brownie, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BWH', 'Belgian Waffle House', id, 32.50, 32.50, 'Popular maker of belgian waffle house, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'STBA', 'Stroopwafel Bakery', id, 34.82, 34.82, 'Popular maker of stroopwafel bakery, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FMS', 'French Macaron Salon', id, 80.80, 80.80, 'Popular maker of french macaron salon, loved by snack enthusiasts nationwide.', 0.032
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ICSP', 'Ice Cream Sundae Parlor', id, 5.72, 5.72, 'Popular maker of ice cream sundae parlor, loved by snack enthusiasts nationwide.', 0.017
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'GGS', 'Gelato Gourmet Shop', id, 33.40, 33.40, 'Popular maker of gelato gourmet shop, loved by snack enthusiasts nationwide.', 0.038
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FYB', 'Frozen Yogurt Bliss', id, 73.58, 73.58, 'Popular maker of frozen yogurt bliss, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SCT', 'S''mores Campfire Treats', id, 58.16, 58.16, 'Popular maker of s''mores campfire treats, loved by snack enthusiasts nationwide.', 0.017
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BSS', 'Banana Split Shack', id, 51.30, 51.30, 'Popular maker of banana split shack, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CSC2', 'Crepe Suzette Corner', id, 77.14, 77.14, 'Popular maker of crepe suzette corner, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PPB1', 'Pecan Pie Bakery', id, 42.52, 42.52, 'Popular maker of pecan pie bakery, loved by snack enthusiasts nationwide.', 0.033
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'KLPH', 'Key Lime Pie House', id, 68.91, 68.91, 'Popular maker of key lime pie house, loved by snack enthusiasts nationwide.', 0.019
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CAC', 'Caramel Apple Cart', id, 25.51, 25.51, 'Popular maker of caramel apple cart, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FCF', 'Funnel Cake Fairground', id, 9.94, 9.94, 'Popular maker of funnel cake fairground, loved by snack enthusiasts nationwide.', 0.021
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RVC', 'Red Velvet Cupcake', id, 62.20, 62.20, 'Popular maker of red velvet cupcake, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CFS1', 'Cheesecake Factory Slice', id, 16.83, 16.83, 'Popular maker of cheesecake factory slice, loved by snack enthusiasts nationwide.', 0.037
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MLCS', 'Molten Lava Cake Shack', id, 47.61, 47.61, 'Popular maker of molten lava cake shack, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PRBA', 'Profiterole Bakery', id, 16.65, 16.65, 'Popular maker of profiterole bakery, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PSS', 'Pancake Stack Shack', id, 56.20, 56.20, 'Popular maker of pancake stack shack, loved by snack enthusiasts nationwide.', 0.035
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MSW', 'Maple Syrup Waffles', id, 46.63, 46.63, 'Popular maker of maple syrup waffles, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CBC1', 'Cannoli Bakery Chain', id, 23.15, 23.15, 'Popular maker of cannoli bakery chain, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BSC', 'Baklava Sweet Corner', id, 38.50, 38.50, 'Popular maker of baklava sweet corner, loved by snack enthusiasts nationwide.', 0.035
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BFB', 'Beignet French Bakery', id, 18.62, 18.62, 'Popular maker of beignet french bakery, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'TCC3', 'Tiramisu Cafe Chain', id, 14.58, 14.58, 'Popular maker of tiramisu cafe chain, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PCH', 'Peach Cobbler House', id, 84.23, 84.23, 'Popular maker of peach cobbler house, loved by snack enthusiasts nationwide.', 0.025
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'PPS', 'Pumpkin Pie Shack', id, 50.70, 50.70, 'Popular maker of pumpkin pie shack, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RTB', 'Raspberry Tart Bakery', id, 64.73, 64.73, 'Popular maker of raspberry tart bakery, loved by snack enthusiasts nationwide.', 0.038
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'LMS', 'Lemon Meringue Shop', id, 80.67, 80.67, 'Popular maker of lemon meringue shop, loved by snack enthusiasts nationwide.', 0.026
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CTS1', 'Choco Tacos Shack', id, 62.03, 62.03, 'Popular maker of choco tacos shack, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SSIC', 'Soft Serve Ice Cream', id, 34.68, 34.68, 'Popular maker of soft serve ice cream, loved by snack enthusiasts nationwide.', 0.018
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'POPA', 'Popsicle Paradise', id, 70.00, 70.00, 'Popular maker of popsicle paradise, loved by snack enthusiasts nationwide.', 0.016
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'ICSC', 'Ice Cream Sandwich Co', id, 11.90, 11.90, 'Popular maker of ice cream sandwich co, loved by snack enthusiasts nationwide.', 0.039
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'MDC', 'Milkshake Diner Chain', id, 84.72, 84.72, 'Popular maker of milkshake diner chain, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'RBFS', 'Root Beer Float Shack', id, 39.40, 39.40, 'Popular maker of root beer float shack, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DHE', 'Donut Hole Express', id, 84.32, 84.32, 'Popular maker of donut hole express, loved by snack enthusiasts nationwide.', 0.035
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'EPG', 'Eclair Pastry Guild', id, 24.79, 24.79, 'Popular maker of eclair pastry guild, loved by snack enthusiasts nationwide.', 0.027
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'FTB', 'Fruit Tart Boutique', id, 29.69, 29.69, 'Popular maker of fruit tart boutique, loved by snack enthusiasts nationwide.', 0.024
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BCB', 'Bundt Cake Bakery', id, 81.02, 81.02, 'Popular maker of bundt cake bakery, loved by snack enthusiasts nationwide.', 0.023
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'CSS', 'Cupcake Sugar Shack', id, 61.89, 61.89, 'Popular maker of cupcake sugar shack, loved by snack enthusiasts nationwide.', 0.031
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'BSB', 'Brownie Sundae Bar', id, 32.94, 32.94, 'Popular maker of brownie sundae bar, loved by snack enthusiasts nationwide.', 0.036
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'DPK', 'Danish Pastry Kingdom', id, 76.13, 76.13, 'Popular maker of danish pastry kingdom, loved by snack enthusiasts nationwide.', 0.022
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO stocks (symbol, name, sector_id, base_price, current_price, description, volatility)
SELECT 'SBB', 'Sweet Brioche Bakery', id, 13.51, 13.51, 'Popular maker of sweet brioche bakery, loved by snack enthusiasts nationwide.', 0.028
FROM sectors WHERE key = 'SUGAR_SHACK'
ON CONFLICT (symbol) DO NOTHING;


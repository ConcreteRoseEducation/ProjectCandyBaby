-- Clear old duplicate test/demo accounts from previous testing
DELETE FROM users WHERE firebase_uid LIKE 'dev:google_trader_%' OR firebase_uid = 'dev:google_test_user_%' OR firebase_uid = 'dev:guest';

-- Ensure username is strictly unique across all player accounts
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'users_username_key'
    ) THEN
        ALTER TABLE users ADD CONSTRAINT users_username_key UNIQUE (username);
    END IF;
END $$;

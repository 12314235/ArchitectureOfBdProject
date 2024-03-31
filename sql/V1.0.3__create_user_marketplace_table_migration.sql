BEGIN;
	CREATE TABLE IF NOT EXISTS user_marketplace(
		user_id INTEGER NOT NULL,
		marketplace_id INTEGER NOT NULL,
		CONSTRAINT fk_user
			FOREIGN KEY(user_id)
			REFERENCES users(user_id)
			ON DELETE SET NULL,
		CONSTRAINT fk_marketplace
			FOREIGN KEY(marketplace_id)
			REFERENCES marketplace(marketplace_id)
			ON DELETE SET NULL
	);
COMMIT;

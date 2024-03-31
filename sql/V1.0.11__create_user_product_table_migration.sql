BEGIN;
	CREATE TABLE IF NOT EXISTS user_product(
		user_id INTEGER,
		product_id INTEGER,
		CONSTRAINT fk_user
			FOREIGN KEY(user_id)
			REFERENCES users(user_id),
		CONSTRAINT fk_product
			FOREIGN KEY(product_id)
			REFERENCES product(product_id)
	);
COMMIT;

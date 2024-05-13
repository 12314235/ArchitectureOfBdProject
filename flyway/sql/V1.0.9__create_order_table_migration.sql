BEGIN;
CREATE TABLE IF NOT EXISTS order_table (
	order_id SERIAL PRIMARY KEY,
	customer_id INTEGER NOT NULL,
	order_time TIMESTAMP,
	marketplace_id INTEGER,
	CONSTRAINT fk_customer
		FOREIGN KEY(customer_id)
		REFERENCES customer(customer_id)
		ON DELETE SET NULL,
	CONSTRAINT fk_marketplace
		FOREIGN KEY(marketplace_id)
		REFERENCES marketplace(marketplace_id)
		ON DELETE SET NULL
);
COMMIT;

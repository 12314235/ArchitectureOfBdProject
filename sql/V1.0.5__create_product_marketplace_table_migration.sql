BEGIN;
	CREATE TABLE IF NOT EXISTS product_marketplace(
		product_id INTEGER,
		marketplace_id INTEGER,
		CONSTRAINT fk_product
			FOREIGN KEY(product_id)
			REFERENCES product(product_id)
			ON DELETE SET NULL,
		CONSTRAINT fk_marketplace
			FOREIGN KEY(marketplace_id)
			REFERENCES marketplace(marketplace_id)
	);
COMMIT;

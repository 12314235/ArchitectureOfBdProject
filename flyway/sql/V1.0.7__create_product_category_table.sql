BEGIN;
	CREATE TABLE IF NOT EXISTS product_category(
		product_id INTEGER,
		category_id INTEGER,
		CONSTRAINT fk_product
			FOREIGN KEY(product_id)
			REFERENCES product(product_id)
			ON DELETE SET NULL,
		CONSTRAINT fk_category
			FOREIGN KEY(category_id)
			REFERENCES category(category_id)
	);
COMMIT;

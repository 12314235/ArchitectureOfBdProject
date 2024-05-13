BEGIN;
	CREATE TABLE IF NOT EXISTS order_detail (
		order_details_id SERIAL PRIMARY KEY,
		order_id INTEGER,
		product_id INTEGER,
		quantity INTEGER,
		price NUMERIC(10,2),
		CONSTRAINT fk_order
			FOREIGN KEY(order_id)
			REFERENCES order_table(order_id),
		CONSTRAINT fk_product
			FOREIGN KEY(product_id)
			REFERENCES product(product_id)
	);
COMMIT;

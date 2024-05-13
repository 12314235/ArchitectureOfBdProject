BEGIN;
	CREATE TABLE IF NOT EXISTS feedback (
		feedback_id SERIAL PRIMARY KEY,
		customer_id INTEGER,
		product_id INTEGER,
		description VARCHAR(256),
		rating NUMERIC(2,1),
		order_id INTEGER,
		CONSTRAINT fk_customer
			FOREIGN KEY(customer_id)
			REFERENCES customer(customer_id),
		CONSTRAINT fk_product
			FOREIGN KEY(product_id)
			REFERENCES product(product_id),
		CONSTRAINT fk_order
			FOREIGN KEY(order_id)
			REFERENCES order_table(order_id)
	);
COMMIT;

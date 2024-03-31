BEGIN;
	CREATE TABLE IF NOT EXISTS product(
		product_id SERIAL PRIMARY KEY,
		name VARCHAR(255),
		description VARCHAR(255),
		price NUMERIC(10,2),
		quantity INTEGER,
		image_url VARCHAR(255)
	);
COMMIT;

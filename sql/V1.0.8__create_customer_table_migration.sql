BEGIN;
	CREATE TABLE IF NOT EXISTS customer(
		customer_id SERIAL PRIMARY KEY,
		name VARCHAR(100) NOT NULL,
		surname VARCHAR(100),
		nickname VARCHAR(100),
		phone_number NUMERIC(15,0)
	);
COMMIT;

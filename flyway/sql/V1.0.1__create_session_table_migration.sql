BEGIN;
	CREATE TABLE IF NOT EXISTS session (
		session_id SERIAL PRIMARY KEY,
		user_id INTEGER,
	        creation_time TIMESTAMP,
		exit_timestamp TIMESTAMP,
		ip_address INET,
		CONSTRAINT fk_user
			FOREIGN KEY(user_id)
			REFERENCES users(user_id)
			ON DELETE SET NULL
	);
COMMIT;

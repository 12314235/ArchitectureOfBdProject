CREATE OR REPLACE FUNCTION insert_fake_session(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO session (user_id, creation_time, exit_timestamp, ip_address)
SELECT
    (SELECT user_id FROM users ORDER BY random() LIMIT 1),
    '2014-01-10 20:00:00',
	'2014-01-10 20:00:00',
	(SELECT faker.password());

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_session(100);

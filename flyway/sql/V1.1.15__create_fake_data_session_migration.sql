CREATE OR REPLACE FUNCTION insert_fake_session(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO session (user_id, creation_time, exit_timestamp, ip_address)
SELECT
    (SELECT user_id FROM users WHERE (user_id * 17) % 10 = i % 10 GROUP BY user_id LIMIT 1),
    (SELECT timestamp '2014-01-10 20:00:00' +
       random() * (timestamp '2014-01-20 20:00:00' -
                   timestamp '2014-01-10 10:00:00')),
	(SELECT timestamp '2014-01-10 20:00:00' +
       random() * (timestamp '2014-01-20 20:00:00' -
                   timestamp '2014-01-10 10:00:00')),
	(SELECT faker.password());

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_session(1000000);

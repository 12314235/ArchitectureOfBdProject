CREATE OR REPLACE FUNCTION insert_fake_user_marketplace(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO user_marketplace (user_id, marketplace_id)
SELECT
    (SELECT user_id FROM users ORDER BY random() LIMIT 1),
    (SELECT marketplace_id FROM marketplace ORDER BY random() LIMIT 1);

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_user_marketplace(${CORTAGES_COUNT_MAIN_ENTITIES});

CREATE OR REPLACE FUNCTION insert_fake_user_marketplace(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
    min_user INT := (SELECT MIN(user_id) FROM users);
    max_user INT := (SELECT MAX(user_id) FROM users);
    min_mc INT := (SELECT MIN(marketplace_id) FROM marketplace);
    max_mc INT := (SELECT MAX(marketplace_id) FROM marketplace);
BEGIN 
    WHILE i <= num_rows LOOP
        INSERT INTO user_marketplace (user_id, marketplace_id)
SELECT
    floor(random() * (max_user - min_user + 1)) + min_user,
    floor(random() * (max_mc - min_mc + 1)) + min_mc;

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_user_marketplace(${CORTAGES_COUNT_MAIN_ENTITIES});
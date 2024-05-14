CREATE OR REPLACE FUNCTION insert_fake_user_product(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
    min_user INT := (SELECT MIN(user_id) FROM users);
    max_user INT := (SELECT MAX(user_id) FROM users);
    min_product INT := (SELECT MIN(product_id) FROM product);
    max_product INT := (SELECT MAX(product_id) FROM product);
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO user_product (user_id, product_id)
SELECT
    floor(random() * (max_user - min_user + 1)) + min_user,
    floor(random() * (max_product - min_product + 1)) + min_product;

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_user_product(${CORTAGES_COUNT_MIDDLE_ENTITIES});

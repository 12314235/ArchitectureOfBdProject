CREATE OR REPLACE FUNCTION insert_fake_user_product(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO user_product (user_id, product_id)
SELECT
    (SELECT user_id FROM users WHERE (user_id * 17) % 10 = i % 10 GROUP BY user_id LIMIT 1),
    (SELECT product_id FROM product WHERE (product_id * 13) % 10 = i % 10 GROUP BY product_id LIMIT 1);

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_user_product(1000000);

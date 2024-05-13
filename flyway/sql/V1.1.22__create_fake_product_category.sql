CREATE OR REPLACE FUNCTION insert_fake_product_category(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO product_category (product_id, category_id)
SELECT
    (SELECT product_id FROM product ORDER BY random() LIMIT 1),
    (SELECT category_id FROM category ORDER BY random() LIMIT 1);

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_product_category(${CORTAGES_COUNT_MAIN_ENTITIES});

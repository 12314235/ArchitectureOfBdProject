CREATE OR REPLACE FUNCTION insert_fake_product_marketplace(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
    min_product INT := (SELECT MIN(product_id) FROM product);
    max_product INT := (SELECT MAX(product_id) FROM product);
    min_mc INT := (SELECT MIN(marketplace_id) FROM marketplace);
    max_mc INT := (SELECT MAX(marketplace_id) FROM marketplace);
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO product_marketplace (product_id, marketplace_id)
SELECT
    floor(random() * (max_product - min_product + 1)) + min_product,
    floor(random() * (max_mc - min_mc + 1)) + min_mc;

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_product_marketplace(${CORTAGES_COUNT_MAIN_ENTITIES});

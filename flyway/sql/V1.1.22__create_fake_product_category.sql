CREATE OR REPLACE FUNCTION insert_fake_product_category(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
    min_product INT := (SELECT MIN(product_id) FROM product);
    max_product INT := (SELECT MAX(product_id) FROM product);
    min_category INT := (SELECT MIN(category_id) FROM category);
    max_category INT := (SELECT MAX(category_id) FROM category);
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO product_category (product_id, category_id)
SELECT
    floor(random() * (max_product - min_product + 1)) + min_product,
    floor(random() * (max_category - min_category + 1)) + min_category;

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_product_category(${CORTAGES_COUNT_MAIN_ENTITIES});

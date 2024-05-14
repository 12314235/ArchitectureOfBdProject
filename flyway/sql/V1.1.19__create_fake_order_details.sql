CREATE OR REPLACE FUNCTION insert_fake_order_detail(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
    min_order INT := (SELECT MIN(order_id) FROM order_table);
    max_order INT := (SELECT MAX(order_id) FROM order_table);
    min_product INT := (SELECT MIN(product_id) FROM product);
    max_product INT := (SELECT MAX(product_id) FROM product);
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO order_detail (order_id, product_id, quantity, price)
        SELECT
            floor(random() * (max_order - min_order + 1)) + min_order,
            floor(random() * (max_product - min_product)) + min_product,
            (SELECT (random()*20000000)::INTEGER),
            round(random()::INTEGER, 2); 
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT insert_fake_order_detail(${CORTAGES_COUNT_MAIN_ENTITIES});

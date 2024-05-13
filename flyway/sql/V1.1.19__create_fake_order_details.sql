CREATE OR REPLACE FUNCTION insert_fake_order_detail(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO order_detail (order_id, product_id, quantity, price)
        SELECT
            (SELECT order_id FROM order_table ORDER BY random() LIMIT 1),
            (SELECT product_id FROM product ORDER BY random() LIMIT 1),
            (SELECT (random()*20000000)::INTEGER),
            round(random()::INTEGER, 2); 
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT insert_fake_order_detail(${CORTAGES_COUNT_MAIN_ENTITIES});

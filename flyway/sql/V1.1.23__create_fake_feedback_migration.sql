CREATE OR REPLACE FUNCTION insert_fake_feedback(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO feedback (customer_id, product_id, description, rating, order_id)
        SELECT
            (SELECT customer_id FROM customer ORDER BY random() LIMIT 1),
            (SELECT product_id FROM product ORDER BY random() LIMIT 1),
		faker.text(),
            round(random()::INTEGER, 1),
	(SELECT order_id FROM order_table ORDER BY random() LIMIT 1);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT insert_fake_feedback(${CORTAGES_COUNT_MIDDLE_ENTITIES});

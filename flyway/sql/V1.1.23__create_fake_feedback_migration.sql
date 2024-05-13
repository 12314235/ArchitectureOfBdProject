CREATE OR REPLACE FUNCTION insert_fake_feedback(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO feedback (customer_id, product_id, description, rating, order_id)
        SELECT
            (SELECT customer_id FROM customer WHERE (customer_id * 17) % 10 = i % 10 GROUP BY customer_id LIMIT 1),
            (SELECT product_id FROM product WHERE (product_id * 17) % 10 = i % 10 GROUP BY product_id LIMIT 1),
		faker.text(),
            round(random()::INTEGER, 1),
	(SELECT order_id FROM order_table WHERE (order_id * 17) % 10 = i % 10 GROUP BY order_id LIMIT 1);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT insert_fake_feedback(1000000);

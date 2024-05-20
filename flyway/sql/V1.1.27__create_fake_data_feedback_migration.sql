CREATE OR REPLACE FUNCTION insert_fake_feedback_new(num_rows INT)
RETURNS VOID AS $$
DECLARE
i INT := 1;
max_customer INT := (SELECT MAX(customer_id) FROM customer);
min_customer INT := (SELECT MIN(customer_id) FROM customer);
max_product INT := (SELECT MAX(product_id) FROM product);
min_product INT := (SELECT MIN(product_id) FROM product);
max_order INT := (SELECT MAX(order_id) FROM order_table);
min_order INT := (SELECT MIN(order_id) FROM order_table);
BEGIN
WHILE i <= num_rows LOOP
INSERT INTO feedback (customer_id, product_id, description, rating, order_id, feedback_date)
SELECT
floor(random() * (max_customer - min_customer + 1)) + min_customer,
floor(random() * (max_product - min_product + 1)) + min_product,
faker.text(),
round(random()::INTEGER, 1),
floor(random() * (max_order - min_order + 1)) + min_order,
'2020-01-01'::date + (floor(random() * (365 * 5)) || ' days')::interval;
i := i + 1;
END LOOP;
END;
$$ LANGUAGE plpgsql;
SELECT insert_fake_feedback_new(${CORTAGES_COUNT_MAIN_ENTITIES});
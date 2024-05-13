CREATE OR REPLACE FUNCTION insert_fake_order(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO order_table (customer_id, order_time, marketplace_id)
SELECT
    (SELECT customer_id FROM customer WHERE (customer_id * 17) % 10 = i % 10 GROUP BY customer_id LIMIT 1),
    (SELECT timestamp '2014-01-10 20:00:00' +
       random() * (timestamp '2014-01-20 20:00:00' -
                   timestamp '2014-01-10 10:00:00')),
	(SELECT marketplace_id FROM marketplace WHERE (marketplace_id * 17) % 10 = i % 10 GROUP BY marketplace_id LIMIT 1);

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_order(1000000);

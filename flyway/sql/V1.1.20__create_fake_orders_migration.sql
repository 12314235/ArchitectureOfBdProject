CREATE OR REPLACE FUNCTION insert_fake_order(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
    min_customer INT := (SELECT MIN(customer_id) FROM customer);
    max_customer INT := (SELECT MAX(customer_id) FROM customer);
    min_mc INT := (SELECT MIN(marketplace_id) FROM marketplace);
    max_mc INT := (SELECT MAX(marketplace_id) FROM marketplace);
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO order_table (customer_id, order_time, marketplace_id)
SELECT
    floor(random() * (max_customer - min_customer + 1)) + min_customer,
    (SELECT timestamp '2014-01-10 20:00:00' +
       random() * (timestamp '2014-01-20 20:00:00' -
                   timestamp '2014-01-10 10:00:00')),
	floor(random() * (max_mc - min_mc + 1)) + min_mc;

	i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_order(${CORTAGES_COUNT_MIDDLE_ENTITIES});

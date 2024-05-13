CREATE OR REPLACE FUNCTION insert_fake_customer(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO customer (name, surname, nickname, phone_number)
        VALUES (
            faker.name(),
            faker.last_name(),
            faker.name(), 
            faker.phone_number()
        );
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


SELECT insert_fake_customer(${CORTAGES_COUNT_MAIN_ENTITIES});

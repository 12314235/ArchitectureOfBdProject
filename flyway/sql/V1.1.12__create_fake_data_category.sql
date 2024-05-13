CREATE OR REPLACE FUNCTION insert_fake_category(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO category (name, description)
        VALUES (
            faker.name(),
            faker.text()
        );
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;



SELECT insert_fake_category(${CORTAGES_COUNT_SMALL_ENTITIES});

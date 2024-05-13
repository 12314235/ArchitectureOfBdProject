CREATE OR REPLACE FUNCTION insert_fake_marketplaces(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO marketplace (name, api_key, secret_api, url)
        VALUES (
            faker.company(),
            faker.password(),
            faker.password(),
            faker.url()
        );
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


SELECT insert_fake_marketplaces(1000000);

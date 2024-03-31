CREATE OR REPLACE FUNCTION insert_fake_users(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO users (username, password, email, phone_number)
        VALUES (
            faker.name(),
            faker.password(),
            faker.email(), 
            faker.phone_number()
        );
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


SELECT insert_fake_users(1000000);

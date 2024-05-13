CREATE OR REPLACE FUNCTION insert_fake_products(num_rows INT)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= num_rows LOOP
        INSERT INTO product (name, description, price, quantity, image_url)
        VALUES (
            faker.random_company_product(),
            faker.text(),
            round(random()::INTEGER, 2), 
            random(),
		faker.url()
        );
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


SELECT insert_fake_products(1000000);

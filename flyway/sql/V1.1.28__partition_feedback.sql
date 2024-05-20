BEGIN;
	CREATE TABLE IF NOT EXISTS feedback_partitioned (
		feedback_id SERIAL,
		customer_id INTEGER,
		product_id INTEGER,
		description VARCHAR(256),
		rating NUMERIC(2,1),
		order_id INTEGER,
        feedback_date DATE,
		CONSTRAINT fk_customer
			FOREIGN KEY(customer_id)
			REFERENCES customer(customer_id),
		CONSTRAINT fk_product
			FOREIGN KEY(product_id)
			REFERENCES product(product_id),
		CONSTRAINT fk_order
			FOREIGN KEY(order_id)
			REFERENCES order_table(order_id)
	) PARTITION BY RANGE(feedback_date);

    

    CREATE TABLE feedback_y2020_first_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2020-01-01') TO ('2020-04-01');
    CREATE TABLE feedback_y2020_second_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2020-04-01') TO ('2020-07-01');
    CREATE TABLE feedback_y2020_third_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2020-07-01') TO ('2020-10-01');
    CREATE TABLE feedback_y2020_fourth_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2020-10-01') TO ('2021-01-01');

    CREATE TABLE feedback_y2021_first_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2021-01-01') TO ('2021-04-01');
    CREATE TABLE feedback_y2021_second_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2021-04-01') TO ('2021-07-01');
    CREATE TABLE feedback_y2021_third_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2021-07-01') TO ('2021-10-01');
    CREATE TABLE feedback_y2021_fourth_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2021-10-01') TO ('2022-01-01');

    CREATE TABLE feedback_y2022_first_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2022-01-01') TO ('2022-04-01');
    CREATE TABLE feedback_y2022_second_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2022-04-01') TO ('2022-07-01');
    CREATE TABLE feedback_y2022_third_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2022-07-01') TO ('2022-10-01');
    CREATE TABLE feedback_y2022_fourth_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2022-10-01') TO ('2023-01-01');

    CREATE TABLE feedback_y2023_first_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2023-01-01') TO ('2023-04-01');
    CREATE TABLE feedback_y2023_second_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2023-04-01') TO ('2023-07-01');
    CREATE TABLE feedback_y2023_third_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2023-07-01') TO ('2023-10-01');
    CREATE TABLE feedback_y2023_fourth_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2023-10-01') TO ('2024-01-01');

    CREATE TABLE feedback_y2024_first_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2024-01-01') TO ('2024-04-01');
    CREATE TABLE feedback_y2024_second_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2024-04-01') TO ('2024-07-01');
    CREATE TABLE feedback_y2024_third_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2024-07-01') TO ('2024-10-01');
    CREATE TABLE feedback_y2024_fourth_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2024-10-01') TO ('2025-01-01');

    CREATE TABLE feedback_y2025_first_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2025-01-01') TO ('2025-04-01');
    CREATE TABLE feedback_y2025_second_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2025-04-01') TO ('2025-07-01');
    CREATE TABLE feedback_y2025_third_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2025-07-01') TO ('2025-10-01');
    CREATE TABLE feedback_y2025_fourth_quarter PARTITION OF feedback_partitioned FOR VALUES FROM('2025-10-01') TO ('2026-01-01');

    INSERT INTO feedback_partitioned(feedback_id, customer_id, product_id, description, rating, order_id, feedback_date) SELECT * FROM feedback AS f WHERE f.feedback_date IS NOT NULL;

    DROP TABLE feedback;

    ALTER TABLE feedback_partitioned RENAME TO feedback;
COMMIT;

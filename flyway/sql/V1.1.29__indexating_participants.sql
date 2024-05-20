BEGIN;
    CREATE INDEX ON feedback_y2020_first_quarter(feedback_date);
    CREATE INDEX ON feedback_y2020_second_quarter(feedback_date);
    CREATE INDEX ON feedback_y2020_third_quarter(feedback_date);
    CREATE INDEX ON feedback_y2020_fourth_quarter(feedback_date);

    CREATE INDEX ON feedback_y2021_first_quarter(feedback_date);
    CREATE INDEX ON feedback_y2021_second_quarter(feedback_date);
    CREATE INDEX ON feedback_y2021_third_quarter(feedback_date);
    CREATE INDEX ON feedback_y2021_fourth_quarter(feedback_date);

    CREATE INDEX ON feedback_y2022_first_quarter(feedback_date);
    CREATE INDEX ON feedback_y2022_second_quarter(feedback_date);
    CREATE INDEX ON feedback_y2022_third_quarter(feedback_date);
    CREATE INDEX ON feedback_y2022_fourth_quarter(feedback_date);

    CREATE INDEX ON feedback_y2023_first_quarter(feedback_date);
    CREATE INDEX ON feedback_y2023_second_quarter(feedback_date);
    CREATE INDEX ON feedback_y2023_third_quarter(feedback_date);
    CREATE INDEX ON feedback_y2023_fourth_quarter(feedback_date);

    CREATE INDEX ON feedback_y2024_first_quarter(feedback_date);
    CREATE INDEX ON feedback_y2024_second_quarter(feedback_date);
    CREATE INDEX ON feedback_y2024_third_quarter(feedback_date);
    CREATE INDEX ON feedback_y2024_fourth_quarter(feedback_date);

    CREATE INDEX ON feedback_y2025_first_quarter(feedback_date);
    CREATE INDEX ON feedback_y2025_second_quarter(feedback_date);
    CREATE INDEX ON feedback_y2025_third_quarter(feedback_date);
    CREATE INDEX ON feedback_y2025_fourth_quarter(feedback_date);
COMMIT;
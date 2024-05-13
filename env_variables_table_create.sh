psql -U postgres -h localhost -p 5432 -d database -c 'CREATE TABLE IF NOT EXISTS env_variables(id INTEGER, value INTEGER);INSERT INTO env_variables(id, value) SELECT (1, $CORTAGES_COUNT_MAIN_ENTITIES) WHERE NOT EXISTS (SELECT * FROM env_variables);'


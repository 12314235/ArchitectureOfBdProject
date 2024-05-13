#!/bin/bash

psql -d $POSTGRES_DB -U $POSTGRES_USER << EOF

CREATE ROLE reader;
CREATE ROLE writer;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO reader;

GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO writer;

CREATE USER analytic WITH PASSWORD 'password';

GRANT SELECT ON table_name TO analytic;

CREATE ROLE no_login_necessary NOLOGIN;

GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO no_login_necessary;

EOF

for username in "${@:3}"; do
    psql -d $POSTGRES_DB -U $POSTGRES_USER -c "CREATE USER $username WITH PASSWORD 'your_password';"
    psql -d $POSTGRES_DB -U $POSTGRES_USER -c "GRANT CONNECT ON DATABASE $POSTGRES_DB TO $username;"
    psql -d $POSTGRES_DB -U $POSTGRES_USER -c "GRANT no_login_necessary TO $username;"
done


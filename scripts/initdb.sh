#!/bin/bash
/usr/local/pg12tde/bin/initdb -D /var/lib/pgsql/data -K /opt/pgtde/provide_key.sh
./start.sh
/usr/local/pg12tde/bin/createdb ${POSTGRES_DB_NAME}
/usr/local/pg12tde/bin/createuser ${POSTGRES_DB_NAME}
/usr/local/pg12tde/bin/psql ${POSTGRES_DB_NAME} -c "ALTER USER ${POSTGRES_USER} with encrypted password '${POSTGRES_PASSWORD}';"
/usr/local/pg12tde/bin/psql ${POSTGRES_DB_NAME} -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ${POSTGRES_USER};"
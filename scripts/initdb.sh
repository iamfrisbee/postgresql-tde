#!/bin/bash
# create the database cluster
/usr/local/pg12tde/bin/initdb -D /var/lib/pgsql/data -K /opt/pgtde/provide_key.sh

# update the config
echo "listen_addresses = '*'" >> /var/lib/pgsql/data/postgresql.conf
echo "port = ${POSTGRES_PORT}" >> /var/lib/pgsql/data/postgresql.conf
echo "host  all all   0.0.0.0/0   md5" >> /var/lib/pgsql/data/pg_hba.conf
echo "host  all all   ::/0   md5" >> /var/lib/pgsql/data/pg_hba.conf 

# start the database
./start.sh

# create the connecting user
/usr/local/pg12tde/bin/createdb ${POSTGRES_DB_NAME}
/usr/local/pg12tde/bin/createuser ${POSTGRES_USER}
/usr/local/pg12tde/bin/psql ${POSTGRES_DB_NAME} -c "ALTER USER ${POSTGRES_USER} with encrypted password '${POSTGRES_PASSWORD}';"
/usr/local/pg12tde/bin/psql ${POSTGRES_DB_NAME} -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ${POSTGRES_USER};"
# Postgresql TDE

This image uses the open source TDE version of postgresql created by [Cybertec](https://www.cybertec-postgresql.com/en/products/postgresql-transparent-data-encryption/)

## Environment Variables

1. POSTGRES_USER a user to connect to the postgres database with (default: postgresql)
1. POSTGRES_PASSWORD the password for POSTGRES_USER (default: changeme)
1. POSTGRES_DB_NAME the name of the database (default: postgresql)
1. POSTGRES_PORT the port to run postgres on
1. POSTGRES_TDE_KEY the encryption key used to encrypt the database (default: THIS_IS_A_SUPER_SECRET_KEY)

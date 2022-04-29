# Postgresql TDE

This image uses the open source TDE version of postgresql created by [Cybertec](https://www.cybertec-postgresql.com/en/products/postgresql-transparent-data-encryption/)

## Key provider

The default key provider just echos the environment variable POSTGRES_TDE_KEY. It is recommended that you override this functionality by creating your own script that echos your encryption key and replace the script at `/opt/pgtde/scripts/provide_key.sh`

```bash
% docker run -d -p 5432:5432 -v /path/to/your/script.sh:/opt/pgtde/scripts/provide_key.sh pgsqltde
```

## Environment Variables

1. POSTGRES_USER a user to connect to the postgres database with (default: postgresql)
1. POSTGRES_PASSWORD the password for POSTGRES_USER (default: changeme)
1. POSTGRES_DB_NAME the name of the database (default: postgresql)
1. POSTGRES_PORT the port to run postgres on
1. POSTGRES_TDE_KEY the 32 character hex key used to encrypt the database (default: dd015df7f1374ba6e37916f608ddb3f4)

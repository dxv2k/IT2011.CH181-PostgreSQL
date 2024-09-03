#!/bin/bash
set -e

export POSTGRES_USER="myuser"
export POSTGRES_PASSWORD="mypassword"
export POSTGRES_DB="mydatabaseexport"

# Remove any existing PG data directory if it exists and is not empty
if [ "$(ls -A $PGDATA)" ]; then
    echo "Cleaning up existing PostgreSQL data directory..."
    rm -rf ${PGDATA:?}/*
fi

# Initialize the database cluster
if [ ! -s "$PGDATA/PG_VERSION" ]; then
    echo "Initializing PostgreSQL data directory..."
    gosu postgres initdb -D "$PGDATA"

    # Start PostgreSQL in the background
    gosu postgres pg_ctl -D "$PGDATA" -o "-c listen_addresses='*'" -w start

    # Create the user and database
    gosu postgres psql -v ON_ERROR_STOP=1 --username "postgres" <<-EOSQL
        CREATE USER $POSTGRES_USER WITH SUPERUSER PASSWORD '$POSTGRES_PASSWORD';
        CREATE DATABASE $POSTGRES_DB;
        GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
EOSQL

    # Stop the server to apply configuration changes
    gosu postgres pg_ctl -D "$PGDATA" -m fast -w stop
fi

# Update PostgreSQL configuration to enable pgAudit
echo "shared_preload_libraries = 'pgaudit'" >> "$PGDATA/postgresql.conf"
echo "pgaudit.log = 'all'" >> "$PGDATA/postgresql.conf"

# Start PostgreSQL server again to apply configuration changes
exec gosu postgres docker-entrypoint.sh postgres

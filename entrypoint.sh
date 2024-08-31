#!/bin/bash
set -e

# Run the original entrypoint script provided by the postgres image
docker-entrypoint.sh postgres &

# Wait for PostgreSQL to be ready
until pg_isready -h "localhost" -p "5432" -U "$POSTGRES_USER"; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

# Execute the SQL scripts
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f ./scripts/init.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f ./scripts/create.sql

# Wait indefinitely to keep the container running
tail -f /dev/null

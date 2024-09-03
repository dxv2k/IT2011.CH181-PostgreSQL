#!/bin/bash
set -e

# Run the original entrypoint script provided by the postgres image
docker-entrypoint.sh postgres &

# Wait for PostgreSQL to be ready
until pg_isready -h "localhost" -p "5432" -U "$POSTGRES_USER"; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

# Configure pgAudit
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "CREATE EXTENSION pgaudit;"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "ALTER SYSTEM SET pgaudit.log = 'read, write, function';"
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT pg_reload_conf();"

# Execute the SQL scripts to initialize the database and user monitoring
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /scripts/init.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /scripts/create.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /scripts/create_user_activity.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /scripts/create_log_function.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /scripts/create_log_trigger.sql

# Wait indefinitely to keep the container running
tail -f /dev/null

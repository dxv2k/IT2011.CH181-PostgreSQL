FROM postgres:16

# Install the postgresql-16-pgaudit extension
RUN apt-get update && apt-get install -y postgresql-16-pgaudit

# Copy custom PostgreSQL configuration
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Use the custom configuration
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]

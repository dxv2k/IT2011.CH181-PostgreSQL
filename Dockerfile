# Use the official PostgreSQL image from the Docker Hub
FROM postgres:13

# Install pgbench and other necessary packages
RUN apt-get update && apt-get install -y postgresql-contrib vim curl rsync

# Install pgAudit
RUN apt-get update && apt-get install -y postgresql-13-pgaudit

# Set the working directory
WORKDIR /app

# COPY
COPY . .

# Ensure entrypoint script is executable
RUN chmod +x ./entrypoint.sh

# Expose the default PostgreSQL port
EXPOSE 5432

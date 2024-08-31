# Use the official PostgreSQL image from the Docker Hub
FROM postgres:latest

# Install pgbench and other necessary packages
RUN apt-get update && apt-get install -y postgresql-contrib
RUN apt-get update && apt-get install vim curl rsync -y  


# COPY
COPY . ./app

# Set the working directory
WORKDIR /app

# Expose the default PostgreSQL port
EXPOSE 5432

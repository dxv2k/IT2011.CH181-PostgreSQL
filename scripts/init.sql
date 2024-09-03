-- scripts/init.sql

-- Create a table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    department VARCHAR(50)
);

-- Create table for pgAudit  
CREATE EXTENSION IF NOT EXISTS pgaudit;

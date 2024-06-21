-- script.sql
CREATE TABLE example (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO example (name) VALUES ('Sample Name');

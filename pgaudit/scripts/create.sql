-- scripts/create.sql

-- Insert sample data into employees table
INSERT INTO employees (first_name, last_name, email, hire_date, department, user_id) VALUES
('John', 'Doe', 'john.doe@example.com', '2020-01-15', 'IT', 1),
('Jane', 'Smith', 'jane.smith@example.com', '2019-12-22', 'Finance', 2),
('Mike', 'Johnson', 'mike.johnson@example.com', '2021-03-10', 'Marketing', 3),
('Emily', 'Davis', 'emily.davis@example.com', '2022-05-07', 'HR', 4);

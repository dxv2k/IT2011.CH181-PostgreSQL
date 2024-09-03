-- scripts/create_user_activity.sql

-- Create user_activity table to log user actions
CREATE TABLE user_activity (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    action VARCHAR(255) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

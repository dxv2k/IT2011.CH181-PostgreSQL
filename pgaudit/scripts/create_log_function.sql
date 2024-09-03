-- scripts/create_log_function.sql

-- Create a function to log user actions
CREATE OR REPLACE FUNCTION log_user_action() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO user_activity (user_id, action) VALUES (NEW.user_id, TG_OP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

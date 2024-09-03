-- scripts/create_log_trigger.sql

-- Create a trigger to log user actions on the employees table
CREATE TRIGGER log_employee_actions
AFTER INSERT OR UPDATE ON employees
FOR EACH ROW EXECUTE FUNCTION log_user_action();

CREATE OR REPLACE FUNCTION trigger_to_log_action_on_activities() RETURNS TRIGGER AS $$ 
BEGIN

INSERT INTO action_log VALUES (nextval('id_generator'),'delete','activity',"user".id,'postgres');
RETURN OLD;

END;
$$ LANGUAGE PLPGSQL;


CREATE TRIGGER action_log
AFTER DELETE ON activity
FOR EACH ROW EXECUTE PROCEDURE trigger_to_log_action_on_activities();




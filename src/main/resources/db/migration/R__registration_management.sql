CREATE OR REPLACE FUNCTION register_user_on_activity(userId bigInt, activityId bigInt) RETURNS SETOF registration AS $$
	DECLARE
		newId bigint;
	BEGIN
		newId = nextval('id_generator');
		IF NOT EXISTS(SELECT * FROM "registration" WHERE user_id = userId AND activityId = id_activity) THEN
			INSERT INTO "registration" (id,user_id,activity_id)
			VALUES (newId,userId,activityId);
			
			RETURN QUERY SELECT * FROM registration
			WHERE registration.id = newId;
		ELSE
			RAISE EXCEPTION 'registration_already_exists';
		END IF;
	END;
$$ LANGUAGE PLPGSQL;
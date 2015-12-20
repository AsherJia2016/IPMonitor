CREATE OR REPLACE FUNCTION ods.load_alert_info
(
    _alert_info ods.tvp_alert_info[]
)
RETURNS void
AS $$
DECLARE
    _local_now timestamp := (now() AT TIME ZONE 'UTC-8');
BEGIN

	INSERT INTO ods.alert_info
	(
		ip,
		first_lost_time,
		second_lost_time,
		send,
		create_date,
		recovery_time
	)
	SELECT
		record.ip,
		record.first_lost_time,
		record.second_lost_time,
		record.send,
		_local_now,
		record.recovery_time
	FROM
		unnest(_alert_info) AS record;
END;
$$ LANGUAGE PLPGSQL;
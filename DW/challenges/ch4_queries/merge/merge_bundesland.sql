OPEN SCHEMA NOAH_JUTZ;

MERGE INTO Bundesland t
USING (SELECT MAX(VALUE_ID) AS VALUE_ID, LABEL
       FROM (
                SELECT DISTINCT v.VALUE_ID, v.LABEL
                FROM ST_META_POLITBAROMETER_VALUE_LABELS v
                WHERE v.VARIABLE_ID = 'v75'
                  AND v.VALUE_ID > 0
                UNION
                SELECT DISTINCT null, state_name
                FROM ST_META_BUNDESTAG_DISTRICTS d
                WHERE d.ERROR_INFO IS NULL
                )
       GROUP BY LABEL) AS s
ON t.STATE_VALUE_ID = s.VALUE_ID
WHEN MATCHED THEN
    UPDATE
    SET t.state_name = s.LABEL
WHEN NOT MATCHED THEN
    INSERT (STATE_VALUE_ID, STATE_NAME)
    VALUES (s.VALUE_ID,
            s.LABEL);
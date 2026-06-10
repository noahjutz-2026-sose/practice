OPEN SCHEMA NOAH_JUTZ;

MERGE INTO VOTING_DISTRICT t
USING (
    SELECT d.*, v.VALUE_ID AS STATE_VALUE_ID
    FROM ST_META_BUNDESTAG_DISTRICTS d
             JOIN ST_META_POLITBAROMETER_VALUE_LABELS v
                  ON edit_distance(d.STATE_NAME, v.label) < 2
    WHERE d.ERROR_INFO IS NULL
      AND v.VARIABLE_ID = 'v75'
    ORDER BY d.DISTRICT_ID
    ) AS s
ON t.VOTING_DISTRICT_ID = s.DISTRICT_ID
WHEN MATCHED THEN
    UPDATE
    SET t.voting_district_name = s.DISTRICT_NAME,
        t.STATE_ID       = s.STATE_VALUE_ID,
        t.is_west_germany      = default
WHEN NOT MATCHED THEN
    INSERT (VOTING_DISTRICT_ID, STATE_ID, VOTING_DISTRICT_NAME, IS_WEST_GERMANY)
    VALUES (s.DISTRICT_ID,
            s.STATE_VALUE_ID,
            s.DISTRICT_NAME,
            CASE
                WHEN s.STATE_NAME IN
                     ('Brandenburg', 'Mecklenburg-Vorpommern', 'Sachsen',
                      'Sachsen-Anhalt', 'Thüringen') THEN FALSE
                WHEN s.STATE_NAME = 'Berlin' AND s.DISTRICT_ID IN (74, 75, 83, 84, 85) THEN FALSE
                ELSE TRUE
                END);


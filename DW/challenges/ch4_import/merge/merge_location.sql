OPEN SCHEMA NOAH_JUTZ;

TRUNCATE TABLE LOCATION;
MERGE INTO LOCATION l
USING (
    SELECT *
    FROM ST_META_BUNDESTAG_DISTRICTS
    WHERE ERROR_INFO IS NULL
    ) AS d
ON l.VOTING_DISTRICT_ID = d.DISTRICT_ID
WHEN MATCHED THEN
    UPDATE
    SET l.voting_district_name = d.DISTRICT_NAME,
        l.state_name           = d.STATE_NAME
WHEN NOT MATCHED THEN
    INSERT (VOTING_DISTRICT_ID, VOTING_DISTRICT_NAME, STATE_NAME, IS_WEST_GERMANY)
    VALUES (d.DISTRICT_ID,
            d.DISTRICT_NAME,
            d.STATE_NAME,
            CASE
                WHEN d.STATE_NAME IN
                     ('Brandenburg', 'Mecklenburg-Vorpommern', 'Sachsen',
                      'Sachsen-Anhalt', 'Thüringen') THEN FALSE
                WHEN d.STATE_NAME = 'Berlin' AND d.DISTRICT_ID IN (74, 75, 83, 84, 85) THEN FALSE
                ELSE TRUE
                END)

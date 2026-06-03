OPEN SCHEMA NOAH_JUTZ;

SELECT *
FROM ST_POLITBAROMETER_SURVEY;

-- ST_POLITBAROMETER_SURVEY
-- Unique: (study_id, v4a_east_west, respondent_id)
-- Result: Some respondent show up twice, however I do not interpret these as duplicates
SELECT *
WITH INVALID UNIQUE (study_id, v4a_east_west, respondent_id)
FROM ST_POLITBAROMETER_SURVEY;


-- ST_BUNDESTAG_ELECTIONS
-- Unique: (intyear, district_id, party)
-- Result: No duplicates
SELECT *
WITH INVALID UNIQUE (INTYEAR, DISTRICT_ID, PARTY)
FROM ST_BUNDESTAG_ELECTIONS;

-- ST_SEAT_DISTRIBUTION
-- Unique: (intyear)
-- Result: No duplicates
SELECT *
WITH INVALID UNIQUE (INTYEAR)
FROM ST_SEAT_DISTRIBUTION;

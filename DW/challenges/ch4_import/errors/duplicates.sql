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

-- ST_META_BUNDESTAG_DISTRICTS
-- Unique: All columns
-- Result: Many duplicates
SELECT DISTRICT_ID, COUNT(*)
FROM ST_META_BUNDESTAG_DISTRICTS
GROUP BY DISTRICT_ID;

ALTER TABLE ST_META_BUNDESTAG_DISTRICTS
ADD COLUMN unique_id INT IDENTITY;

UPDATE ST_META_BUNDESTAG_DISTRICTS
SET error_info = COALESCE(error_info, '') || 'DUPLICATE;'
WHERE unique_id IN (
    SELECT unique_id
    FROM (
        SELECT unique_id,
               ROW_NUMBER() OVER (PARTITION BY district_id ORDER BY unique_id) AS rn
        FROM ST_META_BUNDESTAG_DISTRICTS
    ) sub
    WHERE rn > 1
);

-- ST_META_BUNDESTAG_PARTIES
-- Unique: Shortname
-- Result: Redundancy for alternative names
SELECT *
WITH INVALID UNIQUE (SHORTNAME)
FROM ST_META_BUNDESTAG_PARTIES;

-- ST_META_POLITBAROMETER_COLUMN_LABELS
-- Unique: (variable_id)
-- Result: No duplicates
SELECT *
WITH INVALID UNIQUE (VARIABLE_ID)
FROM ST_META_POLITBAROMETER_COLUMN_LABELS;

-- ST_META_POLITBAROMETER_VALUE_LABELS
-- Unique: (variable_id, value_id)
-- Result: No duplicates
SELECT *
WITH INVALID UNIQUE (VARIABLE_ID, VALUE_ID)
FROM ST_META_POLITBAROMETER_VALUE_LABELS;

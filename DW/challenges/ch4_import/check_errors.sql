OPEN SCHEMA NOAH_JUTZ;

SELECT *
FROM ST_POLITBAROMETER_SURVEY;

-- Duplicate checks --

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

-- Error checks --

-- ST_POLITBAROMETER_SURVEY
-- Cross-check with ST_META_POLITBAROMETER_VALUE_LABELS
SELECT s.V6_INTENDED_VOTE, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v6'
                       AND l.value_id = s.v6_intended_vote
WHERE l.value_id IS NULL
GROUP BY s.V6_INTENDED_VOTE;

-- ST_BUNDESTAG_ELECTIONS
-- Check if district_id 1..1 district_name
SELECT DISTINCT DISTRICT_ID, COUNT(DISTINCT DISTRICT_NAME)
FROM ST_BUNDESTAG_ELECTIONS
GROUP BY DISTRICT_ID
ORDER BY DISTRICT_ID;

-- ST_SEAT_DISTRIBUTION
-- Check if totaL_seats equals summation of seats
WITH CUM AS (SELECT intyear,
                    total_seats,
                    (zeroifnull(CDU) + zeroifnull(AFD) + zeroifnull(SPD) + zeroifnull(GRUENE) + zeroifnull(LINKE) +
                     zeroifnull(CSU) +
                     zeroifnull(SSW) + zeroifnull(FDP) + zeroifnull(BP) + zeroifnull(DP) + zeroifnull(KPD) +
                     zeroifnull(WAV) +
                     zeroifnull(WAV) + zeroifnull(ZENTRUM) + zeroifnull(DKPDRP) + zeroifnull(GBBHE) + zeroifnull(FDV) +
                     zeroifnull(INDEPENDENT)) AS cum
             FROM ST_SEAT_DISTRIBUTION)
SELECT INTYEAR,
       TOTAL_SEATS,
       cum
FROM CUM
WHERE TOTAL_SEATS != cum
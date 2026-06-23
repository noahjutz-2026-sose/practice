OPEN SCHEMA NOAH_JUTZ;

MERGE INTO POLITBAROMETER_PARTY_RATINGS t
USING (
    WITH base AS (SELECT (RESPONDENT_ID * 10000000) + (V4A_EAST_WEST * 1000000) + STUDY_ID AS NEW_RESPONDENT_ID,
                         TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM')      AS DATE_MONTH,
                         D_WEIGHT,
                         V8_RATING_SPD,
                         V9_RATING_CDU,
                         V11_RATING_FDP,
                         V12_RATING_GRUENE,
                         V13_RATING_AFD,
                         V14_RATING_LINKE
                  FROM ST_POLITBAROMETER_SURVEY
                  WHERE V4A_EAST_WEST > 0)
    SELECT NEW_RESPONDENT_ID, DATE_MONTH, D_WEIGHT, party, rating
    FROM (
             SELECT NEW_RESPONDENT_ID, DATE_MONTH, D_WEIGHT, 'spd' AS party, V8_RATING_SPD AS rating
             FROM base
             UNION ALL
             SELECT NEW_RESPONDENT_ID, DATE_MONTH, D_WEIGHT, 'union', V9_RATING_CDU
             FROM base
             UNION ALL
             SELECT NEW_RESPONDENT_ID, DATE_MONTH, D_WEIGHT, 'fdp', V11_RATING_FDP
             FROM base
             UNION ALL
             SELECT NEW_RESPONDENT_ID, DATE_MONTH, D_WEIGHT, 'gruene', V12_RATING_GRUENE
             FROM base
             UNION ALL
             SELECT NEW_RESPONDENT_ID, DATE_MONTH, D_WEIGHT, 'afd', V13_RATING_AFD
             FROM base
             UNION ALL
             SELECT NEW_RESPONDENT_ID, DATE_MONTH, D_WEIGHT, 'linke', V14_RATING_LINKE
             FROM base
             )
    WHERE rating > 0
    QUALIFY ROW_NUMBER() OVER (PARTITION BY NEW_RESPONDENT_ID, DATE_MONTH) = 1
    ) AS s
ON t.RESPONDENT_ID = s.NEW_RESPONDENT_ID AND t.DATE_MONTH = s.DATE_MONTH AND t.PARTY = s.party
WHEN MATCHED THEN
    UPDATE
    SET t.RATING = s.rating,
        t.WEIGHT = s.D_WEIGHT
WHEN NOT MATCHED THEN
    INSERT (RESPONDENT_ID, DATE_MONTH, WEIGHT, PARTY, RATING)
    VALUES (s.NEW_RESPONDENT_ID, s.DATE_MONTH, s.D_WEIGHT, s.party, s.rating);
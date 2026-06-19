OPEN SCHEMA NOAH_JUTZ;

MERGE INTO POLITBAROMETER_PARTY_RATINGS t
USING (
    SELECT *
    FROM (
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    D_WEIGHT,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'spd'                                                        AS party,
                    V8_RATING_SPD                                                AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    D_WEIGHT,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'union'                                                      AS party,
                    V9_RATING_CDU                                                AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    D_WEIGHT,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'fdp'                                                        AS party,
                    V11_RATING_FDP                                               AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    D_WEIGHT,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'gruene'                                                     AS party,
                    V12_RATING_GRUENE                                            AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    D_WEIGHT,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'afd'                                                        AS party,
                    V13_RATING_AFD                                               AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    D_WEIGHT,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'linke'                                                      AS party,
                    V14_RATING_LINKE                                             AS rating
             FROM ST_POLITBAROMETER_SURVEY
             ) AS x
    WHERE rating > 0
    QUALIFY row_number() OVER (PARTITION BY RESPONDENT_ID, STUDY_ID, V4A_EAST_WEST, DATE_MONTH) = 1
    ) AS s
ON t.RESPONDENT_ID = s.RESPONDENT_ID AND t.RESPONDENT_STUDY_ID = s.STUDY_ID AND
   t.RESPONDENT_EAST_WEST = s.V4A_EAST_WEST AND t.PARTY = s.party
WHEN MATCHED THEN
    UPDATE
    SET t.RATING = s.RATING, t.WEIGHT = s.D_WEIGHT
WHEN NOT MATCHED THEN
    INSERT
    VALUES (s.RESPONDENT_ID, s.STUDY_ID, s.V4A_EAST_WEST, s.D_WEIGHT, s.DATE_MONTH, s.party, s.rating);
Data Warehousing | Summer Semester 2026 | Prof. Schildgen | OTH Regensburg

---

**Name:** Noah Jutz

# Challenge 4: Data Integration and Analytical Queries

**Tasks:**

1. Analogous to the other workbook (Challenge 3).
2. Again, please put your SQL commands in code blocks. Be careful that long queries are not cut off at the right border of the page.

## Title

\*Please, again write your project title (as in the previous workbook) here). If you want to change your title, write here the old and the new title.

Bundestag Election Data Warehouse: Politische Stimmungs- und Ergebnisdatenbank

## Data Transformation

_How did you perform your data transformation? Fill out the following list with short answers and optionally one example SQL query each. Which tasks were necessary for your project? Why? Why not? How did you do it? Write at least one SQL query here. (Ex. Sheet 4, Exercise 1)_

- Checking data quality and fixing data errors: Cross-check data sources for inconsistencies and verify that cumulative datapoints add up correctly. For example:

    ```sql
    -- Cross-check data table (st_politbarometer_survey) with allowed values (st_meta_politbarometer_value_labels).
    SELECT s.v22_left_right, COUNT(*)
    FROM st_Politbarometer_Survey s
            LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                    ON l.variable_id = 'v22'
                        AND l.value_id = s.v22_left_right
    WHERE l.value_id IS NULL
    GROUP BY s.v22_left_right;
    ```

All queries: [errors](https://github.com/noahjutz-2026-sose/practice/tree/main/DW/challenges/ch4_queries/errors)

- Harmonization / Normalization: Allow one unique party name, consolidate duplicates, filter out negative values

    ```sql
    UPDATE ST_BUNDESTAG_ELECTIONS
    SET PARTY='verjuengungsforschung'
    WHERE PARTY = 'partei_fuer_gesundheitsforschung';
    ```

- Deduplication: Determine unique constraint columns and find duplicates using `GROUP BY` or `WITH INVALID UNIQUE`. For example:

    ```sql
    SELECT * WITH INVALID UNIQUE (SHORTNAME) FROM ST_META_BUNDESTAG_PARTIES;
    ```

All queries: [duplicates](https://github.com/noahjutz-2026-sose/practice/tree/main/DW/challenges/ch4_queries/duplicates)

- Fuzzy entity matching (Levensthein, Soundex, ...):
    - Match parties (st_meta_politbarometer_value_labels, st_bundestag_elections, st_seat_distribution (columns), st_meta_bundestag_parties)
    - Match districts and states (st_meta_politbarometer_survey_labels, st_meta_bundestag_districts, st_bundestag_elections)
    - For example:

    ```sql
    -- Match states (variable 75) from bundeswahlleiterin (st_meta_bundestag_districts) and politbarometer (st_meta_politbarometer_value_labels)
    SELECT d.*, v.VALUE_ID AS STATE_VALUE_ID
    FROM ST_META_BUNDESTAG_DISTRICTS d
        JOIN ST_META_POLITBAROMETER_VALUE_LABELS v
            ON edit_distance(d.STATE_NAME, v.label) < 2
    WHERE d.ERROR_INFO IS NULL
    AND v.VARIABLE_ID = 'v75'
    ORDER BY d.DISTRICT_ID
    ```

- Data Fusion (merge multiple rows into one target row): N/A

## Data Integration

_Write down a MERGE command to integrate data from your staging area into your target data-warehouse schema: (Ex. Sheet 4, Exercise 2)_

```sql
MERGE INTO POLITBAROMETER_PARTY_RATINGS t
USING (
    SELECT *
    FROM (
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'spd'                                                        AS party,
                    V8_RATING_SPD                                                AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'union'                                                      AS party,
                    V9_RATING_CDU                                                AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'fdp'                                                        AS party,
                    V11_RATING_FDP                                               AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'gruene'                                                     AS party,
                    V12_RATING_GRUENE                                            AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'afd'                                                        AS party,
                    V13_RATING_AFD                                               AS rating
             FROM ST_POLITBAROMETER_SURVEY
             UNION ALL
             SELECT RESPONDENT_ID,
                    STUDY_ID,
                    V4A_EAST_WEST,
                    TO_DATE(INTYEAR || '-' || LPAD(INTMONTH, 2, '0'), 'YYYY-MM') AS DATE_MONTH,
                    'linke'                                                      AS party,
                    V14_RATING_LINKE                                             AS rating
             FROM ST_POLITBAROMETER_SURVEY
             ) AS x
    QUALIFY row_number() OVER (PARTITION BY RESPONDENT_ID, STUDY_ID, V4A_EAST_WEST, DATE_MONTH) = 1
    ) AS s
ON t.RESPONDENT_ID = s.RESPONDENT_ID AND t.RESPONDENT_STUDY_ID = s.STUDY_ID AND
   t.RESPONDENT_EAST_WEST = s.V4A_EAST_WEST AND t.PARTY = s.party
WHEN MATCHED THEN
    UPDATE
    SET t.RATING = s.RATING
WHEN NOT MATCHED THEN
    INSERT
    VALUES (s.RESPONDENT_ID, s.STUDY_ID, s.V4A_EAST_WEST, s.DATE_MONTH, s.party, s.rating)
```

All queries: [merge](https://github.com/noahjutz-2026-sose/practice/tree/main/DW/challenges/ch4_queries/merge)

## Analytical Queries

_Write 7 SQL queries here. These can be your query ideas from your presentation (Challenge 1), but can also be other queries. Write at least one query with `GROUPING SETS` (or `ROLLUP` or `CUBE`) , one with a window function (no ranking), one with a ranking function, one with a statistical function (e.g., `STDEV_POP`), and one skyline query. Start each query with a comment that describes the query. (Ex. Sheet 6)_

```sql
-- Query 1: GROUPING SETS / ROLLUP / CUBE
-- 🖊️
-- What is the voter turnout across district, state and term?

SELECT CASE
           WHEN GROUPING(c.TERM) = 0 AND GROUPING(s.STATE_NAME) = 0 AND GROUPING(d.VOTING_DISTRICT_NAME) = 0
               THEN 'District Level'
           WHEN GROUPING(c.TERM) = 0 AND GROUPING(s.STATE_NAME) = 0 THEN 'State Level'
           WHEN GROUPING(c.TERM) = 0 THEN 'Term Level'
           ELSE 'Grand Total'
           END                                                 AS GROUP_LEVEL,
       c.TERM,
       s.STATE_NAME,
       d.VOTING_DISTRICT_NAME,
       SUM(c.VOTERS) / SUM(c.VOTING_ELIGIBLE_POPULATION) * 100 AS TURNOUT_PERCENTAGE
FROM BUNDESTAG_ELECTION_CENSUS c
         JOIN VOTING_DISTRICT d ON c.DISTRICT_ID = d.VOTING_DISTRICT_ID
         JOIN BUNDESLAND s ON d.STATE_ID = s.STATE_VALUE_ID
GROUP BY ROLLUP (c.TERM, s.STATE_NAME, d.VOTING_DISTRICT_NAME)
ORDER BY c.TERM, s.STATE_NAME, d.VOTING_DISTRICT_NAME;

```

```sql
-- Query 2: Window Function (no ranking)
-- 🖊️
-- How does each party's average rating change month over month? (considering row weight)

SELECT PARTY,
       DATE_MONTH,
       SUM(RATING * WEIGHT) / SUM(WEIGHT)                                                       AS CURRENT_AVG_RATING,
       LAG(SUM(RATING * WEIGHT) / SUM(WEIGHT), 1) OVER (PARTITION BY PARTY ORDER BY DATE_MONTH) AS PREVIOUS_MONTH_AVG,
       SUM(RATING * WEIGHT) / SUM(WEIGHT) -
       LAG(SUM(RATING * WEIGHT) / SUM(WEIGHT), 1) OVER (PARTITION BY PARTY ORDER BY DATE_MONTH) AS SENTIMENT_DELTA
FROM POLITBAROMETER_PARTY_RATINGS
WHERE WEIGHT > 0
GROUP BY PARTY, DATE_MONTH
ORDER BY DATE_MONTH;
```

```sql
-- Query 3: Window Function (ranking query)
-- 🖊️
-- What is the dominant party in each state for each term?

WITH StatePartyVotes AS (
    SELECT
        er.TERM,
        b.STATE_NAME,
        er.PARTY,
        SUM(er.VOTES) AS TOTAL_STATE_VOTES
    FROM BUNDESTAG_ELECTION_RESULT er
    JOIN VOTING_DISTRICT vd ON er.DISTRICT_ID = vd.VOTING_DISTRICT_ID
    JOIN BUNDESLAND b      ON vd.STATE_ID = b.STATE_VALUE_ID
    GROUP BY er.TERM, b.STATE_NAME, er.PARTY
),
RankedStateVotes AS (
    SELECT
        TERM,
        STATE_NAME,
        PARTY,
        TOTAL_STATE_VOTES,
        RANK() OVER (PARTITION BY TERM, STATE_NAME ORDER BY TOTAL_STATE_VOTES DESC) AS VoteRank
    FROM StatePartyVotes
)
SELECT
    TERM,
    STATE_NAME,
    PARTY,
    TOTAL_STATE_VOTES
FROM RankedStateVotes
WHERE VoteRank = 1
ORDER BY TERM DESC, STATE_NAME;
```

```sql
-- Query 4: Statistical Function
-- 🖊️
-- How correlated are personal financial standing and government approval in each state?

SELECT
    b.STATE_NAME,
    CORR(ps.RATING_GOVERNMENT, 6 - r.FINANCIAL_STANDING_FORECAST) AS CORRELATION_COEFF,
    COVAR_POP(ps.RATING_GOVERNMENT, 6 - r.FINANCIAL_STANDING_FORECAST) AS COVARIANCE_POP,
    COUNT(*) AS SAMPLE_SIZE
FROM POLITBAROMETER_SURVEY ps
JOIN RESPONDENT r
    ON ps.RESPONDENT_ID = r.RESPONDENT_ID
   AND ps.RESPONDENT_STUDY_ID = r.STUDY_ID
   AND ps.RESPONDENT_EAST_WEST = r.EAST_WEST
JOIN BUNDESLAND b
    ON r.BUNDESLAND_ID = b.STATE_VALUE_ID
GROUP BY b.STATE_NAME;
```

```sql
-- Query 5: Skyline Query
-- 🖊️
-- In which districts was voter turnout high with many invalid votes?

SELECT C.TERM,
       D.VOTING_DISTRICT_NAME,
       (C.VOTERS / C.VOTING_ELIGIBLE_POPULATION) AS TURNOUT,
       (C.INVALID_VOTES / C.VOTERS)              AS INVALID_RATE
FROM BUNDESTAG_ELECTION_CENSUS C
         JOIN VOTING_DISTRICT D ON C.DISTRICT_ID = D.VOTING_DISTRICT_ID
WHERE C.VOTERS > 0
    PREFERRING HIGH (C.VOTERS / C.VOTING_ELIGIBLE_POPULATION) PLUS HIGH (C.INVALID_VOTES / C.VOTERS)
ORDER BY TERM DESC, INVALID_RATE DESC;
```

```sql
-- Query 6:
-- 🖊️
-- What is the average view on CDU/CSU given any combination of demographic indicators?

SELECT lbl_gender.LABEL                         AS GENDER,
       lbl_edu.LABEL                            AS EDUCATION,
       lbl_emp.LABEL                            AS EMPLOYMENT_STATUS,
       COUNT(p.RESPONDENT_ID)                   AS TOTAL_RATINGS,
       SUM(p.RATING * p.WEIGHT) / SUM(p.WEIGHT) AS AVG_PARTY_RATING
FROM POLITBAROMETER_PARTY_RATINGS p
         JOIN RESPONDENT r
              ON p.RESPONDENT_ID = r.RESPONDENT_ID
                  AND p.RESPONDENT_STUDY_ID = r.STUDY_ID
                  AND p.RESPONDENT_EAST_WEST = r.EAST_WEST
         LEFT JOIN POLITBAROMETER_VALUE_LABELS lbl_gender
                   ON lbl_gender.VARIABLE_ID = 'v54'
                       AND r.GENDER = lbl_gender.VALUE_ID
         LEFT JOIN POLITBAROMETER_VALUE_LABELS lbl_edu
                   ON lbl_edu.VARIABLE_ID = 'v60'
                       AND r.EDUCATION = lbl_edu.VALUE_ID
         LEFT JOIN POLITBAROMETER_VALUE_LABELS lbl_emp
                   ON lbl_emp.VARIABLE_ID = 'v64'
                       AND r.EMPLOYMENT_STATUS = lbl_emp.VALUE_ID
WHERE p.PARTY = 'union'
  AND p.DATE_MONTH BETWEEN '2016-01-01' AND '2026-01-01'
GROUP BY CUBE (lbl_gender.LABEL, lbl_edu.LABEL, lbl_emp.LABEL)
HAVING COUNT(p.RESPONDENT_ID) > 1000
ORDER BY AVG_PARTY_RATING
```

```sql
-- Query 7:
-- 🖊️
-- Are powerful parties popular? How correlated is the number of seats with a party's average rating within that term?
WITH term_boundaries AS (SELECT TERM                            AS term_start,
                                LEAD(TERM) OVER (ORDER BY TERM) AS term_end
                         FROM (SELECT DISTINCT TERM FROM SEAT_DISTRIBUTION)),
     party_term_ratings AS (SELECT b.term_start,
                                   r.PARTY,
                                   AVG(r.RATING) AS avg_rating
                            FROM POLITBAROMETER_PARTY_RATINGS r
                                     JOIN term_boundaries b
                                          ON r.DATE_MONTH >= b.term_start
                                              AND (r.DATE_MONTH < b.term_end OR b.term_end IS NULL)
                            WHERE r.RATING IS NOT NULL
                            GROUP BY b.term_start, r.PARTY),
     term_metrics AS (SELECT r.term_start,
                             r.PARTY,
                             COALESCE(s.SEATS, 0) AS SEATS,
                             r.avg_rating
                      FROM party_term_ratings r
                               LEFT JOIN SEAT_DISTRIBUTION s
                                         ON r.PARTY = s.PARTY
                                             AND r.term_start = s.TERM)
SELECT COALESCE(PARTY, 'Total') AS PARTY,
       CORR(SEATS, avg_rating)  AS correlation_seats_vs_rating
FROM term_metrics
GROUP BY ROLLUP (PARTY);
```

**Please check: Have you written your name on the very top?**

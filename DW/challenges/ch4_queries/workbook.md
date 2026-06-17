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

All queries: [errors](https://github.com/noahjutz-2026-sose/practice/tree/main/DW/challenges/ch4_import/errors)

- Harmonization / Normalization: Allow one unique party name, consolidate duplicates

    ```sql
    UPDATE ST_BUNDESTAG_ELECTIONS
    SET PARTY='partei_der_vernunft'
    WHERE PARTY = 'parteidervernunft';
    ```

- Deduplication: Determine unique constraint columns and find duplicates using `sql GROUP BY` or `sql WITH INVALID UNIQUE` or `sql OVER (PARTITION BY ...)`. For example:

    ```sql
    SELECT * WITH INVALID UNIQUE (SHORTNAME) FROM ST_META_BUNDESTAG_PARTIES;
    ```

All queries: [duplicates](https://github.com/noahjutz-2026-sose/practice/tree/main/DW/challenges/ch4_import/duplicates)

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

All queries: [merge](https://github.com/noahjutz-2026-sose/practice/tree/main/DW/challenges/ch4_import/merge)

## Analytical Queries

_Write 7 SQL queries here. These can be your query ideas from your presentation (Challenge 1), but can also be other queries. Write at least one query with `GROUPING SETS` (or `ROLLUP` or `CUBE`) , one with a window function (no ranking), one with a ranking function, one with a statistical function (e.g., `STDEV_POP`), and one skyline query. Start each query with a comment that describes the query. (Ex. Sheet 6)_

```sql
-- Query 1: GROUPING SETS / ROLLUP / CUBE
-- 🖊️
SELECT 🖊️
```

```sql
-- Query 2: Window Function (no ranking)
-- 🖊️
SELECT 🖊️
```

```sql
-- Query 3: Window Function (ranking query)
-- 🖊️
SELECT 🖊️
```

```sql
-- Query 4: Statistical Function
-- 🖊️
SELECT 🖊️
```

```sql
-- Query 5: Skyline Query
-- 🖊️
SELECT 🖊️
```

```sql
-- Query 6:
-- 🖊️
SELECT 🖊️
```

```sql
-- Query 7:
-- 🖊️
SELECT 🖊️
```

**Please check: Have you written your name on the very top?**

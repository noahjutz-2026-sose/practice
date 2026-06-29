OPEN SCHEMA NOAH_JUTZ;

CREATE OR REPLACE VIEW v_calendar AS
WITH date_series AS (
    SELECT CAST('2000-01-01' AS DATE) + LEVEL - 1 AS cal_date
    FROM DUAL
    CONNECT BY LEVEL <= CAST('2040-12-31' AS DATE) - CAST('2000-01-01' AS DATE) + 1
)
SELECT
    cal_date,
    CAST(EXTRACT(YEAR FROM cal_date) AS INT) AS cal_year,
    CAST(EXTRACT(MONTH FROM cal_date) AS INT) AS cal_month,
    CAST(EXTRACT(DAY FROM cal_date) AS INT) AS cal_day
FROM date_series;
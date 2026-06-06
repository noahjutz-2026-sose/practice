OPEN SCHEMA NOAH_JUTZ;

-- Find duplicates
-- Unique: All columns
-- Result: Many duplicates

SELECT DISTRICT_ID, COUNT(*)
FROM ST_META_BUNDESTAG_DISTRICTS
GROUP BY DISTRICT_ID;

-- Add error_info

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

OPEN SCHEMA NOAH_JUTZ;

-- Normalize st_Meta_Politbarometer_Value_Labels[v6] (party names)

ALTER TABLE ST_META_POLITBAROMETER_VALUE_LABELS
    ADD COLUMN LABEL_PART1 VARCHAR(100);
ALTER TABLE ST_META_POLITBAROMETER_VALUE_LABELS
    ADD COLUMN LABEL_PART2 VARCHAR(100);

UPDATE ST_META_POLITBAROMETER_VALUE_LABELS
SET LABEL_PART1 = TRIM(REGEXP_SUBSTR(LABEL, '^[^-/,]+')),
    LABEL_PART2 = TRIM(REGEXP_REPLACE(
            REGEXP_SUBSTR(LABEL, '[-/,].*$'),
            '^[-/,]',
            ''
                       ))
WHERE VARIABLE_ID = 'v6';

-- Merge

MERGE INTO PARTY t
USING (
    SELECT v.VALUE_ID, v.LABEL, b.SHORTNAME, b.NAME
    FROM ST_META_BUNDESTAG_PARTIES b
             RIGHT JOIN ST_META_POLITBAROMETER_VALUE_LABELS v
                             ON lower(v.LABEL_PART1) = replace(lower(b.SHORTNAME), '_', ' ')
                                 OR lower(v.LABEL_PART1) = lower(b.name)
                                 OR lower(v.LABEL_PART2) = replace(lower(b.SHORTNAME), '_', ' ')
                                 OR lower(v.LABEL_PART2) = lower(b.name)
    WHERE coalesce(v.VARIABLE_ID, 'v6') = 'v6'
      AND coalesce(v.VALUE_ID, 1) > 0
    QUALIFY ROW_NUMBER() OVER (PARTITION BY v.VALUE_ID) = 1
    ) AS s
ON s.VALUE_ID = t.VALUE_ID
WHEN MATCHED THEN UPDATE SET t.VALUE_LABEL = s.LABEL,
                             t.SHORTNAME = s.SHORTNAME,
                             t.FULL_NAME = s.NAME
WHEN NOT MATCHED THEN INSERT (VALUE_ID, VALUE_LABEL, SHORTNAME, FULL_NAME) VALUES (VALUE_ID, LABEL, SHORTNAME, NAME);

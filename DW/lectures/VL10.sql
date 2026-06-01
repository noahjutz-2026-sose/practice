OPEN SCHEMA NOAH_JUTZ;

SELECT coalesce(null, 2, 9); -- returns first non-null value
SELECT RESPONDENT_ID, first_value(3) FROM ST_POLITBAROMETER_SURVEY;

SELECT * WITH INVALID UNIQUE(p_weight) FROM ST_POLITBAROMETER_SURVEY;

SELECT COUNT(*)
FROM ST_POLITBAROMETER_SURVEY a1, ST_POLITBAROMETER_SURVEY a2
WHERE a1.RESPONDENT_ID = a2.RESPONDENT_ID AND a1.STUDY_ID = a2.STUDY_ID AND a1.V75_STATE = a2.V75_STATE; -- Duplicate detection

SELECT * FROM ST_POLITBAROMETER_SURVEY WHERE V55_AGE > 100; -- Outlier Removal

SELECT edit_distance('jeffery', 'levenstein');
SELECT edit_distance('noah', 'noah');
SELECT soundex('google'), soundex('googol'), soundex('koogel'), soundex('bugle');
SELECT soundex('dribble'), soundex('dabble'),  soundex('doable'), soundex('dimple');
select cologne_phonetic('köln'), cologne_phonetic('chollen'), cologne_phonetic('schollen');

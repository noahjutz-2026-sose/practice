-- DataGrip + OTH Exasol instance

OPEN SCHEMA NOAH_JUTZ;

CREATE TABLE test(name VARCHAR(500));

INSERT INTO TEST VALUES ('NOAHHHH\');

DROP TABLE test;

CREATE TABLE gesis_tmp(
    respid INT,
    studyid INT
);

-- IMPORT INTO gesis_tmp FROM LOCAL CSV FILE '~/Downloads/gesis_df_v2.tsv';

OPEN SCHEMA NOAH_JUTZ;

SELECT * FROM EXA_USER_TABLES;
DROP TABLE ST_POLITBAROMETER_SURVEY;
DROP TABLE ST_SEAT_DISTRIBUTION;
DROP TABLE ST_BUNDESTAG_ELECTIONS;

CREATE TABLE st_Bundestag_Elections (
    intyear INT, -- "jahr"
    district_id INT, -- "wahlkreis_nr"
    district_name VARCHAR(500), -- "wahlkreis_name"
    party VARCHAR(100), -- "partei"
    votes INT, -- "stimmen"
    percentage DOUBLE, -- "anteil"
    voting_eligible_population INT, -- "wahlberechtigte"
    voters INT, -- "waehlende"
    valid_votes INT, -- "gueltige"
    invalid_votes INT -- "ungueltige"
);

CREATE TABLE st_Politbarometer_Survey (
    respondent_id INT, -- PK respondent; "respid"
    intyear INT,
    intmonth INT,
    study_id INT, -- PK respondent
    version INT, -- "split"
    p_weight DOUBLE, -- Weight before 1999; "pwght"
    d_weight DOUBLE, -- Weight from 1999; "dwght"
    v4a_east_west INT,
    v5_turnout INT,
    v6_intended_vote INT,
    v7_last_vote INT,
    v8_rating_spd INT,
    v9_rating_cdu INT,
    v10_rating_csu INT,
    v11_rating_fdp INT,
    v12_rating_gruene INT,
    v13_rating_afd INT,
    v14_rating_linke INT,
    v15_rating_government INT,
    v16_rating_opposition INT,
    v18_democracy_satisfaction INT,
    v21_political_interest_intensity INT,
    v22_left_right INT,
    v25_economy_brd INT,
    v26_economy_forecast INT,
    v27_financial_standing INT,
    v28_financial_standing_forecast INT,
    v29_reunification INT,
    v30_asylum INT,
    v41_crime_threat INT,
    v42_eu_membership INT,
    v44_society INT,
    v50_year_review INT,
    v51_year_forecast INT,
    v52_religion INT,
    v54_gender INT,
    v55_age INT,
    v57_marital_status INT,
    v59_education_pre_87 INT,
    v60_education INT,
    v64_employment_status INT,
    v65_occupation INT,
    v72_preferred_party INT,
    v73_preference_intensity INT,
    v74_workers_union INT,
    v75_state INT
);

CREATE TABLE st_Seat_Distribution (
    intyear INT,
    total_seats INT, -- TODO add to M/ER
    cdu INT,
    afd INT,
    spd INT,
    gruene INT,
    linke INT,
    csu INT,
    ssw INT,
    fdp INT,
    bp INT,
    dp INT,
    kpd INT,
    wav INT,
    zentrum INT,
    dkpdrp INT,
    gbbhe INT,
    fdv INT,
    independent INT
);
OPEN SCHEMA NOAH_JUTZ;

SELECT OBJECT_NAME
FROM EXA_ALL_SCHEMA_OBJECTS;

CREATE TABLE st_Bundestagswahl_Historische_Wahlkreis_Daten (
    jahr INT,
    wahlkreis_nr INT,
    wahlkreis_name VARCHAR(500),
    partei VARCHAR(100),
    stimmen INT,
    anteil DOUBLE,
    wahlberechtigte INT,
    waehlende INT,
    gueltige INT,
    ungueltige INT
);

CREATE TABLE st_Politbarometer (
    respondent_id INT, -- PK respondent, "respid"
    year INT,
    month INT,
    study_id INT, -- PK respondent
    version INT, -- "split"
    p_weight DOUBLE, -- "pwght" TODO add to M/ER
    d_weight DOUBLE, -- "dwght" TODO add to M/ER
    v4a_east_west INT,
    v5_turnout INT, -- TODO add to M/ER
    v6_intended_vote INT,
    v7_last_vote INT,
    v8_rating_spd INT,
    v9_rating_cdu INT,
    v10_rating_csu INT,
    v11_rating_fdp INT,
    v12_rating_gruene INT,
    v13_rating_afd INT,
    v14_rating_linke INT,
    v15_rating_government INT, -- TODO add to M/ER
    v16_rating_opposition INT, -- TODO add to M/ER
    v18_democracy_satisfaction INT, -- TODO translate in M/ER
    v20_political_interest INT, -- TODO translate in M/ER
    v21_political_interest_intensity INT, -- TODO add to M/ER
    v22_left_right INT, -- TODO translate in M/ER
    v23_left INT, -- TODO translate in M/ER
    v24_right INT, -- TODO translate in M/ER
    v25_economy_brd INT, -- TODO translate in M/ER
    v26_economy_forecast INT, -- TODO add to M/ER
    v27_financial_standing INT, -- TODO change financial_situation to financial_standing in M/ER
    v28_financial_standing_forecast INT, -- TODO add to M/ER
    v29_reunification INT, -- TODO add to M/ER
    v30_asylum INT, -- TODO translate in M/ER
    v31_foreigners INT, -- TODO add to M/ER
    v32_abortion INT, -- TODO translate in M/ER
    v39_nuclear_energy INT, -- TODO translate in M/ER
    v41_crime_threat INT, -- TODO translate in M/ER
    v42_eu_membership INT, -- TODO add to M/ER
    v43_responsibility_foreign_policy INT, -- TODO add to M/ER
    v44_society INT, -- TODO add to M/ER
    v48_military_threat INT, -- TODO translate in M/ER
    v49_security INT, -- TODO add to M/ER
    v50_year_review INT, -- TODO translate in M/ER
    v51_year_forecast INT, -- TODO translate in M/ER
    v52_religion INT, -- TODO add dimension to M/ER
    v54_gender INT, -- TODO rename in M/ER
    v55_age INT,
    v56_age_group INT, -- TODO add to M/ER
    v57_marital_status INT,
    v59_education_pre_87 INT, -- TODO add to M/ER
    v60_education INT,
    v64_employment_status INT,
    v65_occupation INT,
    v72_preferred_party INT, -- TODO rename in M/ER
    v73_preference_intensity INT, -- TODO add to M/ER
    v74_workers_union INT,
    v75_state INT -- TODO translate in M/ER
);

CREATE TABLE st_seat_distribution (
    year INT,
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
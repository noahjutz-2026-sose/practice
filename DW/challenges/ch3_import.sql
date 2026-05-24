OPEN SCHEMA NOAH_JUTZ;

-- Ch3.2.1 Import Data

IMPORT INTO ST_SEAT_DISTRIBUTION
    (
     intyear,
     total_seats,
     cdu,
     afd,
     spd,
     gruene,
     linke,
     csu,
     ssw,
     fdp,
     bp,
     dp,
     kpd,
     wav,
     zentrum,
     dkpdrp,
     gbbhe,
     fdv,
     independent
        )
    FROM LOCAL CSV FILE '/tmp/st_seat_distribution.csv'
    ROW SEPARATOR = 'CRLF'
    SKIP = 1 ERRORS INTO error_tbl REJECT LIMIT UNLIMITED IGNORE CERTIFICATE;

IMPORT INTO ST_BUNDESTAG_ELECTIONS
    (
     intyear,
     district_id,
     district_name,
     party,
     votes,
     percentage,
     voting_eligible_population,
     voters,
     valid_votes,
     invalid_votes
        )
    FROM LOCAL CSV FILE '/tmp/st_bundestag_elections.csv'
    (1..10)
    SKIP = 1 IGNORE CERTIFICATE ERRORS INTO error_tbl REJECT LIMIT UNLIMITED;

IMPORT INTO ST_POLITBAROMETER_SURVEY
    (
     respondent_id,
     intyear,
     intmonth,
     study_id,
     version,
     p_weight,
     d_weight,
     v4a_east_west,
     v5_turnout,
     v6_intended_vote,
     v7_last_vote,
     v8_rating_spd,
     v9_rating_cdu,
     v10_rating_csu,
     v11_rating_fdp,
     v12_rating_gruene,
     v13_rating_afd,
     v14_rating_linke,
     v15_rating_government,
     v16_rating_opposition,
     v18_democracy_satisfaction,
     v21_political_interest_intensity,
     v22_left_right,
     v25_economy_brd,
     v26_economy_forecast,
     v27_financial_standing,
     v28_financial_standing_forecast,
     v29_reunification,
     v30_asylum,
     v41_crime_threat,
     v42_eu_membership,
     v44_society,
     v50_year_review,
     v51_year_forecast,
     v52_religion,
     v54_gender,
     v55_age,
     v57_marital_status,
     v59_education_pre_87,
     v60_education,
     v64_employment_status,
     v65_occupation,
     v72_preferred_party,
     v73_preference_intensity,
     v74_workers_union,
     v75_state
        )
    FROM LOCAL CSV FILE '/tmp/st_politbarometer_survey.csv'
    (4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 25, 28, 29, 32, 33, 34, 35, 36, 37, 48, 49, 51, 57, 58, 59, 61, 62, 64, 66, 67, 71, 72, 79, 80, 81, 82)
    SKIP = 1 IGNORE CERTIFICATE ERRORS INTO error_tbl REJECT LIMIT UNLIMITED;

-- Ch3.2.2 Inspect tables

SELECT *
FROM ST_SEAT_DISTRIBUTION
LIMIT 49;

SELECT *
FROM ST_BUNDESTAG_ELECTIONS
LIMIT 49;

SELECT *
FROM ST_POLITBAROMETER_SURVEY
LIMIT 49;

SELECT *
FROM error_tbl
LIMIT 49;

-- Ch3.2.3 Size

SELECT COUNT(*)
FROM ST_POLITBAROMETER_SURVEY;
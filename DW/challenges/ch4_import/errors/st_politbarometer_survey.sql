OPEN SCHEMA NOAH_JUTZ;

SELECT s.respondent_id, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'respondent'
                       AND l.value_id = s.respondent_id
WHERE l.value_id IS NULL
GROUP BY s.respondent_id;

SELECT s.intyear, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'intyear'
                       AND l.value_id = s.intyear
WHERE l.value_id IS NULL
GROUP BY s.intyear;

SELECT s.intmonth, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'intmonth'
                       AND l.value_id = s.intmonth
WHERE l.value_id IS NULL
GROUP BY s.intmonth;

SELECT s.study_id, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'study'
                       AND l.value_id = s.study_id
WHERE l.value_id IS NULL
GROUP BY s.study_id;

SELECT s.version, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'version'
                       AND l.value_id = s.version
WHERE l.value_id IS NULL
GROUP BY s.version;

SELECT s.p_weight, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'p'
                       AND l.value_id = s.p_weight
WHERE l.value_id IS NULL
GROUP BY s.p_weight;

SELECT s.d_weight, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'd'
                       AND l.value_id = s.d_weight
WHERE l.value_id IS NULL
GROUP BY s.d_weight;

SELECT s.v4a_east_west, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v4a'
                       AND l.value_id = s.v4a_east_west
WHERE l.value_id IS NULL
GROUP BY s.v4a_east_west;

SELECT s.v5_turnout, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v5'
                       AND l.value_id = s.v5_turnout
WHERE l.value_id IS NULL
GROUP BY s.v5_turnout;

SELECT s.v6_intended_vote, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v6'
                       AND l.value_id = s.v6_intended_vote
WHERE l.value_id IS NULL
GROUP BY s.v6_intended_vote;

SELECT s.v7_last_vote, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v7'
                       AND l.value_id = s.v7_last_vote
WHERE l.value_id IS NULL
GROUP BY s.v7_last_vote;

SELECT s.v8_rating_spd, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v8'
                       AND l.value_id = s.v8_rating_spd
WHERE l.value_id IS NULL
GROUP BY s.v8_rating_spd;

SELECT s.v9_rating_cdu, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v9'
                       AND l.value_id = s.v9_rating_cdu
WHERE l.value_id IS NULL
GROUP BY s.v9_rating_cdu;

SELECT s.v10_rating_csu, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v10'
                       AND l.value_id = s.v10_rating_csu
WHERE l.value_id IS NULL
GROUP BY s.v10_rating_csu;

SELECT s.v11_rating_fdp, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v11'
                       AND l.value_id = s.v11_rating_fdp
WHERE l.value_id IS NULL
GROUP BY s.v11_rating_fdp;

SELECT s.v12_rating_gruene, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v12'
                       AND l.value_id = s.v12_rating_gruene
WHERE l.value_id IS NULL
GROUP BY s.v12_rating_gruene;

SELECT s.v13_rating_afd, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v13'
                       AND l.value_id = s.v13_rating_afd
WHERE l.value_id IS NULL
GROUP BY s.v13_rating_afd;

SELECT s.v14_rating_linke, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v14'
                       AND l.value_id = s.v14_rating_linke
WHERE l.value_id IS NULL
GROUP BY s.v14_rating_linke;

SELECT s.v15_rating_government, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v15'
                       AND l.value_id = s.v15_rating_government
WHERE l.value_id IS NULL
GROUP BY s.v15_rating_government;

SELECT s.v16_rating_opposition, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v16'
                       AND l.value_id = s.v16_rating_opposition
WHERE l.value_id IS NULL
GROUP BY s.v16_rating_opposition;

SELECT s.v18_democracy_satisfaction, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v18'
                       AND l.value_id = s.v18_democracy_satisfaction
WHERE l.value_id IS NULL
GROUP BY s.v18_democracy_satisfaction;

SELECT s.v21_political_interest_intensity, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v21'
                       AND l.value_id = s.v21_political_interest_intensity
WHERE l.value_id IS NULL
GROUP BY s.v21_political_interest_intensity;

SELECT s.v22_left_right, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v22'
                       AND l.value_id = s.v22_left_right
WHERE l.value_id IS NULL
GROUP BY s.v22_left_right;

SELECT s.v25_economy_brd, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v25'
                       AND l.value_id = s.v25_economy_brd
WHERE l.value_id IS NULL
GROUP BY s.v25_economy_brd;

SELECT s.v26_economy_forecast, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v26'
                       AND l.value_id = s.v26_economy_forecast
WHERE l.value_id IS NULL
GROUP BY s.v26_economy_forecast;

SELECT s.v27_financial_standing, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v27'
                       AND l.value_id = s.v27_financial_standing
WHERE l.value_id IS NULL
GROUP BY s.v27_financial_standing;

SELECT s.v28_financial_standing_forecast, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v28'
                       AND l.value_id = s.v28_financial_standing_forecast
WHERE l.value_id IS NULL
GROUP BY s.v28_financial_standing_forecast;

SELECT s.v29_reunification, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v29'
                       AND l.value_id = s.v29_reunification
WHERE l.value_id IS NULL
GROUP BY s.v29_reunification;

SELECT s.v30_asylum, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v30'
                       AND l.value_id = s.v30_asylum
WHERE l.value_id IS NULL
GROUP BY s.v30_asylum;

SELECT s.v41_crime_threat, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v41'
                       AND l.value_id = s.v41_crime_threat
WHERE l.value_id IS NULL
GROUP BY s.v41_crime_threat;

SELECT s.v42_eu_membership, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v42'
                       AND l.value_id = s.v42_eu_membership
WHERE l.value_id IS NULL
GROUP BY s.v42_eu_membership;

SELECT s.v44_society, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v44'
                       AND l.value_id = s.v44_society
WHERE l.value_id IS NULL
GROUP BY s.v44_society;

SELECT s.v50_year_review, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v50'
                       AND l.value_id = s.v50_year_review
WHERE l.value_id IS NULL
GROUP BY s.v50_year_review;

SELECT s.v51_year_forecast, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v51'
                       AND l.value_id = s.v51_year_forecast
WHERE l.value_id IS NULL
GROUP BY s.v51_year_forecast;

SELECT s.v52_religion, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v52'
                       AND l.value_id = s.v52_religion
WHERE l.value_id IS NULL
GROUP BY s.v52_religion;

SELECT s.v54_gender, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v54'
                       AND l.value_id = s.v54_gender
WHERE l.value_id IS NULL
GROUP BY s.v54_gender;

SELECT s.v55_age, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v55'
                       AND l.value_id = s.v55_age
WHERE l.value_id IS NULL
GROUP BY s.v55_age;

SELECT s.v57_marital_status, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v57'
                       AND l.value_id = s.v57_marital_status
WHERE l.value_id IS NULL
GROUP BY s.v57_marital_status;

SELECT s.v59_education_pre_87, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v59'
                       AND l.value_id = s.v59_education_pre_87
WHERE l.value_id IS NULL
GROUP BY s.v59_education_pre_87;

SELECT s.v60_education, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v60'
                       AND l.value_id = s.v60_education
WHERE l.value_id IS NULL
GROUP BY s.v60_education;

SELECT s.v64_employment_status, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v64'
                       AND l.value_id = s.v64_employment_status
WHERE l.value_id IS NULL
GROUP BY s.v64_employment_status;

SELECT s.v65_occupation, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v65'
                       AND l.value_id = s.v65_occupation
WHERE l.value_id IS NULL
GROUP BY s.v65_occupation;

SELECT s.v72_preferred_party, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v72'
                       AND l.value_id = s.v72_preferred_party
WHERE l.value_id IS NULL
GROUP BY s.v72_preferred_party;

SELECT s.v73_preference_intensity, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v73'
                       AND l.value_id = s.v73_preference_intensity
WHERE l.value_id IS NULL
GROUP BY s.v73_preference_intensity;

SELECT s.v74_workers_union, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v74'
                       AND l.value_id = s.v74_workers_union
WHERE l.value_id IS NULL
GROUP BY s.v74_workers_union;

SELECT s.v75_state, COUNT(*)
FROM st_Politbarometer_Survey s
         LEFT JOIN st_Meta_Politbarometer_Value_Labels l
                   ON l.variable_id = 'v75'
                       AND l.value_id = s.v75_state
WHERE l.value_id IS NULL
GROUP BY s.v75_state;
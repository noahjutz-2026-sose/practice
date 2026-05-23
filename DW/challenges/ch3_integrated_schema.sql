OPEN SCHEMA NOAH_JUTZ;

-- Dimensions

CREATE TABLE Party (
    id INT,
    shortname VARCHAR(50),
    full_name VARCHAR(200)
);

CREATE TABLE Respondent (
    id INT,
    location_id INT,
    financial_standing_level INT,
    financial_standing_name VARCHAR(50),
    financial_standing_forecast_level INT,
    financial_standing_forecast_name VARCHAR(50),
    religion VARCHAR(50),
    is_male BOOL,
    age INT,
    marital_status VARCHAR(50),
    education_level INT,
    education_name VARCHAR(50),
    is_employed BOOL,
    occupation VARCHAR(50),
    is_unionized BOOL
);

CREATE TABLE Location (
    id INT,
    voting_district_name VARCHAR(100),
    voting_district_id INT,
    municipality VARCHAR(100),
    municipality_population INT,
    region VARCHAR(100),
    state VARCHAR(50),
    is_west_germany BOOL
);

-- Facts

CREATE TABLE Seat_Distribution (
    date DATE, -- YYYY-01-01
    party_id INT,
    seats INT
);

CREATE TABLE Bundestag_Election_Census (
    date DATE, -- YYYY-01-01
    location_id INT,
    voting_eligible_population INT,
    voters INT,
    valid_votes INT,
    invalid_votes INT
);

CREATE TABLE Bundestag_Election_Result (
    date DATE, -- YYYY-01-01
    party_id INT,
    location_id INT,
    votes INT,
    percentage DOUBLE
);

CREATE TABLE Politbarometer_Opinion_Poll (
    date DATE, -- YYYY-MM-01
    respondent_id INT,
    weight DOUBLE, -- p_weight and d_weight
    is_willing_to_vote BOOL, -- v5
    rating_government INT, -- v15
    rating_opposition INT, -- v16
    democracy_satisfaction INT, -- v18
    political_interest INT, -- v20 and v21
    left_right INT, -- v22
    economy_current INT, -- v25
    economy_forecast INT, -- v26
    reunification INT, -- v29
    asylum INT, -- v30
    crime_threat INT, -- v41
    eu_membership INT, -- v42
    society INT, -- v44
    was_last_year_good BOOL, -- v50
    year_forecast INT -- v51
);

CREATE TABLE Politbarometer_Election_Poll (
    date DATE, -- YYYY-MM-01
    respondent_id INT,
    party_id INT,
    is_intended_vote BOOL, -- v6
    was_last_vote BOOL, -- v7
    is_preferred_party BOOL, -- v72
    preference_intensity INT, -- v73
    rating INT -- v8
);
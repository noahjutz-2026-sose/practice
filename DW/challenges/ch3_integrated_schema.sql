OPEN SCHEMA NOAH_JUTZ;

-- Dimensions

CREATE TABLE Party (
    id INT,
    shortname VARCHAR(50),
    full_name VARCHAR(200),
);

CREATE TABLE Respondent (
    id INT,
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
    voting_district_name VARCHAR(100),
    voting_district_id INT,
    municipality VARCHAR(100),
    municipality_population INT,
    region VARCHAR(100),
    state VARCHAR(50),
    is_west_germany BOOL
);

-- Facts


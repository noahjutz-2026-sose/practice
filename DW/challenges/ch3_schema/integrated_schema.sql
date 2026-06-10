OPEN SCHEMA NOAH_JUTZ;

-- Dimensions

CREATE TABLE Party
(
    value_id    INT PRIMARY KEY,
    value_label VARCHAR(100),
    shortname   VARCHAR(100),
    full_name   VARCHAR(200)
);

CREATE TABLE Bundesland
(
    state_value_id INT PRIMARY KEY,
    state_name     VARCHAR(100)
);

CREATE TABLE Voting_District
(
    voting_district_id   INT PRIMARY KEY,
    state_id             INT REFERENCES Bundesland (state_value_id),
    voting_district_name VARCHAR(500),
    is_west_germany      BOOL
);


CREATE TABLE Respondent
(
    respondent_id               INT,
    study_id                    INT,
    east_west                   INT,
    bundesland_id               INT REFERENCES Bundesland (state_value_id),
    financial_standing          INT,
    financial_standing_forecast INT,
    religion                    INT,
    gender                      INT,
    age                         INT,
    marital_status              INT,
    education                   INT,
    employment_status           INT,
    occupation                  INT,
    workers_union               INT,
    PRIMARY KEY (respondent_id, study_id, east_west)
);

-- Facts

CREATE TABLE Seat_Distribution
(
    term     DATE, -- YYYY-01-01
    party_id INT REFERENCES Party (value_id),
    seats    INT
);

CREATE TABLE Bundestag_Election_Census
(
    term                       DATE, -- YYYY-01-01
    voting_eligible_population INT,
    voters                     INT,
    valid_votes                INT,
    invalid_votes              INT
);

CREATE TABLE Bundestag_Election_Result
(
    term        DATE, -- YYYY-01-01
    party_id    INT REFERENCES Party (value_id),
    district_id INT REFERENCES Voting_District (VOTING_DISTRICT_ID),
    votes       INT,
    percentage  DOUBLE
);

CREATE TABLE Politbarometer_Opinion_Poll
(
    date_month             DATE,   -- YYYY-MM-01
    respondent_id          INT,
    respondent_study_id    INT,
    respondent_east_west   INT,
    weight                 DOUBLE, -- p_weight and d_weight
    is_willing_to_vote     BOOL,   -- v5
    rating_government      INT,    -- v15
    rating_opposition      INT,    -- v16
    democracy_satisfaction INT,    -- v18
    political_interest     INT,    -- v20 and v21
    left_right             INT,    -- v22
    economy_current        INT,    -- v25
    economy_forecast       INT,    -- v26
    reunification          INT,    -- v29
    asylum                 INT,    -- v30
    crime_threat           INT,    -- v41
    eu_membership          INT,    -- v42
    society                INT,    -- v44
    was_last_year_good     BOOL,   -- v50
    year_forecast          INT,    -- v51
    FOREIGN KEY (respondent_id, respondent_study_id, respondent_east_west) REFERENCES respondent
);

CREATE TABLE Politbarometer_Election_Poll
(
    date_month           DATE, -- YYYY-MM-01
    respondent_id        INT REFERENCES Respondent (id),
    party_id             INT REFERENCES Party (value_id),
    is_intended_vote     BOOL, -- v6
    was_last_vote        BOOL, -- v7
    is_preferred_party   BOOL, -- v72
    preference_intensity INT,  -- v73
    rating               INT   -- v8
);
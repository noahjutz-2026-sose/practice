OPEN SCHEMA NOAH_JUTZ;

-- Dimensions

CREATE TABLE Party
(
    value_id    INT,
    value_label VARCHAR(100),
    shortname   VARCHAR(100) PRIMARY KEY,
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
    district_id                INT REFERENCES Voting_District (voting_district_id),
    voting_eligible_population INT,
    voters                     INT,
    valid_votes                INT,
    invalid_votes              INT,
    PRIMARY KEY (term, district_id)
);

CREATE TABLE Bundestag_Election_Result
(
    term        DATE, -- YYYY-01-01
    party       VARCHAR(100) REFERENCES Party (shortname),
    district_id INT REFERENCES Voting_District (VOTING_DISTRICT_ID),
    votes       INT,
    percentage  DOUBLE,
    PRIMARY KEY (term, party, district_id)
);

DROP TABLE BUNDESTAG_ELECTION_RESULT

CREATE TABLE Politbarometer_Opinion_Poll
(
    respondent_id          INT,
    respondent_study_id    INT,
    respondent_east_west   INT,
    date_month             DATE,   -- YYYY-MM-01
    weight                 DOUBLE, -- p_weight and d_weight
    turnout                INT,    -- v5
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
    year_review            INT,    -- v50
    year_forecast          INT,    -- v51
    FOREIGN KEY (respondent_id, respondent_study_id, respondent_east_west) REFERENCES respondent
);

CREATE TABLE Politbarometer_Election_Poll
(
    date_month           DATE, -- YYYY-MM-01
    respondent_id        INT,
    respondent_study_id  INT,
    respondent_east_west INT,
    party                VARCHAR(100) REFERENCES Party (shortname),
    is_intended_vote     BOOL, -- v6
    was_last_vote        BOOL, -- v7
    is_preferred_party   BOOL, -- v72
    preference_intensity INT,  -- v73
    rating               INT,  -- v8, v9, v10, v11, v12, v13, v14
    FOREIGN KEY (respondent_id, respondent_study_id, respondent_east_west) REFERENCES respondent
);

CREATE TABLE POLITBAROMETER_VALUE_LABELS
(
    variable_id VARCHAR(50),
    value_id    INT,
    label       VARCHAR(500),
    PRIMARY KEY (variable_id, value_id)
)
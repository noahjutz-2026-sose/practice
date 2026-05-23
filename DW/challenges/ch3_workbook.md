Data Warehousing | Summer Semester 2026 | Prof. Schildgen | OTH Regensburg

---

**Name:** Noah Jutz

# Challenge 3: Data Modelling and Importing the Data

**Tasks:**

3. Fill out this workbook with care. It will be graded with points. Write high-class content, but compact. Before you submit, read everything again and improve.

4. When you are finished, export your workbook as a PDF and upload it to ELO before the deadline. Open your PDF in a PDF viewer to check whether everything was exported correctly and no code blocks are cut off.
5. In this workbook, you need to write SQL commands. Put them in code blocks and split long queries into multiple lines.

## Title

_Please, again write your project title (as in the first workbook) here). If you want to change your title, write here the old and the new title._

**Old:** CyberRunner Warehouse - Analyse von Reinforcement Learning Daten

**New:** Bundestag Election Data Warehouse: Politische Stimmungs- und Ergebnisdatenbank

## Staging Area: Tables

_Write down your `CREATE TABLE` commands to create your tables in which you import your data from the data sources. (Ex. Sheet 3, Exercise 1.3)_

```sql
CREATE TABLE st_Bundestag_Elections
(
    intyear                    INT,          -- "jahr"
    district_id                INT,          -- "wahlkreis_nr"
    district_name              VARCHAR(500), -- "wahlkreis_name"
    party                      VARCHAR(100), -- "partei"
    votes                      INT,          -- "stimmen"
    percentage                 DOUBLE,       -- "anteil"
    voting_eligible_population INT,          -- "wahlberechtigte"
    voters                     INT,          -- "waehlende"
    valid_votes                INT,          -- "gueltige"
    invalid_votes              INT           -- "ungueltige"
);

CREATE TABLE st_Politbarometer_Survey
(
    respondent_id                    INT,
    intyear                          INT,
    intmonth                         INT,
    study_id                         INT,
    version                          INT,    -- "split"
    p_weight                         DOUBLE, -- Weight before 1999; "pwght"
    d_weight                         DOUBLE, -- Weight from 1999; "dwght"
    v4a_east_west                    INT,
    v5_turnout                       INT,
    v6_intended_vote                 INT,
    v7_last_vote                     INT,
    v8_rating_spd                    INT,
    v9_rating_cdu                    INT,
    v10_rating_csu                   INT,
    v11_rating_fdp                   INT,
    v12_rating_gruene                INT,
    v13_rating_afd                   INT,
    v14_rating_linke                 INT,
    v15_rating_government            INT,
    v16_rating_opposition            INT,
    v18_democracy_satisfaction       INT,
    v21_political_interest_intensity INT,
    v22_left_right                   INT,
    v25_economy_brd                  INT,
    v26_economy_forecast             INT,
    v27_financial_standing           INT,
    v28_financial_standing_forecast  INT,
    v29_reunification                INT,
    v30_asylum                       INT,
    v41_crime_threat                 INT,
    v42_eu_membership                INT,
    v44_society                      INT,
    v50_year_review                  INT,
    v51_year_forecast                INT,
    v52_religion                     INT,
    v54_gender                       INT,
    v55_age                          INT,
    v57_marital_status               INT,
    v59_education_pre_87             INT,
    v60_education                    INT,
    v64_employment_status            INT,
    v65_occupation                   INT,
    v72_preferred_party              INT,
    v73_preference_intensity         INT,
    v74_workers_union                INT,
    v75_state                        INT
);

CREATE TABLE st_Seat_Distribution
(
    intyear     INT,
    cdu         INT,
    afd         INT,
    spd         INT,
    gruene      INT,
    linke       INT,
    csu         INT,
    ssw         INT,
    fdp         INT,
    bp          INT,
    dp          INT,
    kpd         INT,
    wav         INT,
    zentrum     INT,
    dkpdrp      INT,
    gbbhe       INT,
    fdv         INT,
    independent INT
);
```

## Forms of Heterogeneity

_Which forms of heterogeneity exist between two of your data sources? Write at least one example. (Ex. Sheet 3, Exercise 1.4)_

| Type                        | Example                                                                               |
| --------------------------- | ------------------------------------------------------------------------------------- |
| **Technical Heterogeneity** | Politbarometer uses DTA, Bundestag_Election uses CSV (resolves after CSV conversion).          |
| **Syntactic Heterogeneity** | Politbarometer uses numbers (1=CDU), Bundestag_Election uses shortnames (linke=Die Linke/PDS). |
| **Semantic Heterogeneity**  | Politbarometer separates CDU/CSU, Bundestag_Election groups as Union=CDU+CSU.             |
| **Schematic Heterogeneity** | Politbarometer uses one column per party per question, Bundestag_Election uses one row per party.           |

## Star / Snowflake Schema

_Your task was to decide whether to use a star schema or a snowflake schema (or a mix of both) within your data warehouse. Provide the `CREATE TABLE` commands of your final schema here. (Ex. Sheet 3, Exercise 1.6)_

**Fact table(s):**

```sql
CREATE TABLE Seat_Distribution
(
    term     DATE, -- YYYY-01-01
    party_id INT REFERENCES Party (id),
    seats    INT
);

CREATE TABLE Bundestag_Election_Census
(
    term                       DATE, -- YYYY-01-01
    location_id                INT REFERENCES Location (id),
    voting_eligible_population INT,
    voters                     INT,
    valid_votes                INT,
    invalid_votes              INT
);

CREATE TABLE Bundestag_Election_Result
(
    term        DATE, -- YYYY-01-01
    party_id    INT REFERENCES Party (id),
    location_id INT REFERENCES Location (id),
    votes       INT,
    percentage  DOUBLE
);

CREATE TABLE Politbarometer_Opinion_Poll
(
    date_month             DATE,   -- YYYY-MM-01
    respondent_id          INT REFERENCES Respondent (id),
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
    year_forecast          INT     -- v51
);

CREATE TABLE Politbarometer_Election_Poll
(
    date_month           DATE, -- YYYY-MM-01
    respondent_id        INT REFERENCES Respondent (id),
    party_id             INT REFERENCES Party (id),
    is_intended_vote     BOOL, -- v6
    was_last_vote        BOOL, -- v7
    is_preferred_party   BOOL, -- v72
    preference_intensity INT,  -- v73
    rating               INT   -- v8
);
```

**Dimension table(s):**

```sql
CREATE TABLE Party
(
    id        INT PRIMARY KEY,
    shortname VARCHAR(50),
    full_name VARCHAR(200)
);

CREATE TABLE Location
(
    id                      INT PRIMARY KEY,
    voting_district_name    VARCHAR(100),
    voting_district_id      INT,
    municipality            VARCHAR(100),
    municipality_population INT,
    region                  VARCHAR(100),
    state_bundesland        VARCHAR(50),
    is_west_germany         BOOL
);

CREATE TABLE Respondent
(
    id                                INT PRIMARY KEY,
    location_id                       INT REFERENCES Location (id),
    financial_standing_level          INT,
    financial_standing_name           VARCHAR(50),
    financial_standing_forecast_level INT,
    financial_standing_forecast_name  VARCHAR(50),
    religion                          VARCHAR(50),
    is_male                           BOOL,
    age                               INT,
    marital_status                    VARCHAR(50),
    education_level                   INT,
    education_name                    VARCHAR(50),
    is_employed                       BOOL,
    occupation                        VARCHAR(50),
    is_unionized                      BOOL
);
```

## IMPORT

_Write down IMPORT commands to import data from your data sources into your staging area tables. (Ex. Sheet 3, Exercise 2.1)_

🖊️

## Numbers

- Numbers of rows in your biggest table: 🖊️
- Size (KB, MB, or GB) of your biggest table: 🖊️
- Name of that biggest table: 🖊️
- Total size (KB, MB, or GB) of your schema: 🖊️

## ME/R Model

_If you use Zettlr, Notion, or another local Markdown editor, embed the image of your ME/R Model here by writing `![ME/R Model](mer.jpg)`. If you create your PDF with a markdown-to-PDF conversion tool, then create this workbook PDF (without the image), and the image PDF as two separate files and combine them into one single PDF (e.g., with PDFSAM or pdftk). (Ex. Sheet 2, Exercise 1.1)_

🖊️

**Please check: Have you written your name on the very top?**

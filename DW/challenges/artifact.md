# Power BI Report — Bundestag Elections & Politbarometer

## Data Connection

Connect Power BI to Exasol via the Exasol ODBC driver. Import all tables from schema  NOAH_JUTZ :  Party ,  Bundesland ,  Voting_District ,  Respondent ,  Seat_Distribution ,
Bundestag_Election_Census ,  Bundestag_Election_Result ,  Politbarometer_Survey ,  Politbarometer_Party_Ratings ,  Politbarometer_Value_Labels ,
Mapping_Party_Politbarometer_Value_Labels . Set up relationships in the Power BI model matching the foreign keys in the schema.

## Page 1 — Election Results & Turnout

### Visualization 1: Stacked Bar Chart — Party Vote Shares per Term

Type: Stacked Bar Chart

Data:

- Source tables:  Bundestag_Election_Result ,  Party
- Axis (Y):  term  (each election year as a category)
- Axis (X / Values):  SUM(votes) , split by  party
- Legend:  party  (or  Party.full_name )

What it shows: For each Bundestag election term, one horizontal bar is divided into segments representing each party's total vote count across all districts. This makes it easy to
compare both total vote volume per election and how the vote share shifts between parties over time.

Power BI instructions:

1. Insert → Stacked Bar Chart.
2. Drag  Bundestag_Election_Result.term  to Y-axis.
3. Drag  Bundestag_Election_Result.votes  to X-axis (it will auto-aggregate as SUM).
4. Drag  Party.shortname  (or  full_name ) to Legend.
5. Sort by  term  ascending.

### Visualization 2: Line Chart — Voter Turnout Over Time by Bundesland

Type: Line Chart

Data:

- Source tables:  Bundestag_Election_Census ,  Voting_District ,  Bundesland
- X-axis:  term
- Y-axis:  SUM(voters) / SUM(voting_eligible_population) * 100  (create a DAX measure:  Turnout % = DIVIDE(SUM(Bundestag_Election_Census[voters]),
SUM(Bundestag_Election_Census[voting_eligible_population])) * 100 )
- Legend / Series:  Bundesland.state_name

What it shows: One line per Bundesland, plotting voter turnout percentage for each election term. Reveals which states consistently have high/low turnout and whether turnout is
trending up or down nationally and regionally.

Power BI instructions:

1. Create the DAX measure  Turnout %  as described above.
2. Insert → Line Chart.
3. Drag  Bundestag_Election_Census.term  to X-axis.
4. Drag the  Turnout %  measure to Y-axis.
5. Drag  Bundesland.state_name  to Legend.

## Page 2 — Public Opinion & Sentiment

### Visualization 3: Line Chart with Multiple Series — Monthly Party Ratings Over Time

Type: Line Chart

Data:

- Source tables:  Politbarometer_Party_Ratings ,  Party
- X-axis:  date_month
- Y-axis: Weighted average rating per party. DAX measure:  Avg Rating = DIVIDE(SUMX(Politbarometer_Party_Ratings, [rating] * [weight]), SUM(Politbarometer_Party_Ratings[weight]))
- Legend / Series:  Party.shortname

What it shows: The monthly weighted-average public approval rating for each party over the entire survey period. Allows tracking long-term sentiment trends, identifying spikes/drops
around political events, and comparing party popularity trajectories.

Power BI instructions:

1. Create the DAX measure  Avg Rating  as described above.
2. Insert → Line Chart.
3. Drag  Politbarometer_Party_Ratings.date_month  to X-axis.
4. Drag the  Avg Rating  measure to Y-axis.
5. Drag  Party.shortname  to Legend.
6. Optionally add a Slicer (see Vis 5) for  date_month  to allow filtering a date range.

### Visualization 4: Matrix (Table with Drill-Down) — Demographics vs. Intended Vote

Type: Matrix

Data:

- Source tables:  Politbarometer_Survey ,  Respondent ,  Politbarometer_Value_Labels ,  Mapping_Party_Politbarometer_Value_Labels
- Rows: Respondent demographics, resolved via  Politbarometer_Value_Labels :
    - Row group 1: Gender ( variable_id = 'v54' , joined on  Respondent.gender = value_id ) →  label
    - Row group 2 (drill-down): Education ( variable_id = 'v60' , joined on  Respondent.education = value_id ) →  label
- Columns:  Politbarometer_Survey.intended_vote  (party shortname)
- Values:  COUNT(respondent_id)  — number of respondents in each cell.

What it shows: A cross-tabulation of demographics (gender, with drill-down into education level) against intended vote party. Reveals which demographic segments lean toward which
parties. The matrix supports expanding/collapsing row hierarchies.

Power BI instructions:

1. To resolve coded integer values into labels, create a dedicated query/view or use Power Query to join  Respondent.gender  →  Politbarometer_Value_Labels  (filtered to  variable_id
= 'v54' ) and  Respondent.education  →  Politbarometer_Value_Labels  (filtered to  variable_id = 'v60' ). Add the resulting label columns to the model.
2. Insert → Matrix.
3. Drag the gender label to Rows, then drag education label below it to create a hierarchy.
4. Drag  Politbarometer_Survey.intended_vote  to Columns.
5. Drag  Politbarometer_Survey.respondent_id  to Values (set aggregation to Count).
6. Enable drill-down in the visual header.

### Visualization 5: Slicer + Pie Chart — Seat Distribution for a Selected Term

Type: Slicer (dropdown) + Pie Chart

Data:

- Source tables:  Seat_Distribution ,  Party

Slicer:

- Field:  Seat_Distribution.term
- Style: Dropdown or list, single-select.

Pie Chart:

- Values:  SUM(Seat_Distribution.seats)
- Legend / Category:  Party.shortname  (or  full_name )
- Detail labels: Show both party name and seat count.

What it shows: The slicer lets the user pick an election term. The pie chart then shows the Bundestag seat distribution for that term — each slice is a party, sized by number of
seats. This gives an immediate sense of parliamentary composition and coalition possibilities.

Power BI instructions:

1. Insert → Slicer. Drag  Seat_Distribution.term  into the slicer. Set to dropdown/single-select mode.
2. Insert → Pie Chart.
3. Drag  Seat_Distribution.seats  to Values.
4. Drag  Party.shortname  to Legend.
5. Enable data labels showing category + value.
6. The slicer automatically cross-filters the pie chart on the same page.

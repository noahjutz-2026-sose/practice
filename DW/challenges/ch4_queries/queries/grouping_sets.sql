OPEN SCHEMA NOAH_JUTZ;

-- What is the voter turnout across district, state and term?

SELECT CASE
           WHEN GROUPING(c.TERM) = 0 AND GROUPING(s.STATE_NAME) = 0 AND GROUPING(d.VOTING_DISTRICT_NAME) = 0
               THEN 'District Level'
           WHEN GROUPING(c.TERM) = 0 AND GROUPING(s.STATE_NAME) = 0 THEN 'State Level'
           WHEN GROUPING(c.TERM) = 0 THEN 'Term Level'
           ELSE 'Grand Total'
           END                                                 AS GROUP_LEVEL,
       c.TERM,
       s.STATE_NAME,
       d.VOTING_DISTRICT_NAME,
       SUM(c.VOTERS) / SUM(c.VOTING_ELIGIBLE_POPULATION) * 100 AS TURNOUT_PERCENTAGE
FROM BUNDESTAG_ELECTION_CENSUS c
         JOIN VOTING_DISTRICT d ON c.DISTRICT_ID = d.VOTING_DISTRICT_ID
         JOIN BUNDESLAND s ON d.STATE_ID = s.STATE_VALUE_ID
GROUP BY ROLLUP (c.TERM, s.STATE_NAME, d.VOTING_DISTRICT_NAME)
ORDER BY c.TERM, s.STATE_NAME, d.VOTING_DISTRICT_NAME;

-- What is the average view on CDU/CSU given any combination of demographic indicators?

SELECT lbl_gender.LABEL       AS GENDER,
       lbl_edu.LABEL          AS EDUCATION,
       lbl_emp.LABEL          AS EMPLOYMENT_STATUS,
       COUNT(p.RESPONDENT_ID) AS TOTAL_RATINGS,
       AVG(p.RATING)          AS AVG_PARTY_RATING
FROM POLITBAROMETER_PARTY_RATINGS p
         JOIN RESPONDENT r
              ON p.RESPONDENT_ID = r.RESPONDENT_ID
                  AND p.RESPONDENT_STUDY_ID = r.STUDY_ID
                  AND p.RESPONDENT_EAST_WEST = r.EAST_WEST
         LEFT JOIN POLITBAROMETER_VALUE_LABELS lbl_gender
                   ON lbl_gender.VARIABLE_ID = 'v54'
                       AND r.GENDER = lbl_gender.VALUE_ID
         LEFT JOIN POLITBAROMETER_VALUE_LABELS lbl_edu
                   ON lbl_edu.VARIABLE_ID = 'v60'
                       AND r.EDUCATION = lbl_edu.VALUE_ID
         LEFT JOIN POLITBAROMETER_VALUE_LABELS lbl_emp
                   ON lbl_emp.VARIABLE_ID = 'v64'
                       AND r.EMPLOYMENT_STATUS = lbl_emp.VALUE_ID
WHERE p.PARTY = 'afd'
GROUP BY CUBE (lbl_gender.LABEL, lbl_edu.LABEL, lbl_emp.LABEL);
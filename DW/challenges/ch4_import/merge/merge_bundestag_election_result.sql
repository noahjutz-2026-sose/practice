OPEN SCHEMA NOAH_JUTZ;

MERGE INTO BUNDESTAG_ELECTION_RESULT t
USING (
    SELECT DISTINCT INTYEAR,
                    DISTRICT_ID,
                    PARTY,
                    VOTES,
                    PERCENTAGE,
                    TO_DATE(TO_CHAR(INTYEAR), 'YYYY') AS INTYEAR_DATE,
                    p.VALUE_ID
    FROM ST_BUNDESTAG_ELECTIONS e
             LEFT JOIN PARTY p
                       ON e.party = p.SHORTNAME
    ) AS s
ON t.term = s.INTYEAR_DATE AND t.DISTRICT_ID = s.DISTRICT_ID AND t.PARTY_ID = s.PARTY
WHEN MATCHED THEN
    UPDATE
    SET t.PERCENTAGE = s.PERCENTAGE,
        t.VOTES      = s.VOTES
WHEN NOT MATCHED THEN
    INSERT
    VALUES (s.INTYEAR_DATE,
            s.VALUE_ID,
            s.DISTRICT_ID,
            s.VOTES,
            s.PERCENTAGE);

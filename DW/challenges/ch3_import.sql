OPEN SCHEMA NOAH_JUTZ;

SELECT *
FROM ST_SEAT_DISTRIBUTION;
SELECT *
FROM ST_BUNDESTAG_ELECTIONS;

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
    SKIP = 1 IGNORE CERTIFICATE;

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
    SKIP = 1 IGNORE CERTIFICATE;

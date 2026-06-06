OPEN SCHEMA NOAH_JUTZ;

-- Check if totaL_seats equals summation of seats
WITH CUM AS (SELECT intyear,
                    total_seats,
                    (zeroifnull(CDU) + zeroifnull(AFD) + zeroifnull(SPD) + zeroifnull(GRUENE) + zeroifnull(LINKE) +
                     zeroifnull(CSU) +
                     zeroifnull(SSW) + zeroifnull(FDP) + zeroifnull(BP) + zeroifnull(DP) + zeroifnull(KPD) +
                     zeroifnull(WAV) +
                     zeroifnull(WAV) + zeroifnull(ZENTRUM) + zeroifnull(DKPDRP) + zeroifnull(GBBHE) + zeroifnull(FDV) +
                     zeroifnull(INDEPENDENT)) AS cum
             FROM ST_SEAT_DISTRIBUTION)
SELECT INTYEAR,
       TOTAL_SEATS,
       cum
FROM CUM
WHERE TOTAL_SEATS != cum
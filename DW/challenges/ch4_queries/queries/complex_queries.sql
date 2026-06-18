OPEN SCHEMA NOAH_JUTZ;

-- Are powerful parties popular? How correlated is the number of seats with a party's average rating within that term?

WITH term_boundaries AS (SELECT TERM                            AS term_start,
                                LEAD(TERM) OVER (ORDER BY TERM) AS term_end
                         FROM (SELECT DISTINCT TERM FROM SEAT_DISTRIBUTION)),
     party_term_ratings AS (SELECT b.term_start,
                                   r.PARTY,
                                   AVG(r.RATING) AS avg_rating
                            FROM POLITBAROMETER_PARTY_RATINGS r
                                     JOIN term_boundaries b
                                          ON r.DATE_MONTH >= b.term_start
                                              AND (r.DATE_MONTH < b.term_end OR b.term_end IS NULL)
                            WHERE r.RATING IS NOT NULL
                            GROUP BY b.term_start, r.PARTY),
     term_metrics AS (SELECT s.TERM AS term_start,
                             s.PARTY,
                             s.SEATS,
                             r.avg_rating
                      FROM SEAT_DISTRIBUTION s
                               JOIN party_term_ratings r
                                    ON s.PARTY = r.PARTY
                                        AND s.TERM = r.term_start)
SELECT PARTY, CORR(SEATS, avg_rating)
FROM term_metrics
GROUP BY ROLLUP (PARTY);
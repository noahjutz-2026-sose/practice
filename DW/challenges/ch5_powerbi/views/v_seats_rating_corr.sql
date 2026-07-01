OPEN SCHEMA NOAH_JUTZ;

CREATE OR REPLACE VIEW v_seats_rating_corr AS
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
     term_metrics AS (SELECT r.term_start,
                             r.PARTY,
                             COALESCE(s.SEATS, 0) AS SEATS,
                             r.avg_rating
                      FROM party_term_ratings r
                               LEFT JOIN SEAT_DISTRIBUTION s
                                         ON r.PARTY = s.PARTY
                                             AND r.term_start = s.TERM)
SELECT COALESCE(PARTY, 'Total') AS PARTY,
       CORR(SEATS, avg_rating)  AS correlation_seats_vs_rating
FROM term_metrics
GROUP BY ROLLUP (PARTY);
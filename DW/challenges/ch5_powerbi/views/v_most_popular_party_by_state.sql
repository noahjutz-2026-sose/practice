OPEN SCHEMA NOAH_JUTZ;

CREATE OR REPLACE VIEW V_MOST_POPULAR_PARTY_BY_STATE AS
WITH StatePartyVotes AS (
    -- Aggregate total votes for each party by state and term
    SELECT
        ber.TERM,
        bl.STATE_NAME,
        ber.PARTY,
        SUM(ber.VOTES) AS TOTAL_VOTES
    FROM
        BUNDESTAG_ELECTION_RESULT ber
    JOIN
        VOTING_DISTRICT vd ON ber.DISTRICT_ID = vd.VOTING_DISTRICT_ID
    JOIN
        BUNDESLAND bl ON vd.STATE_ID = bl.STATE_VALUE_ID
    GROUP BY
        ber.TERM,
        bl.STATE_NAME,
        ber.PARTY
),
RankedParties AS (
    -- Rank the parties within each state and term based on total votes
    SELECT
        TERM,
        STATE_NAME,
        PARTY,
        TOTAL_VOTES,
        RANK() OVER (PARTITION BY TERM, STATE_NAME ORDER BY TOTAL_VOTES DESC) AS vote_rank
    FROM
        StatePartyVotes
)
-- Filter for only the top-ranked party and join the PARTY table for the hex color
SELECT
    rp.TERM,
    rp.STATE_NAME,
    rp.PARTY AS TOP_PARTY,
    p.HEX_COLOR AS PARTY_COLOR,
    rp.TOTAL_VOTES
FROM
    RankedParties rp
LEFT JOIN
    PARTY p ON rp.PARTY = p.SHORTNAME
WHERE
    rp.vote_rank = 1;

CREATE OR REPLACE VIEW V_MOST_POPULAR_PARTY_BY_STATE AS
WITH DistinctTerms AS (
    -- 1. Get every unique election term
    SELECT DISTINCT TERM FROM BUNDESTAG_ELECTION_RESULT
),
TermRanges AS (
    -- 2. Create every possible continuous range (term_from to term_to)
    SELECT
        t1.TERM AS term_from,
        t2.TERM AS term_to
    FROM
        DistinctTerms t1
    JOIN
        DistinctTerms t2 ON t1.TERM <= t2.TERM
),
RangeVotes AS (
    -- 3. Aggregate total votes for each party, within each state, for every term range
    SELECT
        tr.term_from,
        tr.term_to,
        bl.STATE_NAME,
        ber.PARTY,
        SUM(ber.VOTES) AS TOTAL_VOTES
    FROM
        TermRanges tr
    JOIN
        BUNDESTAG_ELECTION_RESULT ber
        -- Match election results that fall exactly within the current range pairing
        ON ber.TERM >= tr.term_from AND ber.TERM <= tr.term_to
    JOIN
        VOTING_DISTRICT vd ON ber.DISTRICT_ID = vd.VOTING_DISTRICT_ID
    JOIN
        BUNDESLAND bl ON vd.STATE_ID = bl.STATE_VALUE_ID
    GROUP BY
        tr.term_from,
        tr.term_to,
        bl.STATE_NAME,
        ber.PARTY
),
RankedParties AS (
    -- 4. Rank the parties within each state and term range based on total votes
    SELECT
        term_from,
        term_to,
        STATE_NAME,
        PARTY,
        TOTAL_VOTES,
        RANK() OVER (
            PARTITION BY term_from, term_to, STATE_NAME
            ORDER BY TOTAL_VOTES DESC
        ) AS vote_rank
    FROM
        RangeVotes
)
-- 5. Filter for only the top-ranked party and pull in the party color
SELECT
    rp.term_from,
    rp.term_to,
    rp.STATE_NAME,
    rp.PARTY AS TOP_PARTY,
    p.HEX_COLOR AS PARTY_COLOR,
    rp.TOTAL_VOTES
FROM
    RankedParties rp
LEFT JOIN
    PARTY p ON rp.PARTY = p.SHORTNAME
WHERE
    rp.vote_rank = 1;
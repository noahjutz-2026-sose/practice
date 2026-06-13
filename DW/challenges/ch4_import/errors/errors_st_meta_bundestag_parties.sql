OPEN SCHEMA NOAH_JUTZ;

-- Check for missing parties

SELECT E.PARTY, COUNT(*) AS cnt
FROM ST_BUNDESTAG_ELECTIONS E
         FULL OUTER JOIN ST_META_BUNDESTAG_PARTIES P
                         ON E.PARTY = P.SHORTNAME
WHERE P.SHORTNAME IS NULL
GROUP BY E.PARTY
ORDER BY cnt desc;

-- Add missing parties

INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('linke', 'PDS / Die LINKE');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('union', 'CDU / CSU');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('afd', 'AfD');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('spd', 'SPD');

-- Remove duplicates

DELETE FROM ST_META_BUNDESTAG_PARTIES
WHERE SHORTNAME IN ('mlpd', 'npd', 'bp', 'dib', 'dkp', 'tierschutzpartei', 'tierschutz', 'violetten', 'familie', 'piraten');

-- Rename / normalize in st_bundestag_elections

UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'solidaritaet'
WHERE PARTY = 'bueso';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'frauen'
WHERE PARTY = 'diefrauen';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'graue'
WHERE PARTY = 'diegrauen';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'volt_deutschland'
WHERE PARTY = 'volt';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'npd'
WHERE PARTY = 'heimat';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'die_partei'
WHERE PARTY = 'partei_fuer_arbeit_rechtsstaat_tierschutz_elitenfoerderung_und_basisdemokratische_initiative';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'partei_der_humanisten'
WHERE PARTY = 'die_humanisten';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'basisdemokratische_partei_deutschland'
WHERE PARTY = 'diebasis';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'oedp'
WHERE PARTY = 'oekologischdemokratische_partei';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'v'
WHERE PARTY = 'vpartei3_partei_fuer_veraenderung_vegetarier_und_veganer';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'die_tierschutzpartei'
WHERE PARTY = 'parteimenschumwelttierschutz';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'liberalkonservative_reformer'
WHERE PARTY = 'lkr';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'v'
WHERE PARTY = 'vpartei3';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'partei_der_vernunft'
WHERE PARTY = 'parteidervernunft';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'die_violetten'
WHERE PARTY = 'dievioletten';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'rrp'
WHERE PARTY = 'buendnis_21rrp';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'solidaritaet'
WHERE PARTY = 'buergerrechtsbewegung_solidaritaet';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'psg'
WHERE PARTY = 'sgp';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'psg'
WHERE PARTY = 'sozialistische_gleichheitspartei_vierte_internationale';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'partei_des_fortschritts'
WHERE PARTY = 'pdf';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'graue'
WHERE PARTY = 'die_grauen';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'graue_panther'
WHERE PARTY = 'die_grauen_fuer_alle_generationen';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'b'
WHERE PARTY = 'bergpartei_die_ueberpartei';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY = 'menschliche_welt'
WHERE PARTY = 'menschlichewelt';

-- Add missing parties to schema

INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('freiewaehler', 'Freie Wähler');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('buendnis_grundeinkommen', 'Bündnis Grundeinkommen');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('team_todenhoefer', 'Team Todenhöfer');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('demokratieinbewegung', 'Demokratie in Bewegung');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('stattpartei', 'Statt Partei');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('verjuengungsforschung', 'Partei für Verjüngungsforschung');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('buendnis_c', 'Bündnis C');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('chance2000', 'Chance 2000');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('parteilose', 'Parteilose');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('nichtwaehler', 'Nichtwähler');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('partei_fuer_gesundheitsforschung', 'Partei für Gesundheitsforschung');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('dierechte', 'Die Rechte');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('buendnis21', 'Bündnis 21');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('lfk', 'LFK');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('liebe', 'Liebe');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('iiiweg', 'Der III. Weg');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('unabhaengige', 'Unabhängige');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('dib', 'Demokratie in Bewegung');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('allianz_fuer_menschenrechte_tier_und_naturschutz', 'Allianz für Menschenrechte, Tier- und Naturschutz');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('buergerbewegung', 'Bürgerbewegung');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('oekounion', 'Öko-Union');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('tierschutzallianz', 'Tierschutzallianz');
INSERT INTO ST_META_BUNDESTAG_PARTIES
VALUES ('ab2000', 'AB 2000');

SELECT * FROM ST_BUNDESTAG_ELECTIONS WHERE PARTY = 'tierschutzallianz'
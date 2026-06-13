OPEN SCHEMA NOAH_JUTZ;

-- Check if district_id 1..1 district_name
SELECT DISTINCT DISTRICT_ID, COUNT(DISTINCT DISTRICT_NAME)
FROM ST_BUNDESTAG_ELECTIONS
GROUP BY DISTRICT_ID
ORDER BY DISTRICT_ID;

-- Cross-check with st_Meta_Bundestag_Parties
SELECT E.PARTY, COUNT(*) AS cnt
FROM ST_BUNDESTAG_ELECTIONS E
         FULL OUTER JOIN ST_META_BUNDESTAG_PARTIES P
                         ON E.PARTY = P.SHORTNAME
WHERE P.SHORTNAME IS NULL
GROUP BY E.PARTY
ORDER BY cnt desc;

-- Normalize party names manually

UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='partei_der_vernunft'
WHERE PARTY = 'parteidervernunft';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='solidaritaet'
WHERE PARTY = 'bueso';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='deutsche_kommunistische_partei'
WHERE PARTY = 'dkp';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='v'
WHERE PARTY = 'vpartei3_partei_fuer_veraenderung_vegetarier_und_veganer';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='graue'
WHERE PARTY = 'diegrauen';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='menschliche_welt'
WHERE PARTY = 'menschlichewelt';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='piratenpartei_deutschland'
WHERE PARTY = 'piraten';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='die_partei'
WHERE PARTY = 'partei_fuer_arbeit_rechtsstaat_tierschutz_elitenfoerderung_und_basisdemokratische_initiative';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='oedp'
WHERE PARTY = 'oekologischdemokratische_partei';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='nationaldemokratische_partei_deutschlands'
WHERE PARTY = 'npd';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='solidaritaet'
WHERE PARTY = 'buergerrechtsbewegung_solidaritaet';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='demokratieinbewegung'
WHERE PARTY = 'dib';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='marxistischleninistische_partei_deutschlands'
WHERE PARTY = 'mlpd';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='nationaldemokratische_partei_deutschlands'
WHERE PARTY = 'heimat';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='die_violetten'
WHERE PARTY = 'violetten';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='die_tierschutzpartei'
WHERE PARTY = 'tierschutzpartei';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='frauen'
WHERE PARTY = 'diefrauen';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='bayernpartei'
WHERE PARTY = 'bp';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='partei_des_fortschritts'
WHERE PARTY = 'pdf';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='liberalkonservative_reformer'
WHERE PARTY = 'lkr';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='die_violetten'
WHERE PARTY = 'dievioletten';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='graue'
WHERE PARTY = 'die_grauen_fuer_alle_generationen';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='psg'
WHERE PARTY = 'sgp';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='v'
WHERE PARTY = 'vpartei3';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='b'
WHERE PARTY = 'bergpartei_die_ueberpartei';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='volt_deutschland'
WHERE PARTY = 'volt';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='psg'
WHERE PARTY = 'sozialistische_gleichheitspartei_vierte_internationale';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='partei_der_humanisten'
WHERE PARTY = 'die_humanisten';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='die_tierschutzpartei'
WHERE PARTY = 'parteimenschumwelttierschutz';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='graue'
WHERE PARTY = 'die_grauen';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='familienpartei_deutschlands'
WHERE PARTY = 'familie';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='basisdemokratische_partei_deutschland'
WHERE PARTY = 'diebasis';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='die_tierschutzpartei'
WHERE PARTY = 'tierschutz';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='rrp'
WHERE PARTY = 'buendnis_21rrp';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='uebrige'
WHERE PARTY = 'parteilose';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='uebrige'
WHERE PARTY = 'nichtwaehler';
UPDATE ST_BUNDESTAG_ELECTIONS
SET PARTY='uebrige'
WHERE PARTY = 'unabhaengige';

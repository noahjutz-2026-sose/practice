OPEN SCHEMA NOAH_JUTZ;

-- Integrate st_politbarometer_survey manually

INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 1, 'union');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 4, 'spd');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 5, 'fdp');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 6, 'gruene');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 7, 'linke');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 105, 'adm');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 118, 'bfb');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 126, 'bayernpartei');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 127, 'buergerp');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 134, 'solidaritaet');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 138, 'cm');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 147, 'frauen');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 149, 'graue');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 151, 'die_partei');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 152, 'die_violetten');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 156, 'deutsche_kommunistische_partei');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 165, 'dsu');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 168, 'dvu');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 171, 'familienpartei_deutschlands');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 176, 'forum');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 180, 'fwd');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 202, 'marxistischleninistische_partei_deutschlands');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 206, 'nationaldemokratische_partei_deutschlands');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 209, 'oedp');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 214, 'pbc');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 215, 'piratenpartei_deutschland');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 219, 'pro_dm');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 221, 'psg');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 224, 'rentner');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 225, 'rep');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 226, 'rrp');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 228, 'schill');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 235, 'stattpartei');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 237, 'die_tierschutzpartei');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 256, 'zentrum');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 322, 'afd');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 331, 'liberalkonservative_reformer');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 364, 'volt_deutschland');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 372, 'basisdemokratische_partei_deutschland');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 801, 'uebrige');

-- Many-to-Many mappings
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 250, 'linke');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 305, 'union');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 309, 'fdp');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 371, 'basisdemokratische_partei_deutschland');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 392, 'linke');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 393, 'union');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 400, 'gruene');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 401, 'gruene');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 402, 'gruene');
INSERT INTO Mapping_Party_Politbarometer_Value_Labels
VALUES (default, 403, 'union');
-- INSERT INTO Mapping_Party_Politbarometer_Value_Labels
-- VALUES (default, 2, 'union');
-- INSERT INTO Mapping_Party_Politbarometer_Value_Labels
-- VALUES (default, 3, 'union');

-- Check if everything is integrated

SELECT *
FROM MAPPING_PARTY_POLITBAROMETER_VALUE_LABELS P
         RIGHT JOIN ST_META_POLITBAROMETER_VALUE_LABELS L
                    ON P.VALUE_ID = L.VALUE_ID
WHERE L.VARIABLE_ID in ('v6', 'v7', 'v72')
  AND L.VALUE_ID > 0
  AND P.VALUE_ID IS NULL;
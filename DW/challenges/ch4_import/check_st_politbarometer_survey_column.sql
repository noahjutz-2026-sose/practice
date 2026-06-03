OPEN SCHEMA NOAH_JUTZ;

CREATE OR REPLACE SCRIPT check_st_politbarometer_survey_column (column_name) AS
local var_id = string.match(column_name, "^(.-)_")
if not var_id then
    var_id = column_name
end

local sql = [[
SELECT ''' || column_name || ''' AS column_name, s.]]
    .. column_name .. [[ AS value_id
FROM st_Politbarometer_Survey s
LEFT JOIN st_Meta_Politbarometer_Value_Labels l
  ON l.variable_id = ']] .. var_id .. [['
  AND l.value_id = s.]] .. column_name .. [[
WHERE l.value_id IS NULL
]]

query(sql)
/

EXECUTE SCRIPT check_invalid_values('v6_intended_vote');


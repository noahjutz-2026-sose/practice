SELECT to_char(current_date, 'D'); -- Day of week (sun=1, sat=7)
SELECT to_char(current_date, 'DD'); -- Day of month

SELECT * FROM exa_dba_audit_sessions LIMIT 10;
SELECT * FROM exa_dba_audit_sessions WHERE logout_time IS null;
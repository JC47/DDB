set sqlprompt "_user_connect_identifier 'Calette'>";

spool %ORA_OUT%\salidaV$TIMEZONE_NAMES.txt
set linesize 150
set pagesize 30
column tzname format a45;
column tzabbrev format a45;
set timing on
SELECT TZNAME,TZABBREV
  FROM V$TIMEZONE_NAMES;
SET timing off
spool off

spool %ORA_OUT%\salidaV$TABLESPACE.txt
COLUMN TS# FORMAT 999;
COLUMN NAME FORMAT A25;
COLUMN INCLUDED_IN_DATABASE_BACKUP FORMAT A25
SELECT TS#,NAME,INCLUDED_IN_DATABASE_BACKUP
  FROM V$TABLESPACE;
spool off

spool %ORA_OUT%\salidaV$PARAMETER.txt
COLUMN VALUE A25;
COLUMN NAME FORMAT A25;
COLUMN DESCRIPTION FORMAT A70;
SELECT NAME,VALUE,DESCRIPTION
  FROM V$PARAMETER;
spool off

spool %ORA_OUT%\salida_SER_INDEXES.txt
COLUMN INDEX_NAME A25;
COLUMN INDEX_TYPE FORMAT A25;
COLUMN TABLE_OWNER FORMAT A70;
COLUMN TABLE_NAME A25;
COLUMN BLEVEL FORMAT A25;
COLUMN LEAF_BLOCKS FORMAT A70;
SELECT INDEX_NAME,INDEX_TYPE,TABLE_OWNER,TABLE_NAME,
BLEVEL,LEAF_BLOCKS
  FROM SER_INDEXES;
spool off

spool %ORA_OUT%\salidaROLE_SYS_PRIVS.txt
COLUMN ROLE A35;
COLUMN PRIVILEGE FORMAT A35;
COLUMN ADMIN_OPTION FORMAT A35;
SELECT ROLE,PRIVILEGE,ADMIN_OPTION
  FROM ROLE_SYS_PRIVS;
spool off

spool %ORA_OUT%\salidaNLS_INSTANCE_PARAMETERS.txt
COLUMN VALUE A35;
COLUMN parameter FORMAT A35;
SELECT parameter,VALUE
  FROM NLS_INSTANCE_PARAMETERS;
spool off

spool %ORA_OUT%\salidaUSER_SECUENCES.txt
COLUMN SECUENCE_NAME A25;
COLUMN MIN_VALUE FORMAT 9999;
COLUMN MAX_VALUE 9999;
COLUMN LAST_NUMBER FORMAT 9999;
SELECT SECUENCE_NAME,MIN_VALUE,MAX_VALUE,LAST_NUMBER
  FROM USER_SECUENCES;
spool off

spool %ORA_OUT%\P2S2.txt
column "Current Date" format a18,
column "Year 88" format a10;
column "Year 18" format a18;
SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') "Current Date",
TO_CHAR(TO_DATE('10/14/88','MM/DD/RR'), 'YYYY') "YEAR 88",
TO_CHAR(TO_DATE('10/14/18','MM/DD/RR'), 'YYYY') "YEAR 18"
FROM dual;
spool off

spool %ORA_OUT%\P2S2-1.txt
column "Current Date" format a18,
column "Year 88" format a10;
column "Year 18" format a18;
SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') "Current Date",
TO_CHAR(TO_DATE('14-OCT-88','DD-MON-RR'), 'YYYY') "YEAR 88",
TO_CHAR(TO_DATE('14-OCT-18','DD-MON-RR'), 'YYYY') "YEAR 18"
FROM dual;
spool off

spool %ORA_OUT%\P248.txt
set serveroutput on
DECLARE
a TIMESTAMP WITH TIME ZONE;
b TIMESTAMP WITH TIME ZONE;
c TIMESTAMP WITH TIME ZONE;
d TIMESTAMP WITH TIME ZONE;
e TIMESTAMP WITH TIME ZONE;
BEGIN
a := TIMESTAMP '2002-02-19 11:52:00.00 -05:00';
b := TIMESTAMP '2002-02-19 14:00:00.000000000 -05:00';
c := TIMESTAMP '2002-02-19 13:52:00 -05:00';
d := TIMESTAMP '2002-02-19 13:52:00';
e := TIMESTAMP '2002-02-19';
DBMS_OUTPUT.PUT_LINE(a);
DBMS_OUTPUT.PUT_LINE(b);
DBMS_OUTPUT.PUT_LINE(c);
DBMS_OUTPUT.PUT_LINE(d);
DBMS_OUTPUT.PUT_LINE(e);
END;
spool off

spool %ORA_OUT%\P245.txt
set serveroutput on
DECLARE
a TIMESTAMP;
b TIMESTAMP;
BEGIN
a := TO_TIMESTAMP('22-Feb-2002 09.00.00.50');
b := TO_TIMESTAMP('02/24/02 09.00.00.50');
DBMS_OUTPUT.PUT_LINE(a);
DBMS_OUTPUT.PUT_LINE(b);
END;
spool off

PROMPT CONSULTA LOS USUARIOS DESDE SYS
select username,account_status,lock_date,expiry_date
  from dba_users;
PROMPT CONSULTA AL USUARIO STUDENT
select username,account_status,expiry_date
  from dba_users
  where username='STUDENT';

ALTER USER STUDENT ACCOUNT UNLOCK;

SET PAGESIZE 0
SET FEEDBACK OFF
SELECT 'DROP TABLE' || table_name || ';'
FROM user_tables
  WHERE table_name LIKE UPPER('HR')
SPOOL drop.cmd
/
SPOOL OFF
@drop.cmd

SELECT owner || '.' || name refs_table, referenced_owner || '.' ||
referenced_name table_referenced
  FROM all_dependencies
  WHERE owner LIKE UPPER('HR')
  AND TYPE IN ('PACKAGE','PACKAGE BODY','PROCEDURE','FUNCTION')
  AND referenced_type IN ('TABLE','VIEW')
  ORDER BY owner,name,referenced_owner,referenced_name;

CREATE TABLE temp (N NUMBER);
CREATE OR REPLACE TRIGGER temp_air
  AFTER INSERT ON TEMP
  FOR EACH ROW
  BEGIN
  DBMS_OUTPUT.PUT_LINE('executing temp_air');
  END
  /
INSERT INTO temp VALUES(10);
INSERT INTO temp VALUES(20);
INSERT INTO temp VALUES(30);
INSERT INTO temp VALUES(40);
INSERT INTO temp VALUES(50);

INSERT INTO temp SELECT * FROM temp;
INSERT INTO temp SELECT * FROM temp;

PROMPT DESPLEGAR LOS TRIGGERS ACTIVOS
PROMPT ACTIVAR LOS TRIGGERS
PROMPT DESACTIVAR LOS TRIGGERS
CREATE OR REPLACE TRIGGER temp_aur
AFTER UPDATE ON TEMP
FOR EACH ROW
WHEN (NEW.N BETWEEN 1 AND 10)
BEGIN
  DBMS_OUTPUT.PUT_LINE('EXECUTING TEMP_AUR');
END;

CREATE TABLE TEMP(N NUMBER, M NUMBER DEFAULT 5);
CREATE OR REPLACE TRIGGER temp_bur
BEFORE UPDATE ON TEMP
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('BUR old N:'||:old.n||'M:'||old.M);
  DBMS_OUTPUT.PUT_LINE('BUR old N:'||:new.n||'M:'||new.M);
END;


CREATE OR REPLACE TRIGGER temp_aur
AFTER UPDATE ON TEMP
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('AUR old N:'||:old.n||'M:'||old.M);
  DBMS_OUTPUT.PUT_LINE('AUR old N:'||:new.n||'M:'||new.M);
END;

INSERT INTO TEMP(n) VALUES (1);
UPDATE TEMP SET n=n+1 where n>=1;

UPDATE TEMP SET m=2 WHERE M=5;
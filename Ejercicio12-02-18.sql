spool %ORA_OUT%\ej_1_12_febrero.txt
  desc hr.employees;
  desc dba_tab_columns;
  column owner format a15
  column table_name format a20
  set colsep ' * '

select owner,table_name,column_name
  from dba_tab_columns
  where owner='HR' and table_name='EMPLOYEES';

spool off;

ALTER USER HR/HR ACCOUNT UNLOCK;

select table_name,column_name
  from user_tab_columns
  where table_name LIKE '%EMPLOY%';

select owner,table_name,column_name
  from All_tab_columns
  where owner='HR' and table_name='EMPLOYEES';

DESC ALL_OBJECTS
REM --configura pàgina, tamaño de linea, separador de columnas y subrayado

SET PAGESIZE 99
SET LINESIZE 150
SET COLSEP '| '
SET UNDERLINE '='

COLUMN OWNER FORMAT A10 JUS CENTER
COLUMN OBJECT_NAME FORMAT A25 JUS CENTER
COLUMN Tipo FORMAT A10 JUS CENTER

SELECT OWNER, OBJECT_NAME, OBJECT_TYPE "Tipo"
  FROM ALL_OBJECTS
  WHERE OWNER='HR'
  ORDER BY 3;

DESC ALL_TAB_COLUMNS;

COLUMN OWNER FORMAT A6
COLUMN TABLE_NAME FORMAT A25
COLUMN COLUMN_NAME FORMAT A18
COLUMN DATA_TYPE FORMAT A10
COLUMN DATA_TYPE_MOD FORMAT A6
COLUMN DATA_TYPE_OWNER FORMAT A6

SELECT OWNER,TABLE_NAME,COLUMN_NAME,DATA_TYPE, CHARACTER_SET_NAME
  FROM ALL_TAB_COLUMNS
  WHERE OWNER = 'HR'
  ORDER BY 2,3;

COLUMN PARAMETER FORMAT A25;
COLUMN VALUE FORMAT A40;
SET SPACE 7;

select parameter,value
  from nls_session_parameters;

  select sysdate from dual;
  alter session set NLS_DATE_FORMAT = "DAY DD-MONTH-YYYY";
  alter session set NLS_LANGUAGE = 'ENGLISH';
  select sysdate from dual;
  alter session set NLS_LANGUAGE = 'FRENCH';
  select sysdate from dual;
  alter session set NLS_LANGUAGE = 'SPANISH';
  select sysdate from dual;

  DEFINE GNAME=CALETTE;
  set sqlprompt '&GNAME>';
  REM DESPLEGAR VARIAS FECHAS;
    select to_char(sysdate,'J') from dual;
    select to_char('30-03-14','J') from dual;
    select to_char(SYSTIMESTAMP,'J') from dual;
    select SYSTIMESTAMP from dual;
    select sysdate,SYSTIMESTAMP from dual;
    set sqlprompt 'SQL>';
  CLEAR COLUMNS;
  COLUMN FECHA1 FORMAT A20;
  COLUMN FECHA2 FORMAT A32;
    select sysdate FECHA1, SYSTIMESTAMP FECHA2 from dual;
  REM EL 1 DE ENERO DEL AÑO 4712 AC;
    select
      TO_CHAR(TO_DATE('1-Ene-4712 12:00 pm', 'dd-Mon-syyyy hh:mi am'),'J')
    from dual;
  REM EL 1 DE ENERO DEL AÑO 1 DE NUESTRA ERA;
    select
      TO_CHAR(TO_DATE('1-Ene-1 12:00 pm', 'dd-Mon-syyyy hh:mi am'),'J')
    from dual;
  REM EL 12 DE FEBRERO DE 2018;
    select
      TO_CHAR(TO_DATE('12-Feb-2018 07:00 am', 'dd-Mon-syyyy hh:mi am'),'J')
    from dual;
  REM Los dias recordaatos por Gregorio VII;
    select
      TO_CHAR(TO_DATE('04-Oct-1582 03:50 pm', 'dd-Mon-syyyy hh:mi am'),'J')
    from dual;
  REM Los dias recordaatos por Gregorio VII;
    select
      TO_CHAR(TO_DATE('10-Oct-1582 03:50 pm', 'dd-Mon-syyyy hh:mi am'),'J')
    from dual;
  REM Los dias recordaatos por Gregorio VII;
    select
      TO_CHAR(TO_DATE('15-Oct-1582 03:50 pm', 'dd-Mon-syyyy hh:mi am'),'J')
    from dual;

    REM Encontrar diferencia entre FECHAS
      select
        TO_CHAR(TO_DATE('12-Feb-2018 07:00 am', 'dd-Mon-syyyy hh:mi am'),'J') FEHCA1,
        TO_CHAR(TO_DATE('29-Ene-2018 07:00 am', 'dd-Mon-syyyy hh:mi am'),'J') FECHA2,
        (TO_DATE('12-Feb-2018 07:00 am', 'dd-Mon-syyyy hh:mi am') -
        TO_DATE('29-Ene-2018 07:00 am', 'dd-Mon-syyyy hh:mi am')) "Dias transcurridos"
      from dual;

set pagesize 99
set linesize 150
set colsep '||'
set underline '='
desc dict_columns

desc all_source
column owner format a8
column name format a25
column type format a13
column line format 99
column text format a79 wrapped
select owner,name,type,line text from all_source where owner='HR' and rownum <=5;

select owner,name,type,line text from all_source where owner='HR' and NAME='ADD_JOB_HISTORY';

select owner, distinct owner type from all_source where owner = 'HR';

SELECT DISTINCT NAME FROM ALL_SOURCE WHERE TYPE = 'FUNCTION';

SELECT DISTINCT NAME FROM USER_SOURCE WHERE TYPE = 'PROCEDURE';

select owner,name,type,line text from all_source where TYPE = 'PROCEDURE' and NAME='SECURE_DML';

select owner,name,type,line text from user_source where TYPE = 'PROCEDURE' and NAME='SECURE_DML';

SELECT DISTINCT TYPE FROM USER_SOURCE WHERE TYPE = 'FUNCTION';

SELECT COUNT(DISTINCT NAME) FROM ALL_SOURCE WHERE TYPE = 'FUNCTION';

SELECT COUNT(DISTINCT NAME) FROM ALL_SOURCE;

SELECT DISTINCT TYPE"Tipo Objeto" FROM ALL_SOURCE;

SELECT COUNT(DISTINCT TYPE) FROM ALL_SOURCE;

SELECT COUNT(DISTINCT TYPE), COUNT(NAME) FROM ALL_SOURCE;

SELECT COUNT(DISTINCT NAME)"Tot objetos", COUNT(NAME)"Tot lineas" FROM ALL_SOURCE;

SELECT DISTINCT OWNER FROM ALL_SOURCE;

SELECT COUNT(DISTINCT OWNER)"Tot usuario",COUNT(OWNER)"Tot lineas" FROM ALL_SOURCE;

SELECT DISTINCT OWNER FROM ALL_SOURCE;

desc user_source
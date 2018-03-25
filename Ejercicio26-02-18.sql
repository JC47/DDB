drop table EMP;
create table EMP(
  empleado_id integer primary key,
  First_name varchar2(20),
  Last_name varchar2(20),
  Reporta_a integer
);

prompt tuplas

insert into EMP VALUES(1,'Nancy','Devolio',NULL);
insert into EMP VALUES(2,'Andrew','Fuller',1);
insert into EMP VALUES(3,'Janet','Leverling',1);
insert into EMP VALUES(4,'Margaret','Peacock',1);
insert into EMP VALUES(5,'Steven','Rodriguez',3);
insert into EMP VALUES(6,'Rosy','Buychanan',5);
insert into EMP VALUES(7,'Mary','Sumaya',6);

prompt despliega empleados del jefe

select First_name,Last_name
  from EMP WHERE Reporta_a = 1;

prompt despliega el jefe

select First_name,Last_name,Reporta_a
  from EMP WHERE empleado_id=1;

prompt despliega jefe

COLUMN First_name format A12;
COLUMN Last_name format A12;
COLUMN Reporta format A12;


select First_name,Last_name,NVL(TO_CHAR(Reporta_a),'Sin Jefe')Reporta
  FROM emp WHERE Reporta_a is NULL;

select First_name,Last_name
  FROM emp WHERE Reporta_a = NULL;

prompt Declara la llave foranea;

Alter table emp
  add constraint FK_EMP_Reflexiva foreign key (Reporta_a) references EMP(empleado_id);

prompt Habilita llave foranea

Alter table emp
  enable constraint FK_EMP_Reflexiva;

prompt Intenta borrar al Jefe

DELETE FROM emp where empleado_id = 1;

prompt Deshabilita llave foranea;

Alter table emp
  disable constraint FK_EMP_Reflexiva;

prompt Borrar al Jefe

DELETE FROM emp where empleado_id = 1;

prompt Insertar al Jefe

INSERT INTO EMP VALUES(1,'Nancy','Devolio', NULL);

prompt despliega tuplas

select * from EMP;

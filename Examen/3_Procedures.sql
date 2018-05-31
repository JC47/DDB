--Procedures para 3 ejercicios del examen
--Calette Cornelio Javier

CREATE OR REPLACE PROCEDURE GET_NAME_BY_MONTH(MES EMPLEADO.NOMBRE%TYPE) IS
  REGISTRO EMPLEADO.NOMBRE%TYPE;
  CURSOR CR1 IS SELECT NOMBRE FROM EMPLEADO WHERE (SUBSTR(CURP,7,2) = MES);
BEGIN
  OPEN CR1;
  LOOP
    FETCH CR1 INTO REGISTRO;
    EXIT WHEN CR1%NOTFOUND;
    DBMS_OUTPUT.put_line(REGISTRO);
  END LOOP;
  CLOSE CR1;
END;
/

CREATE OR REPLACE PROCEDURE GET_CAPICUA IS
  REGISTRO SALARIO.FORMULA%TYPE;
  VAR VARCHAR2(5);
  PA VARCHAR2(5) := '(';
  AUX VARCHAR2(5);
  AUX2 VARCHAR2(5);
  CAP NUMBER := 0;
  CURSOR CR1 IS SELECT MONTO FROM SALARIO;
BEGIN
  OPEN CR1;
  LOOP
    FETCH CR1 INTO REGISTRO;
    EXIT WHEN CR1%NOTFOUND;
    VAR := SUBSTR(REGISTRO,2,1);
    IF UTL_MATCH.EDIT_DISTANCE(VAR, PA) <= 0   THEN
      AUX := SUBSTR(REGISTRO,3,1);
      AUX2 := SUBSTR(REGISTRO,-5,1);
      IF UTL_MATCH.EDIT_DISTANCE(AUX, AUX2) <= 0   THEN
         CAP := CAP + 1;
      END IF;
    ELSE
      AUX := SUBSTR(REGISTRO,2,1);
      AUX2 := SUBSTR(REGISTRO,-4,1);
      IF UTL_MATCH.EDIT_DISTANCE(AUX, AUX2) <= 0   THEN
         CAP := CAP + 1;
      END IF;
    END IF;
  END LOOP;
  DBMS_OUTPUT.put_line('EMPLEADOS CON SALARIO CAPICUA: '||CAP);
  CLOSE CR1;
END;
/

CREATE OR REPLACE PROCEDURE GET_COMPUESTOS IS
  VAR VARCHAR2(5);
  ESPACIO VARCHAR2(5) := ' ';
  COMPUESTO NUMBER := 0;
  NE NUMBER:= 0;
  REGISTRO EMPLEADO.NOMBRE%TYPE;
  CURSOR CR1 IS SELECT NOMBRE FROM EMPLEADO;
BEGIN
  OPEN CR1;
  LOOP
    FETCH CR1 INTO REGISTRO;
    EXIT WHEN CR1%NOTFOUND;
    NE := 0;
    FOR i IN 1..LENGTH(REGISTRO) LOOP
     VAR := substr(REGISTRO,i,1);
     IF UTL_MATCH.EDIT_DISTANCE(VAR, ESPACIO) <= 0   THEN
      NE := NE + 1;
     END IF;
    END LOOP;
    IF NE > 2 THEN
      COMPUESTO := COMPUESTO + 1;
    END IF;
  END LOOP;
  DBMS_OUTPUT.put_line('EMPLEADOS CON NOMBRE/APELLIDO COMPUESTO: '||COMPUESTO);
  CLOSE CR1;
END;
/

SELECT OBJECT_NAME, STATUS FROM USER_OBJECTS WHERE OBJECT_TYPE='PROCEDURE';
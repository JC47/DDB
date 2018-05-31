CREATE OR REPLACE PACKAGE PKG_1 AS
  FECHA DATE;
  PROCEDURE DESCUENTO;
  FUNCTION INSTRUCTOR_ID_NUEVO
  RETURN INSTRUCTOR.INSTRUCTOR_ID%TYPE;
  FUNCTION COSTO_TOTAL(AUX_ID IN STUDENT.STUDENT_ID%TYPE)
  RETURN COURSE.COST%TYPE;
  PRAGMA RESTRICT_REFERENCES
  (COSTO_TOTAL, WNDS, WNPS, RNPS);
  PROCEDURE GET_INFO
  (AUX_ID IN STUDENT.STUDENT_ID%TYPE,AUX_LN OUT STUDENT.LAST_NAME%TYPE,AUX_FN OUT STUDENT.FIRST_NAME%TYPE,AUX_ZIP OUT STUDENT.ZIP%TYPE,AUX_CODIGO OUT NUMBER);
  PROCEDURE GET_INFO
  (AUX_LN IN STUDENT.LAST_NAME%TYPE,AUX_FN IN STUDENT.FIRST_NAME%TYPE,AUX_ID OUT STUDENT.STUDENT_ID%TYPE,AUX_ZIP OUT STUDENT.ZIP%TYPE,AUX_CODIGO OUT NUMBER);
  PROCEDURE DELETE_STUDENT(AUX_ID IN STUDENT.STUDENT_ID%TYPE);
END PKG_1;
/

CREATE OR REPLACE PACKAGE BODY PKG_1 AS
  PROCEDURE DESCUENTO IS
  CURSOR DESCUENTOS IS
  SELECT DISTINCT S.COURSE_NO, C.DESCRIPTION FROM SECTION S, ENROLLMENT E, COURSE C WHERE S.SECTION_ID = E.SECTION_ID GROUP BY S.COURSE_NO,C.DESCRIPTION,E.SECTION_ID, S.SECTION_ID HAVING COUNT(*) >=8;
  BEGIN
    FOR AUX1 IN DESCUENTOS LOOP
    UPDATE COURSE SET COST = COST * .95 WHERE COURSE_NO = AUX1.COURSE_NO;
    DBMS_OUTPUT.PUT_LINE('5% DESCUENTO PARA: '||AUX1.COURSE_NO||' '||AUX1.DESCRIPTION);
    END LOOP;
  END DESCUENTO;

  FUNCTION INSTRUCTOR_ID_NUEVO
    RETURN INSTRUCTOR.INSTRUCTOR_ID%TYPE
    IS
    ID_NUEVO INSTRUCTOR.INSTRUCTOR_ID%TYPE;
  BEGIN
    SELECT MAX(INSTRUCTOR_ID) + 1 INTO ID_NUEVO FROM INSTRUCTOR;
    RETURN ID_NUEVO;
    EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR');
  END INSTRUCTOR_ID_NUEVO;

FUNCTION COSTO_TOTAL(AUX_ID IN STUDENT.STUDENT_ID%TYPE)
  RETURN COURSE.COST%TYPE
  IS
  COSTO COURSE.COST%TYPE;
BEGIN
  SELECT SUM(COST) INTO COSTO FROM COURSE C, SECTION S, ENROLLMENT E WHERE C.COURSE_NO = C.COURSE_NO AND E.SECTION_ID = S.SECTION_ID AND E.STUDENT_ID = AUX_ID;
  RETURN COSTO;
  EXCEPTION
  WHEN OTHERS THEN
  RETURN NULL;
END COSTO_TOTAL;

PROCEDURE GET_INFO(AUX_ID IN STUDENT.STUDENT_ID%TYPE,AUX_LN OUT STUDENT.LAST_NAME%TYPE,AUX_FN OUT STUDENT.FIRST_NAME%TYPE,AUX_ZIP OUT STUDENT.ZIP%TYPE,AUX_CODIGO OUT NUMBER)
IS
BEGIN
  SELECT LAST_NAME, FIRST_NAME, ZIP INTO AUX_LN, AUX_FN, AUX_ZIP FROM STUDENT WHERE STUDENT.STUDENT_ID = AUX_ID;
  AUX_CODIGO := 0;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE ('ID INVALIDO');
  AUX_CODIGO := -100;
  AUX_LN := NULL;
  AUX_FN := NULL;
  AUX_ZIP := NULL;
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERROR');
END GET_INFO;

PROCEDURE GET_INFO(AUX_LN IN STUDENT.LAST_NAME%TYPE,AUX_FN IN STUDENT.FIRST_NAME%TYPE,AUX_ID OUT STUDENT.STUDENT_ID%TYPE,AUX_ZIP OUT STUDENT.ZIP%TYPE,AUX_CODIGO OUT NUMBER)
IS
BEGIN
  SELECT STUDENT_ID, ZIP INTO AUX_ID, AUX_ZIP FROM STUDENT WHERE UPPER(LAST_NAME) = UPPER(AUX_LN) AND UPPER(FIRST_NAME) = UPPER(AUX_FN);
  AUX_CODIGO := 0;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE ('NOMBRE INVALIDO');
  AUX_CODIGO := -100;
  AUX_ID := NULL;
  AUX_ZIP := NULL;
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERROR');
END GET_INFO;

PROCEDURE DELETE_STUDENT(AUX_ID IN STUDENT.STUDENT_ID%TYPE)
IS
BEGIN
  DELETE FROM STUDENT WHERE STUDENT_ID = AUX_ID;
END;

BEGIN
SELECT TRUNC(SYSDATE, 'DD') INTO FECHA FROM DUAL;
END;
END PKG_1;
/
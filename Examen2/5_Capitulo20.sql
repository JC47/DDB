CREATE OR REPLACE FUNCTION F1
RETURN STUDENT.STUDENT_ID%TYPE
AS
ID_NUEVO STUDENT.STUDENT_ID%TYPE;
BEGIN
  SELECT MAX(STUDENT_ID) + 1 INTO ID_NUEVO FROM STUDENT;
  RETURN(ID_NUEVO);
END;
/
------------------------------------------------------------
CREATE OR REPLACE FUNCTION F2
(ZC IN ZIPCODE.ZIP%TYPE)
RETURN BOOLEAN
AS
AUX CHAR(1);
BEGIN
  SELECT NULL INTO AUX FROM ZIPCODE WHERE ZIP = ZC;
  RETURN FALSE;
  EXCEPTION
  WHEN OTHERS THEN
  RETURN TRUE;
END;
/
-----------------------------------------------------------Test F2
DECLARE
cons_zip CONSTANT zipcode.zip%TYPE := '&sv_zipcode';
e_zipcode_is_not_valid EXCEPTION;
BEGIN
IF F2(cons_zip)
THEN
RAISE e_zipcode_is_not_valid;
ELSE
-- An insert of an instructor's record which
-- makes use of the checked zipcode might go here.
NULL;
END IF;
EXCEPTION
WHEN e_zipcode_is_not_valid THEN
RAISE_APPLICATION_ERROR
(-20003, 'Could not find zipcode '||cons_zip||'.');
END;
/
----------------------------------------------------------------
CREATE OR REPLACE FUNCTION F3
(NOMBRE IN INSTRUCTOR.FIRST_NAME%TYPE,
APELLIDO IN INSTRUCTOR.LAST_NAME%TYPE)
RETURN VARCHAR2
AS
AUX_INSTRUCTOR INSTRUCTOR.INSTRUCTOR_ID%TYPE;
AUX_SECTION NUMBER;
AUX VARCHAR2(100);
BEGIN
  SELECT INSTRUCTOR_ID INTO AUX_INSTRUCTOR FROM INSTRUCTOR WHERE FIRST_NAME = NOMBRE AND LAST_NAME = APELLIDO;

  SELECT COUNT(*) INTO AUX_SECTION FROM SECTION WHERE INSTRUCTOR_ID = AUX_INSTRUCTOR;

  IF AUX_SECTION >= 3 THEN
    AUX := 'INSTRUCTOR: '||NOMBRE||' '||APELLIDO||' DA: '||AUX_SECTION||' , SOBRE EXPLOTADO';
  ELSE
    AUX := 'INSTRUCTOR: '||NOMBRE||' '||APELLIDO||' DA: '||AUX_SECTION||' CURSOS';
  END IF;
  RETURN AUX;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    AUX :='INSTRUCTOR: '||NOMBRE||' '||APELLIDO||' SIN CURSOS';
  RETURN AUX;
  WHEN OTHERS THEN
    AUX :='ERROR';
  RETURN AUX;
END;
/
----------------------------------------------------TEST F3
SELECT F3(first_name, last_name) FROM instructor;


SELECT location "Location",
(capacity) "Total Capacity",
COURSE_NO "CNO"
FROM section
WHERE section_no = 3;

SELECT MIN (description) AS MIN, MAX (description) AS MAX
FROM course;
SELECT DISTINCT (description) AS MIN FROM course;

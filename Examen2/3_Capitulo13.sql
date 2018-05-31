CREATE OR REPLACE TRIGGER T_1
BEFORE INSERT ON ENROLLMENT
FOR EACH ROW
DECLARE
AUX NUMBER := 0;
BEGIN
  SELECT COUNT(*) INTO AUX FROM STUDENT WHERE STUDENT_ID = :NEW.STUDENT_ID;
  IF AUX = 0 THEN
    RAISE_APPLICATION_ERROR (-20001,'ESTUDIANTE INVALIDO');
  END IF;
  SELECT COUNT(*) INTO AUX FROM SECCION WHERE SECTION_ID = :NEW.SECTION_ID;
  IF AUX = 0 THEN
    RAISE_APPLICATION_ERROR (-20001,'SECCION INVALIDA');
  END IF;
  :NEW.ENROLL_DATE := SYSDATE;
  :NEW.CREATED_BY := USER;
  :NEW.CREATED_DATE := SYSDATE;
  :NEW.MODIFIED_BY := USER;
  :NEW.MODIFIED_DATE := SYSDATE;
END;

CREATE OR REPLACE TRIGGER T2
BEFORE UPDATE ON SECTION
FOR EACH ROW
DECLARE
AUX NUMBER := 0;
BEGIN
IF :NEW.INSTRUCTOR_ID IS NOT NULL THEN
  SELECT COUNT(*) INTO AUX FROM INSTRUCTOR WHERE INSTRUCTOR_ID = :NEW.INSTRUCTOR_ID;
  IF AUX = 0 THEN
    RAISE_APPLICATION_ERROR (-20001,'INSTRUCTOR INVALIDO');
  END IF;
END IF;
:NEW.MODIFIED_BY := USER;
:NEW.MODIFIED_DATE := SYSDATE;
END;

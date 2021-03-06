DROP TABLE T3;DROP TABLE T2;DROP TABLE T1;
CREATE TABLE T1(COL1 NUMBER);
CREATE TABLE T2(COL2 NUMBER);
CREATE TABLE T3(COL3 NUMBER);

INSERT INTO T1 VALUES(1);
INSERT INTO T1 VALUES(2);
INSERT INTO T1 VALUES(3);
INSERT INTO T1 VALUES(10);
INSERT INTO T1 VALUES(20);
INSERT INTO T1 VALUES(30);

INSERT INTO T2 VALUES(2);
INSERT INTO T2 VALUES(3);
INSERT INTO T2 VALUES(4);
INSERT INTO T2 VALUES(20);
INSERT INTO T2 VALUES(30);
INSERT INTO T2 VALUES(40);

INSERT INTO T3 VALUES(2);
INSERT INTO T3 VALUES(3);
INSERT INTO T3 VALUES(5);
INSERT INTO T3 VALUES(20);
INSERT INTO T3 VALUES(30);
INSERT INTO T3 VALUES(50);

SELECT * FROM T1;
SELECT * FROM T2;
SELECT * FROM T3;

SELECT COL1 FROM T1;

SELECT COL2 FROM T2;

SELECT COL1,COL2 FROM T1 LEFT OUTER JOIN T2 ON T1.COL1 = T2.COL2;

SELECT COL1,COL2 FROM T1 RIGHT OUTER JOIN T2 ON T1.COL1 = T2.COL2;

SELECT COL1,COL2 FROM T1,T2 WHERE T1,T2 WHERE T1.COL1 = T2.COL2(+) UNION SELECT COL1,COL2 FROM T1,T2 WHERE T1.COL1(+) = T2.COL2;

SELECT C.COURSE_NO CNO,S.COURSE_NO SNO,C.DESCRIPTION,C.PREREQUISITE PREREQ,S.LOCATION LOC,S.SECTION_ID
FROM COURSE C LEFT OUTER JOIN SECTION S ON C.COURSE_NO = S.COURSE_NO
WHERE C.PREREQUISITE = 350;

SELECT C.COURSE_NO CNO,S.COURSE_NO SNO,C.DESCRIPTION,C.PREREQUISITE PREREQ,S.LOCATION LOC,S.SECTION_ID
FROM COURSE C LEFT OUTER JOIN SECTION S ON C.COURSE_NO = S.COURSE_NO
WHERE C.PREREQUISITE = 350;

SELECT C.COURSE_NO CNO,S.COURSE_NO SNO,C.DESCRIPTION,C.PREREQUISITE PREREQ,S.LOCATION LOC,S.SECTION_ID
FROM COURSE C,SECTION S WHERE C.COURSE_NO = S.COURSE_NO(+) AND C.PREREQUISITE = 350;

SELECT C.COURSE_NO CNO,S.COURSE_NO SNO,C.DESCRIPTION,C.PREREQUISITE PREREQ,S.LOCATION LOC,S.SECTION_ID
FROM COURSE C,SECTION S WHERE C.COURSE_NO = S.COURSE_NO(+) AND C.PREREQUISITE = 350 AND S.LOCATION(+) = 'L507';

SELECT CITY,STATE,ZIP, (SELECT COUNT(*) FROM STUDENT S WHERE S.ZIP = Z.ZIP) AS STUDENT_COUNT FROM ZIPCODE Z WHERE STATE = 'CT';

SELECT S.STUDENT_ID,EN.SECTION_ID,GRADE_TYPE_CODE,NUMERIC_GRADE FROM STUDENT S LEFT OUTER JOIN ENROLLMENT EN ON (S.STUDENT_ID = EN.STUDENT_ID)
LEFT OUTER JOIN GRADE G ON (S.STUDENT_ID = G.STUDENT_ID AND EN.SECTION_ID = G.SECTION_ID) WHERE S.STUDENT_ID IN (102,301);

SELECT FIRST_NAME,LAST_NAME,PHONE FROM INSTRUCTOR UNION SELECT FIRST_NAME,LAST_NAME,PHONE FROM STUDENT ORDER BY 1,2;

SELECT COURSE_NO,DESCRIPTION FROM COURSE WHERE PREREQUISITE IS NOT NULL ORDER BY 1 UNION SELECT COURSE_NO,DESCRIPTION FROM COURSE WHERE PREREQUISITE IS NULL;

SELECT COURSE_NO,DESCRIPTION FROM COURSE WHERE PREREQUISITE IS NOT NULL UNION SELECT COURSE_NO,DESCRIPTION FROM COURSE WHERE PREREQUISITE IS NULL ORDER BY 2;

SELECT INSTRUCTOR_ID, LAST_NAME FROM INSTRUCTOR UNION SELECT LAST_NAME,STUDENT_ID FROM STUDENT;

SELECT INSTRUCTOR_ID, LAST_NAME FROM INSTRUCTOR UNION SELECT STUDENT_ID,LAST_NAME FROM STUDENT ORDER BY 2;

SELECT COURSE_NO,DESCRIPTION FROM COURSE WHERE COURSE_NO IN (SELECT COURSE_NO FROM SECTION WHERE INSTRUCTOR_ID IN (SELECT INSTRUCTOR_ID FROM INSTRUCTOR WHERE LAST_NAME='HANKS' AND FIRST_NAME='FERNAND'));

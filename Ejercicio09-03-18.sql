rem COUNT AND NULLS

SELECT COUNT(final_grade),COUNT(selection_id),COUNT(*) FROM enrollment;

rem count distinct

SELECT COUNT(DISTINCT section_id), COUNT(section_id) FROm enrollment;

SELECT AVG(capacity),AVG(NVL(capacity,0)) FROM section;

rem function min max

SELECT MIN(capacity),MAX(capacity) FROM section;

prompt min max con otros tipos de datos

SELECT MIN(registration_date)"First",MAX(registration_date)"Last" FROM student;

SELECT AVG(CASE WHEN prerequisite IS NOT NULL THEN cost*1.1 WHEN prerequisite=20 THEN cost*1.2 ELSE cost END) AS PROMEDIO;

SELECT COUNT(*) FROM course WHERE prerequisite IS NULL COUNT(*);

SELECT COUNT(DISTINC student_id) FROM enrollment;

SELECT NVL(MAX(modified_date),TO_DATE('12-MAR-2005','DD-MON-YYYY'));

SELECT location FROM section GROUP BY location;

SELECT location,COUNT(*),SUM(capacity) AS sum,MIN(capacity) AS min, MAX(capacity) AS max FROM section GROUP BY location;

SELECT location,capacity,section_id FROM section WHERE location='L211';

SELECT location,instructor_id,COUNT(*),SUM(capacity) AS sum,MIN(capacity) AS min, MAX(capacity) AS max FROM section GROUP BY location,instructor_id;

SELECT location,instructor_id,capacity,section_id FROM section WHERE location='L210' ORDER BY 1,2;

SELECT location"Location",instructor_id,COUNT(*)"Total locations",SUM(capacity)"Total capacity" FROM section GROUP BY location,instructor_id ORDER BY "Total capacity" DESC;

rem clausula having

SELECT location"Location",instructor_id,COUNT(*)"Total locations",SUM(capacity)"Total capacity" FROM section GROUP BY location,instructor_id HAVING SUM(capacity) > 50 ORDER BY "Total capacity" DESC;

rem clausula where y having

SELECT location"Location",instructor_id,COUNT(*)"Total locations",SUM(capacity)"Total capacity" FROM section_no IN(2,3) GROUP BY location,instructor_id HAVING SUM(capacity) > 50;

rem funciones de agregacion de unidades

SELECT MAX(COUNT(*)) FROM enrollment GROUP BY section_id;

SELECT prerequisite,COUNT(*) FROM course GROUP BY prerequisite ORDER BY prerequisite;

rem nulls first

SELECT prerequisite,COUNT(*) FROM course GROUP BY prerequisite ORDER BY prerequisite NULLS FIRST;

SELECT student_id,COUNT(*) FROM enrollment GROUP BY student_id HAVING COUNT(*) > 2;

SELECT course_no"Course #",AVG(capacity)"Avg. Capacity",ROUND(AVG(capacity))"Rounded Avg. Capacity" FROM section GROUP BY course_no;

SELECT course_no"Course #",AVG(capacity)"Avg. Capacity",ROUND(AVG(capacity))"Rounded Avg. Capacity" FROM section GROUP BY course_no HAVING COUNT(*) = 2;

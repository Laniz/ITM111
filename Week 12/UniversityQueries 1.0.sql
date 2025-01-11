USE enrollment_project;

-- Question 1 
SELECT f_name
,	l_name
,	DATE_FORMAT(student_dob, '%M %e, %Y') AS'Sept Birthdays'
FROM student
WHERE student_dob REGEXP '-09-';

-- Question 2
SELECT l_name, 
       f_name, 
       FLOOR(DATEDIFF('2017-01-05', student_dob) / 365) AS Years,
       (DATEDIFF('2017-01-05', student_dob) % 365) AS Days,
       CONCAT(FLOOR(DATEDIFF('2017-01-05', student_dob) / 365), ' - Yrs, ', 
       (DATEDIFF('2017-01-05', student_dob) % 365), ' - Days') AS 'Years and Days'
FROM student
ORDER BY student_dob;

--  Question 3

SELECT student.f_name, student.l_name
FROM student
JOIN enrollment ON student.student_id = enrollment.student_id
JOIN sections ON sections.section_id = enrollment.section_id
JOIN faculty On sections.faculty_id = faculty.faculty_id
WHERE faculty.faculty_fname = 'John'
	AND faculty.faculty_lname = 'Jensen'
ORDER BY student.l_name;

-- Question 4

SELECT faculty.faculty_fname, faculty.faculty_lname
FROM student
JOIN enrollment ON student.student_id = enrollment.student_id
JOIN sections ON sections.section_id = enrollment.section_id
JOIN faculty On sections.faculty_id = faculty.faculty_id
JOIN term ON sections.term_id = term.term_id
WHERE student.f_name = 'Bryce'
	AND term.term = 'Winter'
    AND term.year = 2018
ORDER BY faculty.faculty_lname;

-- Question 5
 
 SELECT student.f_name, student.l_name
FROM student
JOIN enrollment ON student.student_id = enrollment.student_id
JOIN sections ON sections.section_id = enrollment.section_id
JOIN term ON sections.term_id = term.term_id
JOIN courses On sections.course_id = courses.course_id
WHERE courses.course_title = 'Econometrics'
	AND term.term = 'Fall'
    AND term.year = 2019
ORDER BY student.l_name;

-- Question 6

SELECT courses.department_code, courses.course_num, courses.course_title
FROM student
JOIN enrollment ON student.student_id = enrollment.student_id
JOIN sections ON sections.section_id = enrollment.section_id
JOIN term ON sections.term_id = term.term_id
JOIN courses On sections.course_id = courses.course_id
WHERE student.f_name = 'Bryce'
	AND student.l_name = 'Carlson'
    AND term.term = 'Winter'
ORDER BY courses.course_title;

-- question 7

SELECT 	term.term, term.year, COUNT(enrollment.student_id) AS Enrollment
FROM student
JOIN enrollment ON student.student_id = enrollment.student_id
JOIN sections ON sections.section_id = enrollment.section_id
JOIN term ON sections.term_id = term.term_id
WHERE term.term = 'Fall'
	AND term.year = 2019;
    
-- Question 8

SELECT college.college_name, count(course_id)
FROM college
JOIN department ON college.college_id = department.college_id
JOIN courses ON department.department_code = courses.department_code
GROUP BY college.college_name
ORDER BY college.college_name;

-- question 9
 
SELECT faculty.faculty_fname, faculty.faculty_lname, sum(sections.section_capacity) AS 'Teaching Capacity'
FROM sections
JOIN faculty On sections.faculty_id = faculty.faculty_id
JOIN term ON sections.term_id = term.term_id
WHERE term.year = 2018
AND term.term = 'Winter'
GROUP BY faculty.faculty_fname, faculty.faculty_lname
ORDER BY sum(sections.section_capacity);

-- Question 10

 SELECT  student.l_name, student.f_name, SUM(courses.course_credits)
FROM student
JOIN enrollment ON student.student_id = enrollment.student_id
JOIN sections ON sections.section_id = enrollment.section_id
JOIN term ON sections.term_id = term.term_id
JOIN courses On sections.course_id = courses.course_id
WHERE term.year = 2019
	AND term.term = 'Fall'
GROUP BY student.f_name, student.l_name
HAVING SUM(courses.course_credits) > 3 
ORDER BY SUM(courses.course_credits) DESC;

SHOW CREATE TABLE college;

SHOW INDEX FROM college;


 
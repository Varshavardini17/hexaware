CREATE DATABASE SISDB;
USE SISDB;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

CREATE TABLE teacher (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO students VALUES
(1, 'Amit', 'Sharma', '2000-05-10', 'amit@example.com', '9876543210'),
(2, 'Neha', 'Patel', '1999-08-21', 'neha@example.com', '9123456789'),
(3, 'Raj', 'Verma', '2001-01-15', 'raj@example.com', '9988776655'),
(4, 'Sneha', 'Joshi', '2002-04-25', 'sneha@example.com', '9011223344'),
(5, 'Karan', 'Singh', '2000-12-10', 'karan@example.com', '9871234567'),
(6, 'Meera', 'Iyer', '1998-11-19', 'meera@example.com', '9765432100'),
(7, 'Yash', 'Desai', '2001-09-01', 'yash@example.com', '9887766554'),
(8, 'Ritu', 'Nair', '2002-07-23', 'ritu@example.com', '9933445566'),
(9, 'Arjun', 'Kapoor', '1999-03-14', 'arjun@example.com', '9988771122'),
(10, 'Tanya', 'Bose', '2000-08-18', 'tanya@example.com', '9445566778');

INSERT INTO Teacher VALUES
(101, 'varsha', 'vardini', 'varsha@school.com'),
(102, 'Priya', 'Madhu', 'priyamadhu@school.com'),
(103, 'kalpana', 'vel', 'kalpanavel@school.com'),
(104, 'balaji', 'sakthivel', 'balajisak@school.com'),
(105, 'afsara', 'ashraf', 'afsara@school.com'),
(106, 'Divya', 'kadir', 'divya.kadir@school.com'),
(107, 'harini', 'baskar', 'harini@school.com'),
(108, 'sahi', 'krishna', 'sahikrishschool.com'),
(109, 'saro', 'Gupta', 'saro@school.com'),
(110, 'mani', 'bala', 'manibala@school.com');

INSERT INTO courses VALUES
(201, 'Mathematics', 4, 101),
(202, 'Physics', 3, 102),
(203, 'Computer Science', 4, 103),
(204, 'Biology', 3, 104),
(205, 'Chemistry', 4, 105),
(206, 'English', 2, 106),
(207, 'History', 3, 107),
(208, 'Economics', 3, 108),
(209, 'Environmental Science', 2, 109),
(210, 'Geography', 3, 110);

INSERT INTO enrollments VALUES
(301, 1, 201, '2024-06-01'),
(302, 2, 202, '2024-06-03'),
(303, 3, 203, '2024-06-05'),
(304, 4, 204, '2024-06-07'),
(305, 5, 205, '2024-06-09'),
(306, 6, 206, '2024-06-11'),
(307, 7, 207, '2024-06-13'),
(308, 8, 208, '2024-06-15'),
(309, 9, 209, '2024-06-17'),
(310, 10, 210, '2024-06-19');

INSERT INTO payments VALUES
(401, 1, 5000.00, '2024-06-10'),
(402, 2, 4500.00, '2024-06-12'),
(403, 3, 4800.00, '2024-06-14'),
(404, 4, 4700.00, '2024-06-16'),
(405, 5, 4900.00, '2024-06-18'),
(406, 6, 5100.00, '2024-06-20'),
(407, 7, 5300.00, '2024-06-22'),
(408, 8, 5200.00, '2024-06-24'),
(409, 9, 5500.00, '2024-06-26'),
(410, 10, 5600.00, '2024-06-28');


---------QUESTION 1 INSERT A NEW STUDENT-------------------------------

INSERT INTO students (student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES (11, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');


-----------QUESTION 2  INSERT A RECORD-------------------------------

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES (311, 11, 203, '2025-04-08');


------------QUESTION 3  UPDATE EMAIL------------------------------
UPDATE teacher
SET email = 'kalpana.new@school.com'
WHERE teacher_id = 103;


--------------QUESTION 4   DELETE SPECIFIC COLUMN----------------------------
DELETE FROM enrollments
WHERE student_id = 2 AND course_id = 202;


-------------------QUESTION 5    UPDATE THE COURSE----------------

UPDATE courses
SET teacher_id = 102
WHERE course_id = 204;

----------------------QUESTION 6   DELETE SPECIFIC TABLE--------------

DELETE FROM enrollments
WHERE student_id = 3;

DELETE FROM payments
WHERE student_id = 3;

DELETE FROM students
WHERE student_id = 3;

--------------------------QUESTION 7 UPDATE THE PAYMENT---------------

UPDATE payments
SET amount = 5500.00
WHERE payment_id = 401;







-------------------------TASK 3 TOTAL PAYMENT MADE BY STUDENT------------------------------
SELECT s.first_name, SUM(p.amount) AS total_payment
FROM students s
JOIN payments p ON s.student_id = p.student_id
WHERE s.student_id = 1
GROUP BY s.first_name;
-----------------------------Q2  RETRIVE LIST OF COURSES------------------------------------
SELECT  c.course_id,c.course_name, COUNT(e.enrollment_id) AS total_enrolled
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name,c.course_id;
------------------------------Q3 STUDENTS WHO HAVE NOT ENROLLED-------------------------------------------
SELECT s.first_name, s.last_name,e.enrollment_id
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id;
------------------------------Q4 RETRIEVE STUDENTS WHO ENROLLED----------------------------------------------
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;
-------------------------------Q5   NAME OF TEACHRS COURSES ASSIGNED--------------------------------------------
SELECT t.first_name , t.last_name , c.course_name
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id;
-------------------------------Q6   RETIEVE STUDENT AND ENROLLMENT FOE SPECIFIC COURSE--------------------------------------------
SELECT s.first_name, c.course_name, e.enrollment_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_id = 203;
--------------------------------Q7 STUDENT WITH NO PAYMENT---------------------------------------------------------
SELECT s.first_name, s.last_name,p.payment_id
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id;
---------------------------------Q8 COURSES WITH NO ENROLLMENTS------------------------------------------------------
SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;
---------------------------------Q9 STUDENTS WITH MORE THEN ONE COURSE------------------------------------------------------
SELECT DISTINCT st.student_id, st.first_name, st.last_name
FROM Enrollments s1
JOIN Enrollments s2 ON s1.student_id = s2.student_id AND s1.course_id <> s2.course_id
JOIN Students st ON s1.student_id = st.student_id;
----------------------------------Q10  TEACHERS NOT ASSINGNED COURSE-----------------------------------------------------
SELECT t.teacher_id
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
WHERE c.course_id IS NULL;
--------------------------------------------------------------------------------------





--------------------------TASK 4 AVERAGE NUMBER OF STUDENTS ENROLLED--------------------------------------------------
SELECT AVG(StudentCount) AS AverageEnrollmentsPerCourse
FROM (
    SELECT COUNT(*) AS StudentCount
    FROM Enrollments
    GROUP BY course_id
)AS CourseCount;
---------------------------------Q2  STUDENT WITH HIGHEST PAYMENT-----------------------------------------------------
SELECT s.student_id, s.first_name, s.last_name, p.amount
FROM Payments p
JOIN Students s ON p.student_id = s.student_id
WHERE p.amount = (
    SELECT MAX(amount) FROM Payments
);
----------------------------------Q3  HIGHEST NO OF ENROLLMENT--------------------------------------------------------
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS enroll_count
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) = (
    SELECT MAX(enroll_total) FROM (
        SELECT COUNT(student_id) AS enroll_total
        FROM Enrollments
        GROUP BY course_id
    ) AS sub
);
----------------------------------Q4  TOTAL PAYMENT FOR A COURSE BY TEACHER-----------------------------------------------------
SELECT t.teacher_id, t.first_name, t.last_name, SUM(p.amount) AS total_payment
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Payments p ON e.student_id = p.student_id
GROUP BY t.teacher_id, t.first_name, t.last_name;
------------------------------------Q5 STUDENTS ENROLLED IN AVAILABLE COURSE---------------------------------------------------
SELECT student_id
FROM Enrollments
GROUP BY student_id
HAVING COUNT(DISTINCT course_id) = (
    SELECT COUNT(*) FROM Courses
);
-------------------------------------Q6  TEACHERS WHO HAVE NOT ASSIGNED ANY COURSE-------------------------------------------------
SELECT first_name, last_name
FROM teacher
WHERE teacher_id NOT IN (
    SELECT DISTINCT teacher_id FROM Courses
);
--------------------------------------Q7  AVERAGE AGE OF STUDENTS-------------------------------------------------
SELECT AVG(age) AS average_age
FROM (
    SELECT DATEDIFF(YEAR, date_of_birth, GETDATE()) AS age
    FROM Students
) AS student_ages;
--------------------------------------Q8  COURSE WITH NO ENROLLMENT----------------------------------------------
SELECT course_id, course_name
FROM Courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM Enrollments
);
--------------------------------------O9 TOTAL PAYMENT MADE BY EACH STUDENT FOR EACH COURSE ENROLLED-----------------------------------------------
SELECT 
    s.student_id,
    c.course_name,
    p.amount
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN payments p ON s.student_id = p.student_id;

---------------------------------------Q10 STUDENT WITH MORE THAN ONE PAYMENT-------------------------------------------------
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(p.payment_id)as payment_count
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(p.payment_id)> 1;

-----------------------------------------Q11 TOTAL PAYMENT MADE BY EACH STUDENT-----------------------------------------------
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_payments
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;
---------------------------------------------Q12RETRIEVE LIST OF STUDENTS ALONG WITH COUNT OF STUDENTS  -------------------------------------------------
SELECT 
    c.course_name,
    COUNT(e.student_id) AS total_enrolled
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
-----------------------------------------------Q13 AVERAGE PAYMENT AMOUNT BY STUDENT--------------------------------------------------
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    AVG(p.amount) AS average_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;
-----------------------------------------------------------------------------------------------





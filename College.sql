-- College Management System SQL Script
-- Normalized Design with Constraints

-- Drop existing database if exists
DROP DATABASE IF EXISTS CollegeDB;
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- =========================
-- TABLES
-- =========================

CREATE TABLE Department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Student
CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    dob DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- 3. Faculty
CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- 4. Course
CREATE TABLE Course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- 5. Enrollment
CREATE TABLE Enrollment (
    enroll_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- INSERTING DATA NOW
 
-- Departments
INSERT INTO Department (dept_name) VALUES
('Computer Science'),
('Electronics'),
('Mechanical'),
('Civil'),
('Management');

-- Students
INSERT INTO Student (name, email, dob, dept_id) VALUES
('Amit Kumar', 'amit@gmail.com', '2002-01-15', 1),
('Dawood Ibhraham', 'riya@gmail.com', '2001-11-20', 2),
('John Doe', 'john@gmail.com', '2002-05-10', 3),
('Priyanka Chopra', 'priya@gmail.com', '2003-07-08', 1),
('David', 'arjun@gmail.com', '2001-09-25', 4);

-- Faculty
INSERT INTO Faculty (name, email, dept_id) VALUES
('Dr. Verma', 'verma@clg.com', 1),
('Dr. Iyer', 'iyer@clg.com', 2),
('Dr. Khan', 'khan@clg.com', 3),
('Dr. Patel', 'patel@clg.com', 4),
('Dr. Roy', 'roy@clg.com', 5);

-- Courses
INSERT INTO Course (course_name, credits, dept_id) VALUES
('DBMS', 4, 1),
('Digital Circuits', 3, 2),
('Thermodynamics', 3, 3),
('Structural Engg', 4, 4),
('Business Mgmt', 3, 5);

-- Enrollments
INSERT INTO Enrollment (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(2, 2, 'B'),
(3, 3, 'A'),
(4, 1, 'C'),
(5, 4, 'B');

-- QUERIES

-- 1. JOIN: List students with their department and course
SELECT s.name AS Student, d.dept_name AS Department, c.course_name AS Course
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Course c ON e.course_id = c.course_id;

-- 2. SUBQUERY: Find students enrolled in 'DBMS'
SELECT name FROM Student
WHERE student_id IN (
    SELECT student_id FROM Enrollment e
    JOIN Course c ON e.course_id = c.course_id
    WHERE c.course_name = 'DBMS'
);

-- 3. AGGREGATE: Count students per department
SELECT d.dept_name, COUNT(s.student_id) AS StudentCount
FROM Department d
LEFT JOIN Student s ON d.dept_id = s.dept_id
GROUP BY d.dept_name;

-- 4. UPDATE (DML): Update a student’s email
UPDATE Student SET email = 'amit_updated@gmail.com' WHERE student_id = 1;

-- 5. DELETE (DML): Delete an enrollment record
DELETE FROM Enrollment WHERE enroll_id = 5;

-- 6. INSERT (DML): Add a new student
INSERT INTO Student (name, email, dob, dept_id)
VALUES ('Neha Gupta', 'neha@gmail.com', '2003-12-12', 5);


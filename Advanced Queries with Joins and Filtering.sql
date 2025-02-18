CREATE DATABASE TASK2;
USE TASK2;

-- CREATING REQUIRED TABLES ----

-- Creating Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Creating Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_description TEXT
);

-- Creating Enrolments table
CREATE TABLE Enrolments (
    enrolment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrolment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
-- Explainations----
-- Created three tables with appropriate fields and data types.
-- Used PRIMARY KEY for unique identification.
-- FOREIGN KEY ensures relational integrity between Students and Enrolments, and Courses and Enrolments.


-- INSERTING SAMPLE DATA IN ABOVE THREE TABLES----

-- Insert data into Students table
INSERT INTO Students (student_id, name, email) VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Charlie Davis', 'charlie@example.com');

-- Insert data into Courses table
INSERT INTO Courses (course_id, course_name, course_description) VALUES
(101, 'SQL Basics', 'Introduction to SQL queries and database concepts'),
(102, 'Advanced SQL', 'Complex SQL queries, joins, and subqueries'),
(103, 'Database Design', 'Designing efficient database schemas');

-- Insert data into Enrolments table
INSERT INTO Enrolments (enrolment_id, student_id, course_id, enrolment_date) VALUES
(1, 1, 101, '2025-02-01'),
(2, 1, 102, '2025-02-05'),
(3, 2, 101, '2025-02-03');
-- Explainations----
-- Inserted sample data for testing queries.
-- Ensured students are enrolled in multiple courses for task validation.
-- Included a course with no enrolments for edge case testing.


-- NOW TASKS TO PERFORM----

-- Task 1 - List All Students and the Courses They Are Enrolled In----
SELECT s.name AS student_name, c.course_name
FROM Students s
INNER JOIN Enrolments e ON s.student_id = e.student_id
INNER JOIN Courses c ON e.course_id = c.course_id;
-- Explanation:
-- INNER JOIN connects Students, Enrolments, and Courses.
-- Displays student names and corresponding course names.
-- Uses table aliases (s, e, c) for readability.

-- Task 2 - Find the Number of Students Enrolled in Each Course----
SELECT c.course_name, COUNT(e.student_id) AS enrolled_students
FROM Courses c
LEFT JOIN Enrolments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;
-- Explanations:
-- LEFT JOIN ensures all courses are included, even if no enrolments exist.
-- COUNT(e.student_id) counts enrolled students.
-- GROUP BY groups the results by course.

-- Task 3 - List Students Who Have Enrolled in More Than One Course----
SELECT s.name, COUNT(e.course_id) AS course_count
FROM Enrolments e
JOIN Students s ON e.student_id = s.student_id
GROUP BY e.student_id, s.name
HAVING COUNT(e.course_id) > 1;
-- Explanation:
-- Counts the number of courses each student is enrolled in.
-- HAVING COUNT(e.course_id) > 1 filters only those students enrolled in more than one course.

-- Task 4 - Find Courses with No Enrolled Students----
SELECT c.course_name
FROM Courses c
LEFT JOIN Enrolments e ON c.course_id = e.course_id
WHERE e.enrolment_id IS NULL;
-- Explanation:
-- LEFT JOIN ensures all courses are included.
-- WHERE e.enrolment_id IS NULL filters only courses with no enrolments.






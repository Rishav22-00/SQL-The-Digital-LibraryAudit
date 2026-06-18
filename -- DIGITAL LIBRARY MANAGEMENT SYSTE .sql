-- DIGITAL LIBRARY MANAGEMENT SYSTEM



-- Create Database
CREATE DATABASE DigitalLibrary;

-- Use Database
USE DigitalLibrary;



-- TABLE CREATION



-- Books Table

CREATE TABLE Books (
     BookID INT PRIMARY KEY AUTO_INCREMENT,
     Title VARCHAR(100) NOT NULL,
     Author VARCHAR(100),
     Category VARCHAR(50)
     );


-- Students Table

CREATE TABLE Students (
     StudentID INT PRIMARY KEY AUTO_INCREMENT,
     StudentName VARCHAR(100) NOT NULL,
     Email VARCHAR(100)
     );


-- IssuedBooks Table


CREATE TABLE IssuedBooks (
     IssueID INT PRIMARY KEY AUTO_INCREMENT,
     StudentID INT,
     BookID INT,
     IssueDate DATE,
     ReturnDate DATE,
     FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
     FOREIGN KEY (BookID) REFERENCES Books(BookID)
     );

-- INSERT SAMPLE DATA


-- Books Data

 INSERT INTO Books (Title, Author, Category)
    VALUES
     ('The Alchemist', 'Paulo Coelho', 'Fiction'),
     ('Physics Fundamentals', 'H.C. Verma', 'Science'),
     ('Ancient India', 'R.S. Sharma', 'History'),
     ('Java Programming', 'Herbert Schildt', 'Science');


-- Students Data

 INSERT INTO Students (StudentName, Email)
     VALUES
     ('Ayush Sinha', 'ayush@gmail.com'),
     ('Rahul Kumar', 'rahul@gmail.com'),
     ('Priya Singh', 'priya@gmail.com'),
     ('Neha Sharma', 'neha@gmail.com');



-- Issued Books Data

INSERT INTO IssuedBooks (StudentID, BookID, IssueDate, ReturnDate)
     VALUES
     (1, 1, '2026-05-01', NULL),
     (2, 2, '2026-05-25', NULL),
     (3, 3, '2022-04-10', '2022-04-20'),
     (4, 4, '2021-03-15', '2021-03-25');


-- ANALYTICAL QUERIES


-- 1. PENALTY REPORT (OVERDUE BOOKS > 14 DAYS)

SELECT
     S.StudentID,
     S.StudentName,
     B.Title,
     I.IssueDate
     FROM Students S
     INNER JOIN IssuedBooks I
     ON S.StudentID = I.StudentID
     INNER JOIN Books B
     ON I.BookID = B.BookID
     WHERE I.ReturnDate IS NULL
     AND DATEDIFF(CURDATE(), I.IssueDate) > 14;


+-----------+-------------+---------------+------------+
| StudentID | StudentName | Title         | IssueDate  |
+-----------+-------------+---------------+------------+
|         1 | Ayush Sinha | The Alchemist | 2026-05-01 |
+-----------+-------------+---------------+------------+




-- 2. POPULARITY INDEX
-- MOST BORROWED BOOK CATEGORIES


 SELECT
     B.Category,
     COUNT(*) AS TimesBorrowed
     FROM Books B
     INNER JOIN IssuedBooks I
     ON B.BookID = I.BookID
     GROUP BY B.Category
     ORDER BY TimesBorrowed DESC;


+----------+---------------+
| Category | TimesBorrowed |
+----------+---------------+
| Science  |             2 |
| Fiction  |             1 |
| History  |             1 |
+----------+---------------+




-- QUERY 3 : DATA CLEANUP
-- Mark students inactive if they have
-- not borrowed any book in last 3 years


 ALTER TABLE Students
    -> ADD Status VARCHAR(20) DEFAULT 'Active';


 UPDATE Students
     SET Status = 'Inactive'
     WHERE StudentID NOT IN
     (
     SELECT DISTINCT StudentID
     FROM IssuedBooks
     WHERE IssueDate >= CURDATE() - INTERVAL 3 YEAR
     );

Rows matched: 2  Changed: 2  Warnings: 0

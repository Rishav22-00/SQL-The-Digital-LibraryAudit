#  Digital Library Management System

Digital Library Management System is a SQL-based database project developed for a community college library to manage books, students, and borrowing records.

The system helps librarians track issued books, identify overdue returns, analyze borrowing trends, and manage inactive student accounts.

This project demonstrates the use of relational database design, SQL queries, joins, aggregate functions, date operations, and data maintenance techniques.

---

## Problem Statement

A local community college maintains records of books and student borrowings.

The library faces challenges in:

* Tracking overdue books
* Generating penalty reports
* Identifying the most popular book categories
* Managing inactive student accounts

The goal is to build a relational database system capable of generating useful analytical reports.

---

## Features

* Book inventory management
* Student record management
* Book issue and return tracking
* Overdue book detection
* Popularity analysis of book categories
* Inactive account identification
* Data cleanup operations

---

## Technologies Used

* MySQL
* SQL DDL Commands
* SQL DML Commands
* Joins
* Aggregate Functions
* Date Functions
* Subqueries

---

## Project Structure

DigitalLibrary/

├── DigitalLibrary.sql

└── README.md

---

## Database Schema

### Books Table

Stores information about available books.

| Column   | Data Type    |
| -------- | ------------ |
| BookID   | INT (PK)     |
| Title    | VARCHAR(100) |
| Author   | VARCHAR(100) |
| Category | VARCHAR(50)  |

---

### Students Table

Stores student information.

| Column      | Data Type    |
| ----------- | ------------ |
| StudentID   | INT (PK)     |
| StudentName | VARCHAR(100) |
| Email       | VARCHAR(100) |
| Status      | VARCHAR(20)  |

---

### IssuedBooks Table

Stores book borrowing transactions.

| Column     | Data Type |
| ---------- | --------- |
| IssueID    | INT (PK)  |
| StudentID  | INT (FK)  |
| BookID     | INT (FK)  |
| IssueDate  | DATE      |
| ReturnDate | DATE      |

---

## Sample Data

### Books

| BookID | Title                | Category |
| ------ | -------------------- | -------- |
| 1      | The Alchemist        | Fiction  |
| 2      | Physics Fundamentals | Science  |
| 3      | Ancient India        | History  |
| 4      | Java Programming     | Science  |

---

### Students

| StudentID | Student Name |
| --------- | ------------ |
| 1         | Ayush Sinha  |
| 2         | Rahul Kumar  |
| 3         | Priya Singh  |
| 4         | Neha Sharma  |

---

## Analytical Queries

### Query 1: Penalty Report

Identify students who have not returned books within 14 days.

#### SQL Logic

```sql
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
```

#### Output

```text
+-----------+-------------+---------------+------------+
| StudentID | StudentName | Title         | IssueDate  |
+-----------+-------------+---------------+------------+
| 1         | Ayush Sinha | The Alchemist | 2026-05-01 |
+-----------+-------------+---------------+------------+
```

---

### Query 2: Popularity Index

Find the most borrowed book categories.

#### SQL Logic

```sql
SELECT
B.Category,
COUNT(*) AS TimesBorrowed
FROM Books B
INNER JOIN IssuedBooks I
ON B.BookID = I.BookID
GROUP BY B.Category
ORDER BY TimesBorrowed DESC;
```

#### Output

```text
+----------+---------------+
| Category | TimesBorrowed |
+----------+---------------+
| Science  | 2             |
| Fiction  | 1             |
| History  | 1             |
+----------+---------------+
```

---

### Query 3: Data Cleanup

Mark students inactive if they have not borrowed a book in the last 3 years.

#### Add Status Column

```sql
ALTER TABLE Students
ADD Status VARCHAR(20) DEFAULT 'Active';
```

#### Update Inactive Accounts

```sql
UPDATE Students
SET Status = 'Inactive'
WHERE StudentID NOT IN
(
SELECT DISTINCT StudentID
FROM IssuedBooks
WHERE IssueDate >= CURDATE() - INTERVAL 3 YEAR
);
```

#### Result

```text
Rows matched: 2
Changed: 2
Warnings: 0
```

---

## How To Run

### Step 1: Open MySQL

```sql
mysql -u root -p
```

### Step 2: Execute SQL File

```sql
SOURCE DigitalLibrary.sql;
```

### Step 3: Run Analytical Queries

Execute the provided SQL queries to generate reports and insights.

---

## Concepts Covered

* Database Design
* Primary Keys
* Foreign Keys
* Table Relationships
* SQL Joins
* Aggregate Functions
* GROUP BY
* ORDER BY
* Date Functions
* Subqueries
* Data Maintenance Operations

---

## Learning Outcomes

Through this project, students learn:

* Relational database modeling
* Creating normalized tables
* Managing relationships using foreign keys
* Writing analytical SQL queries
* Using aggregate and date functions
* Implementing real-world reporting systems

---

## Future Improvements

* Library Staff Management
* Fine/Penalty Calculation Module
* Book Reservation System
* Search and Filter Functionality
* Stored Procedures and Triggers
* Web-Based Library Dashboard
* Role-Based User Authentication
B.Tech Computer Science Engineering
KIIT University

/* JOINS
---> Joins are used to combine two or more tables to get specific data/information
-- Join is mainly of 6 types:
--1. Inner Join
--2. Left Outer Join
--3. Right Outer Join
--4. Full Outer Join
--5. Self Join
--6. Cross Join
*/
-- Creating database
CREATE DATABASE Rapido;

-- Using database
USE Rapido;

-- Create the Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    DeptID INT,
    ManagerID INT
);

-- Create the Departments table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100)
);

-- Create the Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    EmpID INT
);

-- Insert data into Employees
INSERT INTO Employees (EmpID, EmpName, DeptID, ManagerID) VALUES
(1, 'Alice', 1, NULL),
(2, 'Bob', 2, 1),
(3, 'Charlie', 1, 1),
(4, 'David', NULL, 2);

-- Insert data into Departments
INSERT INTO Departments (DeptID, DeptName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Marketing');

-- Insert data into Projects
INSERT INTO Projects (ProjectID, ProjectName, EmpID) VALUES
(101, 'Project A', 1),
(102, 'Project B', 2),
(103, 'Project C', 3);

/*Retrieve the names of employees and their respective department names*/

SELECT Employees.EmpName, Departments.DeptName
FROM Employees
INNER JOIN Departments ON Employees.DeptID = Departments.DeptID;

 /*Retrieve all employees along with their department names. Include employees who do not belong to any department.*/

SELECT Employees.EmpName, Departments.DeptName
FROM Employees
LEFT OUTER JOIN Departments ON Employees.DeptID = Departments.DeptID;

/*Retrieve all departments along with the names of their employees. Include departments that do not have any employees.*/

SELECT Employees.EmpName, Departments.DeptName
FROM Employees
RIGHT OUTER JOIN Departments ON Employees.DeptID = Departments.DeptID;

/*Generate a report showing every combination of employee and project.*/

SELECT Employees.EmpName, Projects.ProjectName
FROM Employees
CROSS JOIN Projects;

/* 1. Inner Join
Definition: An inner join returns records that have matching values in both tables. It only includes rows where there is a match between the columns being joined.

SELECT columns
FROM table1
INNER JOIN table2
ON table1.column = table2.column;

2.Left (Outer) Join
Definition: A left outer join returns all records from the left table and the matched records from the right table. If there is no match, the result is NULL on the side of the right table.

SELECT columns
FROM table1
LEFT OUTER JOIN table2
ON table1.column = table2.column;

3.Right (Outer) Join
Definition: A right outer join returns all records from the right table and the matched records from the left table. If there is no match, the result is NULL on the side of the left table.

SELECT columns
FROM table1
RIGHT OUTER JOIN table2
ON table1.column = table2.column;

5. Cross Join
Definition: A cross join returns the Cartesian product of the two tables, i.e., it returns all possible combinations of rows from the tables.

SELECT columns
FROM table1
CROSS JOIN table2;

6. Self Join
Definition: A self join is a regular join, but the table is joined with itself. It is used to combine and compare rows within the same table.

SELECT a.columns, b.columns
FROM table1 a, table1 b
WHERE a.common_column = b.common_column;

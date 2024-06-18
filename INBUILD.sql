/* DQL Commands
GROUP BY, ORDER BY, HAVING BY */

/* In SQL, built-in functions are predefined functions provided by the SQL language to perform various operations on data. 
These functions can be used in SELECT statements, WHERE clauses, GROUP BY  */

/* SELECT 
The SELECT statement is used to query the database and retrieve data. The basic syntax is: */

/* SELECT column1, column2, ...
FROM table_name; */

-- SELECT CAUSES AND OPTIONS

/*GROUP BY
 The GROUP BY clause is used in SQL to group rows that have the same values in specified columns into aggregated data.
 It is often used in conjunction with aggregate functions like COUNT, SUM, AVG, MAX, and MIN
 
 SELECT column1, column2, AGGREGATE_FUNCTION(column3)
FROM table_name
GROUP BY column1, column2;*/


-- HAVING BY
/* The HAVING clause is used to filter groups of rows created by the GROUP BY clause. 
It is similar to the WHERE clause, but HAVING is used for groups whereas WHERE is used for individual rows.
 
 
 SELECT column1, AGGREGATE_FUNCTION(column2)
FROM table_name
GROUP BY column1
HAVING AGGREGATE_FUNCTION(column2) condition;
*/


-- ORDER BY
 /* The ORDER BY clause is used to sort the result set of a query by one or more columns. 
 By default, it sorts in ascending order, but you can specify descending order with DESC.

SELECT column1, column2
FROM table_name
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC];

*/

-- --------------------------------------------------QUESTIONS----------------------------------------------------------------------------
/*
GROUP BY:
1. Write a SQL query to count the number of employees in each department from the employees table.
2. Write a SQL query to find the total salary for each department from the employees table.
3. Write a SQL query to find the average salary in each department from the employees table.
4. Write a SQL query to find the highest salary in each department from the employees table.

ORDER BY:
1. Write a SQL query to count the number of employees in each department and order the result by the number of employees in descending order.
2. Write a SQL query to find the total salary for each department and order the result by the total salary in descending order.
3. Write a SQL query to find the average salary in each department and order the result by the average salary in ascending order.

HAVING BY:
1. Write a SQL query to find departments that have more than 3 employees from the employees table.
2. Write a SQL query to find departments with total salaries exceeding 200,000.
3. Write a SQL query to find departments with an average salary less than 60,000.
/*

/*--------------------------------------------------------------ANSWERS------------------------------------------------------------------------*/
/* GROUP BY: */

SELECT department, COUNT(employee_id) AS num_employees
FROM employees
GROUP BY department;

SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;

SELECT department, MAX(salary) AS highest_salary
FROM employees
GROUP BY department;


/* ORDER BY */

SELECT department, COUNT(employee_id) AS num_employees
FROM employees
GROUP BY department
HAVING COUNT(employee_id) > 3;


SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 200000;


SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) < 60000;




/* HAVING BY */

SELECT department, COUNT(employee_id) AS num_employees
FROM employees
GROUP BY department
HAVING COUNT(employee_id) > 3;

SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 200000;

SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) < 60000;








/* DQL Commands
GROUP BY, ORDER BY, HAVING BY */

/* Data Query Language (DQL) commands in SQL are primarily used to retrieve data from a database. 
The primary and most commonly used DQL command is the SELECT statement. */

/* SELECT 
The SELECT statement is used to query the database and retrieve data. The basic syntax is: */

/* SELECT column1, column2, ...
FROM table_name; */

-- SELECT CAUSES AND OPTIONS

/*GROUP BY
 Used to group rows that have the same values in specified columns.

 SELECT column1, COUNT(column2)
FROM table_name
GROUP BY column1; */

-- HAVING BY
/* The HAVING clause in SQL is used in conjunction with the GROUP BY clause to filter groups
   based on a specified condition. It is applied to the summarized or aggregated rows after the 
   grouping has been done. The HAVING clause works similarly to the WHERE clause, but it operates
   on groups instead of individual rows. 
   
   SELECT column1, COUNT(column2)
FROM table_name
GROUP BY column1
HAVING COUNT(column2) > value;
*/

-- ORDER BY
 /* Used to sort the result set.
 
 SELECT column1, column2
FROM table_name
ORDER BY column1 [ASC|DESC];

*/

-- --------------------------------------------------QUESTIONS----------------------------------------------------------------------------
/*
GROUP BY:
1. Write a SQL query to count the number of employees in each department from the employees table.
2. Write a SQL query to find the total salary for each department from the employees table.
3. Write a SQL query to count the number of employees in each department and job title from the employees table.
4. Write a SQL query to find the average salary for each department from the employees table, but only include departments with more than 3 employees.

ORDER BY:
1. Write a SQL query to select the name and salary of all employees from the employees table.
2.Write a SQL query to select the name and salary of all employees, ordered by salary in ascending order.
3. Write a SQL query to select the name and salary of all employees, ordered by salary in descending order.


HAVING BY:
1.Write a SQL query to find departments that have more than 3 employees from the employees table.
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

SELECT department, job_title, COUNT(employee_id) AS num_employees
FROM employees
GROUP BY department, job_title;

SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING COUNT(employee_id) > 3;


/* ORDER BY */

SELECT name, salary
FROM employees;


SELECT name, salary
FROM employees
ORDER BY salary ASC;


SELECT name, salary
FROM employees
ORDER BY salary DESC;


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




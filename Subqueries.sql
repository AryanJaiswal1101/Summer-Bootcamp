/* A subquery, also known as an inner query or nested query, is a query embedded within another SQL query. The subquery can be placed in various parts of an SQL statement, including the SELECT, FROM, WHERE, and HAVING clauses. Subqueries are used to perform operations that need to be executed before the outer query, or to provide values for the outer query to use.

Types of Subqueries
1. Single-row Subquery: Returns a single row of results.
2. Multi-row Subquery: Returns multiple rows of results.
3. Single-column Subquery: Returns a single column of results.
4. Multi-column Subquery: Returns multiple columns of results.
5. Correlated Subquery: A subquery that references columns from the outer query, meaning it depends on the outer query for its values.*/

/* Example 1: Subquery in the WHERE Clause
Find all users who have asked a question.*/

SELECT username
FROM Users
WHERE user_id IN (SELECT DISTINCT user_id FROM Questions);

/*Example 2: Subquery in the SELECT Clause
Retrieve the total number of answers for each question.*/

SELECT q.question_id, q.title,
       (SELECT COUNT(*) FROM Answers a WHERE a.question_id = q.question_id) AS answer_count
FROM Questions q;

/*Example 3: Correlated Subquery
Retrieve questions and the number of answers posted by the same user who asked the question.*/

SELECT q.question_id, q.title,
       (SELECT COUNT(*) FROM Answers a WHERE a.question_id = q.question_id AND a.user_id = q.user_id) AS user_answer_count
FROM Questions q;

/*1. Retrieve all questions with the number of answers*/

SELECT q.question_id, q.title, q.body, q.created_at, COUNT(a.answer_id) AS answer_count
FROM Questions q
LEFT JOIN Answers a ON q.question_id = a.question_id
GROUP BY q.question_id;

 /*Retrieve questions and their most recent answer*/
 
 SELECT q.question_id, q.title, q.body, q.created_at,
       (SELECT a.body 
        FROM Answers a 
        WHERE a.question_id = q.question_id 
        ORDER BY a.created_at DESC 
        LIMIT 1) AS recent_answer
FROM Questions q;

/*Retrieve users who have posted more than one question*/
SELECT u.user_id, u.username, u.email, COUNT(q.question_id) AS question_count
FROM Users u
JOIN Questions q ON u.user_id = q.user_id
GROUP BY u.user_id
HAVING COUNT(q.question_id) > 1;

/* 1. Subquery in the WHERE Clause:

The subquery (SELECT DISTINCT user_id FROM Questions) retrieves the unique user IDs of users who have asked questions.
The outer query then selects usernames from the Users table where the user ID matches any of those in the subquery result.

2. Subquery in the SELECT Clause:

The subquery (SELECT COUNT(*) FROM Answers a WHERE a.question_id = q.question_id) counts the number of answers for each question.
The outer query selects question details and includes the count of answers in the result.

3. Correlate Subquery:

The subquery (SELECT COUNT(*) FROM Answers a WHERE a.question_id = q.question_id AND a.user_id = q.user_id) counts the number of answers for a question that are posted by the same user who asked the question.
The subquery is correlated because it references the question_id and user_id from the outer query, meaning it depends on the outer query's values.



/*Normalization is a systematic approach of decomposing tables to eliminate data redundancy and ensure data integrity. The primary goal is to organize the data efficiently by breaking down larger tables into smaller, related tables. Here are the types of normalization with a focus on the first normal form (1NF):

Un-normalized Table
Before normalization, a table might have redundancy and anomalies. Here is an example of an un-normalized table:

Un-normalized Table:

OrderID	CustomerID 	CustomerName	Products	Quantities
1	101	Alice	TV, Fridge	1, 1
2	102	Bob	Washing Machine, Oven	1, 2
3	103	Charlie	TV, Oven	2, 1
1. First Normal Form (1NF)
To satisfy the first normal form:

Each table cell should contain a single value.
Each record needs to be unique.
Repeating groups should be eliminated.

1NF Table:

OrderID	CustomerID	CustomerName	Product	Quantity
1	101	Alice	TV	1
1	101	Alice	Fridge	1
2	102	Bob	Washing Machine	1
2	102	Bob	Oven	2
3	103	Charlie	TV	2
3	103	Charlie	Oven	1

2. Second Normal Form (2NF)

To achieve the second normal form:

The table must be in 1NF.
All non-key attributes should be fully functionally dependent on the primary key.
Original 1NF Table:

OrderID	CustomerID	CustomerName	Product	Quantity
1	101	Alice	TV	1
1	101	Alice	Fridge	1
2	102	Bob	Washing Machine	1
2	102	Bob	Oven	2
3	103	Charlie	TV	2
3	103	Charlie	Oven	1
Decomposed into 2NF:

Customers Table:

CustomerID	CustomerName
101	Alice
102	Bob
103	Charlie
Orders Table:

OrderID	CustomerID
1	101
2	102
3	103
OrderDetails Table:

OrderID	Product	Quantity
1	TV	1
1	Fridge	1
2	Washing Machine	1
2	Oven	2
3	TV	2
3	Oven	1

3. Third Normal Form (3NF)

To achieve the third normal form:

The table must be in 2NF.
All the attributes should be functionally dependent only on the primary key.
Original 2NF Tables:
Customers Table:

CustomerID	CustomerName
101	Alice
102	Bob
103	Charlie
Orders Table:

OrderID	CustomerID
1	101
2	102
3	103
OrderDetails Table:

OrderID	Product	Quantity
1	TV	1
1	Fridge	1
2	Washing Machine	1
2	Oven	2
3	TV	2
3	Oven	1
No further decomposition needed if there are no transitive dependencies.


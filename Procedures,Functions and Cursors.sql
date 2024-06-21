use rapido;
/* 1. Functions

Purpose
Functions are used to perform calculations or operations and return a single value. They can be used in SQL statements wherever expressions are allowed.

Usage
Functions are useful for encapsulating reusable logic, performing complex calculations, and maintaining data consistency.

Syntax

CREATE FUNCTION function_name (parameter_list)
RETURNS return_data_type
AS
BEGIN
    -- function body
    RETURN return_value;
END;

Example

CREATE FUNCTION get_discount(price DECIMAL, discount_rate DECIMAL)
RETURNS DECIMAL
AS
BEGIN
    RETURN price * discount_rate / 100;
END;

2. Procedures

Purpose
Procedures (or Stored Procedures) are used to perform actions on the database, such as modifying data or handling transactions. They can execute a series of SQL statements and logic.

Usage
Procedures are useful for performing repetitive tasks, complex business logic, and improving performance by reducing network traffic.

Syntax

CREATE PROCEDURE procedure_name (parameter_list)
AS
BEGIN
    -- procedure body
    -- SQL statements
END;

Example

CREATE PROCEDURE update_employee_salary(employee_id INT, new_salary DECIMAL)
AS
BEGIN
    UPDATE employees
    SET salary = new_salary
    WHERE id = employee_id;
END;

3. Cursors

Purpose:
Cursors in SQL are used to fetch rows from a result set one at a time. They are useful when you need to process each row individually rather than as a set.

Usage:

To perform row-by-row processing.
When set-based operations are not possible or practical.
To work with complex business logic that involves multiple steps per row.

Syntax:
DECLARE cursor_name CURSOR FOR
SELECT_statement;

OPEN cursor_name;

FETCH NEXT FROM cursor_name INTO variable_list;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Logic to process each row
    FETCH NEXT FROM cursor_name INTO variable_list;
END;

CLOSE cursor_name;
DEALLOCATE cursor_name;

Example DECLARE EmployeeCursor CURSOR FOR
SELECT EmployeeId, FirstName, LastName FROM Employees;

OPEN EmployeeCursor;

DECLARE @EmployeeId INT;
DECLARE @FirstName VARCHAR(50);
DECLARE @LastName VARCHAR(50);

FETCH NEXT FROM EmployeeCursor INTO @EmployeeId, @FirstName, @LastName;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Employee: ' + @FirstName + ' ' + @LastName;
    FETCH NEXT FROM EmployeeCursor INTO @EmployeeId, @FirstName, @LastName;
END;

CLOSE EmployeeCursor;
DEALLOCATE EmployeeCursor;

Summary
Functions are used for reusable logic that returns a single value and can be used in SQL statements.
Procedures encapsulate complex business logic and perform batch operations.
Cursors allow row-by-row processing of result sets when set-based operations are not feasible.
Understanding and using these components effectively can help in optimizing database operations and managing complex logic in a structured manner.

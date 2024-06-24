-- Creating the database
CREATE DATABASE rapido;

-- Using the database
USE rapido;

-- Creating the Drivers table
CREATE TABLE drivers (
    did INT PRIMARY KEY,
    dname VARCHAR(50) NOT NULL,
    age INT,
    phone_no BIGINT NOT NULL
);

-- Creating the Customers table
CREATE TABLE customers (
    cid INT PRIMARY KEY,
    cname VARCHAR(50) NOT NULL,
    age INT,
    addr VARCHAR(100)
);

-- Creating the Rides table
CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    cid INT,
    did INT,
    fare INT NOT NULL,
    FOREIGN KEY (cid) REFERENCES customers(cid),
    FOREIGN KEY (did) REFERENCES drivers(did)
);

-- Creating the Payment table
CREATE TABLE payment (
    pay_id INT PRIMARY KEY,
    ride_id INT,
    amount INT NOT NULL,
    mode VARCHAR(30) CHECK (mode IN ('upi', 'credit', 'debit')),
    status VARCHAR(30),
    FOREIGN KEY (ride_id) REFERENCES rides(ride_id)
);

-- Creating the Employee table
CREATE TABLE employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(50) NOT NULL,
    phone_no BIGINT NOT NULL,
    department VARCHAR(50) NOT NULL,
    manager_id INT
);

-- Inserting values into Drivers table
INSERT INTO drivers VALUES (1, 'Amit', 30, 9876543210);
INSERT INTO drivers VALUES (2, 'Arpita', 25, 8765432109);
INSERT INTO drivers VALUES (3, 'Ravi', 35, 7654321098);
INSERT INTO drivers VALUES (4, 'Rohan', 28, 6543210987);
INSERT INTO drivers VALUES (5, 'Manish', 22, 5432109876);

-- Inserting values into Customers table
INSERT INTO customers VALUES (101, 'Ravi', 30, 'Mumbai');
INSERT INTO customers VALUES (102, 'Rahul', 25, 'Delhi');
INSERT INTO customers VALUES (103, 'Simran', 32, 'Bangalore');
INSERT INTO customers VALUES (104, 'Aayush', 28, 'Mumbai');
INSERT INTO customers VALUES (105, 'Tarun', 22, 'Delhi');

-- Inserting values into Rides table
INSERT INTO rides VALUES (1001, 101, 1, 500);
INSERT INTO rides VALUES (1002, 102, 2, 300);
INSERT INTO rides VALUES (1003, 103, 3, 200);
INSERT INTO rides VALUES (1004, 104, 4, 400);
INSERT INTO rides VALUES (1005, 105, 5, 150);

-- Inserting values into Payment table
INSERT INTO payment VALUES (1, 1001, 500, 'upi', 'completed');
INSERT INTO payment VALUES (2, 1002, 300, 'credit', 'completed');
INSERT INTO payment VALUES (3, 1003, 200, 'debit', 'in process');

-- Inserting values into Employee table
INSERT INTO employee VALUES (201, 'Aryan', 9876543210, 'Sales', 205);
INSERT INTO employee VALUES (202, 'Japjot', 8765432109, 'Delivery', 206);
INSERT INTO employee VALUES (203, 'Vansh', 7654321098, 'Delivery', 202);
INSERT INTO employee VALUES (204, 'Rishika', 6543210987, 'Sales', 202);
INSERT INTO employee VALUES (205, 'Sanjana', 5432109876, 'HR', 204);
INSERT INTO employee VALUES (206, 'Sanjay', 4321098765, 'Tech', NULL);

-- Triggers

-- 1. Trigger to Update Payment Status after a Ride is Completed
DELIMITER //
CREATE TRIGGER update_payment_status_after_ride
AFTER UPDATE ON rides
FOR EACH ROW
BEGIN
    IF NEW.status = 'completed' THEN
        UPDATE payment
        SET status = 'completed'
        WHERE ride_id = NEW.ride_id;
    END IF;
END //
DELIMITER ;

-- 2. Trigger to Check Driver Availability before Inserting a Ride
DELIMITER //
CREATE TRIGGER check_driver_availability_before_ride
BEFORE INSERT ON rides
FOR EACH ROW
BEGIN
    DECLARE available_rides INT;
    SELECT COUNT(*) INTO available_rides FROM rides WHERE did = NEW.did;
    IF available_rides >= 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Driver is currently unavailable';
    END IF;
END //
DELIMITER ;

-- 3. Trigger to Update Customer's Address after an Order is Placed
DELIMITER //
CREATE TRIGGER update_customer_address_after_order
AFTER INSERT ON rides
FOR EACH ROW
BEGIN
    UPDATE customers
    SET addr = NEW.addr
    WHERE cid = NEW.cid;
END //
DELIMITER ;

-- TCL Commands

-- 1. Save Command Permanently (Commit)
START TRANSACTION;
INSERT INTO rides (ride_id, cid, did, fare) VALUES (1006, 106, 1, 250);
INSERT INTO payment (pay_id, ride_id, amount, mode, status) VALUES (4, 1006, 250, 'upi', 'completed');
COMMIT;

-- 2. Rollback to Previous Command
START TRANSACTION;
INSERT INTO rides (ride_id, cid, did, fare) VALUES (1007, 107, 2, 300);
ROLLBACK;

-- 3. Create Savepoint and Rollback to Savepoint
START TRANSACTION;
INSERT INTO rides (ride_id, cid, did, fare) VALUES (1008, 108, 3, 350);
SAVEPOINT ride_insert;
INSERT INTO payment (pay_id, ride_id, amount, mode, status) VALUES (5, 1008, 350, 'credit', 'in process');
ROLLBACK TO ride_insert;

-- Views

-- 1. View that Displays Customers with Their Corresponding Rides
CREATE VIEW CustomerRides AS
SELECT c.cid, c.cname, r.ride_id, r.fare
FROM customers c
JOIN rides r ON c.cid = r.cid;

-- 2. Create or Replace View to Show Payment Details with Ride and Customer Information
CREATE OR REPLACE VIEW PaymentRideCustomerDetails AS
SELECT p.pay_id, p.ride_id, r.cid, c.cname, c.age, c.addr, p.amount, p.mode, p.status
FROM payment p
JOIN rides r ON p.ride_id = r.ride_id
JOIN customers c ON r.cid = c.cid;

-- 3. Drop View if It Exists
DROP VIEW IF EXISTS PaymentRideCustomerDetails;

/*TCL (Transaction Control Language) commands and triggers are crucial parts of managing database transactions and ensuring data integrity. Here's an overview of TCL commands, triggers, and views:

TCL Commands
TCL commands in SQL are used to manage transactions in a database. They help ensure the consistency and integrity of data.

1. COMMIT: This command is used to save all changes made during the current transaction. Once a COMMIT is issued, the changes become permanent and visible to other users.*/
COMMIT;

/*
2. ROLLBACK: This command undoes all changes made during the current transaction. It reverts the database to its last committed state.*/
ROLLBACK;

/*
3. SAVEPOINT: This command sets a savepoint within a transaction. You can roll back to this savepoint if necessary without affecting the entire transaction.*/
SAVEPOINT savepoint_name;

/*
4. RELEASE SAVEPOINT: This command deletes a savepoint, making it no longer available for rollback. */
RELEASE SAVEPOINT savepoint_name;

/*
5. ROLLBACK TO SAVEPOINT: This command rolls back the transaction to a specific savepoint.*/
ROLLBACK TO SAVEPOINT savepoint_name;

/* Triggers are special types of stored procedures that automatically execute or "fire" when certain events occur in the database, such as INSERT, UPDATE, or DELETE operations. They are used for maintaining data integrity, enforcing business rules, and auditing changes.

Creating a Trigger
To create a trigger, you generally specify the following:

Timing: BEFORE or AFTER the triggering event.
Event: The specific action that activates the trigger (INSERT, UPDATE, DELETE).
Table: The table on which the trigger operates.
Action: The SQL statements to execute when the trigger fires.

Example: Creating a Trigger*/
CREATE TRIGGER trigger_name
BEFORE INSERT ON table_name
FOR EACH ROW
BEGIN
    -- SQL statements here
END;
 /* Views
Views are virtual tables based on the result of a SELECT query. They do not store data themselves but provide a way to present data from one or more tables in a specific format or with specific filtering criteria.

Creating a View */
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;


/*Summary
TCL Commands: Manage transactions with COMMIT, ROLLBACK, SAVEPOINT, RELEASE SAVEPOINT, and ROLLBACK TO SAVEPOINT.
Triggers: Automate actions in response to changes in the database with CREATE TRIGGER.
Views: Create virtual tables to simplify complex queries and manage data presentation with CREATE VIEW.
These tools help ensure data integrity, automate processes, and simplify complex query management in SQL databases.
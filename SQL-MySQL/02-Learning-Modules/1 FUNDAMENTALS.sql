-- ============================================
-- FUNDAMENTALS
-- 1 Database Basics & SQL Commands
-- 2 Data Types
-- 3 Keys & Constraints
-- 4 DELETE vs TRUNCATE vs DROP
-- ============================================

USE tutorial_db;

-- ============================================
-- 1 Database Basics & SQL Commands
-- ============================================

-- 1.1 DDL (Data Definition Language)
CREATE TABLE test_table (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE test_table ADD COLUMN email VARCHAR(100);

DROP TABLE IF EXISTS test_table;

-- 1.2 DML (Data Manipulation Language)
INSERT INTO departments (department_name, location, budget)
VALUES ('Test Department', 'Remote', 100000.00);

UPDATE departments 
SET budget = budget * 1.10 
WHERE department_name = 'Test Department';

DELETE FROM departments WHERE department_name = 'Test Department';

-- 1.3 DQL (Data Query Language)
SELECT * FROM employees; -- All Columns
SELECT first_name, last_name, salary FROM employees WHERE salary > 80000; -- Specific Columns

-- 1.4 DCL (Data Control Language)
-- GRANT SELECT ON employees TO 'username'@'localhost';
-- REVOKE SELECT ON employees FROM 'username'@'localhost';

-- 1.5 TCL (Transaction Control Language)
START TRANSACTION;
UPDATE employees SET salary = salary * 1.05 WHERE department_id = 1;
COMMIT;
-- ROLLBACK;
-- SAVEPOINT savepoint_name;

-- ============================================
-- 2 Data Types
-- ============================================
/*
-- 2.1 Numeric Types
TINYINT         -- -128 to 127
SMALLINT        -- -32,768 to 32,767
MEDIUMINT       -- -8,388,608 to 8,388,607
INT             -- -2,147,483,648 to 2,147,483,647
BIGINT          -- Very large integers
DECIMAL(M,D)    -- Fixed-point (M=total digits, D=decimal places)
FLOAT           -- Floating-point
DOUBLE          -- Double-precision floating-point

2.2 String Types
CHAR(n)         -- Fixed-length string (max 255)
VARCHAR(n)      -- Variable-length string (max 65,535)
TEXT            -- Long text (max 65,535)
MEDIUMTEXT      -- Medium text (max 16,777,215)
LONGTEXT        -- Very long text (max 4,294,967,295)
ENUM            -- Enumeration (predefined values)
SET             -- Set of values

2.3 Date and Time Types
DATE            -- YYYY-MM-DD
TIME            -- HH:MM:SS
DATETIME        -- YYYY-MM-DD HH:MM:SS
TIMESTAMP       -- YYYY-MM-DD HH:MM:SS (auto-update)
YEAR            -- YYYY

2.4 Other Types
BOOLEAN         -- TRUE or FALSE (TINYINT(1))
BLOB            -- Binary Large Object
JSON            -- JSON data (MySQL 5.7+)
*/

-- ============================================
-- 3 Keys & Constraints
-- ============================================

-- 3.1 Primary Key and AUTO_INCREMENT
CREATE TABLE test_primary (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- 3.2 Foreign Key
CREATE TABLE test_foreign (
    id INT PRIMARY KEY,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES test_primary(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 3.3 Unique Key
CREATE TABLE test_unique (
    id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    username VARCHAR(50) UNIQUE
);

-- 3.4 NOT NULL and Default Constraints
CREATE TABLE test_constraints (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3.5 Check Constraint (MySQL 8.0.16+)
CREATE TABLE test_check (
    id INT PRIMARY KEY,
    age INT CHECK (age >= 18),
    salary DECIMAL(10,2) CHECK (salary > 0)
);

-- Clean up test tables
DROP TABLE IF EXISTS test_foreign;
DROP TABLE IF EXISTS test_primary;
DROP TABLE IF EXISTS test_unique;
DROP TABLE IF EXISTS test_constraints;
DROP TABLE IF EXISTS test_check;

-- ============================================
-- 4 DELETE vs TRUNCATE vs DROP
-- ============================================

-- 4.1 DELETE: Remove specific rows
DELETE FROM employees WHERE employee_id = 999;

-- 4.2 TRUNCATE: Remove all rows (fast)
-- TRUNCATE TABLE temp_table;

-- 4.3 DROP: Remove table structure
-- DROP TABLE temp_table;

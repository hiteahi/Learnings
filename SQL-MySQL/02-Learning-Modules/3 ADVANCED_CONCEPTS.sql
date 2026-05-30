-- ============================================
-- ADVANCED CONCEPTS
-- 1 Transactions, Ranking, Recursion
-- 2 Advanced Query Logic
-- 3 Analytical Queries
-- 4 Recursive Queries
-- 5 Pivot Tables
-- 6 NULL Handling
-- ============================================

USE tutorial_db;


-- ============================================
-- 1 Transactions
-- ============================================

-- Basic transaction
START TRANSACTION;
UPDATE employees SET salary = salary * 1.10 WHERE department_id = 1;
COMMIT;

-- Transaction with rollback
START TRANSACTION;
DELETE FROM employees WHERE department_id = 1;
-- Oops, wrong department!
ROLLBACK;

-- Transaction with savepoint
START TRANSACTION;
INSERT INTO employees (first_name, last_name, email, hire_date, job_title, salary, department_id)
VALUES ('John', 'Doe', 'john.doe@test.com', CURDATE(), 'Developer', 75000, 1);
SAVEPOINT sp1;

INSERT INTO employees (first_name, last_name, email, hire_date, job_title, salary, department_id)
VALUES ('Jane', 'Smith', 'jane.smith@test.com', CURDATE(), 'Manager', 95000, 1);
SAVEPOINT sp2;

-- Rollback to sp1 (keeps only John)
ROLLBACK TO sp1;
COMMIT;

-- Clean up test data
DELETE FROM employees WHERE email IN ('john.doe@test.com', 'jane.smith@test.com');

-- ============================================
-- 2 Advanced Query Logic
-- ============================================

-- IN vs EXISTS
-- Using IN
SELECT first_name
FROM employees
WHERE department_id IN (
    SELECT department_id FROM departments WHERE location = 'San Francisco'
);

-- Using EXISTS (often faster)
SELECT first_name
FROM employees e
WHERE EXISTS (
    SELECT 1 FROM departments d
    WHERE d.department_id = e.department_id
      AND d.location = 'San Francisco'
);

-- UNION vs JOIN
-- UNION: Combine rows
SELECT first_name, 'Employee' as type FROM employees WHERE department_id = 1
UNION
SELECT first_name, 'Employee' as type FROM employees WHERE department_id = 2;

-- JOIN: Combine columns
SELECT e.first_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Fetch common records
SELECT e1.first_name
FROM employees e1
INNER JOIN employees e2 ON e1.first_name = e2.first_name
WHERE e1.employee_id != e2.employee_id;

-- ============================================
-- 3 Analytical Queries
-- ============================================

-- Nth highest salary (N=3)
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) as rank_num
    FROM employees
) ranked
WHERE rank_num = 3;

-- Top N salaries (Top 5)
SELECT first_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- Employees earning more than department average
SELECT 
    e1.first_name,
    e1.salary,
    e1.department_id
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);

-- ============================================
-- 4 Recursive Queries
-- ============================================

-- Find all subordinates
WITH RECURSIVE subordinates AS (
    -- Base case
    SELECT employee_id, first_name, manager_id, 1 as level
    FROM employees
    WHERE employee_id = 2
    
    UNION ALL
    
    -- Recursive case
    SELECT e.employee_id, e.first_name, e.manager_id, s.level + 1
    FROM employees e
    INNER JOIN subordinates s ON e.manager_id = s.employee_id
)
SELECT * FROM subordinates;

-- Organization hierarchy
WITH RECURSIVE org_chart AS (
    SELECT employee_id, first_name, manager_id, first_name as path, 1 as level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    SELECT e.employee_id, e.first_name, e.manager_id,
           CONCAT(o.path, ' > ', e.first_name), o.level + 1
    FROM employees e
    INNER JOIN org_chart o ON e.manager_id = o.employee_id
)
SELECT * FROM org_chart ORDER BY path;

-- ============================================
-- 5 Pivot Tables
-- ============================================

-- Pivot: Convert rows to columns
SELECT 
    department_id,
    SUM(CASE WHEN job_title = 'Manager' THEN 1 ELSE 0 END) as managers,
    SUM(CASE WHEN job_title = 'Software Engineer' THEN 1 ELSE 0 END) as engineers,
    SUM(CASE WHEN job_title = 'Senior Software Engineer' THEN 1 ELSE 0 END) as senior_engineers
FROM employees
GROUP BY department_id;

-- ============================================
-- 6 NULL Handling
-- ============================================

-- Check for NULL
SELECT first_name FROM employees WHERE phone IS NULL;
SELECT first_name FROM employees WHERE phone IS NOT NULL;

-- Replace NULL
SELECT first_name, COALESCE(phone, 'No phone') as phone FROM employees;
SELECT first_name, IFNULL(phone, 'No phone') as phone FROM employees;

-- NULL in calculations
SELECT salary, COALESCE(salary * 0.10, 0) as bonus FROM employees;

-- ============================================
-- PERFORMANCE OPTIMIZATION
-- 1 Query Optimization
-- 2 Indexing Strategies
-- 3 Performance Techniques
-- 4 OLTP vs OLAP Examples
-- 5 Stored Procedures vs Functions
-- 6 COMPREHENSIVE EXAMPLES
-- ============================================

USE tutorial_db;

-- ============================================
-- 1 Query Optimization
-- ============================================

-- EXPLAIN: View execution plan
EXPLAIN SELECT * FROM employees WHERE department_id = 1;

-- EXPLAIN ANALYZE: Detailed execution plan
EXPLAIN ANALYZE SELECT * FROM employees WHERE department_id = 1;

-- Optimization examples

-- BAD: SELECT *
-- SELECT * FROM employees;

-- GOOD: Specify columns
SELECT employee_id, first_name, last_name, salary FROM employees;

-- BAD: Function in WHERE
-- SELECT * FROM employees WHERE YEAR(hire_date) = 2023;

-- GOOD: Direct comparison
SELECT * FROM employees 
WHERE hire_date >= '2023-01-01' AND hire_date < '2024-01-01';

-- BAD: OR conditions
-- SELECT * FROM employees WHERE department_id = 1 OR department_id = 2;

-- GOOD: IN clause
SELECT * FROM employees WHERE department_id IN (1, 2);

-- BAD: Subquery in SELECT
-- SELECT name, (SELECT department_name FROM departments WHERE department_id = e.department_id)
-- FROM employees e;

-- GOOD: JOIN
SELECT e.first_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- ============================================
-- 2 Indexing Strategies
-- ============================================

-- Single-column index
CREATE INDEX idx_salary ON employees(salary);

-- Composite index (order matters!)
CREATE INDEX idx_dept_salary ON employees(department_id, salary);

-- Unique index
CREATE UNIQUE INDEX idx_email ON employees(email);

-- Covering index (includes all needed columns)
CREATE INDEX idx_covering ON employees(department_id, first_name, salary);

-- Query can be satisfied entirely from index
SELECT first_name, salary 
FROM employees 
WHERE department_id = 1;

-- ============================================
-- 3 Performance Techniques
-- ============================================

-- Use LIMIT for large result sets
SELECT * FROM employees ORDER BY salary DESC LIMIT 100;

-- Use EXISTS instead of IN for large subqueries
SELECT first_name
FROM employees e
WHERE EXISTS (
    SELECT 1 FROM departments d
    WHERE d.department_id = e.department_id
      AND d.location = 'San Francisco'
);

-- Avoid wildcard at start of LIKE
-- BAD: SELECT * FROM employees WHERE first_name LIKE '%John%';
-- GOOD: SELECT * FROM employees WHERE first_name LIKE 'John%';

-- Use UNION ALL instead of UNION when duplicates don't matter
SELECT first_name FROM employees WHERE department_id = 1
UNION ALL
SELECT first_name FROM employees WHERE department_id = 2;

-- Batch operations
INSERT INTO employees (first_name, last_name, email, hire_date, job_title, salary, department_id)
VALUES 
    ('Test1', 'User1', 'test1@test.com', CURDATE(), 'Developer', 75000, 1),
    ('Test2', 'User2', 'test2@test.com', CURDATE(), 'Developer', 75000, 1);

-- Clean up
DELETE FROM employees WHERE email LIKE 'test%@test.com';

-- ============================================
-- 4 OLTP vs OLAP Examples
-- ============================================

-- OLTP: Transaction processing
START TRANSACTION;
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (1, CURDATE(), 1500.00);
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
COMMIT;

-- OLAP: Analytical queries
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count,
    AVG(e.salary) as avg_salary,
    SUM(e.salary) as total_payroll
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.is_active = TRUE
GROUP BY d.department_id, d.department_name
ORDER BY total_payroll DESC;

-- Sales analysis (OLAP)
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') as month,
    COUNT(*) as order_count,
    SUM(total_amount) as total_sales,
    AVG(total_amount) as avg_order_value
FROM orders
WHERE order_date >= '2024-01-01'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- ============================================
-- 5 Stored Procedures vs Functions
-- ============================================

-- Stored Procedure
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN dept_id INT)
BEGIN
    SELECT first_name, last_name, salary
    FROM employees
    WHERE department_id = dept_id;
END //
DELIMITER ;

-- Call stored procedure
CALL GetEmployeesByDept(1);

-- Function
DELIMITER //
CREATE FUNCTION GetEmployeeSalary(emp_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE emp_salary DECIMAL(10,2);
    SELECT salary INTO emp_salary
    FROM employees
    WHERE employee_id = emp_id;
    RETURN emp_salary;
END //
DELIMITER ;

-- Use function
SELECT first_name, GetEmployeeSalary(employee_id) as salary
FROM employees
LIMIT 5;

-- Clean up
DROP PROCEDURE IF EXISTS GetEmployeesByDept;
DROP FUNCTION IF EXISTS GetEmployeeSalary;

-- ============================================
-- 6 COMPREHENSIVE EXAMPLES
-- ============================================

-- Complex analytical query combining multiple concepts
WITH 
dept_stats AS (
    SELECT 
        department_id,
        AVG(salary) as avg_salary,
        COUNT(*) as employee_count
    FROM employees
    WHERE is_active = TRUE
    GROUP BY department_id
),
ranked_employees AS (
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.salary,
        e.department_id,
        RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) as dept_rank,
        DENSE_RANK() OVER (ORDER BY e.salary DESC) as overall_rank
    FROM employees e
    WHERE e.is_active = TRUE
)
SELECT 
    re.first_name,
    re.last_name,
    re.salary,
    d.department_name,
    ds.avg_salary as dept_avg_salary,
    re.dept_rank,
    re.overall_rank,
    CASE
        WHEN re.salary > ds.avg_salary * 1.5 THEN 'Top Performer'
        WHEN re.salary > ds.avg_salary THEN 'Above Average'
        ELSE 'Average'
    END as performance_category
FROM ranked_employees re
JOIN departments d ON re.department_id = d.department_id
JOIN dept_stats ds ON re.department_id = ds.department_id
WHERE re.dept_rank <= 3
ORDER BY d.department_name, re.dept_rank;

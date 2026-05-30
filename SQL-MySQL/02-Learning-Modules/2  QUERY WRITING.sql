-- ============================================
-- QUERY WRITING
-- 1 SELECT and WHERE
-- 2 Functions
-- 3 CASE(Conditional) Functions
-- 4 GROUP BY and ORDER BY
-- 5 WHERE vs HAVING
-- 6 Join Types
-- 7 UNION Operations
-- 8 Window Functions
-- 9 Subqueries
-- 10 CTEs and Temporary Tables
-- 11 Common Problems
-- ============================================

USE x_company_db;

-- ============================================
-- 1 SELECT and WHERE
-- ============================================

-- Basic SELECT Statement
SELECT * FROM employees; -- all columns
SELECT employee_id, first_name, salary FROM employees; -- specific columns

-- WHERE Clause
SELECT employee_id, first_name, salary 
FROM employees
WHERE salary > 100000; -- more than 100000

-- ============================================
-- 2 Functions
-- ============================================

-- Aggregate
SELECT COUNT(*) as "Total Employees", 
	   MAX(salary) as "Highest Salary", 
       MIN(salary) as "Lowest Salary", 
       AVG(salary) as avg_salary 
FROM employees;

-- String
SELECT employee_id, 
	   CONCAT(first_name, " ", last_name) as full_name, 
       UPPER(first_name) as upper_name, 
       LOWER(first_name) as lower_name 
FROM employees;

-- ============================================
-- 3 CASE(Conditional) Functions
-- ============================================

-- CASE statement
SELECT 
    first_name,
    salary,
    CASE
        WHEN salary > 100000 THEN 'High'
        WHEN salary > 70000 THEN 'Medium'
        ELSE 'Low'
    END as salary_category
FROM employees;

-- CASE in aggregation
SELECT 
    department_id,
    SUM(CASE WHEN salary > 80000 THEN 1 ELSE 0 END) as high_earners,
    SUM(CASE WHEN salary <= 80000 THEN 1 ELSE 0 END) as regular_earners
FROM employees
GROUP BY department_id;

-- COALESCE: First non-null value
SELECT 
    first_name,
    COALESCE(phone, 'No phone') as phone,
    COALESCE(email, 'No email') as email
FROM employees;

-- ============================================
-- 4 GROUP BY and ORDER BY
-- ============================================

-- Basic GROUP BY
SELECT 
    department_id,
    AVG(salary) as avg_salary
FROM employees
GROUP BY department_id;

-- GROUP BY with multiple columns
SELECT 
    department_id,
    job_title,
    COUNT(*) as count,
    AVG(salary) as avg_salary
FROM employees
GROUP BY department_id, job_title;

-- GROUP BY with HAVING
SELECT 
    department_id,
    COUNT(*) as employee_count,
    AVG(salary) as avg_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5 AND AVG(salary) > 75000;

-- ORDER BY
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC, last_name ASC;

-- LIMIT and OFFSET
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 10;

-- Pagination
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 10 OFFSET 20;

-- ============================================
-- 5 WHERE vs HAVING
-- ============================================

-- WHERE: Filter before grouping
SELECT department_id, AVG(salary) as avg_salary
FROM employees
WHERE is_active = TRUE
GROUP BY department_id;

-- HAVING: Filter after grouping
SELECT department_id, AVG(salary) as avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 80000;

-- Both together
SELECT 
    department_id,
    COUNT(*) as employee_count,
    AVG(salary) as avg_salary
FROM employees
WHERE is_active = TRUE
GROUP BY department_id
HAVING COUNT(*) > 5 AND AVG(salary) > 70000;

-- ============================================
-- 6 Join Types
-- ============================================

-- INNER JOIN: Common records only
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- LEFT JOIN: All left + matched right
SELECT 
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- Find employees without departments
SELECT 
    e.first_name,
    e.last_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- RIGHT JOIN: All right + matched left
SELECT 
    e.first_name,
    d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

-- Find departments without employees
SELECT 
    d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

-- FULL JOIN (MySQL simulation using UNION)
SELECT e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
UNION
SELECT e.first_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

-- SELF JOIN: Employee and their manager
SELECT 
    e.first_name as employee,
    e.job_title,
    m.first_name as manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- CROSS JOIN: All combinations
SELECT 
    e.first_name,
    d.department_name
FROM employees e
CROSS JOIN departments d
LIMIT 20;

-- Multiple JOINs
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    p.project_name,
    a.role
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN assignments a ON e.employee_id = a.employee_id
JOIN projects p ON a.project_id = p.project_id;

-- ============================================
-- 7 UNION Operations
-- ============================================

-- UNION: Remove duplicates
SELECT first_name, last_name, 'Employee' as type
FROM employees
WHERE department_id = 1
UNION
SELECT first_name, last_name, 'Employee' as type
FROM employees
WHERE department_id = 2;

-- UNION ALL: Keep duplicates
SELECT first_name, last_name, 'Current' as status
FROM employees
WHERE is_active = TRUE
UNION ALL
SELECT first_name, last_name, 'All' as status
FROM employees;

-- ============================================
-- 8 Window Functions
-- ============================================

-- ROW_NUMBER: Unique row numbers
SELECT 
    first_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as row_num
FROM employees;

-- ROW_NUMBER per department
SELECT 
    first_name,
    salary,
    department_id,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) as row_num
FROM employees;

-- RANK: With gaps for ties
SELECT 
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) as rank_num
FROM employees;

-- DENSE_RANK: No gaps
SELECT 
    first_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) as rank_num
FROM employees;

-- NTILE: Divide into buckets
SELECT 
    first_name,
    salary,
    NTILE(4) OVER (ORDER BY salary) as quartile
FROM employees;

-- LAG: Previous row value
SELECT 
    first_name,
    salary,
    LAG(salary) OVER (ORDER BY salary) as previous_salary,
    salary - LAG(salary) OVER (ORDER BY salary) as difference
FROM employees;

-- LEAD: Next row value
SELECT 
    first_name,
    salary,
    LEAD(salary) OVER (ORDER BY salary) as next_salary
FROM employees;

-- FIRST_VALUE / LAST_VALUE
SELECT 
    first_name,
    salary,
    department_id,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department_id 
        ORDER BY salary DESC
    ) as highest_in_dept
FROM employees;

-- Running total
SELECT 
    first_name,
    salary,
    SUM(salary) OVER (ORDER BY employee_id) as running_total
FROM employees;

-- ============================================
-- 9 Subqueries
-- ============================================

-- Scalar subquery: Single value
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Row subquery: Single row
SELECT name
FROM employees
WHERE (department_id, salary) = (
    SELECT department_id, MAX(salary)
    FROM employees
    WHERE department_id = 1
);

-- Table subquery: Multiple rows
SELECT name, salary
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) > 80000
);

-- Correlated subquery: Depends on outer query
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

-- EXISTS: Check if subquery returns rows
SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);

-- NOT EXISTS: Check if subquery returns no rows
SELECT department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);

-- ANY / ALL
SELECT name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary FROM employees WHERE is_manager = TRUE
);

SELECT name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary FROM employees WHERE is_manager = TRUE
);

-- ============================================
-- 10 CTEs and Temporary Tables
-- ============================================

-- CTE (Common Table Expression)
WITH high_earners AS (
    SELECT first_name, last_name, salary, department_id
    FROM employees
    WHERE salary > 80000
)
SELECT * FROM high_earners;

-- Multiple CTEs
WITH 
dept_avg AS (
    SELECT department_id, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department_id
),
high_depts AS (
    SELECT department_id
    FROM dept_avg
    WHERE avg_salary > 75000
)
SELECT e.first_name, e.salary
FROM employees e
INNER JOIN high_depts h ON e.department_id = h.department_id;

-- Temporary Table
CREATE TEMPORARY TABLE temp_high_earners AS
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary > 80000;

SELECT * FROM temp_high_earners;
DROP TEMPORARY TABLE temp_high_earners;

-- ============================================
-- 11 Common Problems
-- ============================================

-- Second highest salary
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Using DENSE_RANK (most reliable)
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) as rank_num
    FROM employees
) ranked
WHERE rank_num = 2;

-- Find duplicate records
SELECT email, COUNT(*) as count
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;

-- Nth highest salary (N=3)
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

-- Top N salaries per department
SELECT *
FROM (
    SELECT 
        first_name,
        salary,
        department_id,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) as rank_num
    FROM employees
) ranked
WHERE rank_num <= 3;

-- Employees earning more than manager
SELECT 
    e.first_name as employee,
    e.salary as employee_salary,
    m.first_name as manager,
    m.salary as manager_salary
FROM employees e
INNER JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;
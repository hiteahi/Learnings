# SQL(MySQL)

A complete SQL learning portfolio demonstrating database design, query optimization, and advanced SQL concepts through a real-world company management system.

## Overview

This portfolio showcases my SQL expertise through a comprehensive X Company Management System database, covering everything from fundamental concepts to advanced performance optimization techniques. The project includes 1,500+ lines of production-ready SQL code with learning modules and practical examples.

## Structure

```
SQL-Portfolio/
├── 01-Database-Setup/          # Core database schema and data
│   ├── 01_Tables.sql           # Table definitions with constraints
│   ├── 02_Data.sql             # Sample data insertion (100+ records)
│   ├── 03_Indexes.sql          # Performance indexes
│   └── 04_Views.sql            # Reusable views
│
├── 02-Learning-Modules/        # Comprehensive SQL tutorials
│   ├── 1 FUNDAMENTALS.sql      # SQL basics, data types, constraints
│   ├── 2 QUERY WRITING.sql     # SELECT, JOINs, subqueries, CTEs
│   ├── 3 ADVANCED_CONCEPTS.sql # Window functions, pivots, recursion
│   └── 4 PERFORMANCE OPTIMIZATION.sql  # Indexing, query optimization
│
└── 03-Examples/                # Real-world use cases
    └── Analytics_Queries.sql   # Business intelligence queries
```

## Database Schema

The X Company Management System includes:

- **Departments** - Organizational structure with budget tracking
- **Employees** - Staff information with hierarchical relationships
- **Projects** - Project management with status tracking
- **Assignments** - Employee-project relationships with hours tracking
- **Salaries** - Historical salary records
- **Attendance** - Employee attendance tracking

### Key Features
- Self-referencing relationships (manager hierarchy)
- Referential integrity with foreign keys
- Composite keys and indexes
- Triggers for automated updates
- Views for complex queries
- Stored procedures for business logic

## Quick Start

### Prerequisites
- MySQL 8.0+ or MariaDB 10.5+
- MySQL Workbench (optional, for GUI)

### Setup Instructions

1. **Create the database and tables:**
```bash
mysql -u root -p < 01-Database-Setup/01_Tables.sql
```

2. **Load sample data:**
```bash
mysql -u root -p < 01-Database-Setup/02_Data.sql
```

3. **Create indexes for performance:**
```bash
mysql -u root -p < 01-Database-Setup/03_Indexes.sql
```

4. **Set up views:**
```bash
mysql -u root -p < 01-Database-Setup/04_Views.sql
```

### Verify Installation
```sql
USE X_Company_db;
SHOW TABLES;
SELECT COUNT(*) FROM employees;  -- Should return 50+ records
```

## Learning Modules

### Module 1: Fundamentals (146 lines)
- Database basics and SQL command types (DDL, DML, DQL, DCL, TCL)
- Data types and their use cases
- Primary keys, foreign keys, and constraints
- DELETE vs TRUNCATE vs DROP operations

### Module 2: Query Writing (481 lines)
- SELECT statements with filtering and sorting
- JOIN operations (INNER, LEFT, RIGHT, FULL, CROSS, SELF)
- Aggregate functions and GROUP BY
- Subqueries and Common Table Expressions (CTEs)
- UNION operations and set theory

### Module 3: Advanced Concepts (175 lines)
- Window functions (ROW_NUMBER, RANK, DENSE_RANK, NTILE)
- Analytical functions (LEAD, LAG, FIRST_VALUE, LAST_VALUE)
- PIVOT and UNPIVOT operations
- Recursive CTEs for hierarchical data
- Dynamic SQL and prepared statements

### Module 4: Performance Optimization (226 lines)
- Index types and strategies
- Query execution plans (EXPLAIN)
- Query optimization techniques
- Partitioning strategies
- Caching and materialized views

## Key SQL Concepts Demonstrated

### 1. Complex Joins
```sql
-- Multi-table join with aggregation
SELECT 
    d.department_name,
    COUNT(DISTINCT e.employee_id) as employee_count,
    COUNT(DISTINCT p.project_id) as project_count,
    SUM(a.hours_worked) as total_hours
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN assignments a ON e.employee_id = a.employee_id
LEFT JOIN projects p ON a.project_id = p.project_id
GROUP BY d.department_id, d.department_name;
```

### 2. Window Functions
```sql
-- Salary ranking within departments
SELECT 
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as salary_rank,
    AVG(salary) OVER (PARTITION BY department_id) as dept_avg_salary
FROM employees;
```

### 3. Recursive CTEs
```sql
-- Employee hierarchy traversal
WITH RECURSIVE employee_hierarchy AS (
    SELECT employee_id, first_name, last_name, manager_id, 1 as level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    SELECT e.employee_id, e.first_name, e.last_name, e.manager_id, eh.level + 1
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy ORDER BY level, employee_id;
```

## Sample Queries & Use Cases

### Business Analytics
- Employee performance metrics
- Department budget analysis
- Project profitability reports
- Salary trend analysis
- Attendance patterns

### Data Quality
- Duplicate detection
- Data validation queries
- Referential integrity checks
- Orphaned record identification

### Performance Optimization
- Index usage analysis
- Slow query identification
- Query plan optimization
- Partitioning strategies

## Skills Demonstrated

- Database design and normalization (3NF)
- Complex query writing and optimization
- Index design and performance tuning
- Transaction management and ACID properties
- Stored procedures and functions
- Triggers and automation
- View creation and materialization
- Data analysis and reporting

*Built with ❤️ for data science and analytics*
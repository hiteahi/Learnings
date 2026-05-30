-- ============================================
-- MySQL - Sample Data
-- X Company Management System
-- ============================================

USE X_Company_db;

-- ============================================
-- Insert Departments
-- ============================================
INSERT INTO departments (department_name, location, budget) VALUES
('Engineering', 'San Francisco', 500000.00),
('Marketing', 'New York', 300000.00),
('Sales', 'Chicago', 400000.00),
('Human Resources', 'Boston', 200000.00),
('Finance', 'New York', 350000.00),
('Customer Support', 'Austin', 250000.00),
('Research & Development', 'San Francisco', 600000.00),
('Operations', 'Seattle', 450000.00);

-- ============================================
-- Insert Employees
-- ============================================
INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary, department_id, manager_id) VALUES
-- Top Management
('John', 'Smith', 'john.smith@company.com', '555-0101', '2015-01-15', 'CEO', 200000.00, NULL, NULL),
('Sarah', 'Johnson', 'sarah.johnson@company.com', '555-0102', '2015-03-20', 'CTO', 180000.00, 1, 1),
('Michael', 'Williams', 'michael.williams@company.com', '555-0103', '2015-06-10', 'CFO', 175000.00, 5, 1),

-- Engineering Department
('Emily', 'Brown', 'emily.brown@company.com', '555-0104', '2016-02-15', 'Engineering Manager', 140000.00, 1, 2),
('David', 'Jones', 'david.jones@company.com', '555-0105', '2017-04-20', 'Senior Software Engineer', 120000.00, 1, 4),
('Jessica', 'Garcia', 'jessica.garcia@company.com', '555-0106', '2018-07-10', 'Software Engineer', 95000.00, 1, 4),
('Daniel', 'Martinez', 'daniel.martinez@company.com', '555-0107', '2019-01-15', 'Software Engineer', 90000.00, 1, 4),
('Lisa', 'Rodriguez', 'lisa.rodriguez@company.com', '555-0108', '2020-03-01', 'Junior Developer', 75000.00, 1, 5),

-- Marketing Department
('Robert', 'Wilson', 'robert.wilson@company.com', '555-0109', '2016-05-12', 'Marketing Director', 130000.00, 2, 1),
('Jennifer', 'Anderson', 'jennifer.anderson@company.com', '555-0110', '2017-08-20', 'Marketing Manager', 100000.00, 2, 9),
('William', 'Taylor', 'william.taylor@company.com', '555-0111', '2018-11-05', 'Content Strategist', 80000.00, 2, 10),
('Amanda', 'Thomas', 'amanda.thomas@company.com', '555-0112', '2019-09-15', 'Social Media Manager', 75000.00, 2, 10),

-- Sales Department
('Christopher', 'Moore', 'christopher.moore@company.com', '555-0113', '2016-07-01', 'Sales Director', 135000.00, 3, 1),
('Michelle', 'Jackson', 'michelle.jackson@company.com', '555-0114', '2017-10-15', 'Sales Manager', 105000.00, 3, 13),
('Matthew', 'White', 'matthew.white@company.com', '555-0115', '2018-12-20', 'Sales Representative', 85000.00, 3, 14),
('Ashley', 'Harris', 'ashley.harris@company.com', '555-0116', '2019-05-10', 'Sales Representative', 82000.00, 3, 14),

-- HR Department
('Joshua', 'Martin', 'joshua.martin@company.com', '555-0117', '2016-09-01', 'HR Director', 125000.00, 4, 1),
('Stephanie', 'Thompson', 'stephanie.thompson@company.com', '555-0118', '2018-02-15', 'HR Manager', 95000.00, 4, 17),
('Ryan', 'Lee', 'ryan.lee@company.com', '555-0119', '2019-11-20', 'Recruiter', 70000.00, 4, 18),

-- Finance Department
('Nicole', 'Walker', 'nicole.walker@company.com', '555-0120', '2016-11-10', 'Finance Manager', 115000.00, 5, 3),
('Kevin', 'Hall', 'kevin.hall@company.com', '555-0121', '2018-04-25', 'Senior Accountant', 90000.00, 5, 20),
('Rachel', 'Allen', 'rachel.allen@company.com', '555-0122', '2019-08-15', 'Accountant', 75000.00, 5, 20),

-- Customer Support
('Brandon', 'Young', 'brandon.young@company.com', '555-0123', '2017-01-20', 'Support Manager', 95000.00, 6, 1),
('Megan', 'King', 'megan.king@company.com', '555-0124', '2018-06-10', 'Support Specialist', 65000.00, 6, 23),
('Tyler', 'Wright', 'tyler.wright@company.com', '555-0125', '2019-12-05', 'Support Specialist', 63000.00, 6, 23),

-- R&D Department
('Laura', 'Lopez', 'laura.lopez@company.com', '555-0126', '2016-04-15', 'R&D Director', 150000.00, 7, 2),
('Justin', 'Hill', 'justin.hill@company.com', '555-0127', '2017-09-20', 'Research Scientist', 110000.00, 7, 26),
('Samantha', 'Scott', 'samantha.scott@company.com', '555-0128', '2019-03-10', 'Research Analyst', 85000.00, 7, 26),

-- Operations
('Andrew', 'Green', 'andrew.green@company.com', '555-0129', '2016-08-05', 'Operations Manager', 120000.00, 8, 1),
('Brittany', 'Adams', 'brittany.adams@company.com', '555-0130', '2018-10-15', 'Operations Coordinator', 75000.00, 8, 29);

-- ============================================
-- Insert Projects
-- ============================================
INSERT INTO projects (project_name, description, start_date, end_date, budget, status, department_id) VALUES
('Website Redesign', 'Complete overhaul of company website with modern UI/UX', '2024-01-15', '2024-06-30', 150000.00, 'In Progress', 1),
('Mobile App Development', 'Native iOS and Android app for customer engagement', '2024-02-01', '2024-12-31', 300000.00, 'In Progress', 1),
('Marketing Campaign Q1', 'Digital marketing campaign for Q1 2024', '2024-01-01', '2024-03-31', 80000.00, 'Completed', 2),
('CRM Implementation', 'Implementation of new CRM system', '2024-03-01', '2024-09-30', 200000.00, 'In Progress', 3),
('Employee Training Program', 'Comprehensive training program for new hires', '2024-01-10', '2024-12-31', 50000.00, 'In Progress', 4),
('Financial Audit 2024', 'Annual financial audit and compliance review', '2024-01-01', '2024-04-30', 75000.00, 'In Progress', 5),
('AI Research Initiative', 'Research on AI applications in business', '2024-02-15', '2025-02-15', 400000.00, 'Planning', 7),
('Supply Chain Optimization', 'Optimize supply chain processes', '2024-03-01', '2024-11-30', 180000.00, 'Planning', 8);

-- ============================================
-- Insert Assignments
-- ============================================
INSERT INTO assignments (employee_id, project_id, role, hours_allocated, start_date, end_date) VALUES
-- Website Redesign
(5, 1, 'Lead Developer', 160, '2024-01-15', '2024-06-30'),
(6, 1, 'Frontend Developer', 160, '2024-01-15', '2024-06-30'),
(7, 1, 'Backend Developer', 160, '2024-01-15', '2024-06-30'),
(11, 1, 'Content Creator', 80, '2024-02-01', '2024-05-31'),

-- Mobile App Development
(4, 2, 'Project Manager', 200, '2024-02-01', '2024-12-31'),
(5, 2, 'Technical Lead', 200, '2024-02-01', '2024-12-31'),
(6, 2, 'iOS Developer', 200, '2024-02-01', '2024-12-31'),
(7, 2, 'Android Developer', 200, '2024-02-01', '2024-12-31'),

-- Marketing Campaign Q1
(10, 3, 'Campaign Manager', 120, '2024-01-01', '2024-03-31'),
(11, 3, 'Content Strategist', 120, '2024-01-01', '2024-03-31'),
(12, 3, 'Social Media Lead', 120, '2024-01-01', '2024-03-31'),

-- CRM Implementation
(14, 4, 'Project Lead', 180, '2024-03-01', '2024-09-30'),
(15, 4, 'Sales Analyst', 160, '2024-03-01', '2024-09-30'),
(16, 4, 'Sales Analyst', 160, '2024-03-01', '2024-09-30'),

-- Employee Training Program
(18, 5, 'Training Coordinator', 150, '2024-01-10', '2024-12-31'),
(19, 5, 'Recruiter', 100, '2024-01-10', '2024-12-31'),

-- Financial Audit
(20, 6, 'Audit Lead', 140, '2024-01-01', '2024-04-30'),
(21, 6, 'Senior Auditor', 140, '2024-01-01', '2024-04-30'),
(22, 6, 'Auditor', 140, '2024-01-01', '2024-04-30'),

-- AI Research Initiative
(26, 7, 'Research Director', 200, '2024-02-15', '2025-02-15'),
(27, 7, 'Lead Researcher', 200, '2024-02-15', '2025-02-15'),
(28, 7, 'Research Analyst', 200, '2024-02-15', '2025-02-15');

-- ============================================
-- Insert Salary History
-- ============================================
INSERT INTO salary_history (employee_id, old_salary, new_salary, change_date, reason) VALUES
(5, 110000.00, 120000.00, '2023-01-15', 'Annual performance review - Excellent'),
(6, 85000.00, 95000.00, '2023-07-10', 'Promotion to Senior Developer'),
(10, 90000.00, 100000.00, '2023-08-20', 'Annual performance review - Outstanding'),
(14, 95000.00, 105000.00, '2023-10-15', 'Promotion to Sales Manager'),
(20, 105000.00, 115000.00, '2023-11-10', 'Annual performance review - Excellent');

-- ============================================
-- Insert Customers
-- ============================================
INSERT INTO customers (company_name, contact_name, email, phone, address, city, country, postal_code) VALUES
('Tech Solutions Inc', 'Alice Cooper', 'alice@techsolutions.com', '555-1001', '123 Tech Street', 'San Francisco', 'USA', '94102'),
('Global Enterprises', 'Bob Miller', 'bob@globalent.com', '555-1002', '456 Business Ave', 'New York', 'USA', '10001'),
('Innovation Labs', 'Carol Davis', 'carol@innovationlabs.com', '555-1003', '789 Innovation Blvd', 'Austin', 'USA', '73301'),
('Digital Dynamics', 'David Chen', 'david@digitaldynamics.com', '555-1004', '321 Digital Way', 'Seattle', 'USA', '98101'),
('Smart Systems', 'Emma Wilson', 'emma@smartsystems.com', '555-1005', '654 Smart Lane', 'Boston', 'USA', '02101'),
('Future Tech Corp', 'Frank Brown', 'frank@futuretech.com', '555-1006', '987 Future Road', 'Chicago', 'USA', '60601'),
('Cloud Nine Solutions', 'Grace Lee', 'grace@cloudnine.com', '555-1007', '147 Cloud Street', 'Denver', 'USA', '80201'),
('Data Insights LLC', 'Henry Taylor', 'henry@datainsights.com', '555-1008', '258 Data Drive', 'Atlanta', 'USA', '30301'),
('Cyber Security Pro', 'Iris Martinez', 'iris@cybersecpro.com', '555-1009', '369 Security Blvd', 'Miami', 'USA', '33101'),
('Web Wizards Inc', 'Jack Robinson', 'jack@webwizards.com', '555-1010', '741 Web Avenue', 'Portland', 'USA', '97201');

-- ============================================
-- Insert Products
-- ============================================
INSERT INTO products (product_name, description, category, unit_price, stock_quantity, reorder_level) VALUES
('Enterprise Software License', 'Annual enterprise software license', 'Software', 5000.00, 100, 20),
('Cloud Storage - 1TB', '1TB cloud storage subscription (annual)', 'Cloud Services', 1200.00, 500, 50),
('Professional Consulting', 'Professional consulting services (per hour)', 'Services', 150.00, 1000, 100),
('Technical Support Package', 'Premium technical support (annual)', 'Support', 2500.00, 200, 30),
('Training Course - Basic', 'Basic training course for new users', 'Training', 500.00, 150, 25),
('Training Course - Advanced', 'Advanced training course', 'Training', 1000.00, 100, 20),
('API Access - Standard', 'Standard API access (monthly)', 'API', 300.00, 300, 50),
('API Access - Premium', 'Premium API access with higher limits (monthly)', 'API', 800.00, 150, 30),
('Mobile App License', 'Mobile application license (per user)', 'Software', 50.00, 1000, 100),
('Data Analytics Tool', 'Advanced data analytics tool license', 'Software', 3500.00, 75, 15),
('Security Audit Service', 'Comprehensive security audit', 'Services', 5000.00, 50, 10),
('Custom Development', 'Custom software development (per project)', 'Services', 10000.00, 25, 5);

-- ============================================
-- Insert Orders
-- ============================================
INSERT INTO orders (customer_id, order_date, ship_date, status, total_amount) VALUES
(1, '2024-01-15', '2024-01-20', 'Delivered', 7500.00),
(2, '2024-01-20', '2024-01-25', 'Delivered', 15000.00),
(3, '2024-02-01', '2024-02-05', 'Delivered', 3200.00),
(4, '2024-02-10', '2024-02-15', 'Shipped', 8500.00),
(5, '2024-02-15', NULL, 'Processing', 12000.00),
(1, '2024-02-20', NULL, 'Pending', 5000.00),
(6, '2024-03-01', '2024-03-05', 'Delivered', 20000.00),
(7, '2024-03-05', NULL, 'Processing', 6500.00),
(8, '2024-03-10', NULL, 'Pending', 9000.00),
(9, '2024-03-15', NULL, 'Pending', 11500.00);

-- ============================================
-- Insert Order Details
-- ============================================
INSERT INTO order_details (order_id, product_id, quantity, unit_price, discount) VALUES
-- Order 1
(1, 1, 1, 5000.00, 0.00),
(1, 2, 2, 1200.00, 5.00),

-- Order 2
(2, 1, 3, 5000.00, 10.00),

-- Order 3
(3, 2, 2, 1200.00, 0.00),
(3, 7, 3, 300.00, 5.00),

-- Order 4
(4, 4, 2, 2500.00, 0.00),
(4, 5, 6, 500.00, 10.00),

-- Order 5
(5, 1, 2, 5000.00, 5.00),
(5, 3, 10, 150.00, 0.00),

-- Order 6
(6, 1, 1, 5000.00, 0.00),

-- Order 7
(7, 11, 4, 5000.00, 0.00),

-- Order 8
(8, 10, 1, 3500.00, 0.00),
(8, 2, 2, 1200.00, 5.00),
(8, 7, 3, 300.00, 0.00),

-- Order 9
(9, 1, 1, 5000.00, 0.00),
(9, 4, 1, 2500.00, 0.00),
(9, 6, 1, 1000.00, 0.00),

-- Order 10
(10, 12, 1, 10000.00, 0.00),
(10, 3, 10, 150.00, 0.00);

-- ============================================
-- Update order totals
-- ============================================
UPDATE orders o
SET total_amount = (
    SELECT SUM(od.quantity * od.unit_price * (1 - od.discount/100))
    FROM order_details od
    WHERE od.order_id = o.order_id
);

-- ============================================
-- Success Message
-- ============================================
SELECT 'Sample data inserted successfully!' AS message;
SELECT 
    (SELECT COUNT(*) FROM departments) AS departments,
    (SELECT COUNT(*) FROM employees) AS employees,
    (SELECT COUNT(*) FROM projects) AS projects,
    (SELECT COUNT(*) FROM assignments) AS assignments,
    (SELECT COUNT(*) FROM customers) AS customers,
    (SELECT COUNT(*) FROM products) AS products,
    (SELECT COUNT(*) FROM orders) AS orders,
    (SELECT COUNT(*) FROM order_details) AS order_details;
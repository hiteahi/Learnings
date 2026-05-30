-- ============================================
-- X Company Management System
-- Create Views for Common Queries
-- ============================================

-- View: Employee Details with Department
CREATE VIEW vw_employee_details AS
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.email,
    e.job_title,
    e.salary,
    d.department_name,
    d.location,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employees m ON e.manager_id = m.employee_id
WHERE e.is_active = TRUE;

-- View: Project Summary
CREATE VIEW vw_project_summary AS
SELECT 
    p.project_id,
    p.project_name,
    p.status,
    d.department_name,
    COUNT(a.employee_id) AS team_size,
    p.budget,
    p.start_date,
    p.end_date
FROM projects p
LEFT JOIN departments d ON p.department_id = d.department_id
LEFT JOIN assignments a ON p.project_id = a.project_id
GROUP BY p.project_id, p.project_name, p.status, d.department_name, p.budget, p.start_date, p.end_date;

-- View: Order Summary
CREATE VIEW vw_order_summary AS
SELECT 
    o.order_id,
    c.company_name,
    c.contact_name,
    o.order_date,
    o.status,
    COUNT(od.order_detail_id) AS item_count,
    SUM(od.quantity * od.unit_price * (1 - od.discount/100)) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id, c.company_name, c.contact_name, o.order_date, o.status;

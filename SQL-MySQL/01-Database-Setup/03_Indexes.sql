-- ============================================
-- X Company Management System
-- Create Indexes for Performance
-- ============================================
CREATE INDEX idx_employee_department ON employees(department_id);
CREATE INDEX idx_employee_manager ON employees(manager_id);
CREATE INDEX idx_employee_email ON employees(email);
CREATE INDEX idx_project_department ON projects(department_id);
CREATE INDEX idx_assignment_employee ON assignments(employee_id);
CREATE INDEX idx_assignment_project ON assignments(project_id);
CREATE INDEX idx_order_customer ON orders(customer_id);
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_order_detail_order ON order_details(order_id);
CREATE INDEX idx_order_detail_product ON order_details(product_id);

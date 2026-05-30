-- ============================================
-- ANALYTICS QUERIES
-- Business Intelligence & Reporting Examples
-- ============================================

USE X_Company_db;

-- ============================================
-- 1. EMPLOYEE ANALYTICS
-- ============================================

-- 1.1 Employee Demographics Summary
SELECT 
    COUNT(*) as total_employees,
    COUNT(CASE WHEN is_active = TRUE THEN 1 END) as active_employees,
    COUNT(CASE WHEN is_active = FALSE THEN 1 END) as inactive_employees,
    ROUND(AVG(salary), 2) as avg_salary,
    MIN(salary) as min_salary,
    MAX(salary) as max_salary,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, hire_date, CURDATE())), 1) as avg_tenure_years
FROM employees;

-- 1.2 Salary Distribution by Quartile
WITH salary_quartiles AS (
    SELECT 
        employee_id,
        first_name,
        last_name,
        salary,
        NTILE(4) OVER (ORDER BY salary) as salary_quartile
    FROM employees
    WHERE is_active = TRUE
)
SELECT 
    salary_quartile,
    COUNT(*) as employee_count,
    MIN(salary) as min_salary,
    MAX(salary) as max_salary,
    ROUND(AVG(salary), 2) as avg_salary
FROM salary_quartiles
GROUP BY salary_quartile
ORDER BY salary_quartile;

-- 1.3 Top Performers by Department (Top 3 Salaries)
WITH ranked_employees AS (
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.salary,
        d.department_name,
        RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) as salary_rank
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id
    WHERE e.is_active = TRUE
)
SELECT 
    department_name,
    first_name,
    last_name,
    salary,
    salary_rank
FROM ranked_employees
WHERE salary_rank <= 3
ORDER BY department_name, salary_rank;

-- 1.4 Employee Retention Analysis by Hire Year
SELECT 
    YEAR(hire_date) as hire_year,
    COUNT(*) as total_hired,
    SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) as still_active,
    SUM(CASE WHEN is_active = FALSE THEN 1 ELSE 0 END) as left_company,
    ROUND(SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as retention_rate
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year DESC;

-- 1.5 Manager Span of Control
SELECT 
    m.employee_id as manager_id,
    CONCAT(m.first_name, ' ', m.last_name) as manager_name,
    m.job_title as manager_title,
    COUNT(e.employee_id) as direct_reports,
    ROUND(AVG(e.salary), 2) as avg_team_salary,
    MIN(e.salary) as min_team_salary,
    MAX(e.salary) as max_team_salary
FROM employees m
INNER JOIN employees e ON m.employee_id = e.manager_id
WHERE e.is_active = TRUE
GROUP BY m.employee_id, m.first_name, m.last_name, m.job_title
ORDER BY direct_reports DESC;

-- ============================================
-- 2. DEPARTMENT ANALYTICS
-- ============================================

-- 2.1 Department Performance Dashboard
SELECT 
    d.department_name,
    d.location,
    d.budget as allocated_budget,
    COUNT(e.employee_id) as employee_count,
    ROUND(SUM(e.salary), 2) as total_salary_cost,
    ROUND(AVG(e.salary), 2) as avg_salary,
    ROUND(d.budget - SUM(e.salary), 2) as budget_remaining,
    ROUND((SUM(e.salary) / d.budget) * 100, 2) as budget_utilization_pct
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.is_active = TRUE
GROUP BY d.department_id, d.department_name, d.location, d.budget
ORDER BY total_salary_cost DESC;

-- 2.2 Department Growth Trend (Headcount by Quarter)
SELECT 
    d.department_name,
    YEAR(e.hire_date) as year,
    QUARTER(e.hire_date) as quarter,
    COUNT(*) as new_hires,
    SUM(COUNT(*)) OVER (
        PARTITION BY d.department_id 
        ORDER BY YEAR(e.hire_date), QUARTER(e.hire_date)
    ) as cumulative_headcount
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name, YEAR(e.hire_date), QUARTER(e.hire_date)
ORDER BY d.department_name, year, quarter;

-- 2.3 Department Salary Comparison
WITH dept_stats AS (
    SELECT 
        department_id,
        AVG(salary) as dept_avg_salary
    FROM employees
    WHERE is_active = TRUE
    GROUP BY department_id
),
company_avg AS (
    SELECT AVG(salary) as company_avg_salary
    FROM employees
    WHERE is_active = TRUE
)
SELECT 
    d.department_name,
    ROUND(ds.dept_avg_salary, 2) as dept_avg_salary,
    ROUND(ca.company_avg_salary, 2) as company_avg_salary,
    ROUND(ds.dept_avg_salary - ca.company_avg_salary, 2) as diff_from_company_avg,
    ROUND(((ds.dept_avg_salary - ca.company_avg_salary) / ca.company_avg_salary) * 100, 2) as pct_diff
FROM departments d
INNER JOIN dept_stats ds ON d.department_id = ds.department_id
CROSS JOIN company_avg ca
ORDER BY dept_avg_salary DESC;

-- ============================================
-- 3. PROJECT ANALYTICS
-- ============================================

-- 3.1 Project Portfolio Overview
SELECT 
    status,
    COUNT(*) as project_count,
    ROUND(SUM(budget), 2) as total_budget,
    ROUND(AVG(budget), 2) as avg_budget,
    ROUND(AVG(DATEDIFF(COALESCE(end_date, CURDATE()), start_date)), 0) as avg_duration_days
FROM projects
GROUP BY status
ORDER BY 
    CASE status
        WHEN 'Active' THEN 1
        WHEN 'Planning' THEN 2
        WHEN 'On Hold' THEN 3
        WHEN 'Completed' THEN 4
    END;

-- 3.2 Project Resource Allocation
SELECT 
    p.project_name,
    p.status,
    p.budget,
    COUNT(DISTINCT a.employee_id) as team_size,
    SUM(a.hours_worked) as total_hours,
    ROUND(AVG(a.hours_worked), 2) as avg_hours_per_person,
    ROUND(SUM(a.hours_worked) * 50, 2) as estimated_labor_cost  -- Assuming $50/hour
FROM projects p
LEFT JOIN assignments a ON p.project_id = a.project_id
GROUP BY p.project_id, p.project_name, p.status, p.budget
ORDER BY total_hours DESC;

-- 3.3 Employee Project Workload
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.department_name,
    COUNT(DISTINCT a.project_id) as active_projects,
    SUM(a.hours_worked) as total_hours_worked,
    ROUND(AVG(a.hours_worked), 2) as avg_hours_per_project
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN assignments a ON e.employee_id = a.employee_id
INNER JOIN projects p ON a.project_id = p.project_id
WHERE p.status = 'Active' AND e.is_active = TRUE
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name
HAVING COUNT(DISTINCT a.project_id) > 0
ORDER BY active_projects DESC, total_hours_worked DESC;

-- 3.4 Project Timeline Analysis
SELECT 
    project_name,
    start_date,
    end_date,
    status,
    DATEDIFF(COALESCE(end_date, CURDATE()), start_date) as duration_days,
    CASE 
        WHEN end_date IS NULL AND status = 'Active' THEN 'Ongoing'
        WHEN end_date < CURDATE() THEN 'Completed'
        WHEN end_date >= CURDATE() THEN 'Future'
    END as timeline_status,
    CASE 
        WHEN end_date IS NOT NULL AND end_date < CURDATE() AND status != 'Completed' 
        THEN 'Overdue'
        ELSE 'On Track'
    END as delivery_status
FROM projects
ORDER BY start_date DESC;

-- ============================================
-- 4. SALARY ANALYTICS
-- ============================================

-- 4.1 Salary Increase History
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    s.effective_date,
    s.salary_amount,
    LAG(s.salary_amount) OVER (PARTITION BY e.employee_id ORDER BY s.effective_date) as previous_salary,
    s.salary_amount - LAG(s.salary_amount) OVER (PARTITION BY e.employee_id ORDER BY s.effective_date) as salary_increase,
    ROUND(
        ((s.salary_amount - LAG(s.salary_amount) OVER (PARTITION BY e.employee_id ORDER BY s.effective_date)) 
        / LAG(s.salary_amount) OVER (PARTITION BY e.employee_id ORDER BY s.effective_date)) * 100, 
        2
    ) as increase_percentage
FROM employees e
INNER JOIN salaries s ON e.employee_id = s.employee_id
ORDER BY e.employee_id, s.effective_date;

-- 4.2 Average Salary Increase by Department
WITH salary_changes AS (
    SELECT 
        e.department_id,
        s.employee_id,
        s.salary_amount,
        LAG(s.salary_amount) OVER (PARTITION BY s.employee_id ORDER BY s.effective_date) as previous_salary
    FROM salaries s
    INNER JOIN employees e ON s.employee_id = e.employee_id
)
SELECT 
    d.department_name,
    COUNT(DISTINCT sc.employee_id) as employees_with_increases,
    ROUND(AVG(sc.salary_amount - sc.previous_salary), 2) as avg_increase_amount,
    ROUND(AVG(((sc.salary_amount - sc.previous_salary) / sc.previous_salary) * 100), 2) as avg_increase_pct
FROM salary_changes sc
INNER JOIN departments d ON sc.department_id = d.department_id
WHERE sc.previous_salary IS NOT NULL
GROUP BY d.department_id, d.department_name
ORDER BY avg_increase_pct DESC;

-- ============================================
-- 5. ATTENDANCE ANALYTICS
-- ============================================

-- 5.1 Attendance Summary by Employee
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.department_name,
    COUNT(*) as total_records,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) as present_days,
    SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) as absent_days,
    SUM(CASE WHEN a.status = 'Late' THEN 1 ELSE 0 END) as late_days,
    SUM(CASE WHEN a.status = 'Leave' THEN 1 ELSE 0 END) as leave_days,
    ROUND((SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as attendance_rate
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
LEFT JOIN attendance a ON e.employee_id = a.employee_id
WHERE e.is_active = TRUE
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name
HAVING COUNT(*) > 0
ORDER BY attendance_rate DESC;

-- 5.2 Department Attendance Comparison
SELECT 
    d.department_name,
    COUNT(DISTINCT a.employee_id) as employees_tracked,
    COUNT(*) as total_records,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) as present_count,
    SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) as absent_count,
    ROUND((SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as dept_attendance_rate
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
LEFT JOIN attendance a ON e.employee_id = a.employee_id
WHERE e.is_active = TRUE
GROUP BY d.department_id, d.department_name
ORDER BY dept_attendance_rate DESC;

-- 5.3 Monthly Attendance Trends
SELECT 
    YEAR(date) as year,
    MONTH(date) as month,
    DATE_FORMAT(date, '%Y-%m') as year_month,
    COUNT(DISTINCT employee_id) as employees_tracked,
    COUNT(*) as total_records,
    SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) as present_count,
    SUM(CASE WHEN status = 'Absent' THEN 1 ELSE 0 END) as absent_count,
    ROUND((SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as attendance_rate
FROM attendance
GROUP BY YEAR(date), MONTH(date), DATE_FORMAT(date, '%Y-%m')
ORDER BY year DESC, month DESC;

-- ============================================
-- 6. CROSS-FUNCTIONAL ANALYTICS
-- ============================================

-- 6.1 Employee Value Score (Composite Metric)
WITH employee_metrics AS (
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.salary,
        TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) as tenure_years,
        COUNT(DISTINCT a.project_id) as project_count,
        COALESCE(SUM(a.hours_worked), 0) as total_hours,
        COALESCE(att.attendance_rate, 0) as attendance_rate
    FROM employees e
    LEFT JOIN assignments a ON e.employee_id = a.employee_id
    LEFT JOIN (
        SELECT 
            employee_id,
            ROUND((SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as attendance_rate
        FROM attendance
        GROUP BY employee_id
    ) att ON e.employee_id = att.employee_id
    WHERE e.is_active = TRUE
    GROUP BY e.employee_id, e.first_name, e.last_name, e.salary, e.hire_date, att.attendance_rate
)
SELECT 
    employee_id,
    CONCAT(first_name, ' ', last_name) as employee_name,
    salary,
    tenure_years,
    project_count,
    total_hours,
    attendance_rate,
    -- Composite score: weighted average of normalized metrics
    ROUND(
        (tenure_years * 0.2) + 
        (project_count * 0.3) + 
        ((total_hours / 100) * 0.3) + 
        ((attendance_rate / 100) * 0.2),
        2
    ) as value_score
FROM employee_metrics
ORDER BY value_score DESC
LIMIT 20;

-- 6.2 Department ROI Analysis
SELECT 
    d.department_name,
    d.budget as allocated_budget,
    COUNT(DISTINCT e.employee_id) as employee_count,
    SUM(e.salary) as total_salary_cost,
    COUNT(DISTINCT p.project_id) as projects_involved,
    SUM(p.budget) as total_project_budget,
    ROUND(SUM(p.budget) / SUM(e.salary), 2) as project_to_salary_ratio,
    ROUND((SUM(p.budget) - SUM(e.salary)) / SUM(e.salary) * 100, 2) as roi_percentage
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.is_active = TRUE
LEFT JOIN assignments a ON e.employee_id = a.employee_id
LEFT JOIN projects p ON a.project_id = p.project_id
GROUP BY d.department_id, d.department_name, d.budget
HAVING employee_count > 0
ORDER BY roi_percentage DESC;

-- ============================================
-- 7. PREDICTIVE ANALYTICS
-- ============================================

-- 7.1 Attrition Risk Indicators
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    d.department_name,
    TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) as tenure_years,
    e.salary,
    COUNT(DISTINCT a.project_id) as recent_projects,
    COALESCE(att.recent_absences, 0) as recent_absences,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) < 2 THEN 'High Risk'
        WHEN COALESCE(att.recent_absences, 0) > 5 THEN 'High Risk'
        WHEN COUNT(DISTINCT a.project_id) = 0 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END as attrition_risk
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
LEFT JOIN assignments a ON e.employee_id = a.employee_id 
    AND a.start_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
LEFT JOIN (
    SELECT 
        employee_id,
        COUNT(*) as recent_absences
    FROM attendance
    WHERE status = 'Absent' 
        AND date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    GROUP BY employee_id
) att ON e.employee_id = att.employee_id
WHERE e.is_active = TRUE
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name, e.hire_date, e.salary, att.recent_absences
ORDER BY 
    CASE attrition_risk
        WHEN 'High Risk' THEN 1
        WHEN 'Medium Risk' THEN 2
        WHEN 'Low Risk' THEN 3
    END,
    tenure_years;

-- ============================================
-- END OF ANALYTICS QUERIES
-- ============================================
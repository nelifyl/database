SELECT e.emp_name AS guard, r.room_name
FROM employees e
CROSS JOIN rooms r
WHERE e.dept_id = 105;

SELECT COUNT(*) AS checks_per_night
FROM employees e
CROSS JOIN rooms r
WHERE e.dept_id = 105;

SELECT d.dept_id, d.dept_name,
       p.project_id, p.project_name, p.budget
FROM departments d
FULL JOIN projects p ON d.dept_id = p.dept_id
WHERE d.dept_id IS NULL   
   OR p.project_id IS NULL;

SELECT e.emp_name, a.entered_at
FROM access_log a
INNER JOIN employees e ON a.badge_id = e.badge_id
INNER JOIN rooms r     ON a.room_id  = r.room_id
WHERE r.room_name = 'Server Room'
  AND a.entered_at >= '2026-10-14 22:00:00'
  AND a.entered_at <  '2026-10-15 00:00:00';


SELECT e.emp_name, d.dept_name 
FROM employees e 
LEFT JOIN departments d 
ON e.dept_id = d.dept_id
WHERE d.dept_id is NULL;



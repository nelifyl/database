-- Part A: Database and Table Setup

-- 1. Create database and tables

CREATE DATABASE "advanced Lab";

CREATE TABLE IF NOT EXISTS employes (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);


CREATE TABLE IF NOT EXISTS departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50),
    budget INT,
    manager_id INT
);


CREATE TABLE IF NOT EXISTS projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT,
    start_date DATE,
    end_date DATE,
    budget INT
);



-- Part B: Advanced INSERT Operations


-- 2. INSERT with column specification
INSERT INTO employes (emp_id, first_name, last_name, department)
VALUES (1, 'Aibar', 'Kassym', 'IT');

-- 3. INSERT with DEFAULT values
INSERT INTO employes (first_name, last_name, department, salary, status)
VALUES ('Dana', 'Erzhan', 'HR', DEFAULT, DEFAULT);

-- 4. INSERT multiple rows in single statement
INSERT INTO departments (dept_name, budget, manager_id)
VALUES 
    ('IT', 120000, 1),
    ('HR', 50000, 2),
    ('Sales', 80000, 3);

-- 5. INSERT with expressions
INSERT INTO employes (first_name, last_name, department, salary, hire_date)
VALUES ('Ali', 'Kasymov', 'IT', 50000 * 1.1, CURRENT_DATE);

-- 6. INSERT from SELECT (subquery)
CREATE TEMP TABLE temp_employees AS 
SELECT * FROM employes WHERE 1=0;

INSERT INTO temp_employees
SELECT * FROM employes
WHERE department = 'IT';



-- Part C: Complex UPDATE Operations


-- 7. UPDATE with arithmetic expressions
UPDATE employes 
SET salary = salary * 1.10;

-- 8. UPDATE with WHERE clause and multiple conditions
UPDATE employes 
SET status = 'Senior' 
WHERE salary > 60000 
  AND hire_date < '2020-01-01';

-- 9. UPDATE using CASE expression
UPDATE employes 
SET department = CASE 
    WHEN salary > 80000 THEN 'Management'
    WHEN salary BETWEEN 50000 AND 80000 THEN 'Senior'
    ELSE 'Junior'
END;

-- 10. UPDATE with DEFAULT
UPDATE employes 
SET department = DEFAULT 
WHERE status = 'Inactive';

-- 11. UPDATE with subquery
UPDATE departments d 
SET budget = (
    SELECT AVG(salary) * 1.20 
    FROM employes e 
    WHERE e.department = d.dept_name
)
WHERE EXISTS (
    SELECT 1 
    FROM employes e 
    WHERE e.department = d.dept_name
);

-- 12. UPDATE multiple columns
UPDATE employes 
SET salary = salary * 1.15, 
    status = 'Promoted' 
WHERE department = 'Sales';



-- Part D: Advanced DELETE Operations


-- 13. DELETE with simple WHERE condition
DELETE FROM employes 
WHERE status = 'Terminated';

-- 14. DELETE with complex WHERE clause
DELETE FROM employes 
WHERE salary < 40000 
  AND hire_date > '2023-01-01' 
  AND department IS NULL;

-- 15. DELETE with subquery
DELETE FROM departments 
WHERE dept_id NOT IN (
    SELECT DISTINCT dept_id 
    FROM employes 
    WHERE dept_id IS NOT NULL
);

-- 16. DELETE with RETURNING clause
DELETE FROM projects 
WHERE end_date < '2023-01-01' 
RETURNING *;



-- Part E: Operations with NULL Values


-- 17. INSERT with NULL values
INSERT INTO employes (first_name, last_name, department, salary, hire_date)
VALUES ('John', 'Doe', NULL, NULL, CURRENT_DATE);

-- 18. UPDATE NULL handling
UPDATE employes 
SET department = 'Unassigned' 
WHERE department IS NULL;

-- 19. DELETE with NULL conditions
DELETE FROM employes 
WHERE salary IS NULL 
   OR department IS NULL;



-- Part F: RETURNING Clause Operations


-- 20. INSERT with RETURNING
INSERT INTO employes (first_name, last_name, department, salary, hire_date)
VALUES ('Elena', 'Smit', 'IT', 65000, CURRENT_DATE)
RETURNING emp_id, first_name || ' ' || last_name AS full_name;

-- 21. UPDATE with RETURNING
UPDATE employes
SET salary = salary + 5000
WHERE department = 'IT'
RETURNING emp_id, salary - 5000 AS old_salary, salary AS new_salary;

-- 22. DELETE with RETURNING all columns
DELETE FROM employes
WHERE hire_date < '2020-01-01'
RETURNING *;



-- Part G: Advanced DML Patterns


-- 23. Conditional INSERT
INSERT INTO employes (first_name, last_name, department, salary, hire_date)
SELECT 'Arman', 'Saparov', 'IT', 70000, CURRENT_DATE
WHERE NOT EXISTS (
    SELECT 1 
    FROM employes 
    WHERE first_name = 'Arman' AND last_name = 'Saparov'
);

-- 24. UPDATE with JOIN logic using subqueries
UPDATE employes e
SET salary = CASE 
    WHEN (
        SELECT budget 
        FROM departments d 
        WHERE d.dept_name = e.department
    ) > 100000 THEN salary * 1.10
    ELSE salary * 1.05
END
WHERE department IS NOT NULL;

-- 25. Bulk operations
INSERT INTO employes (first_name, last_name, department, salary, hire_date)
VALUES 
    ('Aibar', 'Kassym', 'Sales', 45000, CURRENT_DATE),
    ('Dana', 'Erzhan', 'HR', 48000, CURRENT_DATE),
    ('Timur', 'Ospanov', 'IT', 60000, CURRENT_DATE),
    ('Madina', 'Alimova', 'Marketing', 52000, CURRENT_DATE),
    ('Kairat', 'Nurtas', 'Sales', 40000, CURRENT_DATE);

UPDATE employes
SET salary = salary * 1.10
WHERE last_name IN ('Kassym', 'Erzhan', 'Ospanov', 'Alimova', 'Nurtas');

-- 26. Data migration simulation
CREATE TABLE IF NOT EXISTS employee_archive (LIKE employes INCLUDING ALL);

INSERT INTO employee_archive
SELECT * FROM employes
WHERE status = 'Inactive';

DELETE FROM employes
WHERE status = 'Inactive';

-- 27. Complex business logic
UPDATE projects p
SET end_date = end_date + INTERVAL '30 days'
WHERE budget > 50000
  AND dept_id IN (
      SELECT d.dept_id
      FROM departments d
      JOIN employes e ON e.department = d.dept_name
      GROUP BY d.dept_id
      HAVING COUNT(e.emp_id) > 3
  );
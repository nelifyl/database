-- =====================================================================
--  Lab 6 game: "The 200,000 Heist"  (SQL JOINs)  -  VARIANT C
--  Database setup script for PostgreSQL.
--  Run once before class:  psql -d <your_db> -f heist_setup.sql
--  Safe to re-run: it drops and recreates all tables.
-- =====================================================================

DROP TABLE IF EXISTS transfers, access_log, rooms, projects, employees, departments CASCADE;

CREATE TABLE departments (
    dept_id   INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location  VARCHAR(50)
);

CREATE TABLE employees (
    emp_id     INT PRIMARY KEY,
    emp_name   VARCHAR(50),
    dept_id    INT,            -- no foreign key on purpose (old HR system)
    salary     DECIMAL(10, 2),
    manager_id INT,
    badge_id   VARCHAR(10)
);

CREATE TABLE projects (
    project_id   INT PRIMARY KEY,
    project_name VARCHAR(50),
    dept_id      INT,
    budget       DECIMAL(10, 2)
);

CREATE TABLE rooms (
    room_id   INT PRIMARY KEY,
    room_name VARCHAR(50),
    location  VARCHAR(50),
    dept_id   INT              -- department that owns the room
);

CREATE TABLE access_log (
    log_id     INT PRIMARY KEY,
    badge_id   VARCHAR(10),
    room_id    INT,
    entered_at TIMESTAMP
);

CREATE TABLE transfers (
    transfer_id INT PRIMARY KEY,
    project_id  INT,
    amount      DECIMAL(10, 2),
    made_at     TIMESTAMP,
    approved_by INT            -- emp_id of the approver
);

INSERT INTO departments (dept_id, dept_name, location) VALUES
(101, 'IT',        'Building A'),
(102, 'HR',        'Building B'),
(103, 'Finance',   'Building C'),
(104, 'Marketing', 'Building D'),
(105, 'Security',  'Building A');

INSERT INTO employees (emp_id, emp_name, dept_id, salary, manager_id, badge_id) VALUES
(1,  'Tom Brown',       101,  50000, 3,    'B-01'),
(2,  'Kate Lee',         102,  60000, 3,    'B-02'),
(3,  'Olivia King',     101,  55000, NULL, 'B-03'),
(4,  'Mike Johnson',   103,  65000, 3,    'B-04'),
(5,  'Arman Bekov',        NULL, 45000, 3,    'B-05'),
(6,  'Sarah Williams', 105,  40000, 8,    'B-06'),
(7,  'Ruslan Akhmetov',       103,  58000, 4,    'B-07'),
(8,  'Jane Doe',  105,  52000, 3,    'B-08'),
(9,  'John Smith',      101,  47000, 3,    'B-09'),
(10, 'Emma Clark',      106,  43000, 9,    'B-10'),
(11, 'Daniyar Seitkali',         106,  41000, 9,    'B-11');

INSERT INTO projects (project_id, project_name, dept_id, budget) VALUES
(1, 'Website Redesign',  101, 100000),
(2, 'Employee Training', 102,  50000),
(3, 'Budget Analysis',   103,  75000),
(4, 'Cloud Migration',   101, 150000),
(5, 'Data Lake',       NULL, 200000);

INSERT INTO rooms (room_id, room_name, location, dept_id) VALUES
(1, 'Server Room',    'Basement',   101),
(2, 'IT Office',      'Building A', 101),
(3, 'HR Office',      'Building B', 102),
(4, 'Finance Office', 'Building C', 103),
(5, 'Vault',          'Building C', 103),
(6, 'Security Desk',  'Building A', 105),
(7, 'Meeting Room', 'Building B', 102),
(8, 'Archive', 'Building C', 103);

INSERT INTO access_log (log_id, badge_id, room_id, entered_at) VALUES
-- 13 October
(1,  'B-02', 3, '2026-10-13 09:15'),
(2,  'B-04', 5, '2026-10-13 16:00'),
(3,  'B-09', 1, '2026-10-13 22:30'),
-- 14 October, daytime
(4,  'B-01', 2, '2026-10-14 09:00'),
(5,  'B-04', 4, '2026-10-14 10:00'),
(6,  'B-08', 6, '2026-10-14 20:00'),
(7,  'B-01', 1, '2026-10-14 21:30'),
-- 14 October, the night of the heist
(8,  'B-03', 1, '2026-10-14 22:10'),
(9,  'B-07', 1, '2026-10-14 22:45'),
(10, 'B-05', 1, '2026-10-14 23:05'),
(11, 'B-10', 1, '2026-10-14 23:30'),
(12, 'B-06', 1, '2026-10-14 23:55'),
-- 15 October
(13, 'B-06', 6, '2026-10-15 07:00'),
(14, 'B-11', 2, '2026-10-15 08:40');

INSERT INTO transfers (transfer_id, project_id, amount, made_at, approved_by) VALUES
(1, 1,  20000, '2026-10-02 11:00', 3),
(2, 3,  15000, '2026-10-08 15:30', 4),
(3, 4,  30000, '2026-10-12 10:20', 3),
(4, 5, 200000, '2026-10-14 23:41', 9);



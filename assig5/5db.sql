--1.1
CREATE TABLE employees (
    employee_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    age INTEGER CHECK (age BETWEEN 18 AND 65),
    salary NUMERIC CHECK (salary > 0)
);

--1.2
CREATE TABLE products_catalog (
    product_id INTEGER,
    product_name TEXT,
    regular_price NUMERIC,
    discount_price NUMERIC,
    CONSTRAINT valid_discount CHECK (
        regular_price > 0
        AND discount_price > 0
        AND discount_price < regular_price
    )
);

--1.3
CREATE TABLE bookings (
    booking_id INTEGER,
    check_in_date DATE,
    check_out_date DATE,
    num_guests INTEGER,
    CHECK (num_guests BETWEEN 1 AND 10),
    CHECK (check_out_date > check_in_date)
);

--1.4 valid data
INSERT INTO employees VALUES
(1, 'John', 'Smith', 25, 300000),
(2, 'Anna', 'Brown', 40, 450000);

INSERT INTO products_catalog VALUES
(1, 'Laptop', 500000, 450000),
(2, 'Phone', 300000, 270000);

INSERT INTO bookings VALUES
(1, '2026-10-15', '2026-10-18', 2),
(2, '2026-11-01', '2026-11-05', 5);

--invalid data

-- INSERT INTO employees VALUES
-- (3, 'Mike', 'Green', 16, 200000);

-- INSERT INTO employees VALUES
-- (4, 'David', 'White', 70, 250000);

-- INSERT INTO employees VALUES
-- (5, 'Kate', 'Black', 30, 0);

-- INSERT INTO employees VALUES
-- (6, 'Tom', 'Gray', 35, -1000);

-- INSERT INTO products_catalog VALUES
-- (3, 'Tablet', 0, 100);

-- INSERT INTO products_catalog VALUES
-- (4, 'Monitor', 100000, 0);

-- INSERT INTO products_catalog VALUES
-- (5, 'Keyboard', 10000, 12000);

-- INSERT INTO products_catalog VALUES
-- (6, 'Mouse', 5000, 5000);

-- INSERT INTO bookings VALUES
-- (3, '2026-10-20', '2026-10-22', 0);

-- INSERT INTO bookings VALUES
-- (4, '2026-10-20', '2026-10-22', 11);

-- INSERT INTO bookings VALUES
-- (5, '2026-10-25', '2026-10-22', 3);

-- INSERT INTO bookings VALUES
-- (6, '2026-10-25', '2026-10-25', 2);

--2.1
CREATE TABLE customers (
    customer_id INTEGER NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    registration_date DATE NOT NULL
);

--2.2
CREATE TABLE inventory (
    item_id INTEGER NOT NULL,
    item_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    unit_price NUMERIC NOT NULL CHECK (unit_price > 0),
    last_updated TIMESTAMP NOT NULL
);

--2.3
INSERT INTO customers VALUES
(1, 'john@example.com', '+77011234567', '2026-10-10'),
(2, 'anna@example.com', '+77017654321', '2026-10-11');

INSERT INTO inventory VALUES
(1, 'Laptop', 10, 350000, '2026-10-13 10:00:00'),
(2, 'Mouse', 25, 5000, '2026-10-13 11:30:00');

--null to not null 

-- INSERT INTO customers VALUES
-- (NULL, 'test@example.com', '+77011234567', '2026-10-12');

-- INSERT INTO customers VALUES
-- (3, NULL, '+77011234567', '2026-10-12');

-- INSERT INTO customers VALUES
-- (4, 'test@example.com', '+77011234567', NULL);

-- INSERT INTO inventory VALUES
-- (NULL, 'Keyboard', 10, 15000, '2026-10-13 12:00:00');

-- INSERT INTO inventory VALUES
-- (3, NULL, 10, 15000, '2026-10-13 12:00:00');

-- INSERT INTO inventory VALUES
-- (4, 'Monitor', NULL, 100000, '2026-10-13 12:00:00');

-- INSERT INTO inventory VALUES
-- (5, 'Headphones', 5, NULL, '2026-10-13 12:00:00');

-- INSERT INTO inventory VALUES
-- (6, 'Webcam', 8, 20000, NULL);

-- INSERT INTO customers VALUES
-- (5, 'alex@example.com', NULL, '2026-10-13');

-- INSERT INTO customers VALUES
-- (6, 'maria@example.com', NULL, '2026-10-13');

--3.1
CREATE TABLE users (
    user_id INTEGER,
    username TEXT UNIQUE,
    email TEXT UNIQUE,
    created_at TIMESTAMP
);

--3.2
CREATE TABLE course_enrollments (
    enrollment_id INTEGER,
    student_id INTEGER,
    course_code TEXT,
    semester TEXT,
    UNIQUE (student_id, course_code, semester)
);

--3.3
ALTER TABLE users
ADD CONSTRAINT unique_username UNIQUE (username);

ALTER TABLE users
ADD CONSTRAINT unique_email UNIQUE (email);

--unique 
INSERT INTO users VALUES
(1, 'duman', 'duman@example.com', '2026-10-13 10:00:00'),
(2, 'alex', 'alex@example.com', '2026-10-13 11:00:00');

--not unique
-- INSERT INTO users VALUES
-- (4, 'newuser', 'duman@example.com', '2026-10-13 13:00:00');


--4.1
CREATE TABLE departments (
    dept_id INTEGER PRIMARY KEY,
    dept_name TEXT NOT NULL,
    location TEXT
);

INSERT INTO departments VALUES
(1, 'IT', 'Almaty'),
(2, 'Finance', 'Astana'),
(3, 'Marketing', 'Shymkent');

-- INSERT INTO departments VALUES
-- (1, 'HR', 'Almaty');

-- INSERT INTO departments VALUES
-- (NULL, 'Sales', 'Astana');


--4.2
CREATE TABLE student_courses (
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE,
    grade TEXT,
    PRIMARY KEY (student_id, course_id)
);

--4.3
-- PRIMARY KEY vs. UNIQUE:
--   PRIMARY KEY: Uniquely identifies a row, cannot be NULL, only one allowed per table.
--   UNIQUE: Guarantees distinct values, allows NULL, multiple allowed per table.
-- Single-Column vs. Composite PRIMARY KEY:
--   Single-Column: Use in most cases (e.g., auto-increment ID, UUID) — simpler foreign keys and cleaner JOINs.
--   Composite: Use when uniqueness requires a combination of columns (e.g., many-to-many junction tables: student_id + course_id).
-- Why only one PRIMARY KEY but multiple UNIQUE constraints?
--   A table has only one primary identity (which often dictates the physical order of data storage on disk).
--   Secondary unique fields (like email or username) are protected using additional UNIQUE constraints.


--5.1
CREATE TABLE employees_dept (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT NOT NULL,
    dept_id INTEGER REFERENCES departments(dept_id),
    hire_date DATE
);

INSERT INTO employees_dept VALUES
(1, 'John Smith', 1, '2026-01-15'),
(2, 'Anna Brown', 2, '2026-02-10'),
(3, 'Mike Wilson', 3, '2026-03-05');

-- INSERT INTO employees_dept VALUES
-- (4, 'David Green', 99, '2026-04-01');

--5.2
CREATE TABLE authors (
    author_id INTEGER PRIMARY KEY,
    author_name TEXT NOT NULL,
    country TEXT
);

CREATE TABLE publishers (
    publisher_id INTEGER PRIMARY KEY,
    publisher_name TEXT NOT NULL,
    city TEXT
);

CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    author_id INTEGER REFERENCES authors(author_id),
    publisher_id INTEGER REFERENCES publishers(publisher_id),
    publication_year INTEGER,
    isbn TEXT UNIQUE
);

INSERT INTO authors VALUES
(1, 'George Orwell', 'United Kingdom'),
(2, 'J.K. Rowling', 'United Kingdom'),
(3, 'Abai Qunanbaiuly', 'Kazakhstan');

INSERT INTO publishers VALUES
(1, 'Penguin Books', 'London'),
(2, 'Bloomsbury', 'London'),
(3, 'Kazakh Press', 'Almaty');

INSERT INTO books VALUES
(1, '1984', 1, 1, 1949, '9780451524935'),
(2, 'Harry Potter', 2, 2, 1997, '9780747532699'),
(3, 'Words of Edification', 3, 3, 1890, '9786010000001');

-- Task 5.3
CREATE TABLE categories(
    category_id INTEGER PRIMARY KEY,
    category_name TEXT NOT NULL
);

CREATE TABLE products_fk(
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category_id INTEGER REFERENCES categories ON DELETE RESTRICT
);

CREATE TABLE orders(
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL
);

CREATE TABLE order_items(
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER REFERENCES orders ON DELETE CASCADE,
    product_id INTEGER REFERENCES products_fk,
    quantity INTEGER CHECK(quantity > 0)
);

INSERT INTO categories VALUES
(1, 'Electronics'), 
(2, 'Books');
INSERT INTO products_fk VALUES
(1, 'Laptop', 1), 
(2, 'Novel', 2);
INSERT INTO orders VALUES
(1, '2026-10-01'), 
(2, '2026-10-02');
INSERT INTO order_items VALUES
(1, 1, 1, 2), 
(2, 1, 2, 1), 
(3, 2, 1, 5);

-- Scenario 1: delete a category that has products (RESTRICT)
-- DELETE FROM categories WHERE category_id = 1;
-- Result: ERROR: update or delete on table "categories" violates foreign key constraint
--         "products_fk_category_id_fkey" on table "products_fk" (deletion blocked by RESTRICT)

-- Scenario 2: delete an order (CASCADE)
DELETE FROM orders WHERE order_id = 1;
-- Result: DELETE 1; order_items rows 1 and 2 were deleted automatically (only item 3 remains)
SELECT * FROM order_items;
-- Result: 1 row -> (3, 2, 1, 5)

-- Scenario 3: delete a product used in order_items (no ON DELETE = NO ACTION)
-- DELETE FROM products_fk WHERE product_id = 1;
-- Result: ERROR: violates foreign key constraint "order_items_product_id_fkey" (item 3 still references it)



-- Task 6.1
-- A separate schema is used because customers and orders already exist above.
CREATE SCHEMA ecommerce;
SET search_path TO ecommerce;

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE products(
    product_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL CHECK(price >= 0),
    stock_quantity INTEGER NOT NULL DEFAULT 0 CHECK(stock_quantity >= 0)
);

CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers ON DELETE RESTRICT,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    total_amount NUMERIC(12,2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
    status TEXT NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled'))
);

CREATE TABLE order_details(
    order_detail_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products ON DELETE RESTRICT,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

-- Sample data (5+ records per table)
INSERT INTO customers(name, email, phone, registration_date) VALUES
    ('Aigerim N.', 'aigerim@mail.com', '+77011111111', '2026-01-05'),
    ('Daniyar S.', 'daniyar@mail.com', '+77022222222', '2026-02-10'),
    ('Madina K.', 'madina@mail.com', NULL,'2026-03-15'),
    ('Timur B.', 'timur@mail.com', '+77044444444', '2026-04-20'),
    ('Aliya T.', 'aliya@mail.com', '+77055555555','2026-05-25');

INSERT INTO products(name, description, price, stock_quantity) VALUES
    ('Laptop','15-inch laptop',1200.00, 10),
    ('Phone','Smartphone',800.00, 25),
    ('Headphones', 'Wireless',150.00, 50),
    ('Keyboard','Mechanical',90.00, 40),
    ('Mouse','Optical mouse',30.00, 100);

INSERT INTO orders(customer_id, order_date, total_amount, status) VALUES
    (1, '2026-09-01', 1350.00, 'delivered'),
    (2, '2026-09-05', 800.00, 'shipped'),
    (3, '2026-09-10', 240.00, 'processing'),
    (4, '2026-09-15', 30.00, 'pending'),
    (5, '2026-09-20',150.00, 'cancelled');

INSERT INTO order_details(order_id, product_id, quantity, unit_price) VALUES
    (1, 1, 1, 1200.00),
    (1, 3, 1,150.00),
    (2, 2, 1, 800.00),
    (3, 4, 1, 90.00),
    (3, 3, 1, 150.00),
    (4, 5, 1, 30.00),
    (5, 3, 1,150.00);

-- Test queries (failed attempts commented out)
-- INSERT INTO customers (name, email) VALUES ('Dup', 'aigerim@mail.com');
-- Result: ERROR: duplicate key value violates unique constraint "customers_email_key"
-- INSERT INTO customers (name, email) VALUES (NULL, 'x@mail.com');
-- Result: ERROR: null value in column "name" violates not-null constraint
-- INSERT INTO products (name, price, stock_quantity) VALUES ('Bad', -5, 10);
-- Result: ERROR: violates check constraint "products_price_check"
-- INSERT INTO products (name, price, stock_quantity) VALUES ('Bad', 5, -1);
-- Result: ERROR: violates check constraint "products_stock_quantity_check"
-- INSERT INTO orders (customer_id, status) VALUES (1, 'lost');
-- Result: ERROR: violates check constraint "orders_status_check"
-- INSERT INTO orders (customer_id) VALUES (999);
-- Result: ERROR: violates foreign key constraint "orders_customer_id_fkey"
-- INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (1, 1, 0, 10);
-- Result: ERROR: violates check constraint "order_details_quantity_check"
-- DELETE FROM customers WHERE customer_id = 1;
-- Result: ERROR: violates foreign key constraint "orders_customer_id_fkey" (RESTRICT, customer has orders)
-- DELETE FROM products WHERE product_id = 1;
-- Result: ERROR: violates foreign key constraint "order_details_product_id_fkey" (RESTRICT, product is ordered)

-- ON DELETE CASCADE: deleting an order removes its details
DELETE FROM orders WHERE order_id = 5;
-- Result: DELETE 1; its order_details row was deleted automatically
SELECT COUNT(*) FROM order_details WHERE order_id = 5;
-- Result: 0

RESET search_path;
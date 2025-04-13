CREATE TABLE author (
author_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR (50),
bio TEXT
);
	
CREATE TABLE book (
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(100),
isbn VARCHAR(20),
publication_year YEAR,
publisher_id INT,
language_id INT,
price DECIMAL(8,2),
stock_quantity INT
);

CREATE TABLE book_author (
book_id INT,
author_id INT,
PRIMARY KEY (book_id, author_id),
FOREIGN KEY (book_id) REFERENCES book(book_id),
FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE book_language (
language_id INT AUTO_INCREMENT PRIMARY KEY,
language_name VARCHAR(50) NOT NULL
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL
);

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    status_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(6,2)
);

CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status_id INT,
    method_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id),
    FOREIGN KEY (method_id) REFERENCES shipping_method(method_id)
);

CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    updated_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);


-- Insert data into address_status
INSERT INTO address_status (status_name) VALUES 
('Active'), ('Inactive'), ('Primary'), ('Secondary');

-- Insert data into country
INSERT INTO country (country_name) VALUES 
('United States'), ('United Kingdom'), ('Canada'), ('Australia'), ('Germany');

-- Insert data into address
INSERT INTO address (street, city, postal_code, country_id, status_id) VALUES
('123 Main St', 'New York', '10001', 1, 1),
('456 Oak Ave', 'Chicago', '60601', 1, 3),
('789 Pine Rd', 'Los Angeles', '90001', 1, 1),
('10 Downing St', 'London', 'SW1A 2AA', 2, 3),
('20 Queen St', 'Toronto', 'M5H 2N8', 3, 1);

-- Insert data into customer
INSERT INTO customer (first_name, last_name, email) VALUES
('John', 'Smith', 'john.smith@email.com'),
('Emily', 'Johnson', 'emily.j@email.com'),
('Michael', 'Williams', 'michael.w@email.com'),
('Sarah', 'Brown', 'sarah.b@email.com');

-- Insert data into customer_address
INSERT INTO customer_address (customer_id, address_id) VALUES
(1, 1), (1, 2), (2, 3), (3, 4), (4, 5);

-- Insert data into order_status
INSERT INTO order_status (status_name) VALUES
('Processing'), ('Shipped'), ('Delivered'), ('Cancelled'), ('Returned');

-- Insert data into shipping_method
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard Shipping', 4.99),
('Express Shipping', 9.99),
('Overnight Shipping', 19.99);

-- Insert data into publisher
INSERT INTO publisher (publisher_name) VALUES
('Bloomsbury'), ('Penguin Books'), ('HarperCollins'), ('Doubleday');

-- Insert data into book_language
INSERT INTO book_language (language_name) VALUES
('English'), ('Spanish'), ('French'), ('German'), ('Japanese');

-- Insert data into author
INSERT INTO author (first_name, last_name, bio) VALUES
('J.K.', 'Rowling', 'British author best known for the Harry Potter series'),
('George', 'Orwell', 'English novelist known for dystopian works'),
('Agatha', 'Christie', 'English writer known for detective novels'),
('Stephen', 'King', 'American author of horror and supernatural fiction'),
('Haruki', 'Murakami', 'Japanese writer known for surrealistic fiction');

-- Insert data into book
INSERT INTO book (title, isbn, publication_year, publisher_id, language_id, price, stock_quantity) VALUES
('Harry Potter and the Philosopher''s Stone', '9780747532743', 1997, 1, 1, 10.99, 50),
('1984', '9780451524935', 1949, 2, 1, 7.99, 100),
('Murder on the Orient Express', '9780007119318', 1934, 3, 1, 8.99, 75),
('The Shining', '9780307743657', 1977, 4, 1, 12.99, 60),
('Norwegian Wood', '9780099448822', 1987, 2, 5, 9.99, 40);

-- Insert data into book_author
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert data into cust_order
INSERT INTO cust_order (customer_id, order_date, status_id, method_id) VALUES
(1, '2023-01-15', 3, 1),
(2, '2023-02-20', 3, 2),
(3, '2023-03-10', 2, 1),
(4, '2023-04-05', 1, 3),
(1, '2023-05-12', 2, 2);

-- Insert data into order_line
INSERT INTO order_line (order_id, book_id, quantity) VALUES
(1, 1, 1), (1, 2, 1), (1, 3, 1),
(2, 2, 2),
(3, 4, 1), (3, 5, 1),
(4, 1, 3),
(5, 5, 1);

-- Insert data into order_history
INSERT INTO order_history (order_id, status_id, updated_at) VALUES
(1, 1, '2023-01-15 10:30:00'),
(1, 2, '2023-01-16 09:15:00'),
(1, 3, '2023-01-20 14:00:00'),
(2, 1, '2023-02-20 11:45:00'),
(2, 2, '2023-02-21 08:30:00'),
(2, 3, '2023-02-22 16:20:00'),
(3, 1, '2023-03-10 13:20:00'),
(3, 2, '2023-03-11 10:10:00'),
(4, 1, '2023-04-05 15:30:00'),
(5, 1, '2023-05-12 09:45:00'),
(5, 2, '2023-05-13 11:30:00');


-- Check for books without authors
SELECT b.book_id, b.title
FROM book b
LEFT JOIN book_author ba ON b.book_id = ba.book_id
WHERE ba.author_id IS NULL;

-- Check for orders without order lines
SELECT o.order_id
FROM cust_order o
LEFT JOIN order_line ol ON o.order_id = ol.order_id
WHERE ol.book_id IS NULL;

-- Check for customers without addresses
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN customer_address ca ON c.customer_id = ca.customer_id
WHERE ca.address_id IS NULL;

-- retrieve all books withtheir authors,publishers and languages

SELECT 
    b.book_id,
    b.title,
    b.isbn,
    CONCAT(a.first_name, ' ', a.last_name) AS author,
    p.publisher_name,
    bl.language_name,
    b.publication_year,
    b.price,
    b.stock_quantity
FROM 
    book b
JOIN 
    book_author ba ON b.book_id = ba.book_id
JOIN 
    author a ON ba.author_id = a.author_id
JOIN 
    publisher p ON b.publisher_id = p.publisher_id
JOIN 
    book_language bl ON b.language_id = bl.language_id
ORDER BY 
    b.title;
    
    
-- retrieve customers order history

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_id,
    o.order_date,
    os.status_name AS order_status,
    sm.method_name AS shipping_method,
    sm.cost AS shipping_cost,
    b.title AS book_title,
    ol.quantity,
    b.price,
    (ol.quantity * b.price) AS item_total,
    a.street,
    a.city,
    a.postal_code,
    co.country_name
FROM 
    customer c
JOIN 
    cust_order o ON c.customer_id = o.customer_id
JOIN 
    order_status os ON o.status_id = os.status_id
JOIN 
    shipping_method sm ON o.method_id = sm.method_id
JOIN 
    order_line ol ON o.order_id = ol.order_id
JOIN 
    book b ON ol.book_id = b.book_id
LEFT JOIN 
    customer_address ca ON c.customer_id = ca.customer_id
LEFT JOIN 
    address a ON ca.address_id = a.address_id
LEFT JOIN 
    country co ON a.country_id = co.country_id
WHERE 
    c.customer_id = 1  
ORDER BY 
    o.order_date DESC;
    
    
-- show top selling books nd sales according to languages

-- Top-selling books by quantity
SELECT 
    b.book_id,
    b.title,
    SUM(ol.quantity) AS total_quantity_sold,
    SUM(ol.quantity * b.price) AS total_revenue
FROM 
    book b
JOIN 
    order_line ol ON b.book_id = ol.book_id
JOIN 
    cust_order o ON ol.order_id = o.order_id
WHERE 
    o.status_id != 4  
GROUP BY 
    b.book_id, b.title
ORDER BY 
    total_quantity_sold DESC
LIMIT 5;

-- Sales by language
SELECT 
    bl.language_name,
    COUNT(DISTINCT b.book_id) AS number_of_books,
    SUM(COALESCE(ol.quantity, 0)) AS total_copies_sold,
    SUM(COALESCE(ol.quantity * b.price, 0)) AS total_revenue
FROM 
    book_language bl
LEFT JOIN 
    book b ON bl.language_id = b.language_id
LEFT JOIN 
    order_line ol ON b.book_id = ol.book_id
LEFT JOIN 
    cust_order o ON ol.order_id = o.order_id AND o.status_id != 4
GROUP BY 
    bl.language_name
ORDER BY 
    total_revenue DESC;
    
-- show order status history with estimated delivery dates

SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    sm.method_name AS shipping_method,
    oh.status_id,
    os.status_name,
    oh.updated_at,
    DATE_ADD(o.order_date, INTERVAL 3 DAY) AS estimated_delivery_min,
    DATE_ADD(o.order_date, INTERVAL 7 DAY) AS estimated_delivery_max
FROM 
    cust_order o
JOIN 
    customer c ON o.customer_id = c.customer_id
JOIN 
    shipping_method sm ON o.method_id = sm.method_id
JOIN 
    order_history oh ON o.order_id = oh.order_id
JOIN 
    order_status os ON oh.status_id = os.status_id
ORDER BY 
    o.order_id, oh.updated_at;
    
-- analyze shippinf]g methods and status

SELECT 
    sm.method_name AS shipping_method,
    COUNT(o.order_id) AS total_orders,
    SUM(CASE WHEN o.status_id = 3 THEN 1 ELSE 0 END) AS delivered_orders,
    SUM(CASE WHEN o.status_id = 2 THEN 1 ELSE 0 END) AS shipped_orders,
    SUM(CASE WHEN o.status_id = 1 THEN 1 ELSE 0 END) AS processing_orders,
    SUM(sm.cost) AS total_shipping_revenue,
    AVG(DATEDIFF(
        (SELECT MAX(updated_at) FROM order_history WHERE order_id = o.order_id AND status_id = 3),
        o.order_date
    )) AS avg_delivery_days
FROM 
    cust_order o
JOIN 
    shipping_method sm ON o.method_id = sm.method_id
GROUP BY 
    sm.method_name
ORDER BY 
    total_orders DESC;
    
    

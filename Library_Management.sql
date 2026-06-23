-- Library Management System

CREATE DATABASE library_management_system;
USE library_management_system;


CREATE TABLE publishers (
    pub_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(150) NOT NULL
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    available INT NOT NULL,
    pub_id INT NOT NULL,
    FOREIGN KEY (pub_id) REFERENCES publishers(pub_id),
    CHECK (price >= 0),
    CHECK (available >= 0)
);

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(150) NOT NULL,
    member_type VARCHAR(30) NOT NULL,
    member_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    CHECK (expiry_date > member_date)
);

CREATE TABLE borrow_records (
    issue_id INT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    CHECK (due_date >= issue_date),
    CHECK (return_date IS NULL OR return_date >= issue_date)
);

-- ALTER operation
ALTER TABLE books ADD shelf_no VARCHAR(20);
ALTER TABLE members ADD email VARCHAR(100);
ALTER TABLE members ADD status VARCHAR(20) DEFAULT 'ACTIVE';

-- Indexes
CREATE INDEX idx_book_title ON books(title);
CREATE INDEX idx_book_publisher ON books(pub_id);
CREATE INDEX idx_borrow_member ON borrow_records(member_id);
CREATE INDEX idx_borrow_due_date ON borrow_records(due_date);

-- Data Insertion -- 

INSERT INTO publishers (pub_id, name, address) VALUES
(1, 'Pearson Education', 'Noida'),
(2, 'McGraw Hill', 'New Delhi'),
(3, 'OReilly Media', 'California'),
(4, 'Oxford University Press', 'Oxford'),
(5, 'Cambridge Press', 'Cambridge'),
(6, 'Wiley India', 'Bengaluru'),
(7, 'Springer', 'Germany'),
(8, 'Packt Publishing', 'Birmingham');

INSERT INTO books (book_id, title, author, price, available, pub_id, shelf_no) VALUES
(1, 'Database Management Systems', 'Raghu Ramakrishnan', 850.00, 5, 1, 'A-101'),
(2, 'Database System Concepts', 'Silberschatz', 900.00, 4, 2, 'A-102'),
(3, 'Fundamentals of Database Systems', 'Elmasri Navathe', 950.00, 3, 1, 'A-103'),
(4, 'Learning SQL', 'Alan Beaulieu', 650.00, 6, 3, 'A-104'),
(5, 'MySQL Cookbook', 'Paul DuBois', 1200.00, 2, 3, 'A-105'),
(6, 'Introduction to Algorithms', 'Thomas Cormen', 1400.00, 4, 5, 'B-101'),
(7, 'The C Programming Language', 'Kernighan Ritchie', 500.00, 5, 4, 'B-102'),
(8, 'Clean Code', 'Robert Martin', 800.00, 3, 6, 'B-103'),
(9, 'Python Crash Course', 'Eric Matthes', 700.00, 6, 3, 'B-104'),
(10, 'Java Complete Reference', 'Herbert Schildt', 1000.00, 4, 2, 'B-105'),
(11, 'Computer Networks', 'Andrew Tanenbaum', 920.00, 3, 1, 'C-101'),
(12, 'Operating System Concepts', 'Silberschatz', 880.00, 2, 2, 'C-102'),
(13, 'Software Engineering', 'Ian Sommerville', 760.00, 5, 1, 'C-103'),
(14, 'Artificial Intelligence', 'Stuart Russell', 1250.00, 3, 1, 'C-104'),
(15, 'Machine Learning Basics', 'Andrew Ng', 700.00, 4, 7, 'C-105'),
(16, 'Data Science Handbook', 'Jake VanderPlas', 850.00, 4, 3, 'D-101'),
(17, 'Discrete Mathematics', 'Kenneth Rosen', 650.00, 5, 2, 'D-102'),
(18, 'Web Development Basics', 'Jon Duckett', 600.00, 6, 8, 'D-103'),
(19, 'HTML and CSS', 'Jon Duckett', 550.00, 7, 8, 'D-104'),
(20, 'JavaScript Guide', 'David Flanagan', 950.00, 3, 3, 'D-105'),
(21, 'Computer Organization', 'Carl Hamacher', 780.00, 4, 5, 'E-101'),
(22, 'Cloud Computing', 'Rajkumar Buyya', 820.00, 3, 7, 'E-102'),
(23, 'Cyber Security Basics', 'William Stallings', 720.00, 5, 6, 'E-103'),
(24, 'Big Data Analytics', 'Seema Acharya', 680.00, 4, 6, 'E-104'),
(25, 'Research Methodology', 'Kothari', 450.00, 6, 4, 'E-105'),
(26, 'English Communication', 'Meenakshi Raman', 390.00, 8, 4, 'F-101'),
(27, 'Business Analytics', 'James Evans', 830.00, 3, 5, 'F-102'),
(28, 'Computer Graphics', 'Hearn Baker', 740.00, 4, 2, 'F-103'),
(29, 'Theory of Computation', 'Michael Sipser', 900.00, 3, 5, 'F-104'),
(30, 'Compiler Design', 'Aho Ullman', 980.00, 2, 1, 'F-105'),
(31, 'Linux Commands', 'Richard Blum', 520.00, 6, 6, 'G-101'),
(32, 'Data Structures in C', 'Reema Thareja', 640.00, 5, 4, 'G-102'),
(33, 'Programming in Java', 'E Balagurusamy', 620.00, 6, 2, 'G-103'),
(34, 'Programming in Python', 'Mark Lutz', 890.00, 4, 3, 'G-104'),
(35, 'NoSQL Databases', 'Pramod Sadalage', 720.00, 3, 3, 'G-105');

INSERT INTO members (member_id, name, address, member_type, member_date, expiry_date, email, status) VALUES
(1, 'Aarav Sharma', 'Bengaluru', 'Student', '2024-07-01', '2026-07-01', 'aarav@gmail.com', 'ACTIVE'),
(2, 'Diya Patel', 'Mumbai', 'Student', '2024-07-02', '2026-07-02', 'diya@gmail.com', 'ACTIVE'),
(3, 'Ishaan Reddy', 'Hyderabad', 'Student', '2024-07-03', '2026-07-03', 'ishaan@gmail.com', 'ACTIVE'),
(4, 'Ananya Nair', 'Kochi', 'Student', '2024-07-04', '2026-07-04', 'ananya@gmail.com', 'ACTIVE'),
(5, 'Rohan Mehta', 'Pune', 'Faculty', '2024-07-05', '2027-07-05', 'rohan@gmail.com', 'ACTIVE'),
(6, 'Sara Khan', 'Delhi', 'Student', '2024-07-06', '2026-07-06', 'sara@gmail.com', 'ACTIVE'),
(7, 'Vikram Rao', 'Mysuru', 'Faculty', '2024-07-07', '2027-07-07', 'vikram@gmail.com', 'ACTIVE'),
(8, 'Meera Iyer', 'Chennai', 'Student', '2024-07-08', '2026-07-08', 'meera@gmail.com', 'ACTIVE'),
(9, 'Aditya Verma', 'Lucknow', 'Student', '2024-07-09', '2026-07-09', 'aditya@gmail.com', 'ACTIVE'),
(10, 'Kavya Singh', 'Jaipur', 'Student', '2024-07-10', '2026-07-10', 'kavya@gmail.com', 'ACTIVE'),
(11, 'Nikhil Gupta', 'Ahmedabad', 'Student', '2024-07-11', '2026-07-11', 'nikhil@gmail.com', 'ACTIVE'),
(12, 'Tara Das', 'Kolkata', 'Faculty', '2024-07-12', '2027-07-12', 'tara@gmail.com', 'ACTIVE'),
(13, 'Arjun Menon', 'Kozhikode', 'Student', '2024-07-13', '2026-07-13', 'arjun@gmail.com', 'ACTIVE'),
(14, 'Priya Kapoor', 'Delhi', 'Student', '2024-07-14', '2026-07-14', 'priya@gmail.com', 'ACTIVE'),
(15, 'Kabir Malhotra', 'Chandigarh', 'Student', '2024-07-15', '2026-07-15', 'kabir@gmail.com', 'ACTIVE'),
(16, 'Neha Bansal', 'Indore', 'Student', '2024-07-16', '2026-07-16', 'neha@gmail.com', 'ACTIVE'),
(17, 'Dev Chatterjee', 'Kolkata', 'Faculty', '2024-07-17', '2027-07-17', 'dev@gmail.com', 'ACTIVE'),
(18, 'Riya Jain', 'Surat', 'Student', '2024-07-18', '2026-07-18', 'riya@gmail.com', 'ACTIVE'),
(19, 'Manav Kulkarni', 'Nagpur', 'Student', '2024-07-19', '2026-07-19', 'manav@gmail.com', 'ACTIVE'),
(20, 'Aisha Thomas', 'Kochi', 'Student', '2024-07-20', '2026-07-20', 'aisha@gmail.com', 'ACTIVE'),
(21, 'Kiran Joshi', 'Bhopal', 'Student', '2024-07-21', '2026-07-21', 'kiran@gmail.com', 'ACTIVE'),
(22, 'Sanjana Pillai', 'Trivandrum', 'Student', '2024-07-22', '2026-07-22', 'sanjana@gmail.com', 'ACTIVE'),
(23, 'Harsh Agarwal', 'Noida', 'Student', '2024-07-23', '2026-07-23', 'harsh@gmail.com', 'ACTIVE'),
(24, 'Leela Bose', 'Kolkata', 'Faculty', '2024-07-24', '2027-07-24', 'leela@gmail.com', 'ACTIVE'),
(25, 'Yash Sinha', 'Patna', 'Student', '2024-07-25', '2026-07-25', 'yash@gmail.com', 'ACTIVE');

INSERT INTO borrow_records (issue_id, book_id, member_id, issue_date, due_date, return_date) VALUES
(1, 1, 1, '2026-05-01', '2026-05-15', '2026-05-14'),
(2, 2, 2, '2026-05-02', '2026-05-16', '2026-05-19'),
(3, 3, 3, '2026-05-03', '2026-05-17', '2026-05-16'),
(4, 4, 4, '2026-05-04', '2026-05-18', NULL),
(5, 5, 5, '2026-05-05', '2026-05-19', '2026-05-21'),
(6, 6, 6, '2026-05-06', '2026-05-20', '2026-05-20'),
(7, 7, 7, '2026-05-07', '2026-05-21', NULL),
(8, 8, 8, '2026-05-08', '2026-05-22', '2026-05-25'),
(9, 9, 9, '2026-05-09', '2026-05-23', '2026-05-22'),
(10, 10, 10, '2026-05-10', '2026-05-24', NULL),
(11, 11, 11, '2026-05-11', '2026-05-25', '2026-05-24'),
(12, 12, 12, '2026-05-12', '2026-05-26', '2026-05-30'),
(13, 13, 13, '2026-05-13', '2026-05-27', NULL),
(14, 14, 14, '2026-05-14', '2026-05-28', '2026-05-27'),
(15, 15, 15, '2026-05-15', '2026-05-29', '2026-06-01'),
(16, 16, 16, '2026-05-16', '2026-05-30', NULL),
(17, 17, 17, '2026-05-17', '2026-05-31', '2026-05-31'),
(18, 18, 18, '2026-05-18', '2026-06-01', '2026-06-05'),
(19, 19, 19, '2026-05-19', '2026-06-02', NULL),
(20, 20, 20, '2026-05-20', '2026-06-03', '2026-06-03'),
(21, 21, 21, '2026-05-21', '2026-06-04', '2026-06-07'),
(22, 22, 22, '2026-05-22', '2026-06-05', NULL),
(23, 23, 23, '2026-05-23', '2026-06-06', '2026-06-06'),
(24, 24, 24, '2026-05-24', '2026-06-07', '2026-06-10'),
(25, 25, 25, '2026-05-25', '2026-06-08', NULL),
(26, 26, 1, '2026-05-26', '2026-06-09', '2026-06-09'),
(27, 27, 2, '2026-05-27', '2026-06-10', '2026-06-12'),
(28, 28, 3, '2026-05-28', '2026-06-11', NULL),
(29, 29, 4, '2026-05-29', '2026-06-12', '2026-06-12'),
(30, 30, 5, '2026-05-30', '2026-06-13', '2026-06-16'),
(31, 31, 6, '2026-06-01', '2026-06-15', NULL),
(32, 32, 7, '2026-06-02', '2026-06-16', '2026-06-16'),
(33, 33, 8, '2026-06-03', '2026-06-17', NULL),
(34, 34, 9, '2026-06-04', '2026-06-18', '2026-06-20'),
(35, 35, 10, '2026-06-05', '2026-06-19', NULL),
(36, 1, 11, '2026-06-06', '2026-06-20', NULL),
(37, 2, 12, '2026-06-07', '2026-06-21', NULL),
(38, 3, 13, '2026-06-08', '2026-06-22', NULL),
(39, 4, 14, '2026-06-09', '2026-06-23', NULL),
(40, 5, 15, '2026-06-10', '2026-06-24', NULL);

-- UPDATE operation
UPDATE books
SET available = available - 1
WHERE book_id = 4;

-- DELETE operation
INSERT INTO members (member_id, name, address, member_type, member_date, expiry_date, email, status)
VALUES (99, 'Temporary Member', 'Test City', 'Student', '2026-01-01', '2027-01-01', 'temp@gmail.com', 'ACTIVE');

DELETE FROM members
WHERE member_id = 99;

CREATE VIEW vw_book_catalog AS
SELECT
    b.book_id,
    b.title,
    p.name AS publisher,
    b.author AS authors,
    b.available AS available_copies,
    b.shelf_no AS shelf_location,
    b.price
FROM books b
JOIN publishers p ON b.pub_id = p.pub_id;

CREATE VIEW vw_active_borrowings AS
SELECT
    br.issue_id AS transaction_id,
    m.member_id,
    m.name AS member_name,
    b.title,
    CONCAT('BOOK-', b.book_id) AS barcode,
    br.issue_date,
    br.due_date,
    DATEDIFF(CURRENT_DATE, br.due_date) AS days_overdue
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
JOIN members m ON br.member_id = m.member_id
WHERE br.return_date IS NULL;

CREATE VIEW vw_member_fine_summary AS
SELECT
    m.member_id,
    m.name,
    SUM(
        CASE
            WHEN br.return_date IS NOT NULL AND br.return_date > br.due_date THEN 1
            WHEN br.return_date IS NULL AND CURRENT_DATE > br.due_date THEN 1
            ELSE 0
        END
    ) AS fine_count,
    SUM(
        CASE
            WHEN br.return_date IS NOT NULL AND br.return_date > br.due_date
                THEN DATEDIFF(br.return_date, br.due_date) * 5
            WHEN br.return_date IS NULL AND CURRENT_DATE > br.due_date
                THEN DATEDIFF(CURRENT_DATE, br.due_date) * 5
            ELSE 0
        END
    ) AS unpaid_amount
FROM members m
LEFT JOIN borrow_records br ON m.member_id = br.member_id
GROUP BY m.member_id, m.name;


-- book data 
SELECT b.book_id, b.title, b.author, p.name AS publisher
FROM books b
JOIN publishers p ON b.pub_id = p.pub_id;

-- book price> average
SELECT book_id, title, price
FROM books
WHERE price > (SELECT AVG(price) FROM books);

-- Highest and average prices of book
SELECT COUNT(*) AS total_books, AVG(price) AS average_price, MAX(price) AS highest_price
FROM books;

-- Searching publishers who have more than 3 books published 
SELECT p.name AS publisher, COUNT(b.book_id) AS total_books
FROM publishers p
JOIN books b ON p.pub_id = b.pub_id
GROUP BY p.pub_id, p.name
HAVING COUNT(b.book_id) > 3;

SELECT * FROM vw_book_catalog;

SELECT * FROM vw_active_borrowings;

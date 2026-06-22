-- =========================================================
-- 4. SQL QUERY REQUIREMENTS
-- =========================================================

-- 1. JOIN query: book with publisher details
SELECT b.book_id, b.title, b.author, p.name AS publisher
FROM books b
JOIN publishers p ON b.pub_id = p.pub_id;

-- 2. Nested query: books costlier than average price
SELECT book_id, title, price
FROM books
WHERE price > (SELECT AVG(price) FROM books);

-- 3. Aggregate function: total and average book price
SELECT COUNT(*) AS total_books, AVG(price) AS average_price, MAX(price) AS highest_price
FROM books;

-- 4. GROUP BY and HAVING: publishers having more than 3 books
SELECT p.name AS publisher, COUNT(b.book_id) AS total_books
FROM publishers p
JOIN books b ON p.pub_id = b.pub_id
GROUP BY p.pub_id, p.name
HAVING COUNT(b.book_id) > 3;

-- 5. View query
SELECT * FROM vw_book_catalog;

-- 6. Borrow report using view
SELECT * FROM vw_active_borrowings;

-- 7. Fine summary using view
SELECT * FROM vw_member_fine_summary;
-- =========================================================
-- VIEWS
-- These views are also used by the frontend.
-- =========================================================

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
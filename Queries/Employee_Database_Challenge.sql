-- Deliverable 1: Find the Number of Retiring Employees
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

-- INTO emp_retire
FROM _______
WHERE _______
ORDER BY _____, _____ DESC;

SELECT * FROM employees 
SELECT * FROM titles 

SELECT  e.emp_no,
    e.first_name,
e.last_name,
    tt.title,
    tt.from_date,
    tt.to_date
INTO emp_retire
FROM employees as e
INNER JOIN titles as tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM emp_retire

-- Use the Distinct On Feature
SELECT DISTINCT ON (ret.emp_no) ret.emp_no,
    ret.first_name,
ret.last_name,
    ret.title
INTO unique_titles
FROM emp_retire as ret
WHERE (ret.to_date = '9999-01-01')
ORDER BY ret.emp_no, ret.title ASC;

SELECT * FROM emp_retire
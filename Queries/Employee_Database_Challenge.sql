-- Deliverable 1: Find the Number of Retiring Employees

-- Query for employees born between 1952 and 1955
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

-- Use the Distinct On Feature for unique titles of those retiring and currently employed
SELECT DISTINCT ON (ret.emp_no) ret.emp_no,
    ret.first_name,
ret.last_name,
    ret.title
INTO unique_titles
FROM emp_retire as ret
WHERE (ret.to_date = '9999-01-01')
ORDER BY ret.emp_no, ret.title ASC;

SELECT * FROM emp_retire

-- Number of employees retiring by title
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;

SELECT * FROM retiring_titles

-- Deliverable 2: Creating a mentorship elgibility table

-- Query for employees born in 1965
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
	tt.title
INTO mentor_list
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, tt.title ASC;

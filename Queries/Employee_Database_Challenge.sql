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

SELECT * FROM mentor_list;

--  Query for employee mentor count by title
SELECT COUNT(ml.emp_no), ml.title
INTO mentor_titles
FROM mentor_list as ml
GROUP BY ml.title
ORDER BY COUNT(ml.emp_no) DESC;

---- Query for employees born in 1965-1968
DROP TABLE mentor_list_update CASCADE;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
	tt.title
INTO mentor_list_update
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1960-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, tt.title ASC;

--  Query for updated employee mentor count by title
SELECT COUNT(mlu.emp_no), mlu.title
-- INTO mentor_titles
FROM mentor_list_update as mlu
GROUP BY mlu.title
ORDER BY COUNT(mlu.emp_no) DESC;
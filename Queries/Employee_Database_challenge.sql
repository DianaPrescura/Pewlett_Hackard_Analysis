-- Creating tables for Employess_Database_challenge
DROP TABLE departments;
CREATE TABLE departments (
     dept_no VARCHAR(50),
     dept_name VARCHAR(50)
    
);
SELECT * FROM departments;

CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

SELECT * FROM employees;

CREATE TABLE dept_manager (
	dept_no VARCHAR(50),
    emp_no VARCHAR(50),
    from_date VARCHAR(50),
    to_date VARCHAR(50)
);
	
SELECT * FROM dept_manager;

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
SELECT * FROM salaries;

CREATE TABLE  titles(
  emp_no VARCHAR(50),
  title VARCHAR(50),
  from_date VARCHAR(50),
  to_date VARCHAR(50)
 
);

SELECT * FROM titles;

DROP TABLE dept_emp;

CREATE TABLE dept_emp(
  emp_no VARCHAR(50),
  dept_no VARCHAR(50),
  from_date VARCHAR(50),
  to_date VARCHAR(50)
	
);
SELECT * FROM dept_emp;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;




--- Deliverable 1 
--- Retirement Titles Table
SELECT e.emp_no, 
	   e.first_name, 
	   e.last_name,
	   t.title,
	   t.from_date, 
	   t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no);
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'),
ORDER BY emp_no ASC;

SELECT * FROM retirement_titles

--- Unique Titles Table
SELECT DISTINCT ON (emp_no), emp_no
	first_name,
	last_name,
	title,
	to_date
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC;

--- Retiring Titles Table 
SELECT COUNT (ut.titles_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY title_no, DESC;

---Deliverable 2

SELECT DISTINCT ON(e.emp_no), e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
INTO mentorship_eligibility
FROM employees AS e
JOIN dept_emp as de
ON (de.emp_no = e.emp_no)
JOIN title AS t
ON (e.emp_no = t.emp_no)
WHERE birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no ASC;





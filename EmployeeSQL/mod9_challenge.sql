-- CREATE TABLES

CREATE TABLE sql_challenge.departments(
	dept_no VARCHAR,
	dept_name VARCHAR,
	PRIMARY KEY (dept_no)
);

CREATE TABLE sql_challenge.dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR NOT NULL
); 

CREATE TABLE sql_challenge.dept_manager(
	dept_no VARCHAR,
	emp_no INTEGER NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE sql_challenge.employees(
	emp_no INTEGER NOT NULL,
	title_id VARCHAR NOT NULL,
	birth_date DATE,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	sex CHAR,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
	
);

CREATE TABLE sql_challenge.salaries(
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE sql_challenge.titles(
	title_id VARCHAR NOT NULL,
	title VARCHAR,
	PRIMARY KEY (title_id)
);

CREATE TABLE sql_challenge.emp_dept_assignment(
	emp_no INTEGER REFERENCES sql_challenge.employees(emp_no),
	dept_no VARCHAR REFERENCES sql_challenge.departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- IMPORT CSV FILES

-- Import data into the departments table
-- (Used pgAdmin 4 Import/Export feature for this operation)

-- Import data into the dept_emp table
-- (Used pgAdmin 4 Import/Export feature for this operation)

-- Import data into the dept_manager table
-- (Used pgAdmin 4 Import/Export feature for this operation)

-- Import data into the employees table
-- (Used pgAdmin 4 Import/Export feature for this operation)

-- Import data into the salaries table
-- (Used pgAdmin 4 Import/Export feature for this operation)

-- Import data into the titles table
-- (Used pgAdmin 4 Import/Export feature for this operation)

-- DATA ANALYSIS

-- 1: List the employee number, last name, first name, sex and salary for each employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM sql_challenge.employees e
JOIN sql_challenge.salaries s ON e.emp_no = s.emp_no;

-- 2: List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM sql_challenge.employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3: List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM sql_challenge.dept_manager dm
JOIN sql_challenge.employees e ON dm.emp_no = e.emp_no
JOIN sql_challenge.departments d ON dm.dept_no = d.dept_no;


-- List the department number for each employee along with that employee's employee number, last name, first name, and department name
SELECT de.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
FROM sql_challenge.dept_emp de
JOIN sql_challenge.employees e ON de.emp_no = e.emp_no
JOIN sql_challenge.departments d ON de.dept_no = d.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM sql_challenge.employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List each employee in the sales department, including their employee number, last name and first name
SELECT de.emp_no, e.last_name, e.first_name
FROM sql_challenge.dept_emp de
JOIN sql_challenge.employees e ON de.emp_no = e.emp_no
JOIN sql_challenge.departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- List each employee in the sales and development departments, including their employee number, last name, first name, and department name
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM sql_challenge.dept_emp de
JOIN sql_challenge.employees e ON de.emp_no = e.emp_no
JOIN sql_challenge.departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- List the frequency counts, in descending order, of all the employee last names (that is,how many employees share each last name)
SELECT last_name, COUNT(*) AS name_count
FROM sql_challenge.employees
GROUP BY last_name
ORDER BY name_count DESC;



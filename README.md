# Historical Employee Database Analysis

## Project Overview
A relational database built from six historical employee CSV extracts for Pewlett Hackard, a fictional company, covering hiring, salary, title, and department records from the 1980s and 1990s. The work spans the full pipeline: designing a normalized schema, loading ~630K rows of raw data, and writing SQL queries to answer specific HR questions about the workforce.

## Technologies Used
- PostgreSQL
- SQL (DDL + analytical queries)
- pgAdmin 4 (used for the original CSV import)

## Schema
Six tables hold the imported data — `employees`, `departments`, `titles`, `salaries`, `dept_emp` (employee-to-department history), and `dept_manager` (department managers) — with primary/foreign keys enforcing referential integrity (e.g. `salaries.emp_no` and `dept_manager.emp_no` reference `employees`). A seventh table, `emp_dept_assignment`, is defined in the schema but not populated or used by any of the queries below — left as-is here rather than silently dropped, since removing it isn't part of this pass's scope.

## Verified Results
All queries below were re-run end-to-end against a fresh PostgreSQL instance loaded from the raw CSVs in `Starter_Code/data/`, confirming the full pipeline — schema, data load, and every query — still works as originally submitted:

| Question | Result |
|---|---|
| Total employee/salary records | 300,024 (1:1 — every employee has exactly one salary record) |
| Employees hired in 1986 | 36,150 |
| Employees named "Hercules" with a last name starting with "B" | 20 |
| Employees in the Sales department | 52,245 |
| Employees in Sales + Development combined | 137,952 |
| Distinct department-manager records (across department history) | 24, across 9 departments |
| Most common last name | "Baba" (226 employees), followed by "Coorg" and "Gelosh" (223 each) |

Full query set — including manager listings per department and department assignments joined to employee names — is in [`EmployeeSQL/employee_data_SQL.sql`](EmployeeSQL/employee_data_SQL.sql).

## How to Run
1. Create a PostgreSQL database and run the `CREATE TABLE` statements at the top of `EmployeeSQL/employee_data_SQL.sql` (creates a `sql_challenge` schema's worth of tables — create the schema first: `CREATE SCHEMA sql_challenge;`).
2. Load the six CSVs from `Starter_Code/data/` into their matching tables — the original workflow used pgAdmin 4's Import/Export feature; `psql`'s `\copy` works the same way from the command line.
3. Run the analysis queries in the second half of the same file.

## Conclusion
This project demonstrates end-to-end relational database work: schema design from raw denormalized CSVs, data loading, and writing joins/aggregations to answer real analytical questions about workforce structure — re-verified against a live database rather than left as an unverified bootcamp submission.

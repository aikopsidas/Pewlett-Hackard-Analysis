--create new retirement_titles table
SELECT et.emp_no, et.first_name, et.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS et
INNER JOIN titles AS t
ON et.emp_no = t.emp_no
WHERE et.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY et.emp_no

--test table 
SELECT * FROM retirement_titles
--removing dups in retirement_title
INTO recent_title
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * FROM recent_title

SELECT COUNT (title) as COUNT, title
INTO retiring_titles
FROM recent_title
GROUP BY title
ORDER BY COUNT DESC

SELECT * FROM retiring_titles

Select sum(count) as "Set to Retire" 
FROM retiring_titles

SELECT DISTINCT ON (emp_no) emp.emp_no, emp.first_name, emp.last_name, emp.birth_date,dmp.from_date,
dmp.to_date, titles.title
INTO mentorship_eligibility
FROM employees as emp
INNER JOIN dept_emp as dmp
ON emp.emp_no = dmp.emp_no
INNER JOIN titles
ON emp.emp_no = titles.emp_no
WHERE dmp.to_date = '9999-01-01'
AND emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp.emp_no
	
SELECT * FROM mentorship_eligibility

SELECT COUNT (title) as COUNT, title
INTO mentorship_list
FROM mentorship_eligibility
GROUP BY title
ORDER BY COUNT DESC


SELECT SUM(count) AS "Total Mentor" FROM mentorship_list

SELECT * FROM mentorship_list
	



SELECT DISTINCT ON (emp_no) emp.emp_no, emp.first_name, emp.last_name, emp.birth_date,dmp.from_date,
dmp.to_date, titles.title
INTO leftovers
FROM employees as emp
INNER JOIN dept_emp as dmp
ON emp.emp_no = dmp.emp_no
INNER JOIN titles
ON emp.emp_no = titles.emp_no
WHERE dmp.to_date = '9999-01-01'
AND emp.birth_date BETWEEN '1956-01-01' and '1964-12-31'
ORDER BY emp.emp_no

SELECT * FROM leftovers

SELECT COUNT (title) as COUNT, title
FROM leftovers
GROUP BY title
ORDER BY COUNT DESC
SELECT SUM (count) FROM remainder
SELECT *
FROM remainder





SELECT remainder.title, retiring_titles.count as "Retiring", remainder.count as "Mentors",  mentorship_list.count as "Mentor Eligable" 
INTO overall_view
FROM remainder
INNER JOIN retiring_titles
ON remainder.title = retiring_titles.title
INNER JOIN mentorship_list
ON remainder.title = mentorship_list.title
ORDER by retiring_titles.count DESC

SELECT * FROM overall_view

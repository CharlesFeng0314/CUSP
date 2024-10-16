##  REVIEW, FUNCTIONS, JOINS, UNION, VIEWS
DROP DATABASE IF EXISTS companyHR; #drop it if it exists
USE companyHR;

/*
QUICK REVIEW 
*/

## An easy way to delete records when you've inserted duplicates
SELECT * FROM employees;
DELETE FROM employees WHERE id >11;

SELECT * FROM employees;

## Altering a table to change column names or data types
DESCRIBE mentorships;

### Let's change status to current_status
ALTER TABLE mentorships CHANGE status current_status VARCHAR(255) NOT NULL;
DESCRIBE mentorships;
SELECT * FROM mentorships;

###Change it back
ALTER TABLE mentorships CHANGE current_status status VARCHAR(255) NOT NULL;
DESCRIBE mentorships;
SELECT * FROM mentorships;

##The effect on primary keys

SHOW TABLES;
ALTER TABLE employees CHANGE id employee_id INT PRIMARY KEY AUTO_INCREMENT; # practice changing the tables to make this work
DESCRIBE employees;
DESCRIBE mentorships;


# FUNCTIONS

##FUNCTION CONCAT
SELECT CONCAT('Hello', ' World', '!!!!'); # add more values
SELECT CONCAT('ks123', '@nyu.edu');
SELECT em_name AS 'EMPLOYEE NAME', CONCAT(1,'-',  contact_number) AS 'PHONE NUMBER' FROM employees;
SELECT em_name, CONCAT(1,'-',  contact_number) FROM employees; # now we can see why we may want to use an alias
SELECT em_name AS 'EMPLOYEE NAME', CONCAT(1,'-',  contact_number) AS 'PHONE NUMBER' FROM employees;

##FUNCTION SUBSTRING
SELECT SUBSTRING('Programming', 2);
SELECT SUBSTRING('Programming', 2, 6); #start at 2nd value and through the 6th character, beginning at 2
SELECT SUBSTRING(contact_number, 1, 3) AS area_code FROM employees;

#CURDATE: Return the current date

SELECT CURDATE();  # returns the date as a string
SELECT CURDATE()  + 2; # returns the current date plus 2 days as a numeric
SELECT NOW();

##BUILT-IN AGGREGATE FUNCTIONS 

USE companyHR;
Select * from employees;
SELECT COUNT(*) FROM employees;

SELECT COUNT(contact_number) FROM employees; # by column, cannot add another one
SELECT * FROM employees;

SELECT COUNT(gender) FROM employees;

SELECT COUNT(DISTINCT gender) FROM employees;

SELECT AVG(salary) FROM employees;
SELECT AVG(salary) AS 'Average Salary' FROM employees;

SELECT ROUND(AVG(salary), 2) AS 'Average Salary' FROM employees;

SELECT ROUND(AVG(salary), -2) AS 'Average Salary' FROM employees;

SELECT MAX(salary) FROM employees;

SELECT MIN(salary) FROM employees;

SELECT SUM(salary) FROM employees;

SELECT gender, MAX(salary) FROM employees GROUP BY gender;

#HAVING - Use to filter the results of grouped data
SELECT gender, MAX(salary) FROM employees GROUP BY gender HAVING MAX(salary) > 10000; # change to 7000 to see both m/f

# JOINS
DROP DATABASE myjoins;
CREATE DATABASE myjoins;
USE myjoins;

CREATE TABLE one(
	A int,
	B int
);

CREATE TABLE two(
	C int,
	B double, 
	D VARCHAR(255)
);

INSERT INTO one VALUES
(1, 259),
(2, 125),
(3, 731)
;

INSERT INTO two VALUES
(2, 218.1, 'ABC'),
(3, 511.5, 'DEF'), 
(4, 219.9, 'GHI')
;

select * from one;
select * from two;
#INNER  JOIN: Inner joins only select rows where common value exists in both tables

SELECT one.A, two.C, one.B AS 'one B', two.B AS 'two B'
FROM
one 
INNER JOIN
two
ON
one.A = two.C;

#LEFT JOIN: Selects all rows from the left table 

SELECT one.A, two.C, one.B AS 'one B', two.B AS 'two B'
FROM
one 
LEFT JOIN
two
ON
one.A = two.C;

Select * from one;
Select * from two;

SELECT A , one.B as onebi, two.B as erbi
FROM
one 
LEFT JOIN
two
ON
one.A = two.C;

#RIGHT JOIN: Selects all from the right table

SELECT one.A, two.C, one.B AS 'one B', two.B AS 'two B'
FROM
one 
RIGHT JOIN
two
ON
one.A = two.C;

select * from one;
select * from two;

##CROSS JOIN: returns all records from both tables
SELECT *
FROM one
CROSS JOIN two;

#company_HR: INNER JOIN
use companyHR;

SELECT employees.id, mentorships.mentor_id, employees.em_name AS 
'Mentor', mentorships.project AS 'Project Name'
FROM
mentorships # switch to employees
INNER JOIN
employees # switch to mentorships
ON
employees.id = mentorships.mentor_id;

SELECT * FROM mentorships;

## If you do not want to show the id and mentor_id columns
SELECT employees.em_name AS 'Mentor', mentorships.project AS 'Project Name'
FROM
mentorships
INNER JOIN
employees
ON
employees.id = mentorships.mentor_id;

## Show the mentee name and the projects they are assigned
SELECT employees.em_name AS 'Mentee', mentorships.project AS 'Project Name'
FROM
mentorships
INNER JOIN
employees
ON
employees.id = mentorships.mentee_id;

##UNIONS
#Combines the results of two or more select statements. Each select must have the same number of columns
SELECT em_name, salary, gender FROM employees WHERE gender = 'M'
UNION
SELECT em_name, years_in_company,gender FROM employees WHERE gender = 'F';

## UNION ALL - Includes duplicates

SELECT mentor_id FROM mentorships ##1123 #try breaking it
UNION ALL
SELECT id FROM employees WHERE gender = 'F';

SELECT mentor_id FROM mentorships
UNION
SELECT id FROM employees WHERE gender = 'F';

#VIEWS: A  view is a virtual table. It's like a table, but contains select statements  not data
USE companyHR;
DROP VIEW IF EXISTS myView;

CREATE VIEW myView AS
SELECT employees.id, mentorships.mentor_id, employees.em_name 
AS 'Mentor', mentorships.project AS 'Project Name'
FROM
mentorships
JOIN
employees
ON
employees.id = mentorships.mentor_id;

SELECT * FROM myView;
SELECT Mentor, `Project Name` FROM myView;
#STOPPED HERE
##Altering a view to change the alias mentorships.project to Project.
ALTER VIEW myView AS
SELECT employees.id, mentorships.mentor_id, employees.em_name AS 'Mentor', mentorships.project AS 'Project'
FROM
mentorships
JOIN
employees
ON
employees.id = mentorships.mentor_id;

SELECT * FROM myView;

DROP VIEW IF EXISTS myView1; # or myView


#######practice with joins############
#left join on mentor_id
SELECT * FROM 
employees
LEFT JOIN
mentorships
ON  
employees.id = mentorships.mentor_id;

SELECT * FROM mentorships;

#left join on mentee_id
SELECT * FROM # id 3 repeated 2x since they are a mentee 2x and null values exist
employees
LEFT JOIN
mentorships
ON  
employees.id = mentorships.mentee_id;

#cross join
SELECT * FROM # 
employees
CROSS JOIN
mentorships
ON  
employees.id = mentorships.mentee_id;

#right join
SELECT * FROM # #23311
employees
RIGHT JOIN
mentorships
ON  
employees.id = mentorships.mentee_id;
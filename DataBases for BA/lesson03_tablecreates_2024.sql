# Databases for Business Analytics
# Fall 2024 | Lesson 3

# Be sure you have logged into the your DBMS instance, not the "Class" instance

######### CREATE DB ############
DROP DATABASE IF EXISTS companyHR;
CREATE DATABASE companyHR;
USE companyHR;

######### CREATE TABLES ############

CREATE TABLE co_employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
	em_name VARCHAR(255) NOT NULL,
	gender CHAR(1) NOT NULL,
	contact_number VARCHAR(255),
	age INT NOT NULL,
	date_created TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE mentorships (
	mentor_id INT NOT NULL,
	mentee_id INT NOT NULL,
	status VARCHAR(255) NOT NULL,
	project VARCHAR(255) NOT NULL,
    
	PRIMARY KEY (mentor_id, mentee_id, project),
	CONSTRAINT fk1 FOREIGN KEY(mentor_id) REFERENCES co_employees(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	CONSTRAINT fk2 FOREIGN KEY(mentee_id) REFERENCES co_employees(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	CONSTRAINT mm_constraint UNIQUE(mentor_id, mentee_id) #unique combo
);

SHOW TABLES;
DESCRIBE mentorships;
DESCRIBE co_employees;
SELECT * FROM co_employees;
select * from mentorships;

RENAME TABLE co_employees TO employees;

SHOW TABLES;
DESCRIBE employees;

##ALTER TABLE

ALTER TABLE employees
	DROP COLUMN age,
	ADD COLUMN salary FLOAT NOT NULL AFTER contact_number,
	ADD COLUMN years_in_company INT NOT NULL AFTER salary;

DESCRIBE employees;

##ALTER TABLE

ALTER TABLE mentorships
	DROP FOREIGN KEY fk2;

ALTER TABLE mentorships
	ADD CONSTRAINT fk2 FOREIGN KEY(mentee_id) REFERENCES employees(id) ON DELETE CASCADE ON UPDATE CASCADE,
	DROP INDEX mm_constraint;

##DROP TABLE SAMPLE CODE - DO NOT RUN

DROP TABLE IF EXISTS tablename; 

##INSERT

##INSERT INTO employees

INSERT INTO employees (em_name, gender, contact_number, salary, years_in_company) VALUES
('James Lee', 'M', '516-514-6568', 3500, 11), 
('Peter Pasternak', 'M', '845-644-7919', 6010, 10),
('Clara Couto', 'F', '845-641-5236', 3900, 8), 
('Walker Welch', 'M', NULL, 2500, 4),
('Li Xiao Ting', 'F', '646-218-7733', 5600, 4),
('Joyce Jones', 'F', '523-172-2191', 8000, 3),
('Jason Cerrone', 'M', '725-441-7172', 7980, 2),
('Prudence Phelps', 'F', '546-312-5112', 11000, 2),
('Larry Zucker', 'M', '817-267-9799', 3500, 1),
('Serena Parker', 'F', '621-211-7342', 12000, 1);

SELECT * FROM employees;
##INSERT INTO mentorships

INSERT INTO mentorships VALUES
(1, 2, 'Ongoing', 'SQF Limited'),
(1, 3, 'Past', 'Wayne Fibre'), 
(2, 3, 'Ongoing', 'SQF Limited'),
(3, 4, 'Ongoing', 'SQF Limited'),
(6, 5, 'Past', 'Flynn Tech');

SELECT * FROM mentorships;

SHOW TABLES;
DESCRIBE employees;
DESCRIBE mentorships;
##STOPPED CLASS 6
SELECT * FROM mentorships;
SELECT * FROM employees;

UPDATE employees
SET contact_number = '516-514-1729'
WHERE id = 1;

DELETE FROM employees
WHERE id = 5;

UPDATE employees
SET id = 11 WHERE id = 4;
SELECT * FROM employees;
SELECT * FROM mentorships;

SELECT em_name, gender from employees; # selecting two columns

SELECT em_name AS `Employee Name`, gender AS `Gender` FROM employees; # use quotes for alias names


SELECT id, em_name AS 'Employee Name', gender AS `Gender` FROM employees LIMIT 3; #added id to show ascending order

SELECT gender FROM employees;
SELECT DISTINCT(gender) FROM employees;

SELECT * FROM employees WHERE id != 1;

SELECT * FROM employees WHERE id BETWEEN 1 AND 3;

SELECT * FROM employees WHERE em_name LIKE '%er';

SELECT * FROM employees WHERE em_name LIKE '%er%';

SELECT * FROM employees WHERE em_name LIKE '____e%'; # 5th letter is an e

SELECT * FROM employees WHERE id IN (6, 7, 1320);

SELECT * FROM employees WHERE id NOT IN (7, 8);

SELECT * FROM employees WHERE (years_in_company > 5 OR salary > 5000) AND gender = 'F';

SELECT em_name from employees WHERE id IN 
(SELECT mentor_id FROM mentorships WHERE project = 'SQF Limited');

SELECT * FROM employees ORDER BY gender, em_name;

SELECT * FROM employees ORDER BY gender DESC, em_name;

##JOIN THE TABLES

SELECT employees.id, mentorships.mentor_id, employees.em_name AS 
'Mentor', mentorships.project AS 'Project Name'
FROM
mentorships
INNER JOIN
employees
ON
employees.id = mentorships.mentor_id;

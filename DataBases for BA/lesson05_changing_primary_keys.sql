## Lesson 5

#PART 1: The effect on primary keys

USE companyHR; 
SHOW TABLES;
ALTER TABLE employees CHANGE id employee_id INT; # practice changing the tables to make this work
DESCRIBE employees;
DESCRIBE mentorships;

#strategy
# ALTER  mentorships table to remove the foreign key contraints  
# ALTER employees table to change the name of id to employee_id
# ALTER  mentorships table to add the two foreign key contraints 

# 1. Drop foreign key constraints from mentorships table
ALTER TABLE mentorships DROP FOREIGN KEY fk1;
ALTER TABLE mentorships DROP FOREIGN KEY fk2;

DESCRIBE mentorships;

# 2. Rename id column to emp_id in co_employees table

ALTER TABLE employees CHANGE id employee_id INT;
#ALTER TABLE employees CHANGE employee_id id INT; to revert back

DESCRIBE employees;

# 3 & 4. Add the updated foreign key constraints back to mentorships table
ALTER TABLE mentorships
	ADD CONSTRAINT fk1 FOREIGN KEY(mentor_id) REFERENCES employees(employee_id) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE mentorships
	ADD CONSTRAINT fk2 FOREIGN KEY(mentee_id) REFERENCES employees(employee_id) ON DELETE CASCADE ON UPDATE CASCADE;


SELECT * FROM mentorships;
DESCRIBE mentorships;


/* We can reference the information schemea

The information_schema is a special schema (or database) in MySQL (and many other relational databases) that contains metadata about all other databases, their tables, and various other elements. It acts as a centralized source of information about the structure and constraints of all databases hosted in that MySQL instance.

*/

# You can see the constraints with this code    
    SELECT 
    kcu.TABLE_NAME,
    kcu.CONSTRAINT_NAME,
    kcu.COLUMN_NAME,
    kcu.REFERENCED_TABLE_NAME,
    kcu.REFERENCED_COLUMN_NAME
FROM 
    information_schema.KEY_COLUMN_USAGE AS kcu
WHERE 
    kcu.TABLE_SCHEMA = 'companyHR'
    AND kcu.TABLE_NAME IN ('employees', 'mentorships')
    AND kcu.REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY 
    kcu.TABLE_NAME;
    
    
    
# For employees
SELECT 
    kcu.TABLE_NAME,
    kcu.CONSTRAINT_NAME,
    kcu.COLUMN_NAME,
    kcu.REFERENCED_TABLE_NAME,
    kcu.REFERENCED_COLUMN_NAME
FROM 
    information_schema.KEY_COLUMN_USAGE AS kcu
WHERE 
    kcu.TABLE_SCHEMA = 'companyHR'
    AND kcu.TABLE_NAME = 'employees'
    AND kcu.REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY 
    kcu.TABLE_NAME;    
    

## CONSTRAINTS: Let's see how the contraints work

# fk1 FOREIGN KEY(mentor_id) REFERENCES employees(employee_id) ON DELETE CASCADE ON UPDATE RESTRICT;
# fk2 FOREIGN KEY(mentee_id) REFERENCES employees(employee_id) ON DELETE CASCADE ON UPDATE CASCADE;

SELECT * FROM employees;
SELECT * FROM mentorships;

# UPDATE RESTRICT: Try to update the parent row id, which references mentor id

UPDATE employees
SET id = 100
WHERE id = 1;

# UPDATE CASCADE: Try to update the parent row id, which references mentee id

SELECT * FROM mentorships; # note 11

UPDATE employees
SET id = 11
WHERE id = 100;
    

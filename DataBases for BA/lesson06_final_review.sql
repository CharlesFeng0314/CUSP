######################################################################
## FINAL EXMAN REVIEW ON YOUR OWN

## Exercise 1:
## Given the four relational schemas:
## Employee(personal_name, street, city)
## Works(personal_name, company_name, salary)
## Company(company_name, city)
## Manages(personal_name, manager_name)
## Formulate the following queries into the corresponding mysql query
##

## 0. Create the database and tables
DROP DATABASE IF EXISTS corporation;
CREATE DATABASE corporation;
USE corporation;

CREATE TABLE Employee (
personal_name VARCHAR(255) NOT NULL,
street VARCHAR(255) NOT NULL,
city VARCHAR(255) NOT NULL,
PRIMARY KEY (personal_name)
);

CREATE TABLE Company (
company_name VARCHAR(255) NOT NULL,
city VARCHAR(255) NOT NULL,
PRIMARY KEY (company_name)
);

CREATE TABLE Works (
personal_name VARCHAR(255) NOT NULL,
company_name VARCHAR(255) NOT NULL,
salary INT NOT NULL,
PRIMARY KEY (personal_name, company_name),
FOREIGN KEY (personal_name) REFERENCES Employee(personal_name),
FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

CREATE TABLE Manages (
personal_name VARCHAR(255) NOT NULL,
manager_name VARCHAR(255) NOT NULL,
PRIMARY KEY (personal_name, manager_name),
FOREIGN KEY (personal_name) REFERENCES Employee(personal_name),
FOREIGN KEY (manager_name) REFERENCES Employee(personal_name)
);

INSERT INTO Employee (personal_name, street, city)
VALUES
('Emma Johnson', 'Oak Street', 'San Francisco'),
('Liam Smith', 'Elm Avenue', 'New York'),
('Olivia Brown', 'Maple Lane', 'Los Angeles'),
('Noah Wilson', 'Pine Road', 'Chicago'),
('Ava Davis', 'Cedar Drive', 'Houston'),
('Sophia Martinez', 'Birch Court', 'Miami'),
('Jackson Lee', 'Willow Circle', 'New York'),
('Harper Taylor', 'Redwood Boulevard', 'Seattle'),
('Mia Anderson', 'Aspen Way', 'New York'),
('Benjamin Thomas', 'Sycamore Lane', 'Boston'),
('Amelia Harris', 'Baker Street', 'London'), -- Europe
('Sophie Turner', 'Willow Lane', 'London'), -- Europe
('Charlotte Allen', 'Cedar Street', 'Paris'), -- Europe
('William Wright', 'Birchwood Drive', 'Shenzhen'), -- Asia
('Evelyn Scott', 'Pinecrest Drive', 'Shenzhen'), -- Asia
('James Turner', 'Willowbrook Lane', 'Shanghai'), -- Asia
('Sofia Rodriguez', 'Redwood Lane', 'Shenzhen'), -- Asia
('Oliver Lewis', 'Maplewood Avenue', 'Sydney'), -- Australia
('Mia Adams', 'Magnolia Drive', 'Toronto'), -- Canada
('Liam Parker', 'Cedar Lane', 'Vancouver'); -- Canada

INSERT INTO Company (company_name, city)
VALUES
('Tech Solutions USA', 'San Francisco'), -- USA
('Big Apple Innovations', 'New York'), -- USA
('EuroTech GmbH', 'Berlin'), -- Europe
('Paris Software Systems', 'Paris'), -- Europe
('London Data Insights Ltd', 'London'), -- UK
('Tokyo MetroTech Services', 'Tokyo'), -- Asia
('Hong Kong Swift Software', 'Hong Kong'), -- Asia
('Hong Kong Technology University', 'Hong Kong'); -- Asia

INSERT INTO Works (personal_name, company_name, salary)
VALUES
('Emma Johnson', 'Tech Solutions USA', 70000),
('Liam Smith', 'Big Apple Innovations', 80000),
('Olivia Brown', 'Big Apple Innovations', 90000),
('Noah Wilson', 'Tech Solutions USA', 100000),
('Ava Davis', 'EuroTech GmbH', 110000),
('Sophia Martinez', 'Hong Kong Swift Software', 120000),
('Jackson Lee', 'Tokyo MetroTech Services', 130000),
('Harper Taylor', 'Paris Software Systems', 140000),
('Mia Anderson', 'Paris Software Systems', 150000),
('Benjamin Thomas', 'Big Apple Innovations', 160000),
('Amelia Harris', 'London Data Insights Ltd', 170000),
('Charlotte Allen', 'Paris Software Systems', 190000),
('William Wright', 'Tokyo MetroTech Services', 200000),
('Sophie Turner', 'Tokyo MetroTech Services', 270000),
('Evelyn Scott', 'Hong Kong Swift Software', 70000),
('James Turner', 'Hong Kong Technology University', 80000),
('Sofia Rodriguez', 'Hong Kong Technology University', 90000),
('Oliver Lewis', 'Hong Kong Swift Software', 100000),
('Mia Adams', 'Paris Software Systems', 110000),
('Liam Parker', 'Big Apple Innovations', 120000);

INSERT INTO Manages (personal_name, manager_name)
VALUES
('Emma Johnson', 'Noah Wilson'),
('Liam Smith', 'Olivia Brown'),
('Olivia Brown', 'Liam Parker'),
('Liam Parker', 'Benjamin Thomas'),
('Evelyn Scott', 'Oliver Lewis'),
('Oliver Lewis', 'Sophia Martinez'),
('James Turner', 'Sofia Rodriguez'),
('Mia Adams', 'Harper Taylor'),
('Harper Taylor', 'Mia Anderson'),
('Mia Anderson', 'Charlotte Allen'),
('Jackson Lee', 'William Wright'),
('William Wright', 'Sophie Turner');


## 1. Find the names of all persons who live in 'New York'
## write your code and assumption here...
## assume the city field is correctly populated
## 'Jackson Lee', 'Liam Smith', 'Mia Anderson'
SELECT personal_name
FROM Employee
WHERE city = 'New York';


## 2. Find the names of all persons who live in "London" but not live in "Baker Street"
## write your code and assumption here...
## assume the city and street fields are correctly populated
## 'Sophie Turner'
SELECT personal_name
FROM Employee
WHERE city = 'London' AND street NOt LIKE '%Baker Street%';


## 3. Find the names of all managers who have employee(s) earning less than $100,000
## write your code and assumption here...
## 'Noah Wilson', 'Oliver Lewis', 'Sofia Rodriguez', 'Olivia Brown', 'Liam Parker'
SELECT manager_name
FROM Manages m JOIN Works w
ON m.personal_name = w.personal_name
WHERE salary < 100000;


## 4. Find the employees that live in 'Shenzhen' but hold a job in ALL companies located in 'Hong Kong'.
## write your code and assumption here...
## 'Evelyn Scott', 'Sofia Rodriguez'
SELECT e.personal_name
FROM Employee e JOIN Works w
ON e.personal_name = w.personal_name
WHERE city = 'Shenzhen' AND company_name in (SELECT company_name
                                             FROM Company
                                             WHERE city = 'Hong Kong');




######################################################################
## Exercise 2:
## Consider the following Supplier-Part-Project database
## Suppliers: Supplier(SupplierID, SupplierName, City)
## Parts: Part(PartID, PartName, Color)
## Projects: Project(ProjectID, ProjectName, City)
## Shipment: Shipment(SupplierID, PartID, ProjectID, Quantity)

## 0. Create the database and tables
DROP DATABASE IF EXISTS shipping;
CREATE DATABASE shipping;
USE shipping;

CREATE TABLE Supplier (
SupplierID INT NOT NULL PRIMARY KEY,
SupplierName VARCHAR(255) NOT NULL,
City VARCHAR(255) NOT NULL
);

CREATE TABLE Part (
PartID INT NOT NULL PRIMARY KEY,
PartName VARCHAR(255) NOT NULL,
Color VARCHAR(255) NOT NULL
);

CREATE TABLE Project (
ProjectID INT NOT NULL PRIMARY KEY,
ProjectName VARCHAR(255) NOT NULL,
City VARCHAR(255) NOT NULL
);

INSERT INTO Supplier (SupplierID, SupplierName, City)
VALUES
(1, 'SupplierOne', 'London'),
(2, 'SupplierTwo', 'London'),
(3, 'SupplierThree', 'London'),
(4, 'SupplierFour', 'San Francisco'),
(5, 'SupplierFive', 'New York'),
(6, 'SupplierSix', 'New York'),
(7, 'SupplierSeven', 'New York');

INSERT INTO Part (PartID, PartName, Color)
VALUES
(1, 'PartOne', 'Red'),
(2, 'PartTwo', 'Orange'),
(3, 'PartThree', 'Yellow'),
(4, 'PartFour', 'Green'),
(5, 'PartFive', 'Blue'),
(6, 'PartSix', 'Indigo'),
(7, 'PartSeven', 'Violet');

INSERT INTO Project (ProjectID, ProjectName, City)
VALUES
(1, 'ProjectOne', 'Chicago'),
(2, 'ProjectTwo', 'Chicago'),
(3, 'ProjectThree', 'Paris'),
(4, 'ProjectFour', 'Paris'),
(5, 'ProjectFive', 'Paris'),
(6, 'ProjectSix', 'Miami'),
(7, 'ProjectSeven', 'Miami');


## 1. Use the CREATE TABLE statement for creating the Shipments table. 
## Include all the referential integrity constraints (primary key, foreign key) in the table. 
## Assume that all attributes are integers.
## write your code and assumption here...
CREATE TABLE Shipment (
SupplierID INT NOT NULL,
PartID INT NOT NULL, 
ProjectID INT NOT NULL,
Quantity INT NOT NULL,
PRIMARY KEY (SupplierID, PartID, ProjectID),
FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
FOREIGN KEY (PartID) REFERENCES Part(PartID),
FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);
   
   
## 1.5 Insert data into the table
INSERT INTO Shipment (SupplierID, PartID, ProjectID, Quantity)
VALUES
(1, 2, 3, 50),
(2, 3, 4, 60),
(3, 4, 5, 70),
(4, 5, 6, 80),
(5, 6, 7, 90),
(6, 7, 1, 100),
(7, 1, 2, 110),
(1, 2, 4, 120),
(2, 4, 5, 130),
(3, 5, 6, 140),
(4, 6, 7, 150),
(5, 7, 1, 160),
(6, 1, 2, 170),
(1, 2, 5, 180),
(1, 4, 5, 190);


## 2. Create and display a view "LONDON_SUPPLIERS" which only contains the names of suppliers in London
## write your code and assumption here...
## SupplierOne, SupplierTwo, SupplierThree
CREATE VIEW LONDON_SUPPLIERS AS (
	SELECT SupplierName 
    FROM Supplier
    WHERE City = 'London'
);
SELECT * from LONDON_SUPPLIERS;


## 3. Get the (distinct) colors of the parts supplied by suppliers in London to projects in Paris.
## Display the results in alphabetical order.
## write your code and assumption here...
## Green, Orange, Yellow
SELECT DISTINCT Part.Color
FROM Supplier, Part, Project, Shipment
WHERE Supplier.City = 'London' AND Project.City = 'Paris' AND Shipment.SupplierID = Supplier.SupplierID 
	AND Shipment.PartID = Part.PartID AND Shipment.ProjectID = Project.ProjectID
ORDER BY Part.Color;


## 4. Get the total number of parts supplied by supplier 1 to each project.
## write your code and assumption here...
# project 3: 1 part, project 4: 1 part, project 5: 2 parts
SELECT ProjectID, count(PartID)
FROM Shipment
WHERE SupplierID = 1
GROUP BY ProjectID;


## 5. Get dinstinct project numbers for projects that are supplied by every supplier in London.
## write your code and assumption here...
## ProjectID 5
SELECT DISTINCT Shipment.ProjectID
FROM Shipment
WHERE Shipment.SupplierID IN ( -- select shipment with suppliers in London
    SELECT SupplierID
    FROM Supplier
    WHERE City = 'London'
)
GROUP BY Shipment.ProjectID
HAVING COUNT(DISTINCT Shipment.SupplierID) = ( -- check if the no of suppliers of such project equals to that in London
    SELECT COUNT(*) -- count the number of suppliers in London
    FROM Supplier
    WHERE City = 'London'
);



## 1. Build the Restaurants database 

DROP DATABASE IF EXISTS restaurants; #drop it if it exists
CREATE DATABASE restaurants;
USE restaurants;

## 2. Build the Restaurant table

CREATE TABLE Restaurant(
  restaurantID int PRIMARY KEY AUTO_INCREMENT,
  restName varchar(255) NOT NULL,
  cuisine varchar(255) NOT NULL,
  borough varchar(255) NOT NULL,
  yearEst int NOT NULL,
  avgPrice int NOT NULL
);

## 3. Build the Reviewer table

CREATE TABLE Reviewer (
  reviewerID int PRIMARY KEY AUTO_INCREMENT,
  firstName varchar(255) NOT NULL,
  lastName varchar(255) NOT NULL,
  affiliation varchar(255) DEFAULT NULL
);

## 4. Populate the Restaurant table

INSERT INTO Restaurant(restName, cuisine, borough, yearEst, avgPrice) VALUES
('Pok Pok', 'Thai', 'Brooklyn', 2005, 100),
('Kiin Thai', 'Thai', 'Manhattan', 2013, 75),
('Carbone', 'Italian', 'Manhattan', 2010, 150),
('Il Mulino', 'Italian', 'Manhattan', 1999, 250),
('Don Peppe', 'Italian', 'Queens', 1998, 75),
('Loukoumi Taverna', 'Greek', 'Queens', 1994, 130),
('Nisi', 'Greek', 'Manhattan', 2014, 100),
('Ela Taverna', 'Greek', 'Brooklyn', 2015, 150);

## 5. Query the Restaurant table to see all records

SELECT * FROM Restaurant;

## 6. Populate the Reviewer table

INSERT INTO Reviewer (firstName, lastName, affiliation) VALUES
('Sarah', 'Martinez', 'NYT'),
('Brittany', 'Harris', 'Vogue'),
('Ashley', 'White', 'NYT'),
('Elizabeth', 'Thomas', 'Chronicle'),
('Chris', 'Jackson', 'NYT');

## 7. Query the Reviewer table to see all records

SELECT * FROM Reviewer;

## 8.Build the Rating table

CREATE TABLE Rating (
  ratingID int PRIMARY KEY AUTO_INCREMENT,
  starRating int NOT NULL,
  ratingDate date DEFAULT NULL,
  comments varchar(255) DEFAULT NULL,   
  restaurantID int NOT NULL,
  reviewerID int NOT NULL,   
  CONSTRAINT Rating_restaurantID_fk FOREIGN KEY (restaurantID) REFERENCES Restaurant(restaurantID) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT Rating_reviewerID_fk FOREIGN KEY (reviewerID) REFERENCES Reviewer(reviewerID) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT Rating_chk_1 CHECK ((starRating <= 5)) #modify your check
);


## 9. Query the Ratings table to see all records. Populate the table for homework

Select * from Rating;

## 10. Look at the your tables

DESCRIBE Restaurant;
DESCRIBE Reviewer;
DESCRIBE Rating;

## 11. Issue some basic queries

#query 1.

SELECT restName FROM Restaurant;

#query 2. 

SELECT starRating FROM Rating; # need data for this (test out for homework)

SELECT * FROM Restaurant;
SELECT * FROM Reviewer;


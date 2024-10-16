DROP DATABASE IF EXISTS Restaurant;
create database Restaurant;
USE Restaurant;
Drop table if exists Restaurant;
CREATE TABLE Restaurant (
	RestaurtantID INT PRIMARY KEY AUTO_INCREMENT,
	RestName VARCHAR(255) not null,
	Borough VARCHAR(255) NOT NULL,
	cuisine VARCHAR(255),
	YearEst INT NOT NULL,
	avgPrice INT NOT NULL
);
CREATE TABLE Rating (
	RatingID INT PRIMARY KEY AUTO_INCREMENT,
	StarRating INT,
	RatingDate Date, 
	comments VARCHAR(255),
	 RestName VARCHAR(255) not null,
     firstN VARCHAR(255),
     lastN VARCHAR(255)
);
show tables;

Describe Restaurant;
Describe Rating;

INSERT INTO Restaurant (RestName, Borough, cuisine, YearEst, avgPrice) VALUES
('Pok Pok','Brooklyn','Thai',2005,100), 
('Kiin Thai','Manhattan','Thai',2013,75),
('Carbone','Manhattan','Italian',2010,150), 
('Il Mulino','Manhattan','Italian',1999,250),
('Don Peppe','Queens','Italian',1998,75),
('Loukoumi Taverna','Queens','Greek',1994,130),
('Nisi','Manhattan','Greek',2014,100),
('Ela Taverna','Brooklyn','Greek',2015,150);

select * from Restaurant;

Describe Rating;

INSERT INTO Rating (StarRating, RatingDate, comments, RestName, firstN, lastN) VALUES
(2,STR_TO_DATE('11/13/14', '%m/%d/%y'),'Good food, bad service','Pok Pok','Sarah','Martinez'), 
(2,STR_TO_DATE('2/1/15', '%m/%d/%y'),'Disappointed','Kiin Thai','Brittany','Harris'),
(2,STR_TO_DATE('6/30/03', '%m/%d/%y'),'Overpriced','Carbone','Ashley','While'), 
(3,NULL,NULL,'Il Mulino',NULL,NULL),
(3,NULL,NULL,'Don Peppe',NULL,NULL),
(5,STR_TO_DATE('12/21/01', '%m/%d/%y'),'Loved everything','Loukoumi Taverna','Elizabeth','Thomas'),
(3,STR_TO_DATE('7/2/16', '%m/%d/%y'),'Great food, rude staff','Nisi','Elizabeth','Thomas'),
(5,NULL,'Must try fish','Ela Taverna','Chris','Jackson');

SELECT * from Rating;

# Make a new table to see comments on the restaurants and it's cuisine
Create table RestComment as SELECT Rating.RestName, Rating.comments, Restaurant.cuisine
FROM Rating
LEFT JOIN Restaurant ON Rating.RestName = Restaurant.RestName;
Select * from RestComment;

# Add columns to tell the reviwer's name of the comments
SELECT RestComment.*, Rating.firstN, Rating.lastN
FROM Rating
LEFT JOIN RestComment ON Rating.comments = RestComment.comments;
USE Restaurant;
# I appologise that I made a mistake about created the wrong table for last homework(I created the table Rating instead of Reviewer for last HW). But I- 
# -do understand the basic logic of how to create table and insert data into it. So I hope it not going to affact my credit too much. 
#For here, I will Create the both table.
CREATE TABLE Reviewer (
  reviewerID int PRIMARY KEY AUTO_INCREMENT,
  firstName varchar(255) NOT NULL,
  lastName varchar(255) NOT NULL,
  affiliation varchar(255) DEFAULT NULL
);

INSERT INTO Reviewer (firstName, lastName, affiliation) VALUES
('Sarah', 'Martinez', 'NYT'),
('Brittany', 'Harris', 'Vogue'),
('Ashley', 'White', 'NYT'),
('Elizabeth', 'Thomas', 'Chronicle'),
('Chris', 'Jackson', 'NYT');

# To show my understanding on the logic of how to create table and insert data, I will drop and rebuild the table again.
DROP TABLE if exists Rating;

CREATE TABLE Rating (
	RatingID INT PRIMARY KEY AUTO_INCREMENT,
	StarRating INT,
	RatingDate Date, 
	comments VARCHAR(255),
	 RestName VARCHAR(255) not null,
     firstN VARCHAR(255),
     lastN VARCHAR(255)
);

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

Alter table Restaurant
add streetAddress varchar(255) not null,
add city varchar(255)not null,
add state varchar(255)not null,
add zipCode int,
add status varchar(255)not null;

Create table RestADD(
RestID varchar(255),
streetAddress varchar(255) not null,
city varchar(255)not null,
state varchar(255)not null,
zipCode int,
status varchar(255)not null);

select * from Restaurant;

Insert into RestADD (RestID,streetAddress, city, state,zipCode,status) VALUES
('Pok Pok','117 Columbia St', 'Brooklyn', 'NY','11231','close'),
('Kiin Thai','36 E 8th St', 'NewYork', 'NY','10003','close'),
('Carbone','181 Thompson St', 'NewYork', 'NY','10012','open'),
('Il Mulino','86 W 3rd St', 'NewYork', 'NY','10012','open'),
('Don Peppe','135-58 Lefferts Blvd', 'South Ozone Park', 'NY','11420','open'),
('Loukoumi Taverna','45-07 Ditmars Blvd', 'Astoria', 'NY','11105','open'),
('Nisi','549 Main St', 'NewYork', 'NY','10044','open'),
('Ela Taverna','946 Manhattan Ave', 'Brooklyn', 'NY','11222','close');



SET SQL_SAFE_UPDATES = 0;

Update Restaurant
Left join RestADD on Restaurant.restName = RestADD.RestID
set Restaurant.streetAddress = RestADD.streetAddress,
Restaurant.city = RestADD.city,
Restaurant.state = RestADD.state,
Restaurant.zipCode = RestADD.zipCode,
Restaurant.status = RestADD.status;
select * from Restaurant;

Describe Rating;

SELECT * 
FROM Restaurant
LEFT JOIN 
  (SELECT restName, StarRating FROM Rating) AS Rating
ON Rating.restName = Restaurant.restName
WHERE Restaurant.status = 'open';
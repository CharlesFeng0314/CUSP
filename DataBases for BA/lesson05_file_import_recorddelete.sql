
USE restaurants_a;
SHOW TABLES;
SELECT * FROM Restaurant;
SELECT * FROM Rating;
SELECT * FROM Reviewer;
#DELETE FROM Rating WHERE ratingID > 25; # overrides safe mode

/*INSERT INTO Rating (restaurantID, reviewerID, starRating, ratingDate, comments) VALUES
  (1, 1, 2, '2014-11-13', 'Good food, bad service'),
  (3, 2, 2, '2015-02-01', 'Disappointed'),
  (4, 3, 3, '2003-06-30', 'Overpriced'), 
  (6, 4, 5, '2001-12-21', 'Loved everything'),
  (7, 4, 3, '2016-07-02', 'Great food, rude staff'),
  (8, 5, 4, NULL, 'Must try fish'); #NOTE I ADDED 0 here. Change it to 10. Change it back to 4*/

##IMPORT DATA USING WIZARD(8 records)
SELECT * FROM Rating;

## CREATE VIEW OF RESTAURANT RATINGS FOR ALL RESTAURANTS 

CREATE VIEW all_ratings as
SELECT a.restName, b.starRating
FROM Restaurant as a
LEFT JOIN Rating as b
ON a.restaurantID = b.restaurantID;

SELECT * FROM all_ratings;

DESCRIBE Restaurant;

## CREATE VIEW OF RESTAURANT AND AVERAGE RATING FOR OPEN RESTAURANTS ##
USE restaurants_a;

/*CREATE VIEW av_rates as
SELECT a.restName, avg(b.starRating) as average_rating
FROM Restaurant as a
LEFT JOIN Rating as b
ON a.restaurantID = b.restaurantID
WHERE a.status = 'open'
GROUP BY a.restName;*/


SELECT * FROM av_rates;
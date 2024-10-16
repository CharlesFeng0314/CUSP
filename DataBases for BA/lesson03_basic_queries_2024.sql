# Databases for Business Analytics
# Fall 2024 | Lesson 3

# Be sure you have connect to the "Class" DBMS instance, not your own.
/*
The USE, SHOW, and DESCRIBE keywords 
*/

#1a. Display all the databases
SHOW DATABASES;

/* Exercises 1-3: USE, SHOW, and DESCRIBE
*/

#1b. Set your database schema to bike_sharing
USE bike_sharing;

#2. Display all of the entities in the schema
SHOW TABLES;

#3. Display the attributes and data types of those attributes of the table daily
DESCRIBE daily;
use bike_sharing;

##Sample queries###
SELECT * FROM daily;
select dteday from daily where atemp>=32;
select * from daily;

SELECT * FROM daily WHERE  yr=1;
SELECT mnth FROM daily WHERE yr !=0;
SELECT dteday FROM daily As Date1 WHERE registered >=1000 AND registered <= 2000;



/* 
Exercises 4-6: USING THE SELECT, WHERE, AND keywords 
along with logical and comparison operators to issue queries
*/

#4. Write a query to show those rows for April 2011 
SELECT * FROM daily WHERE yr=0 AND mnth=4;

#5. Write a query to show those days with normalized feeling temperatures 32 or greater.
SELECT * FROM daily WHERE atemp >=.32; 

#6. Show the dates and the total rentals for when the total rentals exceeded 8000.
SELECT dteday, cnt FROM daily WHERE cnt >8000;  

/* 
Using the AS keyword to change the way a column name is displayed in the results set
*/

#7. Use the alias DATE to select the dteday and the alias MEMBERS to select registered users for the year 2012 (noted as 1, in the yr column).  
SELECT dteday AS 'DATE', registered AS 'MEMBERS' FROM daily WHERE yr=1; # note required comma, quotes are optional
show tables;

/* 
Using the LIMIT keyword  to show only a certain number of records
*/

#8. Show casual riders in August 2012. Limit the results to 5 rows.
SELECT casual FROM daily WHERE yr=1 AND mnth=8;

/* 
Using the ORDER BY and DESC keywords to show results in descending or ascending order, the NOT IN keyword 
to select records except for those specified and to show unique values using SELECT DISTINCT. 
*/

#9. Show all records by holiday in descending order.
SELECT  * FROM daily ORDER BY holiday DESC;

#10. Show all records where the season is not winter or fall.
SELECT  * FROM daily WHERE season NOT IN (1,4);

#11. show the unique values for the holiday field in the daily table.
SELECT DISTINCT (holiday) FROM daily; # parentheses not required

/*
Using the BETWEEN keyword to show values within a range (inclusive)
*/

#12. Show those dates where the temperature is within the range of .80 and .90.
SELECT dteday, temp from daily WHERE temp BETWEEN .80 AND .90;

/*
Using the imdb database to write SELECT statements with the LIKE keyword. 
*/

#13. Use the imdb database to show those movie titles that begin with Amer.

USE imdb;
SHOW TABLES;
DESCRIBE movies;
SELECT * FROM movies WHERE name LIKE 'Amer%';

#14. Use the imdb database to show those directors whose last name ends in or.
show tables;
DESCRIBE directors;

SELECT * FROM directors WHERE last_name LIKE '%or';  

#15. Show all movies where the rating is greater than 8.9 and less than 9.9.
SELECT * FROM movies WHERE rating >8.9 AND rating <9.9;
select * from movies where year like '%96';

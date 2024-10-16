/* Lesson 5: Airports Database*/

# Activity 1: Accessing the flights database and understanding the table structure
###Exercise 1###
SHOW DATABASES;

USE flights;
SHOW TABLES;

DESCRIBE m_airports;
SELECT * FROM m_airports;

DESCRIBE m_ticket_prices;
SELECT * FROM m_ticket_prices;


###Exercise 2###
# Write a query to show all columns in the m_ticket_prices table for delta flights that originate at JFK.
SELECT * FROM m_ticket_prices WHERE carrier="DL" and origin="JFK";

# Activity 2: Joins
###Exercise 1###
# Write a query to show the state, carrier, and destination for all of the flights. Order by state.
show tables;
select a.state, t.carrier, t.dest
from m_ticket_prices as t
left join m_airports as a
on t.origin = a.airport
order by a.state desc;





SELECT a.state_name as State, b.carrier, b.dest
FROM m_airports as a
INNER JOIN m_ticket_prices as b
ON a.airport = b.dest
ORDER BY a.state_name DESC;

###Exercise 2###
#Compute the total revenue per flight. Show all the columns.
DESCRIBE m_ticket_prices;

SELECT *, fare * passengers as total_flight_revenue FROM m_ticket_prices;

###Exercise 3###
#Compute the total revenue per flight for Delta. Show all the columns.
SELECT *, fare * passengers as total_flight_revenue FROM m_ticket_prices 
having carrier = 'DL';


SELECT *, fare * passengers as total_flight_revenue FROM m_ticket_prices WHERE carrier = "DL";

###Exercise 4###
#Compute the total revenue all the flights.
SELECT FORMAT(SUM(fare * passengers),2) as total_revenue FROM m_ticket_prices;

# Activity 3: 
###EXAMPLE 0###
# Show the passengers column
SELECT passengers FROM m_ticket_prices;

# Show the total number of passengers
SELECT SUM(passengers) FROM m_ticket_prices;

###EXAMPLE 1###
#SUM FUNCTION with GROUP BY. Shows the # of passengers by origin (Value of ABE 7818)
SELECT origin, SUM(passengers) FROM m_ticket_prices GROUP BY origin; 

###EXAMPLE 2###
/*SUM FUNCTION with GROUP BY. Shows the # of passengers by origin first, then by carrier
Note ABE is repeated for all the carriers and the sum values are the sum of passengers by carrier by origin*/
SELECT origin, carrier, SUM(passengers) FROM m_ticket_prices GROUP BY origin, carrier; 

###EXAMPLE 3###
#SUM FUNCTION with WHERE and GROUP BY
SELECT origin, carrier, SUM(passengers) FROM m_ticket_prices WHERE carrier="DL" GROUP BY origin; 
SELECT origin, carrier, SUM(passengers) FROM m_ticket_prices WHERE carrier IN ("DL","AA") GROUP BY origin, carrier; 

###EXAMPLE 4###
#AVG FUNCTION with GROUP BY

SELECT origin, AVG(passengers) from m_ticket_prices GROUP BY origin; 
#>>>>>COMPARE IT TO THE SUM 7818 vs 113.30 (AVG)  
SELECT origin, SUM(passengers) from m_ticket_prices GROUP BY origin;

###EXAMPLE 5###
SELECT origin, MIN(passengers), MAX(passengers) FROM m_ticket_prices GROUP BY origin; 

###EXAMPLE 6###
SELECT COUNT(*) from m_ticket_prices;
SELECT COUNT(carrier)  FROM m_ticket_prices;
	
###EXAMPLE 7###
SELECT COUNT(DISTINCT carrier) FROM m_ticket_prices;

###EXAMPLE 8###

SELECT *, ROW_NUMBER() OVER(ORDER BY fare DESC) FROM m_ticket_prices WHERE carrier = 'DL' and dest='JFK';

###EXAMPLE 9###

SELECT *, RANK() OVER(ORDER BY fare DESC) FROM m_ticket_prices WHERE carrier = 'DL' and dest='JFK';

###EXAMPLE 10###

SELECT *, DENSE_RANK() OVER(ORDER BY fare DESC) FROM m_ticket_prices WHERE carrier = 'DL' and dest='JFK';

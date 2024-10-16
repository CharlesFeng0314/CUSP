/*LESSON 6: Illustrating the use of databases and python

Use lesson06.sql and 
https://colab.research.google.com/drive/1xEXrsdwZEhlM4jCZ0a9W3-rX-02a_0T6?usp=sharing#scrollTo=M-MkDj7sO9hS 

*/

DROP DATABASE IF EXISTS mba;
SHOW DATABASES;

# create mba database

CREATE DATABASE mba;
USE mba;

CREATE TABLE schools (
id INT PRIMARY KEY AUTO_INCREMENT,
    schoolrank INT,
    School VARCHAR(255),
    Country VARCHAR(255),
    AvgSalary INT,
    PreSalary INT,
    GradJobs INT
);

USE mba;
SHOW TABLES;
DESCRIBE schools;
USE Restaurant;

Alter table Restaurant
modify avgPrice varchar(255),
modify RestName varchar(255),
modify Borough varchar(255),
modify YearEst varchar(255),
modify streetAddress varchar(255),
modify city varchar(255),
modify state varchar(255),
modify status varchar(255),
modify zipCode varchar(255);


describe Restaurant;

Create view cuisine_count as
select cuisine, count(RestaurantID) from Restaurant
group by cuisine;

select * from cuisine_count;

select * from Restaurant;

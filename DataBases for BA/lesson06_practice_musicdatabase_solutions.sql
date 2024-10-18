## LESSON 6 - PRACTICE WITH QUERIES AND JOINS

USE music;
SHOW TABLES;
DESCRIBE artist;
DESCRIBE album;
DESCRIBE track;
DESCRIBE users;
DESCRIBE tracks_played;

#1. Count the number of artists in the database
SELECT COUNT(*) FROM artist; 
SELECT COUNT(DISTINCT artist_name) FROM artist; #alternative
SELECT * FROM artist; # to show that each artist is indeed unique

#2. Count the number of tracks in the database

SELECT COUNT(*) FROM track; # a single #

#3. Show the average and standard deviation of the track length using STDDEV(time)
SELECT ROUND(AVG(time),2), ROUND(STDDEV(time),2) FROM track; # two metrics

#4. For each artist, count the number of albums in the database. You only need to show the id of the artist, not the name of the artist.
SELECT artist_id, COUNT(album_id) AS cnt_albums 
FROM album 
GROUP BY artist_id; #You should expect to see 6 artists

#5. For each album, count the number of tracks for that album and the total length of all the tracks in the album. You only need to show the id of the album, not its name.
SELECT artist_id, album_id, COUNT(track_id) AS cnt_tracks, SUM(time) AS total_time
FROM track
GROUP BY artist_id, album_id; # one row per artist / alumn combo

#6. List all the album id's, where the total album length (across all the album's tracks) is longer than 60 minutes.
SELECT artist_id, album_id, SUM(time) AS total_time
FROM track
GROUP BY artist_id, album_id
HAVING SUM(time) > 60; # filters out 5 out of the 13 albums

#7.  For each user, show the total tracks they played and the total amount of time they listened. Assume that each track is played fully.
# Adding the users table and the LEFT JOIN are not necessary.
# However, they allow us to see that two users have not played any music
# First let's find the number of users and see who they are
SELECT COUNT(*) FROM users; #10
SELECT * FROM users; # show the users 

SELECT U.user_id, COUNT(T.track_id) AS tracks_played, SUM(T.time) AS total_time
FROM users U
    LEFT JOIN tracks_played P ON U.user_id = P.user_id
    LEFT JOIN track T ON T.artist_id = P.artist_id AND T.album_id = P.album_id AND T.track_id = P.track_id
GROUP BY U.user_id
ORDER BY U.user_id; # order by isn't necessary

#8. For every day listed in the tracked_played table, show the name of the artist, the artist id, the number of users that listened to the artist, and the total amount of time that users listened to the artist. Assume that each track is played fully.
# Start with understandng the Tracked played
SELECT played_on FROM tracks_played;
SELECT DATE(played_on) FROM tracks_played; # date function shortens to Date, rather then date time

## Result set shows artist repeated by date
SELECT DATE(played_on) AS date_played, A.artist_id, A.artist_name
        ,  COUNT(DISTINCT user_id) AS users
        , SUM(T.time) AS total_time
        , COUNT(*) AS total_tracks
FROM tracks_played P
    JOIN artist A ON P.artist_id = A.artist_id
    JOIN track T ON P.track_id = T.track_id AND P.album_id = T.album_id AND P.artist_id = T.artist_id
GROUP BY date_played, A.artist_id
ORDER BY date_played, A.artist_id;

# 9. Show the name of the artist and the number of albums for each artist in the database. Name the column that shows the number of albums as num_albums.
# You can get the same result without the artist_id
# and without artist_id is also a correct answer.
SELECT R.artist_id, R.artist_name, COUNT(*) AS num_albums
FROM artist R JOIN album A ON A.artist_id = R.artist_id
GROUP BY R.artist_id, R.artist_name; # not necessary to group by artist name


# 10. Show the name of each track and the first and last time it was played. Include tracks that were not played at all. (Hint: You need an LEFT join.)
SELECT T.artist_id, T.album_id, T.track_id, T.track_name, MIN(played_on), MAX(played_on)
FROM track T  
    LEFT JOIN tracks_played P ON T.artist_id = P.artist_id AND T.album_id = P.album_id AND T.track_id = P.track_id
GROUP BY T.artist_id, T.album_id, T.track_id;
#Shows each track by aristic and album


#11. List all the album names by the band New Order
##Start with a basic select:
SELECT *
FROM artist;

## Then inner join with album using artist id

SELECT *
FROM artist R JOIN album A ON A.artist_id = R.artist_id
WHERE R.artist_name = 'New Order';


#12. List the tracks for the album Second Coming
# START WITH A SELECT
SELECT * FROM track;

SELECT T.*
FROM track T 
     JOIN album A ON A.artist_id = T.artist_id AND A.album_id = T.album_id
WHERE A.album_name = 'Second Coming';


#13. List all the track names, the corresponding album name, and the corresponding artist name
SELECT track_name, artist_name, album_name
FROM track T
  JOIN artist R ON T.artist_id = R.artist_id
  JOIN album A ON A.album_id = T.album_id AND A.artist_id = T.artist_id;

#14. List all the tracks by the 
# artist The Stone Roses and rank them by time length, from shortest to longest

SELECT T.*
FROM track T
  JOIN artist R ON T.artist_id = R.artist_id
WHERE R.artist_name = 'The Stone Roses'
ORDER BY T.time;

#15. The table tracks_played contains the tracks 
#the users listened to and the time they listened to the songs. Show the user's first and last name, the user id, 
# the album name, the track name, and the date/time it was played.

SELECT U.user_id, U.first_name, U.last_name, A.album_name, T.track_name, P.played_on
FROM tracks_played P 
    JOIN users U ON U.user_id = P.user_id
    JOIN track T ON P.artist_id = T.artist_id AND P.album_id = T.album_id AND P.track_id = T.track_id
    JOIN album A ON P.artist_id = A.artist_id AND P.album_id = A.album_id
ORDER BY user_id, played_on;

#16. List the first and last names of the users that have not listened to any tracks.
# Start with a select * from tracks_played and users

SELECT * FROM tracks_played;

SELECT * FROM users; # trying to see which users in user table are not in tracks_played

SELECT U.first_name, U.last_name
FROM users U 
    LEFT JOIN tracks_played P ON U.user_id = P.user_id 
WHERE P.user_id IS NULL;


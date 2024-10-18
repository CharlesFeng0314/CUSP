## LESSON 6 - PRACTICE WITH QUERIES AND JOINS

USE music;
SHOW TABLES;
DESCRIBE artist;
DESCRIBE album;
DESCRIBE track;
DESCRIBE users;
DESCRIBE tracks_played;

#1. Count the number of artists in the database


#2. Count the number of tracks in the database



#3. Show the average and standard deviation of the track length using STDDEV(time)



#4. For each artist, count the number of albums in the database. You only need to show the id of the artist, not the name of the artist.


#5. For each album, count the number of tracks for that album and the total length of all the tracks in the album. You only need to show the id of the album, not its name.



#6. List all the album id's, where the total album length (across all the album's tracks) is longer than 60 minutes.




#7.  For each user, show the total tracks they played and the total amount of time they listened. Assume that each track is played fully.
# Adding the users table and the LEFT JOIN are not necessary.
# However, they allow us to see that two users have not played any music




#8. For every day listed in the tracked_played table, show the name of the artist, the artist id, the number of users that listened to the artist, and the total amount of time that users listened to the artist. Assume that each track is played fully.




# 9. Show the name of the artist and the number of albums for each artist in the database. Name the column that shows the number of albums as num_albums.
# You can get the same result without the artist_id
# and without artist_id is also a correct answer.




# 10. Show the name of each track and the first and last time it was played. Include tracks that were not played at all. (Hint: You need an LEFT join.)





#11. List all the album names by the band New Order




#12. List the tracks for the album Second Coming



#13. List all the track names, the corresponding album name, and the corresponding artist name



#14. List all the tracks by the artist The Stone Roses and rank them by time length, from shortest to longest




#15. The table tracks_played contains the tracks the users listened to and the time they listened to the songs. Show the user's first and last name, the user id, the album name, the track name, and the date/time it was played.




#16. List the first and last names of the users that have not listened to any tracks.

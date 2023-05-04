
use ig_clone;
-- Q1 To draw schema or crate ER diagram
-- added a pdf file for the same

-- Q2 We want to reward the user who has been around the longest. Find the 5 oldest users.
select * from users;

select id, username, created_at from users order by (created_at) limit 5;


-- Q3 Find out the day of the week most user register on
select * from users;

select dayname(Created_at) as week, count(id) as registered_user from users group by week;


-- Q4 Find the users who have never posted a photo
SELECT * FROM photos;
SELECT * FROM users;

 SELECT username AS users, users.id AS user_id 
 FROM users 
 WHERE users.id NOT IN (
 SELECT photos.user_id FROM photos);
 
 
 -- Q5 Suppose you are runnung a contest to find out who got the most likes on a photo. Find out who won?
SELECT * FROM likes;
SELECT * FROM ig_clone.photos;

SELECT photos.user_id, COUNT(likes.photo_id) AS most_likes
FROM photos
INNER JOIN likes ON photos.id = likes.photo_id
GROUP BY photos.user_id
ORDER BY most_likes desc
limit 1
;


-- Q6 The investors want to know how many times does the average user post
SELECT * FROM ig_clone.photos;
SELECT * FROM ig_clone.users;

select avg(post_count) from(select user_id, count(*) as post_count from photos group by user_id)temp;


-- Q7 to find top 5 most used hashtags
SELECT * FROM ig_clone.photo_tags;
SELECT * FROM ig_clone.tags;

SELECT tag_name, COUNT(tag_name) AS frequency
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY frequency DESC
LIMIT 5; 

-- Q8 Find the users who have liked every single photo on the site
select * from likes;
select * from users;

SELECT user_id
FROM likes
GROUP BY user_id
HAVING COUNT(DISTINCT photo_id) in (SELECT COUNT(*) FROM photos);

-- Q9 Find the users who have never commented on a photo
SELECT * FROM comments;
SELECT * FROM users;

SELECT users.id, username FROM users
WHERE users.id NOT IN(
SELECT comments.user_id FROM comments);

-- Q10 Find the Users who have never commented on any photo or have commented on every photo.
SELECT * FROM comments;
SELECT * FROM users;

SELECT id, username FROM users WHERE id IN (
SELECT users.id FROM users
WHERE users.id NOT IN(
SELECT comments.user_id FROM comments))
or
id IN (SELECT user_id 
FROM comments 
GROUP BY user_id
HAVING count(DISTINCT photo_id) = (SELECT count(DISTINCT photo_id) FROM comments)) ORDER BY id;
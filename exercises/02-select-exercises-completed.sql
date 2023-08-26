SELECT title, budget, release_date
FROM movie;

SELECT title, homepage
FROM movie
WHERE homepage IS NOT NULL;


SELECT title, runtime
FROM movie
WHERE runtime > 120;

SELECT title, vote_average
FROM movie
ORDER BY revenue DESC
LIMIT 1;

SELECT title, vote_average
FROM movie
ORDER BY revenue ASC
LIMIT 1;

SELECT *
FROM movie
WHERE vote_average > 8;

SELECT *
FROM movie
WHERE release_date >= '2015-08-01' AND release_date <= '2016-01-01';

SELECT COUNT(*)
FROM movie
WHERE release_date > '2016-01-01';

SELECT title, popularity
FROM movie
ORDER BY popularity DESC
LIMIT 10;

SELECT COUNT(*)
FROM movie
WHERE vote_average > 9 AND release_date < '2020-01-01';
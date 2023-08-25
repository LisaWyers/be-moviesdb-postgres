CREATE TABLE rating (
    rating_id SERIAL NOT NULL PRIMARY KEY,
    rating_value INT,
    title VARCHAR(255),
	content VARCHAR(255)
    );
	
INSERT INTO rating (rating_value, title, content)
VALUES (5, 'jaws', 'a film about sharks');

DROP TABLE rating;

DROP TABLE IF EXISTS RATING;

CREATE TABLE rating (
rating_id SERIAL NOT NULL PRIMARY KEY,
rating_value INT CHECK(rating_value >=0 AND rating_value <=10),
title VARCHAR (255),
content VARCHAR (255)	
);

INSERT INTO rating (rating_value, title, content)
VALUES (5, 'jaws', 'a film about sharks');

DROP TABLE rating;

DROP TABLE rating;

CREATE TABLE rating (
      rating_id SERIAL NOT NULL PRIMARY KEY,
      rating_value INT CHECK(rating_value >=0 AND rating_value <=10),
      title VARCHAR (255) UNIQUE,
      content VARCHAR (255),
	  CONSTRAINT unique_rating_id UNIQUE (rating_id)
);
DROP TABLE IF EXISTS rating;

CREATE TABLE rating (
    rating_id SERIAL PRIMARY KEY,
    rating_value INT CHECK (rating_value >= 0 AND rating_value <= 10),
    title VARCHAR(255) UNIQUE,
    content VARCHAR(255)
);

INSERT INTO rating (rating_value, title, content)
VALUES (5, 'jaws', 'a film about sharks');

INSERT INTO rating (rating_value, title, content)
VALUES (8, 'avatar', 'a sci-fi movie');

INSERT INTO rating (rating_value, title, content)
VALUES (9, 'inception', 'a mind-bending film');

CREATE TABLE reviewer (
	reviewer_id SERIAL NOT NULL PRIMARY KEY,
	reviewer_name VARCHAR(255),
	registered_date INT,
	points INT CHECK (points >= 0 AND points <= 1000)
   );

ALTER TABLE rating
ADD COLUMN reviewer_id INT REFERENCES reviewer(reviewer_id) DEFAULT NULL;

DROP TABLE rating;

CREATE TABLE rating (
    rating_id SERIAL NOT NULL PRIMARY KEY,
    rating_value INT CHECK (rating_value >= 0 AND rating_value <= 10),
    title VARCHAR(255) UNIQUE,
    content VARCHAR(255),
    reviewer_id INT REFERENCES reviewer(reviewer_id) DEFAULT NULL
);

INSERT INTO reviewer (reviewer_name, registered_date, points)
VALUES 
('Martin Brody', 25112023, 100),
('Will Smith', 20112023, 1000),
('Paul Hogan', 18112023, 100);

INSERT INTO rating (rating_value, title, content, reviewer_id)
VALUES 
(10, 'Jaws', 'A film about sharks', 1),
(8, 'Shark Tale', 'An animation about sharks', 2),
(10, 'Crocodile Dundee', 'A film about crocodiles', 3);


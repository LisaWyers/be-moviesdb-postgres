UPDATE keyword
SET keyword_name= 'horror'
WHERE keyword_name = 'terror';

UPDATE keyword
SET keyword_name = 'secret'
WHERE keyword_name = 'horror';

UPDATE movie_cast
SET character_name = 'Robert Fitzgerald Diggs'
WHERE character_name = 'RZA';

UPDATE movie
SET homepage = 'https://en.wikipedia.org/wiki/Avatar:_The_Way_of_Water'
WHERE revenue > 1000000;

SELECT movie_id
FROM movie 
WHERE title = 'Forrest Gump'

UPDATE production_company
SET company_name = 'Paramount+'
WHERE company_name = 'Paramount Pictures';

UPDATE movie
SET homepage = 'Paramount+ Streaming Service'
WHERE company_name = 'Paramount+';

UPDATE production_company
SET homepage = 'https://www.paramountplus.com/gb/'
WHERE company_id = 4;


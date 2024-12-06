create database netflix;

use netflix;

select * from netflix_ms;

-- Filling all blank values
UPDATE netflix_ms
SET director = 'NA'
WHERE director = '';

UPDATE netflix_ms
SET cast = 'NA'
WHERE cast = '';

UPDATE netflix_ms
SET country = 'NA'
WHERE country = '';

-- Checking for blank values
SELECT COUNT(*) AS blank_column1_count
FROM netflix_ms
WHERE show_id = '';

SELECT COUNT(*) AS blank_column2_count
FROM netflix_ms
WHERE director = '';

-- Changing Data type
alter table netflix_ms modify show_id varchar(10);
alter table netflix_ms modify type varchar(10);
alter table netflix_ms modify title varchar(150);
alter table netflix_ms modify director varchar(210);
alter table netflix_ms modify cast varchar(1000);
alter table netflix_ms modify country varchar(150);
alter table netflix_ms modify date_added varchar(50);
alter table netflix_ms modify rating varchar(10);
alter table netflix_ms modify duration varchar(15);
alter table netflix_ms modify listed_in varchar(150);
alter table netflix_ms modify description varchar(250);

select count(*) from netflix_ms;

select distinct type from netflix_ms;

-- count number of movies & Tv shows
select type, count(*) as total_content from netflix_ms
group by type;

-- find the most common rating for movies and Tv shows
select type, rating from(
    select type, rating , count(*), 
    rank() over(partition by type order by count(*) desc) as ranking
    from netflix_ms
	group by type , rating) as t1 
where ranking =1;

-- List all movies released in specific year(2020)
select * from netflix_ms where type = "Movie" and release_year = 2020;

-- Identify to Longest Movie
select * from netflix_ms where type="Movie" and
duration=(select max(duration) from netflix_ms);

-- find the content added in the last 5 years
select * from netflix_ms
where str_to_date(date_added, '%M %d, %Y') >= curdate() - interval 5 year;

-- find all the movies/tv shows by director "Toshiya Shinohara"
ALTER TABLE netflix_ms 
MODIFY director VARCHAR(255) COLLATE utf8_general_ci; 
select * from netflix_ms where director collate utf8_general_ci like "%Toshiya Shinohara%";

-- List all TV shows with more than 5 seasons
select * from netflix_ms
where type = "TV Show" and substring_index(duration, " ", 1) > 5;

-- find each year and the average number of content release in United States on netflix
SELECT 
    YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year,
    COUNT(*) AS total_content,
    (COUNT(*) / (SELECT COUNT(*) FROM netflix_ms WHERE country = 'United States') * 100) AS avg_content_per_year
FROM 
    netflix_ms
WHERE 
    country = 'United States'
GROUP BY 
    year;
    
-- list all movies that are Comedies
select * from netflix_ms 
where listed_in like '%Comedies%';
 
-- categorize the content based on presence of the keyword "kill" and "Violence" in
-- in the description field. label the content containing the keyword as "bad" and all other
-- content as good.

select *, 
   case
   when
      description like '%kill%' or 
      description like '%violence%' then 'Bad_content'
      else 'Good_content'
	end  category
from netflix_ms;
	





   












--- basic selection : 
/*
Select title, release_date 
from songs
WHERE release_date BETWEEN '2022-01-01' and '2022-12-31'
 ORDER  by release_date DESC;
 */

--- filtering : 
/*
SELECT * 
from songs 
where popularity_score > 80 and duration_seconds < 240;
*/

--- patter matching :
/*
SELECT *
from artists
where  artist_name like 'the%';
*/

--- multiple conditions :
/*
select *
from customers
where 
premium_member = 'true' 
and 
join_date BETWEEN '2022-01-01' and '2022-12-31';
*/

--- calculations and aliasing : 
/*
 SELECT title,
					duration_seconds,
					round(duration_seconds / 60.0 , 2) as duration_minutes
from songs;
*/

---advanced filtering :
/*
SELECT * 
from purchase
order by  price DESC
LIMIT 5;
*/

--- using multiple tables separatly:
/*
select *
from purchase
WHERE song_id in (
				select song_id 
				from songs
				where popularity_score > 90
)
*/

--- range checking :
/*
SELECT *
from purchase
where purchase_date BETWEEN '2023-01-01' and '2023-03-31'
order  by purchase_date ASC;
*/

--- advanced filtering with order by : 
/*
select *
from songs
where popularity_score > 90
order by popularity_score DESC;
*/
/*
SELECT
  s.song_id,
  s.title,
  s.duration_seconds,
  s.popularity_score
FROM songs AS s
WHERE s.duration_seconds < 240      -- short songs
AND s.popularity_score > 90       -- popular songs
AND s.artist_id IN (
		SELECT a.artist_id
        FROM artists AS a
        WHERE a.artist_name LIKE 'The %'   -- artist name starts with "The"
  )
ORDER BY s.popularity_score DESC, s.duration_seconds ASC;
*/
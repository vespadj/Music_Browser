-- Parameters definitions:
WITH params AS (SELECT 
  '{0}' AS q -- like
, '{1}' AS qNot -- not like
)

SELECT
-- default fields:
  l.id
, case fs_deleted 
  	when 0 then 1 
		when 1 then 0 
	end 
	AS isExists
, artist
, title
, year
, tl.location AS url
, duration
, bitrate AS kbps
, CAST(round((tl.filesize/1024) ) AS INTEGER)  as KB /* 120*1024 */
, album
, IFNULL(tracknumber||'/'||tracktotal, tracknumber)AS n
, genre
, comment
, datetime_added AS filedate

-- other fields:
, bpm


FROM
  params
, library as l

INNER JOIN track_locations as tl
ON tl.id = l.location

WHERE
(tl.location like params.q
OR artist||' '||title like params.q
OR tl.location||' '||IFNULL(artist, '')||' '||IFNULL(title, '')||' '||IFNULL(artist, '')||' '||tl.location like params.q
OR title||' '||artist like params.q
OR artist||' '||album like params.q
OR album||' '||artist like params.q

) AND (
CASE WHEN '' != params.qNot  -- create a function like if then else
THEN
    tl.location not like params.qNot
    AND artist||' '||title not like params.qNot
    AND tl.location||' '||IFNULL(artist, '')||' '||IFNULL(title, '')||' '||IFNULL(artist, '')||' '||tl.location not like params.qNot
    AND title||' '||artist not like params.qNot
    AND artist||' '||album not like params.qNot
    AND album||' '||artist not like params.qNot
ELSE 1=1
END
)


ORDER BY l.id DESC	/* From last added in db */

LIMIT 50 
;
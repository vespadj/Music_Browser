-- Filename that starts with "List" will be executed like list.

-- Parameters definitions:
WITH params AS (SELECT 
  -- 0 list ,
  '{1}' AS qNot -- not like
)


SELECT
-- default fields:
  library.id
, fs_deleted
, artist
, title
, year
, tl.location AS url
, duration
, bitrate AS kbps
, filesize
, album
, IFNULL(tracknumber||'/'||tracktotal, tracknumber)AS n
, genre
, comment
, datetime_added AS filedate

-- other fields:
, key
, bpm
, rating
, query

FROM
  params
, (select '00000' as query union select {0}) AS tmplist

LEFT OUTER JOIN library ON ( 
	(
    tl.location like query
    OR artist||' '||title like query
    OR tl.location||' '||IFNULL(artist, '')||' '||IFNULL(title, '')||' '||IFNULL(artist, '')||' '||tl.location like query
    OR title||' '||artist like query
    OR artist||' '||album like query
    OR album||' '||artist like query
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
)

INNER JOIN track_locations as tl
ON tl.id = library.location

-- WHERE

-- ORDER BY library.id DESC	/* From last added in db */
-- LIMIT 50 

GROUP BY query HAVING MAX(library.id)
;
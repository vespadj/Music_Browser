SELECT 
  l.id
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

, key
, bpm
, rating

FROM library as l

INNER JOIN track_locations as tl
ON tl.id = l.location

WHERE 
l.id in (
  -- Find files with exact duration, artist and title
  select l1.id
  from library as l1, library as l2
  where
  -- identical file 
   l1.duration = l2.duration
  -- TODO: tl.filesize
  and l1.location != l2.location
  and lower(l1.artist) != 'artist'
  and l1.artist != '(No Artist)'
  and l1.artist like l2.artist
  and l1.title like l2.title
)

AND tl.fs_deleted = 0

ORDER BY lower(artist), lower(title), url
LIMIT 100 ;
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
  -- Find files with first tracknumber and with same duration and album
  select l1.id
  from library as l1, library as l2
  where 
  l1.artist like l2.artist
  and l1.location != l2.location
  -- see Checks/Double locations, case insensitive.sql
  and l1.album = l2.album
  and (l1.tracknumber = 1 or l1.tracknumber like '1/%')
  and l1.tracknumber = l2.tracknumber
  and l1.artist != '(No Artist)'
  and l1.album != '(No Album)'
  and abs( l1.duration - l2.duration ) < 5
  and l1.title like l2.title
)

AND tl.fs_deleted = 0

ORDER BY artist, album, url
LIMIT 50 ;
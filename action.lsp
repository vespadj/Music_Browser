<?lsp


local os_name = ""
if mako.execpath then
  local _,op = ba.openio"disk":resourcetype()
  -- trace(op)
  if op == "windows" then
    os_name = "Windows"
  else
    os_name = "Linux"
  end
end

-- === user settings ===
-- user settings table
-- if not us then
-- 	us,err = plconfig.read("..\\data\\Music_Browser\\settings.ini")
-- 	-- on error, load default
-- 	if err then
-- 		-- Paths of executables: lua needs \\ for \ 
-- 		winampPath = "X:\\Programmi\\Winamp\\winamp.exe"
-- 		dndfPath = "..\\..\\..\\..\\dndf.exe"
-- 		print(err)
-- 	else
-- 		winampPath = us.winampPath 	or "X:\\Programmi\\Winamp\\winamp.exe"
-- 		dndfPath = us.dndfPath			or "..\\..\\..\\..\\dndf.exe"
-- 	end
-- end

-- TO DO: exist? try with %programfiles% (or x86)

-- === end user settings ===

local action, url, params, track_id = request:data('action', 'url', 'params', 'track_id')
-- trace(action, url, params)
url = ba.urldecode(url or '')
track_id = tonumber(ba.urldecode(track_id)) or 0


-- FUNCTIONS


-- ACTION
if action == "OpenFolder" then
  local cmd
  local file_exists = false
  if os_name == "Linux" then
    cmd = "caja --select "
    -- TO DO: file exists? doesn't work. Permissions?
    --if io:stat(url) then
    --else
    --    trace("File Not Found", url)
    --end
    file_exists = true

  elseif os_name == "Windows" then
    cmd = 'start '..'Explorer /select,'  -- /e /select non va
    file_exists = true

  end
  
  if file_exists == true then
    ba.exec(cmd..'"'..url..'"')
  end

elseif action == "AddClementine" then

  local cmd
  local file_exists = false
  if os_name == "Linux" then
    cmd = "clementine"
    -- https://linuxcommandlibrary.com/man/clementine
    -- TO DO: file exists? doesn't work. Permissions?
    file_exists = true

  -- elseif os_name == "Windows" then

  end
  
  if file_exists == true then
    ba.exec(cmd..' '..'"'..url..'"')
  end

elseif action == "AddToMixxxAutoDJ" and track_id > 0 then
  local playlist_id = 1 -- id of Auto DJ in Playlists
  local env = assert (luasql.sqlite())  -- create environment object
  local con = assert (env:connect( os.getenv("HOME").."/.mixxx/mixxxdb.sqlite" ))
  local sql = string.format([=[
    INSERT INTO PlaylistTracks (playlist_id, track_id, position, pl_datetime_added) 
    VALUES (
      %s
    , %s
    , (SELECT COALESCE(MAX(position), 0) + 1 FROM PlaylistTracks WHERE playlist_id = %s)
    , datetime('now')
    )
  ]=], playlist_id, track_id, playlist_id)
  -- trace(sql)
  local cur = assert (con:execute( sql ))

elseif action == "AddWinamp" then
  -- TO DO: file exists?
  -- for informations see: cmd.exe help start 
  -- with "start" don't wait the end of process
  local a = 'start "foo" "'..winampPath..'" /ADD '..'"'..url..'"'
  print(a)
  -- assert(os.execute(a))
  ba.exec(a)
  -- TODO: else, error
    
elseif action == "AddWinampAndPlay" then
  -- TO DO: file exists?
  -- for informations see: cmd.exe help start 
  -- with "start" don't wait the end of process
  -- default: works only for first launch
  -- "C:\Program Files (x86)\Winamp\winamp.exe" /ADD "\\QUEUE" "%1" 
  local a = 'start "foo" "'..winampPath..'" /ADD "\\\\QUEUE" ' .. '"' .. url .. '"'
  -- NO alternative: http://forums.winamp.com/showthread.php?threadid=180297
  -- "C:\Program Files (x86)\Winamp\winamp.exe" /ADD "%1" /COMMAND=40158 /PLAY
  -- local a = 'start "foo" "'..winampPath..'" /ADD ' .. '"' .. url .. '"' .. " /COMMAND=40158 /PLAY"
  print(a)
  -- assert(os.execute(a))
  ba.exec(a)
  -- TODO: else, error

elseif action == "dndf" then
  local pos = params or "-mousepos"
  local a = 'start "" '..dndfPath..' -mini '..pos..' -close -f'..'"'..url..'"'
  print(a)
  ba.exec(a)

elseif action == "OpenMusicBrowserSettings" then
  -- TODO: rewrite setting gesture
  local a = 'start "" "..\\data\\Music_Browser\\settings.ini"'
  print(a)
  ba.exec(a)

else
  -- TODO: error
  print("action '"..action.."' not recognised!")

end


?>
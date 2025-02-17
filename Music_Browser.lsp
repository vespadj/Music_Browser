<?lsp
-- Music_Browser.lsp
-- Main web interface for music library management

-- === Constants and Configuration ===

-- trace(pathname) -- Music_Browser/Music_Browser.lsp
-- Get "Music_Browser/" from "Music_Browser/Music_Browser.lsp":
local BASE_PATH = string.sub(pathname, 1, string.find(pathname, "/[^/]*$"))
local CUR_DIR = "./" .. BASE_PATH
local SQL_SEARCH_PATH = CUR_DIR.."sql_search/"

-- trace(CUR_DIR)

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

-- === Query State ===
q = {
  qPreset = {selected="", options={}},
  q = request:data("q"),
  qExact = request:data("qExact"),
  qNot = request:data("qNot"),
  qList = request:data("qList")
}
q.qPreset.selected = request:data("qPreset") or "Main Search"

db_name = request:data("db")
dbg = request:data("dbg")
jsonOut = {dbg = ""}

local json = ba.json

-- === Utility Functions ===
local function split2(inputstr, sep)
  if not sep then sep = "%s" end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

local function readFile(path)
  local f = assert(io:open(path, "r"))
  local t = f:read("*a")
  f:close()
  return t
end

-- === Database Functions ===
local function tab(strConnDb, sqlfile, style, sql_params)
  local results = {thead = {}, tab = {}}
  local env = assert(luasql.sqlite())
  local con
  
  if strConnDb == "mixxx" then
    con = assert(env:connect(os.getenv("HOME").."/.mixxx/mixxxdb.sqlite"))
  end
  
  local sql = readFile(sqlfile)
  sql_params = type(sql_params) == "table" and sql_params or {sql_params}
  
  for i, param in ipairs(sql_params) do
    if type(param) == "string" and param ~= "" then
      -- Enable spacial char * ?
      -- Notes: Lua special char are	  ^ $ ( ) % . [ ] * + - ?
      -- Notes:  %% means %    (lua bell)
      param = param:gsub("%*","%%"):gsub("%?","_"):gsub("%%","%%%%")

      -- Replace <TAG>, <TAG2> with param
      sql = sql:gsub("<TAG"..((i>1) and i or "")..">", param)
      
      -- lua index starts from 1, not 0
      -- Replace {0}, {1}, ... with param
      sql = sql:gsub("{".. (i-1) .."}", param)
    end
  end
  
  jsonOut.dbg = sql
  
  for _, query in ipairs(split2(sql,";")) do
    if query:find("%a") then
      -- DBG:
      -- trace("\nSQL QUERY:\n\n") print(query) print("\n\n")
      -- response:abort()
      local cur = assert(con:execute(query)) -- DBG: put prefix: cur = 0 or assert(... then remove.

      if type(cur) == "number" then
        print("\nn. ".. cur .. "affected row(s).\n")
      else
        -- Output results
        results.thead = cur:getcolnames()
        local row = cur:fetch({}, "a") 	-- n: numeric index (default); a: the rows will be indexed by field names.
        while row do
          table.insert(results.tab, row)
          row = cur:fetch({}, "a")
        end
        cur:close()
      end
    end
  end
  
  con:close()
  env:close()
  return results
end

-- === Main Functions ===
-- TODO: multiple directories support
local WWW_MEDIA_PATH = tab("mixxx", CUR_DIR .. "sql_admin/directories.sql", "json", "")

function scanSqlFiles()
  q.qPreset.options = {}
  local i = 0
  for name in io:files(SQL_SEARCH_PATH) do
    if string.sub(name, -4) == ".sql" then
      i = i + 1
      table.insert(q.qPreset.options, {
        title = "",
        value = string.sub(name, 1, -5) -- trim extension
      })
    end
  end
  -- trace(i.." sql files found in "..SQL_SEARCH_PATH)
end

function init()
  scanSqlFiles()
  local count = tab("mixxx", CUR_DIR .. "sql_admin/tracks_count.sql", "json", "")
  return json.encode({init = q, count = count, media_directory = WWW_MEDIA_PATH})
end

-- Perform search and return JSON
function searchJSON()
  if q.q ~= "" then
    if q.qExact == "false" then
      q.q = q.q:gsub("[^?A-Za-z0-9]", "%%")
    else
      q.q = q.q:gsub("%*", "%%"):gsub("%?", "%_"):gsub("'", "''")
    end
    q.q = "%%" .. q.q .. "%%"
  end
  
  if q.qNot ~= "" then
    q.qNot = q.qNot:gsub("[^?A-Za-z0-9]", "%%")
    q.qNot = "%%" .. q.qNot .. "%%"
  end
  
  if q.qList ~= "" and string.match(q.qPreset.selected, "^List") then
    local qListTab = split2(q.qList, "\n")
    for i,v in ipairs(qListTab) do
      qListTab[i] = v:gsub("[^?A-Za-z0-9]", "%%"):gsub("%%%%", "%%"):gsub("%%%%", "%%")
    end
    q.q = "'%".. table.concat(qListTab, "%' UNION SELECT '%") .. "%'"
  end
  
  jsonOut.results = tab(db_name, SQL_SEARCH_PATH..'/'..q.qPreset.selected..".sql", "json", {q.q, q.qNot})
  
  -- old example: how manipulate results before returning
  for i,field in ipairs(jsonOut.results.thead) do
    if db_name=="internal" and field == "filedate" then
      for j,row in ipairs(jsonOut.results.tab) do
        jsonOut.results.tab[j].filedate = os.date("%Y/%m/%d", row.filedate or 0)
      end
    end
  end
  
  return jsonOut
end

-- === Initialize Media Path ===
if not page.wwwmedia then
  local MEDIA_NAME = "media"
  page.wwwmedia = ba.create.resrdr(MEDIA_NAME, ba.mkio(ba.openio("disk"), WWW_MEDIA_PATH.tab[1].directory))
  local appenv = setmetatable({io=io,dir=dir},{__index=_G})
  page.wwwmedia:lspfilter(appenv)
  page.wwwmedia:insert()
  trace('Loaded "'..WWW_MEDIA_PATH.tab[1].directory..'" as "'..MEDIA_NAME..'".')
end

-- === Request Handler ===
function handle_client_request()
  if not request:data("rs") then return end
  
  response:setheader("Cache-Control", "no-cache, must-revalidate")
  response:setheader("Pragma", "no-cache")
  
  if not request:checktime(os.time() - (60*60*24)) then return end
  
  local funcname = request:data("rs")
  if not _ENV[funcname] then
    print(string.format("-:%s not callable", funcname))
    if dbg then response:json(_ENV) end
    return
  end
  
  local func = _ENV[funcname]
  local rsargs = request:data("rsargs[]")
  local result
  
  if not rsargs then
    result = func()
  elseif type(rsargs) == "string" then
    result = func(rsargs)
  elseif type(rsargs) == "table" then
    result = func(unpack(rsargs))
  else
    return
  end
  
  if type(result) == "string" then
    print(result)
  elseif type(result) == "table" then
    response:json(result)
  end
  
  return true
end

if handle_client_request() then return end
?>

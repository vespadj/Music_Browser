<pre>
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

-- === Debug utilities and tests ===
local function debug_paths()
  print("=== Testing Server Paths ===")
  trace("=== Testing Server Paths ===")
  for ix,path in ipairs(mako.getapps()) do
    print("Application path ["..ix.."]:" , path)
    trace("Application path ["..ix.."]:" , path)
  end
  
  print("\n=== Current Directory Contents ===")
  trace("\n=== Current Directory Contents ===")
  for name, isdir, mtime, size in io:files(".", true) do
    local outtxt = string.format("File: %s | Directory: %s | Modified: %s | Size: %s",
      name, tostring(isdir), os.date("%Y-%m-%d %H:%M:%S", mtime), size)
    print(outtxt) 
    trace(outtxt)
  end
end

-- === Database connection test ===
local function test_db_connection()
  print("=== Testing Database Connections ===")
  trace("=== Testing Database Connections ===")
  
  local env = assert(luasql.sqlite())
  local su=require"sqlutil" -- Load SQL utility library
  
  -- Test Mixxx db if available
  local mixxx_path
  if os_name == "Linux" then
    mixxx_path = os.getenv("HOME").."/.mixxx/mixxxdb.sqlite"
  end

  if su.exist(mixxx_path) then
    -- why io:stat(mixxx_path) not works?
    print("Testing Mixxx database connection...")
    trace("Testing Mixxx database connection...")
    -- Note: it will create if it doesn't exist
    local con = assert(env:connect(mixxx_path))
    con:close()
  else
    print(mixxx_path)
    trace(mixxx_path)
    print(su.exist(mixxx_path))
    print("Mixxx not found, skipping test")
    trace("Mixxx not found, skipping test")
  end
  
  env:close()
  print("All database connections successful")
  trace("All database connections successful")
end

-- Run specific test if requested, otherwise run all non-intensive tests
local test = request:data("test")
if test then
  if _ENV[test] then
    print("Running specific test:", test)
    trace("Running specific test:", test)
    _ENV[test]()
  end
else
  print("=== Running All Tests ===\n")
  trace("=== Running All Tests ===\n")
  debug_paths()
  test_db_connection()
  print("\n=== All Tests Completed ===")
  trace("\n=== All Tests Completed ===")
end

?>
</pre>
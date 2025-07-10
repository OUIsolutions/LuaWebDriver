
os.execute("mkdir -p dependencies")
if not darwin.dtw.isfile("dependencies/herigitage.lua") then 
  os.execute("curl -L https://github.com/mateusmoutinho/LuaHeritage/releases/download/1.0.0/heregitage.lua -o dependencies/herigitage.lua")
end
local heregitage = darwin.dtw.load_file("dependencies/herigitage.lua")

local all = {
  [[return (function()    
      local Private = {};
      local WebDriver = {};
      local Server  ={}
  ]]
  }
  all[#all + 1] = "local Heregitage = (function()  "..heregitage .. " end\n)()\n"

  local files = darwin.dtw.list_files_recursively("src",true)

  for _, file in ipairs(files) do
    all[#all  +1 ] = darwin.dtw.load_file(file) .."\n"
  end
all[#all + 1] = [[

    return WebDriver;
end)()]]


local result = table.concat(all, "\n")
darwin.dtw.write_file("luaWebDriver.lua", result)

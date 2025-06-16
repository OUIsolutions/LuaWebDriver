local all = {
  [[return (function()    
      local public = {};
  ]]
    }
  local files = darwin.dtw.list_files_recursively("src",true)

  for _, file in ipairs(files) do
    all[#all  +1 ] = darwin.dtw.load_file(file) .."\n"
  end
all[#all + 1] = [[

    return public;
end)()]]


local result = table.concat(all, "\n")
darwin.dtw.write_file("luawebDriver.lua", result)
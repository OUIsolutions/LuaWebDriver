darwin.add_recipe({
    name="lua WebDriver file",
    description="Generate a single lua file for WebDriver",
    outs={"release/luaWebDriver.lua"},
    callback= function ()
        local heregitage = darwin.dtw.load_file("dependencies/herigitage.lua")

        local all = {
          [[return (function()]]
          }
          all[#all + 1] = darwin.dtw.load_file("objects.lua") .. "\n"
          all[#all + 1] = "local Heregitage = (function()  "..heregitage .. " end\n)()\n"

          local files = darwin.dtw.list_files_recursively("src",true)

          for _, file in ipairs(files) do
            all[#all  +1 ] = darwin.dtw.load_file(file) .."\n"
          end
        all[#all + 1] = [[

            return WebDriver;
        end)()]]


        local result = table.concat(all, "\n")
        darwin.dtw.write_file("release/luaWebDriver.lua", result)

    end
})


local luabear = require("luaBear.luaBear")

local luawebdriver = require("luaWebDriver")

local WebDriver = luawebdriver.newDriver(
    "chromedriver",
    "chrome",
    luabear.fetch
)
local session = WebDriver.newSession()

session.print_test()
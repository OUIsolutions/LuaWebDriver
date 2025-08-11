
local webdriver = require("luaWebDriver")
local luabear = require("luaBear.luaBear")

-- Setup WebDriver server
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "/home/mateus/oui_chrome/chromedriver-linux64/chromedriver",
})

-- Create a new browser session
local session = server.newSession({
    binary_location = "/home/mateus/oui_chrome/chrome-linux64/chrome",
})

-- Navigate to a website
session.navegate_to("https://news.ycombinator.com")

-- Find and interact with elements
local big_box = session.get_element_by_id("bigbox")
local td = big_box[1]
local table_1 = td[1] 
local tbody = table_1[1]

-- Print all news items
print("=== Hacker News Articles ===")
for i = 1, tbody.get_children_size() do 
    local tr = tbody.get_element_by_index(i)
    local text = tr.get_text()
    if text and text ~= "" then
        print(i .. ". " .. text)
    end
end
while true do end 
print("✅ Test completed successfully!")
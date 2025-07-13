# LuaWebDriver API Documentation

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Chrome](https://img.shields.io/badge/Chrome-4285F4?style=for-the-badge&logo=Google-chrome&logoColor=white)
![WebDriver](https://img.shields.io/badge/WebDriver-43B02A?style=for-the-badge&logo=selenium&logoColor=white)

## 📋 Table of Contents

- [Installation](#installation)
- [Getting Started](#getting-started)
- [Server Management](#server-management)
- [Session Management](#session-management)
- [Element Interaction](#element-interaction)
- [Window Management](#window-management)
- [Complete Examples](#complete-examples)

## 🚀 Getting Started

### Basic Setup

```lua
local webdriver = require("luaWebDriver")

-- Create a local ChromeDriver server
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,  -- Your HTTP client
    chromedriver_command = "./chromedriver",
    port = 4444
})

-- Start a new browser session
local session = server.newSession({
    binary_location = "./chrome/chrome"
})

-- Navigate to a website
session.navegate_to("https://example.com")
```

## 🖥️ Server Management

### `webdriver.newLocalServer(props)`

![Method](https://img.shields.io/badge/Method-newLocalServer-blue?style=flat-square)
![Required](https://img.shields.io/badge/Required-Yes-red?style=flat-square)

Creates a local ChromeDriver server instance.

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `fetch` | function | ✅ | HTTP client function for making requests |
| `chromedriver_command` | string | ✅ | Path to ChromeDriver executable |
| `port` | number | ✅ | Port number for the server |

**Example:**
```lua
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./drivers/chromedriver",
    port = 9515
})
```

### `webdriver.newRemoteServer(props)`

![Method](https://img.shields.io/badge/Method-newRemoteServer-blue?style=flat-square)
![Optional](https://img.shields.io/badge/Optional-Yes-green?style=flat-square)

Connects to a remote WebDriver server.

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `url` | string | ✅ | URL of the remote server |
| `fetch` | function | ✅ | HTTP client function |

**Example:**
```lua
local server = webdriver.newRemoteServer({
    url = "http://localhost:4444",
    fetch = luabear.fetch
})
```

## 🌐 Session Management

### `server.newSession(props)`

![Method](https://img.shields.io/badge/Method-newSession-blue?style=flat-square)
![Required](https://img.shields.io/badge/Required-Yes-red?style=flat-square)

Creates a new browser session.

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `binary_location` | string | ✅ | Path to Chrome executable |
| `args` | table | ❌ | Chrome command line arguments |
| `use_automation_extension` | boolean | ❌ | Use automation extension (default: false) |

**Example:**
```lua
local session = server.newSession({
    binary_location = "/usr/bin/google-chrome",
    args = {
        "--headless",
        "--window-size=1920,1080"
    }
})
```

### `session.navegate_to(url)`

![Method](https://img.shields.io/badge/Method-navegate__to-blue?style=flat-square)

Navigates to a specific URL.

**Example:**
```lua
session.navegate_to("https://www.google.com")
```

### `session.get_session_id()`

![Method](https://img.shields.io/badge/Method-get__session__id-blue?style=flat-square)

Returns the current session ID.

**Example:**
```lua
local id = session.get_session_id()
print("Session ID:", id)
```

## 🎯 Element Interaction

### Finding Elements

#### `session.get_element(selector_type, value)`

![Method](https://img.shields.io/badge/Method-get__element-blue?style=flat-square)

Finds a single element on the page.

**Selector Types:**
- `"css selector"` - CSS selectors
- `"xpath"` - XPath expressions
- `"tag name"` - HTML tag names
- `"class name"` - CSS class names
- `"id"` - Element IDs

**Example:**
```lua
-- Find by CSS selector
local button = session.get_element("css selector", "#submit-button")

-- Find by XPath
local heading = session.get_element("xpath", "//h1[@class='title']")

-- Find by ID
local input = session.get_element("id", "username")
```

#### `session.get_elements(selector_type, value)`

![Method](https://img.shields.io/badge/Method-get__elements-blue?style=flat-square)

Finds multiple elements on the page.

**Example:**
```lua
local links = session.get_elements("css selector", "a.nav-link")
print("Found " .. #links .. " navigation links")

for i, link in ipairs(links) do
    print(i, link.get_text())
end
```

### Element Methods

#### `element.click()`

![Method](https://img.shields.io/badge/Method-click-blue?style=flat-square)

Clicks on an element.

**Example:**
```lua
local button = session.get_element("css selector", "button[type='submit']")
button.click()
```

#### `element.send_keys(text)`

![Method](https://img.shields.io/badge/Method-send__keys-blue?style=flat-square)

Types text into an input element.

**Example:**
```lua
local searchBox = session.get_element("id", "search")
searchBox.send_keys("Lua programming")
```

#### `element.get_text()`

![Method](https://img.shields.io/badge/Method-get__text-blue?style=flat-square)

Gets the visible text content of an element.

**Example:**
```lua
local paragraph = session.get_element("css selector", "p.description")
local text = paragraph.get_text()
print("Paragraph text:", text)
```

#### `element.get_html()`

![Method](https://img.shields.io/badge/Method-get__html-blue?style=flat-square)

Gets the HTML content of an element.

**Example:**
```lua
local div = session.get_element("css selector", "div.content")
local html = div.get_html()
print("HTML:", html)
```

#### `element.get_attribute(name)`

![Method](https://img.shields.io/badge/Method-get__attribute-blue?style=flat-square)

Gets an attribute value from an element.

**Example:**
```lua
local link = session.get_element("css selector", "a")
local href = link.get_attribute("href")
print("Link URL:", href)
```

### Advanced Element Methods

#### `element.get_element(selector_type, value)`

![Method](https://img.shields.io/badge/Method-get__element-blue?style=flat-square)

Finds a child element within another element.

**Example:**
```lua
local form = session.get_element("id", "login-form")
local username = form.get_element("css selector", "input[name='username']")
```

#### `element.get_elements(selector_type, value)`

![Method](https://img.shields.io/badge/Method-get__elements-blue?style=flat-square)

Finds multiple child elements.

**Example:**
```lua
local list = session.get_element("css selector", "ul.menu")
local items = list.get_elements("css selector", "li")
```

#### `element.get_element_by_index(index)`

![Method](https://img.shields.io/badge/Method-get__element__by__index-blue?style=flat-square)

Gets a direct child element by index (1-based).

**Example:**
```lua
local container = session.get_element("css selector", "div.container")
local firstChild = container.get_element_by_index(1)
local secondChild = container.get_element_by_index(2)
```

#### `element.execute_script(script, ...)`

![Method](https://img.shields.io/badge/Method-execute__script-blue?style=flat-square)

Executes JavaScript on an element.

**Example:**
```lua
local button = session.get_element("id", "hidden-button")
-- Scroll element into view
button.execute_script("arguments[0].scrollIntoView(true);")

-- Change element style
button.execute_script("arguments[0].style.backgroundColor = 'red';")

-- With additional arguments
local element = session.get_element("id", "myDiv")
element.execute_script(
    "arguments[0].innerHTML = arguments[1];",
    "Hello from Lua!"
)
```

## 🪟 Window Management

### `session.open_new_tab()`

![Method](https://img.shields.io/badge/Method-open__new__tab-blue?style=flat-square)

Opens a new browser tab.

**Example:**
```lua
session.open_new_tab()
```

### `session.open_new_window()`

![Method](https://img.shields.io/badge/Method-open__new__window-blue?style=flat-square)

Opens a new browser window.

**Example:**
```lua
session.open_new_window()
```

### `session.switch_to_window(index)`

![Method](https://img.shields.io/badge/Method-switch__to__window-blue?style=flat-square)

Switches to a window by index (1-based).

**Example:**
```lua
-- Open multiple tabs
session.navegate_to("https://google.com")
session.open_new_tab()
session.switch_to_window(2)
session.navegate_to("https://github.com")

-- Switch back to first tab
session.switch_to_window(1)
```

### `session.close_window()`

![Method](https://img.shields.io/badge/Method-close__window-blue?style=flat-square)

Closes the current window/tab.

**Example:**
```lua
session.close_window()
```

## 📚 Complete Examples

### Example 1: Form Automation

```lua
local webdriver = require("luaWebDriver")

-- Setup
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chromedriver",
    port = 4444
})

local session = server.newSession({
    binary_location = "./chrome/chrome"
})

-- Navigate to login page
session.navegate_to("https://example.com/login")

-- Fill login form
local username = session.get_element("id", "username")
username.send_keys("myusername")

local password = session.get_element("id", "password")
password.send_keys("mypassword")

-- Submit form
local submitBtn = session.get_element("css selector", "button[type='submit']")
submitBtn.click()

-- Wait and check result
os.execute("sleep 2")
local welcome = session.get_element("css selector", "h1.welcome")
print("Welcome message:", welcome.get_text())
```

### Example 2: Web Scraping

```lua
local webdriver = require("luaWebDriver")

-- Setup
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chromedriver",
    port = 4444
})

local session = server.newSession({
    binary_location = "./chrome/chrome"
})

-- Navigate to a news website
session.navegate_to("https://news.ycombinator.com")

-- Get all article links
local articles = session.get_elements("css selector", "a.storylink")

-- Extract data
for i = 1, math.min(10, #articles) do
    local article = articles[i]
    local title = article.get_text()
    local url = article.get_attribute("href")
    print(string.format("%d. %s\n   URL: %s", i, title, url))
end
```

### Example 3: Multi-Tab Navigation

```lua
local webdriver = require("luaWebDriver")

-- Setup
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chromedriver",
    port = 4444
})

local session = server.newSession({
    binary_location = "./chrome/chrome"
})

-- Open multiple tabs with different sites
local sites = {
    "https://google.com",
    "https://github.com",
    "https://stackoverflow.com"
}

-- Open first site
session.navegate_to(sites[1])

-- Open remaining sites in new tabs
for i = 2, #sites do
    session.open_new_tab()
    session.switch_to_window(i)
    session.navegate_to(sites[i])
end

-- Switch between tabs and get titles
for i = 1, #sites do
    session.switch_to_window(i)
    local title = session.get_element("css selector", "title").get_attribute("innerText")
    print("Tab " .. i .. ": " .. title)
end

-- Close all tabs except the first
for i = #sites, 2, -1 do
    session.switch_to_window(i)
    session.close_window()
end
```

## 🔧 Tips and Best Practices

### 1. **Always Handle Errors**
```lua
local success, element = pcall(function()
    return session.get_element("id", "may-not-exist")
end)

if success then
    element.click()
else
    print("Element not found")
end
```

### 2. **Wait for Elements**
```lua
local function waitForElement(session, selector, value, timeout)
    timeout = timeout or 10
    local start = os.time()
    
    while os.time() - start < timeout do
        local success, element = pcall(function()
            return session.get_element(selector, value)
        end)
        
        if success then
            return element
        end
        
        os.execute("sleep 0.5")
    end
    
    error("Element not found after " .. timeout .. " seconds")
end
```

### 3. **Clean Up Sessions**
```lua
-- Sessions are automatically cleaned up when garbage collected
-- But you can also manually close them
local function runAutomation()
    local server = webdriver.newLocalServer({...})
    local session = server.newSession({...})
    
    -- Do your automation
    
    -- Manual cleanup (optional, happens automatically)
    collectgarbage()
end
```

## 📝 License

This documentation is for the LuaWebDriver library. Please refer
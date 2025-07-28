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
- [Alert Handling](#alert-handling)
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
| `download_directory` | string | ❌ | Directory for downloads |

**Example:**
```lua
local session = server.newSession({
    binary_location = "/usr/bin/google-chrome",
    download_directory = "/home/user/downloads",
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

### Session Convenience Methods

#### `session.get_element_by_id(element_id)`

![Method](https://img.shields.io/badge/Method-get__element__by__id-blue?style=flat-square)

Finds an element by its ID attribute (convenience method).

**Example:**
```lua
local loginButton = session.get_element_by_id("login-btn")
```

#### `session.get_element_by_css_selector(selector)`

![Method](https://img.shields.io/badge/Method-get__element__by__css__selector-blue?style=flat-square)

Finds an element using CSS selector (convenience method).

**Example:**
```lua
local header = session.get_element_by_css_selector("h1.title")
```

#### `session.get_element_by_xpath(xpath)`

![Method](https://img.shields.io/badge/Method-get__element__by__xpath-blue?style=flat-square)

Finds an element using XPath expression (convenience method).

**Example:**
```lua
local button = session.get_element_by_xpath("//button[@type='submit']")
```

#### `session.get_element_by_class_name(class_name)`

![Method](https://img.shields.io/badge/Method-get__element__by__class__name-blue?style=flat-square)

Finds an element by its CSS class name (convenience method).

**Example:**
```lua
local errorMsg = session.get_element_by_class_name("error-message")
```

#### `session.get_elements_by_css_selector(selector)`

![Method](https://img.shields.io/badge/Method-get__elements__by__css__selector-blue?style=flat-square)

Finds multiple elements using CSS selector (convenience method).

**Example:**
```lua
local navLinks = session.get_elements_by_css_selector("nav a")
```

#### `session.get_elements_by_xpath(xpath)`

![Method](https://img.shields.io/badge/Method-get__elements__by__xpath-blue?style=flat-square)

Finds multiple elements using XPath expression (convenience method).

**Example:**
```lua
local tableRows = session.get_elements_by_xpath("//table//tr")
```

#### `session.get_elements_by_class_name(class_name)`

![Method](https://img.shields.io/badge/Method-get__elements__by__class__name-blue?style=flat-square)

Finds multiple elements by CSS class name (convenience method).

**Example:**
```lua
local cards = session.get_elements_by_class_name("card")
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
local input = session.get_element_by_id( "username")
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
local searchBox = session.get_element_by_id( "search")
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
local form = session.get_element_by_id( "login-form")
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

#### `element.get_element_by_index_recursively(index)`

![Method](https://img.shields.io/badge/Method-get__element__by__index__recursively-blue?style=flat-square)

Gets any descendant element by index (1-based), searching recursively through all children.

**Example:**
```lua
local container = session.get_element("css selector", "div.complex")
-- Gets the 5th element anywhere within the container
local fifthElement = container.get_element_by_index_recursively(5)
```

#### `element.get_children_size()`

![Method](https://img.shields.io/badge/Method-get__children__size-blue?style=flat-square)

Returns the number of direct child elements.

**Example:**
```lua
local list = session.get_element("css selector", "ul")
local childCount = list.get_children_size()
print("List has " .. childCount .. " items")
```

#### `element.get_all_children_size()`

![Method](https://img.shields.io/badge/Method-get__all__children__size-blue?style=flat-square)

Returns the total number of descendant elements (all children recursively).

**Example:**
```lua
local container = session.get_element("css selector", "div.container")
local totalElements = container.get_all_children_size()
print("Container has " .. totalElements .. " elements in total")
```

#### `element.get_chromedriver_id()`

![Method](https://img.shields.io/badge/Method-get__chromedriver__id-blue?style=flat-square)

Returns the internal ChromeDriver element ID for debugging purposes.

**Example:**
```lua
local button = session.get_element_by_id("submit")
local id = button.get_chromedriver_id()
print("Element ID:", id)
```

#### `element.get_requisition_props(script, ...)`

![Method](https://img.shields.io/badge/Method-get__requisition__props-blue?style=flat-square)

Prepares request properties for executing JavaScript on an element.

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `script` | string | ✅ | JavaScript code to execute |
| `...` | any | ❌ | Additional arguments to pass to the script |

**Example:**
```lua
local button = session.get_element_by_id("submit")
local props = button.get_requisition_props("return arguments[0].innerText;")
```

#### `element.execute_script(script, ...)`

![Method](https://img.shields.io/badge/Method-execute__script-blue?style=flat-square)

Executes JavaScript code on an element and returns the result.

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `script` | string | ✅ | JavaScript code to execute |
| `...` | any | ❌ | Additional arguments to pass to the script |

**Example:**
```lua
local button = session.get_element_by_id("submit")
-- Get element's inner text using JavaScript
local text = button.execute_script("return arguments[0].innerText;")
print("Button text:", text)

-- Scroll element into view
button.execute_script("arguments[0].scrollIntoView();")

-- Change element's style
button.execute_script("arguments[0].style.backgroundColor = arguments[1];", "red")
```

## 🚨 Alert Handling

### `session.accept_alert()`

![Method](https://img.shields.io/badge/Method-accept__alert-blue?style=flat-square)

Accepts a JavaScript alert, confirm, or prompt dialog (clicks "OK").

**Example:**
```lua
-- Trigger an alert
session.navegate_to("data:text/html,<script>alert('Hello!');</script>")
-- Accept the alert
session.accept_alert()
```

### `session.dismiss_alert()`

![Method](https://img.shields.io/badge/Method-dismiss__alert-blue?style=flat-square)

Dismisses a JavaScript alert, confirm, or prompt dialog (clicks "Cancel").

**Example:**
```lua
-- Trigger a confirmation dialog
session.navegate_to("data:text/html,<script>confirm('Are you sure?');</script>")
-- Dismiss the alert
session.dismiss_alert()
```

### `session.get_alert_text()`

![Method](https://img.shields.io/badge/Method-get__alert__text-blue?style=flat-square)

Gets the text content of a JavaScript alert, confirm, or prompt dialog.

**Example:**
```lua
-- Trigger an alert with text
session.navegate_to("data:text/html,<script>alert('Important message!');</script>")
-- Get the alert text
local alertText = session.get_alert_text()
print("Alert says:", alertText)
session.accept_alert()
```

### `session.send_alert_text(text)`

![Method](https://img.shields.io/badge/Method-send__alert__text-blue?style=flat-square)

Sends text to a JavaScript prompt dialog.

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `text` | string | ✅ | Text to enter in the prompt |

**Example:**
```lua
-- Trigger a prompt dialog
session.navegate_to("data:text/html,<script>prompt('Enter your name:');</script>")
-- Send text to the prompt
session.send_alert_text("John Doe")
session.accept_alert()
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

### `session.get_window_count()`

![Method](https://img.shields.io/badge/Method-get__window__count-blue?style=flat-square)

Returns the number of open windows/tabs in the current session.

**Example:**
```lua
local windowCount = session.get_window_count()
print("Number of open windows:", windowCount)
```

### `session.get_current_url()`

![Method](https://img.shields.io/badge/Method-get__current__url-blue?style=flat-square)

Returns the URL of the current window/tab.

**Example:**
```lua
session.navegate_to("https://example.com")
local currentUrl = session.get_current_url()
print("Current URL:", currentUrl)
```

### `session.switch_to_frame(element_frame)`

![Method](https://img.shields.io/badge/Method-switch__to__frame-blue?style=flat-square)

Switches the WebDriver context to a specific iframe element.

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `element_frame` | element | ✅ | The iframe element to switch to |

**Example:**
```lua
-- Find an iframe element
local iframe = session.get_element("css selector", "iframe#myframe")
-- Switch to the iframe
session.switch_to_frame(iframe)
-- Now you can interact with elements inside the iframe
local insideElement = session.get_element_by_id("inside-iframe")
insideElement.click()
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
local username = session.get_element_by_id( "username")
username.send_keys("myusername")

local password = session.get_element_by_id( "password")
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

local big_box = session.get_element_by_id("bigbox")
local td = big_box[1]
local table_1 = td[1]
local tbody = table_1[1]

for i =1 , tbody.get_children_size() do 
    local tr = tbody.get_element_by_index(i)
    print(tr.get_text())
end
```

### Example 4: Alert Handling

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

-- Navigate to a page with alerts
session.navegate_to("data:text/html,<html><body>" ..
    "<button onclick=\"alert('Simple alert!')\">Show Alert</button>" ..
    "<button onclick=\"confirm('Are you sure?')\">Show Confirm</button>" ..
    "<button onclick=\"prompt('Enter your name:')\">Show Prompt</button>" ..
    "</body></html>")

-- Test simple alert
local alertBtn = session.get_element("css selector", "button:nth-child(1)")
alertBtn.click()
local alertText = session.get_alert_text()
print("Alert text:", alertText) -- "Simple alert!"
session.accept_alert()

-- Test confirm dialog
local confirmBtn = session.get_element("css selector", "button:nth-child(2)")
confirmBtn.click()
local confirmText = session.get_alert_text()
print("Confirm text:", confirmText) -- "Are you sure?"
session.dismiss_alert() -- Click "Cancel"

-- Test prompt dialog
local promptBtn = session.get_element("css selector", "button:nth-child(3)")
promptBtn.click()
local promptText = session.get_alert_text()
print("Prompt text:", promptText) -- "Enter your name:"
session.send_alert_text("John Doe")
session.accept_alert() -- Click "OK"
```

### Example 5: JavaScript Execution on Elements

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

-- Navigate to a test page
session.navegate_to("https://example.com")

-- Get an element and execute JavaScript on it
local heading = session.get_element("css selector", "h1")

-- Get element properties using JavaScript
local innerText = heading.execute_script("return arguments[0].innerText;")
local tagName = heading.execute_script("return arguments[0].tagName;")
local rect = heading.execute_script("return arguments[0].getBoundingClientRect();")

print("Element text:", innerText)
print("Tag name:", tagName)
print("Element position:", rect.x, rect.y)

-- Modify element using JavaScript
heading.execute_script("arguments[0].style.backgroundColor = 'yellow';")
heading.execute_script("arguments[0].style.fontSize = '24px';")

-- Scroll element into view
heading.execute_script("arguments[0].scrollIntoView({behavior: 'smooth'});")

-- Execute script with multiple arguments
local newText = "Modified by JavaScript"
local newColor = "red"
heading.execute_script(
    "arguments[0].innerText = arguments[1]; arguments[0].style.color = arguments[2];",
    newText,
    newColor
)
```

### Example 6: Frame and Window Management

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

-- Test page with iframe
session.navegate_to("data:text/html,<html><body>" ..
    "<h1>Main Page</h1>" ..
    "<iframe id='testframe' src='data:text/html,<h2>Inside Frame</h2><button id=\"frame-btn\">Frame Button</button>'>" ..
    "</iframe>" ..
    "</body></html>")

-- Work with main page
local mainHeading = session.get_element("css selector", "h1")
print("Main page heading:", mainHeading.get_text())

-- Switch to iframe
local iframe = session.get_element_by_id("testframe")
session.switch_to_frame(iframe)

-- Now work inside the frame
local frameHeading = session.get_element("css selector", "h2")
print("Frame heading:", frameHeading.get_text())

local frameButton = session.get_element_by_id("frame-btn")
frameButton.click()

-- Check window count and URLs
print("Number of windows:", session.get_window_count())
print("Current URL:", session.get_current_url())

-- Open new tabs and switch between them
session.open_new_tab()
session.switch_to_window(2)
session.navegate_to("https://google.com")

session.open_new_tab()
session.switch_to_window(3)
session.navegate_to("https://github.com")

-- Switch back to first window
session.switch_to_window(1)
print("Back to first window:", session.get_current_url())

-- Close tabs
session.switch_to_window(3)
session.close_window()
session.switch_to_window(2)
session.close_window()
```

## 🔧 Tips and Best Practices

### 1. **Always Handle Errors**
```lua
local success, element = pcall(function()
    return session.get_element_by_id( "may-not-exist")
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

### 4. **Handle Alerts Safely**
```lua
local function handleAlerts(session)
    local success, alertText = pcall(function()
        return session.get_alert_text()
    end)
    
    if success then
        print("Alert detected:", alertText)
        session.accept_alert()
        return true
    end
    return false
end

-- Use it before performing actions that might trigger alerts
handleAlerts(session)
button.click()
handleAlerts(session)
```

### 5. **Use JavaScript Execution for Complex Operations**
```lua
-- Instead of multiple WebDriver calls, use JavaScript for complex operations
local element = session.get_element_by_id("complex-element")

-- Multiple property access in one call
local elementInfo = element.execute_script([[
    return {
        text: arguments[0].innerText,
        visible: arguments[0].offsetParent !== null,
        rect: arguments[0].getBoundingClientRect(),
        style: window.getComputedStyle(arguments[0])
    };
]])

print("Element text:", elementInfo.text)
print("Is visible:", elementInfo.visible)
print("Width:", elementInfo.rect.width)
```


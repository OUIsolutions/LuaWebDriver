# LuaWebDriver API Usage Guide

This guide provides detailed documentation on how to use the LuaWebDriver API. LuaWebDriver is a Lua library that allows you to control web browsers programmatically using the WebDriver protocol.

## Table of Contents

1. [Getting Started](#getting-started)
2. [WebDriver Server](#webdriver-server)
3. [Session Management](#session-management)
4. [Page Navigation](#page-navigation)
5. [Element Finding](#element-finding)
6. [Element Interaction](#element-interaction)
7. [Window and Tab Management](#window-and-tab-management)
8. [JavaScript Execution](#javascript-execution)
9. [Complete Examples](#complete-examples)

## Getting Started

### Basic Setup

```lua
local webdriver = require("luaWebDriver")

-- Create a local ChromeDriver server
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,  -- HTTP client (luabear required)
    chromedriver_command = "./chrome/chromedriver",
    port = 4444
})

-- Create a new browser session
local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome"
})
```

### Remote Server Setup

If you have a remote WebDriver server running:

```lua
local server = webdriver.newRemoteServer({
    url = "http://remote-server:4444",
    fetch = luabear.fetch
})
```

## WebDriver Server

### newLocalServer(props)

Creates a local ChromeDriver server instance.

**Parameters:**
- `props` (table): Configuration object
  - `fetch` (function): HTTP client function (required)
  - `chromedriver_command` (string): Path to chromedriver executable (required)
  - `port` (number): Port number for the server (required)

**Returns:** Server object

**Example:**
```lua
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chrome/chromedriver",
    port = 4444
})
```

### newRemoteServer(props)

Connects to an existing remote WebDriver server.

**Parameters:**
- `props` (table): Configuration object
  - `url` (string): URL of the remote WebDriver server (required)
  - `fetch` (function): HTTP client function (required)

**Returns:** Server object

## Session Management

### server.newSession(props)

Creates a new browser session.

**Parameters:**
- `props` (table): Session configuration
  - `binary_location` (string): Path to Chrome browser executable (required)
  - `args` (table, optional): Array of Chrome command-line arguments
  - `use_automation_extension` (boolean, optional): Whether to use automation extension (default: false)

**Default Chrome Arguments:**
```lua
{
    "--disable-blink-features=AutomationControlled",
    "--disable-infobars",
    "--disable-notifications",
    "--disable-popup-blocking",
    "--disable-extensions",
    "--no-sandbox",
    "--ignore-certificate-errors",
    "--window-size=1920,1080",
    "--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"
}
```

**Returns:** Session object

**Example:**
```lua
local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome",
    args = {"--headless", "--no-sandbox"}  -- Custom arguments
})
```

### session.get_session_id()

Gets the current session ID.

**Returns:** String - Session ID

**Example:**
```lua
local sessionId = session.get_session_id()
print("Current session ID:", sessionId)
```

## Page Navigation

### session.navegate_to(url)

Navigates to a specified URL.

**Parameters:**
- `url` (string): The URL to navigate to (required)

**Example:**
```lua
session.navegate_to("https://www.google.com")
session.navegate_to("https://github.com")
```

## Element Finding

### By CSS Selector

#### session.get_element_by_css_selector(selector)
#### element.get_element_by_css_selector(selector)

Finds a single element using CSS selector.

**Parameters:**
- `selector` (string): CSS selector (required)

**Returns:** Element object or nil if not found

**Example:**
```lua
local searchBox = session.get_element_by_css_selector("input[name='q']")
local button = session.get_element_by_css_selector("button.search-btn")
```

#### session.get_elements_by_css_selector(selector)
#### element.get_elements_by_css_selector(selector)

Finds multiple elements using CSS selector.

**Parameters:**
- `selector` (string): CSS selector (required)

**Returns:** Array of Element objects

**Example:**
```lua
local links = session.get_elements_by_css_selector("a")
for i, link in ipairs(links) do
    print("Link " .. i .. ":", link.get_text())
end
```

### By XPath

#### session.get_element_by_xpath(xpath)
#### element.get_element_by_xpath(xpath)

Finds a single element using XPath.

**Parameters:**
- `xpath` (string): XPath expression (required)

**Returns:** Element object or nil if not found

**Example:**
```lua
local element = session.get_element_by_xpath("//div[@class='content']//p[1]")
local button = session.get_element_by_xpath("//button[contains(text(), 'Submit')]")
```

#### session.get_elements_by_xpath(xpath)
#### element.get_elements_by_xpath(xpath)

Finds multiple elements using XPath.

**Parameters:**
- `xpath` (string): XPath expression (required)

**Returns:** Array of Element objects

### By ID

#### session.get_element_by_id(element_id)
#### element.get_element_by_id(element_id)

Finds an element by its ID attribute.

**Parameters:**
- `element_id` (string): Element ID (required)

**Returns:** Element object or nil if not found

**Example:**
```lua
local loginButton = session.get_element_by_id("login-btn")
local username = session.get_element_by_id("username")
```

### By Class Name

#### session.get_element_by_class_name(class_name)
#### element.get_element_by_class_name(class_name)

Finds an element by its class name.

**Parameters:**
- `class_name` (string): Class name (required)

**Returns:** Element object or nil if not found

**Example:**
```lua
local errorMessage = session.get_element_by_class_name("error-message")
```

#### session.get_elements_by_class_name(class_name)
#### element.get_elements_by_class_name(class_name)

Finds multiple elements by class name.

### Generic Element Finding

#### session.get_element(by, value)
#### element.get_element(by, value)

Generic method to find a single element.

**Parameters:**
- `by` (string): Locator strategy ("css selector", "xpath", "id", "class name")
- `value` (string): Locator value

**Example:**
```lua
local element = session.get_element("css selector", "input[type='email']")
local element2 = session.get_element("xpath", "//div[@id='content']")
```

#### session.get_elements(by, value)
#### element.get_elements(by, value)

Generic method to find multiple elements.

### Element Navigation by Index

#### element.get_element_by_index(index)

Gets a direct child element by its index.

**Parameters:**
- `index` (number): 1-based index of the child element

**Returns:** Element object or nil

**Example:**
```lua
local firstChild = parentElement.get_element_by_index(1)
local thirdChild = parentElement.get_element_by_index(3)
```

#### element.get_element_by_index_recursively(index)

Gets any descendant element by its index (searches all nested elements).

**Parameters:**
- `index` (number): 1-based index

**Returns:** Element object or nil

#### element.get_children_size()

Gets the number of direct child elements.

**Returns:** Number of direct children

#### element.get_all_children_size()

Gets the total number of descendant elements.

**Returns:** Number of all descendants

### Metamethods for Elements

Elements support array-like access:

```lua
local firstChild = parentElement[1]  -- Same as get_element_by_index(1)
```

## Element Interaction

### element.click()

Clicks on the element.

**Example:**
```lua
local button = session.get_element_by_id("submit-btn")
button.click()
```

### element.send_keys(keys)

Sends keystrokes to the element.

**Parameters:**
- `keys` (string): Text to type (required)

**Example:**
```lua
local searchBox = session.get_element_by_css_selector("input[name='q']")
searchBox.send_keys("LuaWebDriver tutorial")

local passwordField = session.get_element_by_id("password")
passwordField.send_keys("mySecretPassword")
```

### element.get_text()

Gets the visible text content of the element.

**Returns:** String - Text content

**Example:**
```lua
local heading = session.get_element_by_css_selector("h1")
local title = heading.get_text()
print("Page title:", title)
```

### element.get_html()

Gets the outer HTML of the element.

**Returns:** String - HTML content

**Example:**
```lua
local div = session.get_element_by_id("content")
local html = div.get_html()
print("Element HTML:", html)
```

### element.get_attribute(attribute_name)

Gets the value of an element's attribute.

**Parameters:**
- `attribute_name` (string): Name of the attribute (required)

**Returns:** String - Attribute value or nil if not found

**Example:**
```lua
local link = session.get_element_by_css_selector("a")
local href = link.get_attribute("href")
local className = link.get_attribute("class")
local title = link.get_attribute("title")
```

### element.get_chromedriver_id()

Gets the internal ChromeDriver element ID.

**Returns:** String - Element ID

## Window and Tab Management

### session.open_new_tab()

Opens a new tab in the browser.

**Example:**
```lua
session.open_new_tab()
```

### session.open_new_window()

Opens a new browser window.

**Example:**
```lua
session.open_new_window()
```

### session.switch_to_window(index)

Switches to a specific window or tab by index.

**Parameters:**
- `index` (number): 1-based window index (required)

**Example:**
```lua
-- Switch to the second tab
session.switch_to_window(2)

-- Switch back to the first tab
session.switch_to_window(1)
```

### session.close_window()

Closes the current window or tab.

**Returns:** Array of remaining window handles

**Example:**
```lua
local remainingWindows = session.close_window()
print("Remaining windows:", #remainingWindows)
```

## JavaScript Execution

### element.execute_script(script, ...)

Executes JavaScript code with the element as the first argument.

**Parameters:**
- `script` (string): JavaScript code to execute (required)
- `...` (any): Additional arguments to pass to the script

**Returns:** The return value of the JavaScript execution

**Example:**
```lua
local element = session.get_element_by_id("myDiv")

-- Change element style
element.execute_script("arguments[0].style.backgroundColor = 'red';")

-- Get computed style
local color = element.execute_script("return window.getComputedStyle(arguments[0]).color;")

-- Execute with additional parameters
local result = element.execute_script("return arguments[0].tagName + arguments[1];", " - Modified")
```

## Complete Examples

### Example 1: Simple Google Search

```lua
local webdriver = require("luaWebDriver")

-- Setup
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chrome/chromedriver",
    port = 4444
})

local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome"
})

-- Navigate to Google
session.navegate_to("https://www.google.com")

-- Find search box and enter query
local searchBox = session.get_element_by_css_selector("input[name='q']")
searchBox.send_keys("LuaWebDriver")

-- Click search button
local searchButton = session.get_element_by_css_selector("input[value='Google Search']")
searchButton.click()

-- Wait and get results
local results = session.get_elements_by_css_selector("h3")
for i, result in ipairs(results) do
    print("Result " .. i .. ":", result.get_text())
end
```

### Example 2: Multiple Tabs Management

```lua
local webdriver = require("luaWebDriver")

local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chrome/chromedriver",
    port = 4444
})

local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome"
})

-- Sites to open
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

-- Switch between tabs and get page titles
for i = 1, #sites do
    session.switch_to_window(i)
    local title = session.get_element_by_css_selector("title")
    print("Tab " .. i .. " title:", title.get_text())
end

-- Close all tabs except the first
for i = #sites, 2, -1 do
    session.switch_to_window(i)
    session.close_window()
end
```

### Example 3: Form Interaction

```lua
local webdriver = require("luaWebDriver")

local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chrome/chromedriver",
    port = 4444
})

local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome"
})

-- Navigate to a form page
session.navegate_to("https://example.com/contact")

-- Fill out form fields
local nameField = session.get_element_by_id("name")
nameField.send_keys("John Doe")

local emailField = session.get_element_by_id("email")
emailField.send_keys("john@example.com")

local messageField = session.get_element_by_id("message")
messageField.send_keys("Hello, this is a test message!")

-- Submit the form
local submitButton = session.get_element_by_css_selector("input[type='submit']")
submitButton.click()

-- Check for success message
local successMessage = session.get_element_by_class_name("success")
if successMessage then
    print("Form submitted successfully:", successMessage.get_text())
end
```

### Example 4: Working with Dynamic Content

```lua
local webdriver = require("luaWebDriver")

local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chrome/chromedriver",
    port = 4444
})

local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome"
})

session.navegate_to("https://example.com/dynamic")

-- Get all product elements
local products = session.get_elements_by_class_name("product")

for i, product in ipairs(products) do
    -- Get product details
    local name = product.get_element_by_class_name("product-name").get_text()
    local price = product.get_element_by_class_name("product-price").get_text()
    local image = product.get_element_by_css_selector("img").get_attribute("src")
    
    print("Product " .. i .. ":")
    print("  Name: " .. name)
    print("  Price: " .. price)
    print("  Image: " .. image)
    
    -- Click on the product for more details
    product.click()
    
    -- Do something with the product detail page
    local description = session.get_element_by_class_name("description").get_text()
    print("  Description: " .. description)
    
    -- Go back to the product list
    session.navegate_to("https://example.com/dynamic")
end
```

## Error Handling

LuaWebDriver throws errors when operations fail. You should handle these appropriately:

```lua
local success, err = pcall(function()
    local element = session.get_element_by_id("non-existent-id")
    element.click()
end)

if not success then
    print("Error:", err)
end
```

## Best Practices

1. **Always clean up**: Sessions and servers are automatically cleaned up when they go out of scope, but it's good practice to manage them explicitly.

2. **Wait for elements**: When dealing with dynamic content, you may need to implement waiting logic.

3. **Use specific selectors**: Prefer ID and CSS selectors over XPath when possible for better performance.

4. **Handle errors gracefully**: Use pcall or similar error handling for robust automation.

5. **Close unnecessary tabs/windows**: Keep only the tabs you need open to conserve resources.

This documentation covers all the main functionality of LuaWebDriver. The library provides a simple yet powerful interface for browser automation in Lua.

# LuaWebDriver

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Chrome](https://img.shields.io/badge/Chrome-4285F4?style=for-the-badge&logo=Google-chrome&logoColor=white)
![WebDriver](https://img.shields.io/badge/WebDriver-43B02A?style=for-the-badge&logo=selenium&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

![Version](https://img.shields.io/badge/Version-0.1.0-brightgreen?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-Linux-orange?style=flat-square)

> 🚀 **A powerful and easy-to-use WebDriver implementation for Lua that enables browser automation and web scraping through ChromeDriver**

LuaWebDriver is a native Lua library that provides a complete WebDriver API implementation, allowing you to control Chrome browsers programmatically. Perfect for web automation, testing, scraping, and browser-based tasks.

## ✨ Features

- 🌐 **Full WebDriver API** - Complete implementation of WebDriver protocol
- 🎯 **Element Interaction** - Click, type, and interact with web elements
- 🔍 **Flexible Element Finding** - CSS selectors, XPath, ID, class name, and more
- 🪟 **Multi-Tab Support** - Open, switch, and manage multiple browser tabs
- 🖥️ **Local & Remote Servers** - Connect to local ChromeDriver or remote WebDriver hubs
- 📱 **Responsive Design** - Support for different window sizes and mobile emulation
- 🎨 **Headless Mode** - Run browsers without GUI for servers and CI/CD
- 🔧 **Easy Setup** - Simple installation with pre-compiled binaries

## 📋 Table of Contents

- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Basic Usage](#-basic-usage)
- [Documentation](#-documentation)
- [Examples](#-examples)
- [Building from Source](#-building-from-source)
- [Contributing](#-contributing)
- [License](#-license)

## 🚀 Quick Start

Get started with LuaWebDriver in just a few minutes:

### 1. Download Required Files

```bash
# Download LuaWebDriver
curl -L https://github.com/OUIsolutions/LuaWebDriver/releases/download/0.1.0/luaWebDriver.lua -o luaWebDriver.lua

# Download LuaBear HTTP client
mkdir -p luaBear
curl -L -o luaBear/luaBear.lua https://github.com/OUIsolutions/Lua-Bear/releases/download/0.3.0/luaBear.lua
curl -L -o luaBear/luaBear.so https://github.com/OUIsolutions/Lua-Bear/releases/download/0.3.0/luaBear.so

# Download ChromeDriver and Chrome
mkdir -p chrome
curl -L https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chromedriver-linux64.zip -o chromedriver.zip
curl -L https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chrome-linux64.zip -o chrome-linux64.zip
unzip chromedriver.zip -d chrome && unzip chrome-linux64.zip -d chrome
rm *.zip
```

### 2. Create Your First Script

```lua
local webdriver = require("luaWebDriver")
local luabear = require("luaBear.luaBear")

-- Setup WebDriver server
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chrome/chromedriver-linux64/chromedriver",
    port = 4444
})

-- Create a new browser session
local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome",
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

print("✅ Test completed successfully!")
```

### 3. Run Your Script

```bash
lua your_script.lua
```

## 💾 Installation

For detailed installation instructions, see our comprehensive guide:

📖 **[Installation Guide](docs/instaling_from_native_lua.md)** - Complete step-by-step installation process

## 🎯 Basic Usage

### Server Management

```lua
-- Local ChromeDriver server
local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chromedriver",
    port = 4444
})

-- Remote WebDriver server
local server = webdriver.newRemoteServer({
    url = "http://localhost:4444",
    fetch = luabear.fetch
})
```

### Element Finding & Interaction

```lua
-- Find elements using different strategies
local button = session.get_element_by_id("submit-btn")
local heading = session.get_element("css selector", "h1.title")
local links = session.get_elements("xpath", "//a[@class='nav-link']")

-- Interact with elements
button.click()
searchBox.send_keys("Hello World")
local text = heading.get_text()
local href = link.get_attribute("href")
```

### Multi-Tab Management

```lua
-- Open new tabs and switch between them
session.open_new_tab()
session.switch_to_window(2)
session.navegate_to("https://github.com")

-- Go back to first tab
session.switch_to_window(1)
```

## 📚 Documentation

### Core Documentation

| Document | Description |
|----------|-------------|
| 📖 **[API Usage Guide](docs/api_usage.md)** | Complete API reference with examples |
| 🔧 **[Installation Guide](docs/instaling_from_native_lua.md)** | Step-by-step installation instructions |
| 🏗️ **[Build from Scratch](docs/build_from_scratch.md)** | How to build the project from source |

### Quick Reference

| Topic | Methods | Description |
|-------|---------|-------------|
| **Server** | `newLocalServer()`, `newRemoteServer()` | Create WebDriver servers |
| **Session** | `newSession()`, `navegate_to()` | Browser session management |
| **Elements** | `get_element()`, `get_elements()` | Find elements on the page |
| **Interaction** | `click()`, `send_keys()`, `get_text()` | Interact with web elements |
| **Windows** | `open_new_tab()`, `switch_to_window()` | Multi-tab management |

## 🧪 Examples

### Web Scraping Example

```lua
local webdriver = require("luaWebDriver")
local luabear = require("luaBear.luaBear")

local server = webdriver.newLocalServer({
    fetch = luabear.fetch,
    chromedriver_command = "./chrome/chromedriver-linux64/chromedriver",
    port = 4444
})

local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome"
})

-- Scrape Hacker News
session.navegate_to("https://news.ycombinator.com")
local stories = session.get_elements("css selector", ".athing .titleline > a")

print("📰 Latest Hacker News Stories:")
for i = 1, math.min(5, #stories) do
    print(i .. ". " .. stories[i].get_text())
end
```

### Form Automation Example

```lua
-- Navigate to login page
session.navegate_to("https://example.com/login")

-- Fill form fields
local username = session.get_element_by_id("username")
username.send_keys("myusername")

local password = session.get_element_by_id("password")
password.send_keys("mypassword")

-- Submit form
local submitBtn = session.get_element("css selector", "button[type='submit']")
submitBtn.click()

-- Verify login success
local welcome = session.get_element("css selector", ".welcome-message")
print("Login result:", welcome.get_text())
```

### Headless Automation Example

```lua
-- Run in headless mode (no GUI)
local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome",
    args = {
        "--headless",
        "--no-sandbox",
        "--disable-dev-shm-usage",
        "--window-size=1920,1080"
    }
})

-- Perfect for servers and CI/CD environments
session.navegate_to("https://httpbin.org/json")
local jsonElement = session.get_element("css selector", "pre")
print("API Response:", jsonElement.get_text())
```

## 🏗️ Building from Source

If you want to build LuaWebDriver from source or contribute to the project:

📖 **[Build Guide](docs/build_from_scratch.md)** - Instructions for building with Darwin

### Requirements

- [Darwin](https://github.com/OUIsolutions/Darwin) v0.4.0 or higher
- Native Lua 5.4+

```bash
# Install Darwin
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.4.0/darwin.out -o darwin.out
sudo chmod +x darwin.out && sudo mv darwin.out /usr/bin/darwin

# Build LuaWebDriver
darwin run_blueprint
```

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. 🐛 **Report Bugs** - Open an issue with detailed information
2. 💡 **Suggest Features** - Share your ideas for improvements
3. 🔧 **Submit Pull Requests** - Help us improve the code
4. 📖 **Improve Documentation** - Help others understand the project

### Development Setup

```bash
git clone https://github.com/OUIsolutions/LuaWebDriver.git
cd LuaWebDriver
# Follow the build from source instructions
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Projects

- **[LuaBear](https://github.com/OUIsolutions/Lua-Bear)** - HTTP client library for Lua
- **[Darwin](https://github.com/OUIsolutions/Darwin)** - Build system used by this project
- **[ChromeDriver](https://chromedriver.chromium.org/)** - WebDriver for Chrome

## 🌟 Star History

If you find LuaWebDriver useful, please consider giving it a star! ⭐

---

<div align="center">

**Made with ❤️ by [OUI Solutions](https://github.com/OUIsolutions)**

[🌐 Website](https://ouisolutions.com) • [📧 Contact](mailto:contact@ouisolutions.com) • [🐦 Twitter](https://twitter.com/ouisolutions)

</div>

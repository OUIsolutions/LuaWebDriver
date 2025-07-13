# LuaWebDriver Installation Guide

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Chrome](https://img.shields.io/badge/Chrome-4285F4?style=for-the-badge&logo=Google-chrome&logoColor=white)
![WebDriver](https://img.shields.io/badge/WebDriver-43B02A?style=for-the-badge&logo=selenium&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Installation Steps](#installation-steps)
- [Testing Your Installation](#testing-your-installation)
- [Troubleshooting](#troubleshooting)
- [Alternative Configurations](#alternative-configurations)

## 🔧 Prerequisites

Before starting, make sure you have:

- **Linux operating system** (Ubuntu, Debian, CentOS, etc.)
- **Native Lua installed** (version 5.4 or higher)
- **curl** for downloading files
- **unzip** for extracting archives
- **Basic terminal knowledge**

You can check if you have these by running:
```bash
lua -v          # Check Lua version
curl --version  # Check curl
unzip           # Check unzip
```

## 🚀 Installation Steps

### Step 1: Download LuaWebDriver

![Step](https://img.shields.io/badge/Step-1-blue?style=flat-square)
![Required](https://img.shields.io/badge/Required-Yes-red?style=flat-square)

Download the main LuaWebDriver library file to your project directory.

```bash
curl -L https://github.com/OUIsolutions/LuaWebDriver/releases/download/0.1.0/luaWebDriver.lua -o luaWebDriver.lua
```

**What this does:**
- Downloads the latest stable release (v0.1.0) of LuaWebDriver
- Saves it as `luaWebDriver.lua` in your current directory
- Uses `-L` flag to follow redirects from GitHub

### Step 2: Download LuaBear HTTP Client

![Step](https://img.shields.io/badge/Step-2-blue?style=flat-square)
![Required](https://img.shields.io/badge/Required-Yes-red?style=flat-square)

LuaWebDriver needs an HTTP client to communicate with ChromeDriver. We'll use [`LuaBear`](https://github.com/OUIsolutions/Lua-Bear) for this purpose.

**Why do we need this?**
ChromeDriver uses HTTP/1.1 protocol for communication. LuaBear provides the necessary HTTP functionality that LuaWebDriver requires.

```bash
# Create directory for LuaBear
mkdir -p luaBear

# Download LuaBear Lua module
curl -L -o luaBear/luaBear.lua https://github.com/OUIsolutions/Lua-Bear/releases/download/0.3.0/luaBear.lua

# Download LuaBear native library (compiled C module)
curl -L -o luaBear/luaBear.so https://github.com/OUIsolutions/Lua-Bear/releases/download/0.3.0/luaBear.so
```

**File structure after this step:**
```
your-project/
├── luaWebDriver.lua
└── luaBear/
    ├── luaBear.lua
    └── luaBear.so
```

**Alternative HTTP Clients:**
If you prefer to use a different HTTP client, make sure it provides the same interface as LuaBear's `fetch` function.

### Step 3: Download ChromeDriver

![Step](https://img.shields.io/badge/Step-3-blue?style=flat-square)
![Required](https://img.shields.io/badge/Required-Yes-red?style=flat-square)

ChromeDriver is the bridge between your Lua code and the Chrome browser.

**Finding the right version:**
1. Visit the [Chrome for Testing page](https://googlechromelabs.github.io/chrome-for-testing/)
2. Choose a ChromeDriver version that matches your Chrome browser
3. For this guide, we're using version `138.0.7204.94`

```bash
# Create chrome directory
mkdir -p chrome

# Download ChromeDriver for Linux 64-bit
curl -L https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chromedriver-linux64.zip -o chromedriver.zip

# Extract ChromeDriver
unzip -o chromedriver.zip -d chrome

# Clean up zip file
rm chromedriver.zip
```

**What happens:**
- Downloads ChromeDriver v138.0.7204.94 for Linux 64-bit
- Extracts it to `chrome/chromedriver-linux64/`
- Removes the temporary zip file

### Step 4: Download Chrome Browser

![Step](https://img.shields.io/badge/Step-4-blue?style=flat-square)
![Required](https://img.shields.io/badge/Required-Yes-red?style=flat-square)

You need the Chrome browser binary that matches your ChromeDriver version.

**Important:** Always use the same version for both ChromeDriver and Chrome to avoid compatibility issues.

```bash
# Download Chrome browser (same version as ChromeDriver)
curl -L https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chrome-linux64.zip -o chrome-linux64.zip

# Extract Chrome browser
unzip -o chrome-linux64.zip -d chrome

# Clean up zip file
rm chrome-linux64.zip
```

**File structure after Steps 3 & 4:**
```
your-project/
├── luaWebDriver.lua
├── luaBear/
│   ├── luaBear.lua
│   └── luaBear.so
└── chrome/
    ├── chromedriver-linux64/
    │   └── chromedriver
    └── chrome-linux64/
        ├── chrome
        └── [other Chrome files...]
```

### Step 5: Create Your First Script

![Step](https://img.shields.io/badge/Step-5-blue?style=flat-square)
![Testing](https://img.shields.io/badge/Testing-Ready-green?style=flat-square)

Now let's create a simple test script to verify everything works correctly.

Create a file called `main.lua`:

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

## 🧪 Testing Your Installation

### Run Your First Script

![Test](https://img.shields.io/badge/Test-Run-green?style=flat-square)

```bash
lua main.lua
```

**Expected output:**
```
=== Hacker News Articles ===
1. Show HN: I built a tool to...
2. Ask HN: What are you working on?
3. [Article title...]
...
✅ Test completed successfully!
```

### Verify Installation

![Verify](https://img.shields.io/badge/Verify-Files-blue?style=flat-square)

Check that all files are in place:

```bash
# Check file structure
ls -la
ls -la luaBear/
ls -la chrome/

# Verify ChromeDriver is executable
./chrome/chromedriver-linux64/chromedriver --version

# Verify Chrome is executable  
./chrome/chrome-linux64/chrome --version
```

## 🔧 Troubleshooting

### Common Issues and Solutions

#### ![Error](https://img.shields.io/badge/Error-Permission-red?style=flat-square) Permission Denied

If you get permission errors:
```bash
# Make ChromeDriver executable
chmod +x ./chrome/chromedriver-linux64/chromedriver

# Make Chrome executable
chmod +x ./chrome/chrome-linux64/chrome
```

#### ![Error](https://img.shields.io/badge/Error-Module-red?style=flat-square) Module Not Found

If Lua can't find the modules:
```bash
# Check your current directory
pwd

# Make sure files exist
ls luaWebDriver.lua
ls luaBear/luaBear.lua
ls luaBear/luaBear.so
```

#### ![Error](https://img.shields.io/badge/Error-Chrome-red?style=flat-square) Chrome Won't Start

If Chrome fails to start:
```bash
# Install missing dependencies (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install -y libnss3 libatk-bridge2.0-0 libdrm2 libxcomposite1 libxdamage1 libxrandr2 libgbm1 libxss1 libasound2

# For CentOS/RHEL
sudo yum install -y nss atk at-spi2-atk libdrm libXcomposite libXdamage libXrandr mesa-libgbm libXScrnSaver alsa-lib
```

#### ![Error](https://img.shields.io/badge/Error-Version-red?style=flat-square) Version Mismatch

If ChromeDriver and Chrome versions don't match:
1. Check Chrome version: `./chrome/chrome-linux64/chrome --version`
2. Check ChromeDriver version: `./chrome/chromedriver-linux64/chromedriver --version`
3. Download matching versions from [Chrome for Testing](https://googlechromelabs.github.io/chrome-for-testing/)

## ⚙️ Alternative Configurations

### Using System Chrome

If you prefer to use your system's Chrome installation:

```lua
local session = server.newSession({
    binary_location = "/usr/bin/google-chrome",  -- or "/usr/bin/chromium"
})
```

### Headless Mode

For running without a GUI (servers, CI/CD):

```lua
local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome",
    args = {
        "--headless",
        "--no-sandbox",
        "--disable-dev-shm-usage"
    }
})
```

### Custom Window Size

Set a specific browser window size:

```lua
local session = server.newSession({
    binary_location = "./chrome/chrome-linux64/chrome",
    args = {
        "--window-size=1920,1080"
    }
})
```

## 🎉 Next Steps

Now that you have LuaWebDriver installed, you can:

1. **Read the [API Documentation](api_usage.md)** to learn about all available features
2. **Explore element finding methods** like `get_element_by_id`, `get_element_by_css_selector`
3. **Try form automation** with `send_keys` and `click` methods
4. **Experiment with multiple tabs** using `open_new_tab` and `switch_to_window`

**Happy automating! 🚀**


# LuaWebDriver Build from Scratch Guide

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Darwin](https://img.shields.io/badge/Darwin-Build_Tool-orange?style=for-the-badge&logo=gear&logoColor=white)
![WebDriver](https://img.shields.io/badge/WebDriver-43B02A?style=for-the-badge&logo=selenium&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Understanding the Build Process](#understanding-the-build-process)
- [Installation Steps](#installation-steps)
- [Building LuaWebDriver](#building-luawebdriver)
- [Verifying Your Build](#verifying-your-build)
- [Understanding the Build Output](#understanding-the-build-output)
- [Troubleshooting](#troubleshooting)
- [Advanced Configuration](#advanced-configuration)

## 🔍 Overview

This tutorial teaches you how to build **luaWebDriver.lua** from source code using the Darwin blueprint system. This approach gives you complete control over the build process and allows you to modify the source code if needed.

**When should you build from scratch?**
- You want to modify the LuaWebDriver source code
- You need the latest development version
- You want to understand how the library is constructed
- You're contributing to the project

**Prerequisites Reading:**
If you're new to LuaWebDriver, please read these documents first:
- [Installing from Native Lua](instaling_from_native_lua.md) - Basic installation and usage
- [API Usage](api_usage.md) - Understanding the API

## 🔧 Prerequisites

Before starting, make sure you have:

- **Linux operating system** (Ubuntu, Debian, CentOS, etc.)
- **Native Lua installed** (version 5.4 or higher)
- **curl** for downloading files
- **git** (optional, for cloning the repository)
- **Basic terminal knowledge**

You can check if you have these by running:
```bash
lua -v          # Check Lua version
curl --version  # Check curl availability
git --version   # Check git (optional)
```

## 🏗️ Understanding the Build Process

![Process](https://img.shields.io/badge/Process-Blueprint-blue?style=flat-square)
![Darwin](https://img.shields.io/badge/Tool-Darwin-orange?style=flat-square)

LuaWebDriver uses **Darwin**, a powerful build automation tool, to combine multiple source files into a single distributable `luaWebDriver.lua` file.

### What is Darwin?

[Darwin](https://github.com/OUIsolutions/Darwin) is a Lua-based build automation tool that executes "blueprints" - configuration files that define how to build projects. It's similar to Make, but specifically designed for Lua projects.

### The Blueprint Process

The build process is defined in `darwinconf.lua`, which:

1. **Downloads Dependencies**: Automatically fetches LuaHeritage (inheritance system)
2. **Combines Source Files**: Merges all files from the `src/` directory
3. **Wraps Everything**: Creates a proper Lua module structure
4. **Generates Output**: Produces the final `luaWebDriver.lua` file

### File Structure Overview

```
LuaWebDriver/
├── darwinconf.lua          # Build configuration (Darwin blueprint)
├── objects.lua             # Core object definitions
├── src/                    # Source code directory
│   ├── server.lua         # WebDriver server implementation
│   ├── types.lua          # Type definitions
│   ├── element/           # Element-related functionality
│   │   ├── actions.lua    # Element actions (click, type, etc.)
│   │   ├── constructor.lua # Element creation
│   │   ├── extra.lua      # Additional element features
│   │   ├── finders.lua    # Element finding methods
│   │   ├── meta.lua       # Element metadata
│   │   └── retrivers.lua  # Element property retrieval
│   └── session/           # Session-related functionality
│       ├── constructor.lua # Session creation
│       ├── elements.lua   # Session element management
│       ├── extra.lua      # Additional session features
│       ├── meta.lua       # Session metadata
│       └── navegation.lua # Navigation methods
└── dependencies/          # Auto-generated dependency directory
    └── herigitage.lua     # LuaHeritage inheritance system
```

## 🚀 Installation Steps

### Step 1: Install Darwin Build Tool

![Step](https://img.shields.io/badge/Step-1-blue?style=flat-square)
![Required](https://img.shields.io/badge/Required-Yes-red?style=flat-square)

Darwin is the build automation tool that processes the blueprint configuration.

**Why Darwin 0.4.0+?**
LuaWebDriver's build configuration requires Darwin version 0.4.0 or above for proper blueprint execution and dependency management.

```bash
# Download Darwin binary
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.4.0/darwin.out -o darwin.out

# Make it executable
sudo chmod +x darwin.out

# Install system-wide
sudo mv darwin.out /usr/bin/darwin

# Verify installation
darwin --version
```

**What this does:**
- Downloads Darwin v0.4.0 build tool
- Makes it executable with proper permissions
- Installs it system-wide in `/usr/bin/`
- The `--version` command verifies successful installation

### Step 2: Get the LuaWebDriver Source Code

![Step](https://img.shields.io/badge/Step-2-blue?style=flat-square)
![Method](https://img.shields.io/badge/Method-Choose_One-yellow?style=flat-square)

You can obtain the source code in two ways:

#### Option A: Clone from Git (Recommended)

```bash
# Clone the repository
git clone https://github.com/OUIsolutions/LuaWebDriver.git

# Enter the directory
cd LuaWebDriver
```

#### Option B: Download Source Archive

```bash
# Download the latest source code
curl -L https://github.com/OUIsolutions/LuaWebDriver/archive/main.zip -o luawebdriver-source.zip

# Extract the archive
unzip luawebdriver-source.zip

# Enter the directory
cd LuaWebDriver-main
```

### Step 3: Verify Source Structure

![Step](https://img.shields.io/badge/Step-3-blue?style=flat-square)
![Check](https://img.shields.io/badge/Check-Structure-green?style=flat-square)

Before building, verify that you have all necessary files:

```bash
# Check for essential files
ls -la darwinconf.lua    # Build configuration
ls -la objects.lua       # Core objects
ls -la src/             # Source directory

# Verify source structure
find src/ -name "*.lua" | head -10
```

**Expected output:**
```
-rw-r--r-- 1 user user  827 date darwinconf.lua
-rw-r--r-- 1 user user 1234 date objects.lua
drwxr-xr-x 4 user user 4096 date src/

src/server.lua
src/types.lua
src/element/actions.lua
src/element/constructor.lua
...
```

## 🔨 Building LuaWebDriver

### Step 4: Execute the Darwin Blueprint

![Step](https://img.shields.io/badge/Step-4-blue?style=flat-square)
![Build](https://img.shields.io/badge/Build-Execute-orange?style=flat-square)

Now we'll run the Darwin build process using the blueprint configuration:

```bash
# Execute the Darwin blueprint
darwin run_blueprint
```

**What happens during the build:**

1. **Dependency Download**: Darwin automatically downloads LuaHeritage
   ```
   Creating dependencies/ directory...
   Downloading herigitage.lua...
   ```

2. **File Collection**: Gathers all source files from `src/` recursively
   ```
   Loading objects.lua...
   Processing src/server.lua...
   Processing src/types.lua...
   Processing src/element/*.lua...
   Processing src/session/*.lua...
   ```

3. **Module Assembly**: Combines everything into a single module
   ```
   Wrapping in module structure...
   Adding LuaHeritage integration...
   Generating final output...
   ```

4. **Output Generation**: Creates the final `luaWebDriver.lua` file
   ```
   Writing luaWebDriver.lua...
   Build completed successfully!
   ```

### Step 5: Verify Build Success

![Step](https://img.shields.io/badge/Step-5-blue?style=flat-square)
![Verify](https://img.shields.io/badge/Verify-Success-green?style=flat-square)

Check that the build completed successfully:

```bash
# Check if the output file was created
ls -la luaWebDriver.lua

# Check file size (should be substantial)
wc -l luaWebDriver.lua

# Verify it's a valid Lua file
lua -l luaWebDriver -e "print('Build successful!')"
```

**Expected output:**
```
-rw-r--r-- 1 user user 45678 date luaWebDriver.lua
   1234 luaWebDriver.lua
Build successful!
```

## ✅ Verifying Your Build

### Test the Built Library

![Test](https://img.shields.io/badge/Test-Basic-green?style=flat-square)

Create a simple test to verify your built library works correctly:

```bash
# Create a test file
cat > test_build.lua << 'EOF'
-- Test the built LuaWebDriver library
local webdriver = require("luaWebDriver")

-- Test basic functionality
print("✅ LuaWebDriver loaded successfully")
print("📦 Version: " .. (webdriver.version or "Built from source"))
print("🔧 Build test completed!")

-- Test object creation (without actual browser)
local success, err = pcall(function()
    local server = webdriver.newLocalServer
    if server then
        print("🏭 Server constructor available")
    end
end)

if success then
    print("✅ All basic tests passed!")
else
    print("❌ Test failed: " .. tostring(err))
end
EOF

# Run the test
lua test_build.lua
```

### Compare with Official Release

![Compare](https://img.shields.io/badge/Compare-Optional-blue?style=flat-square)

You can compare your built version with the official release:

```bash
# Download official release for comparison
curl -L https://github.com/OUIsolutions/LuaWebDriver/releases/download/0.1.0/luaWebDriver.lua -o luaWebDriver_official.lua

# Compare file sizes
echo "Your build: $(wc -l < luaWebDriver.lua) lines"
echo "Official:   $(wc -l < luaWebDriver_official.lua) lines"

# Basic diff check (expect some differences in timestamps/comments)
diff -q luaWebDriver.lua luaWebDriver_official.lua || echo "Files differ (expected for source builds)"
```

## 📊 Understanding the Build Output

### The Generated luaWebDriver.lua Structure

The built file follows this structure:

```lua
return (function()
    -- Core object definitions from objects.lua
    
    -- LuaHeritage inheritance system
    local Heregitage = (function() ... end)()
    
    -- Server implementation (src/server.lua)
    
    -- Type definitions (src/types.lua)
    
    -- Element functionality (src/element/*.lua)
    
    -- Session functionality (src/session/*.lua)
    
    return WebDriver;  -- Return the main module
end)()
```

### Dependencies Explained

![Dependencies](https://img.shields.io/badge/Dependencies-Automatic-blue?style=flat-square)

- **LuaHeritage**: Provides object-oriented programming features
- **Source Files**: All functionality split into logical modules
- **Module Wrapper**: Creates a proper Lua module that can be required

## 🔧 Troubleshooting

### Common Build Issues

#### ![Error](https://img.shields.io/badge/Error-Darwin_Not_Found-red?style=flat-square) Darwin Command Not Found

```bash
# Check if Darwin is installed
which darwin

# If not found, reinstall
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.4.0/darwin.out -o darwin.out
sudo chmod +x darwin.out
sudo mv darwin.out /usr/bin/darwin
```

#### ![Error](https://img.shields.io/badge/Error-Permission_Denied-red?style=flat-square) Permission Issues

```bash
# Make sure you have write permissions
ls -la .

# Fix permissions if needed
chmod 755 .
chmod 644 *.lua
```

#### ![Error](https://img.shields.io/badge/Error-Missing_Files-red?style=flat-square) Missing Source Files

```bash
# Verify all required files exist
test -f darwinconf.lua && echo "✅ darwinconf.lua" || echo "❌ darwinconf.lua missing"
test -f objects.lua && echo "✅ objects.lua" || echo "❌ objects.lua missing"
test -d src && echo "✅ src/ directory" || echo "❌ src/ directory missing"

# Re-download if files are missing
git pull  # If using git
# Or re-download the source archive
```

#### ![Error](https://img.shields.io/badge/Error-Network_Issues-red?style=flat-square) Dependency Download Fails

If LuaHeritage download fails:

```bash
# Manually download the dependency
mkdir -p dependencies
curl -L https://github.com/mateusmoutinho/LuaHeritage/releases/download/1.0.0/heregitage.lua -o dependencies/herigitage.lua

# Verify the file
ls -la dependencies/herigitage.lua

# Then run the build again
darwin run_blueprint
```

## ⚙️ Advanced Configuration

### Customizing the Build

You can modify `darwinconf.lua` to customize the build process:

```lua
-- Example: Add custom preprocessing
local custom_header = "-- Built on " .. os.date() .. "\n"

-- Add version information
local version_info = "-- LuaWebDriver Custom Build\n"

-- Modify the build process
local all = {
  [[return (function()]]
}

-- Add custom content
all[#all + 1] = custom_header
all[#all + 1] = version_info

-- Continue with normal build...
```

### Building with Different Dependencies

You can modify which version of LuaHeritage to use:

```bash
# Edit darwinconf.lua to use a different version
sed -i 's/1.0.0/1.1.0/g' darwinconf.lua

# Clean dependencies and rebuild
rm -rf dependencies/
darwin run_blueprint
```

### Development Builds

For development, you might want to add debug information:

```lua
-- Add to darwinconf.lua before the final return
all[#all + 1] = [[
    -- Debug information
    WebDriver._build_info = {
        date = "]] .. os.date() .. [[",
        source = "custom_build"
    }
]]
```

## 🎉 Next Steps

Now that you've successfully built LuaWebDriver from source:

1. **Use Your Build**: Your `luaWebDriver.lua` works exactly like the official release
2. **Modify Source Code**: Edit files in `src/` and rebuild to customize functionality
3. **Contribute**: Submit pull requests with your improvements
4. **Stay Updated**: Rebuild periodically to get the latest changes

**Development Workflow:**
```bash
# Make changes to source files
vim src/element/actions.lua

# Rebuild
darwin run_blueprint

# Test your changes
lua your_test_script.lua
```

**Happy building! 🚀**


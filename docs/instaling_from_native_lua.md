
to install from native lua, follow these steps 

## Step 1: Download luaWebDriver

```bash
curl -L https://github.com/OUIsolutions/LuaWebDriver/releases/download/0.1.0/luaWebDriver.lua -o luaWebDriver.lua
```

## Step 2: Download [`luaBear`](https://github.com/OUIsolutions/Lua-Bear) (or provide a equivalent implementation)
since chromedriver, requires a a http1.0 client ,we  need to download a **htpp** client for these
in these case we are using [`luaBear`](https://github.com/OUIsolutions/Lua-Bear) ,but you can use 
what ever lib you want, as long if the match the same schema 

```bash
mkdir -p luaBear
curl -L -o luaBear/luaBear.lua https://github.com/OUIsolutions/Lua-Bear/releases/download/0.3.0/luaBear.lua
curl -L -o luaBear/luaBear.so https://github.com/OUIsolutions/Lua-Bear/releases/download/0.3.0/luaBear.so
```
## Step 3: Download Chromedriver 
Navegate to [`chrome Testing Page`](https://googlechromelabs.github.io/chrome-for-testing/) and chose a chromedrivver version

```bash
mkdir -p chrome
curl -L https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chromedriver-linux64.zip -o chromedriver.zip
unzip -o chromedriver.zip -d chrome
rm chromedriver.zip
```
## Step 4: Download the same version for chrome 

```bash
curl -L https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chrome-linux64.zip -o chrome-linux64.zip
unzip -o chrome-linux64.zip -d chrome 
rm chrome-linux64.zip
```

## Step 5 : Create a hello world 
now , create a **main.lua** file with the following content 

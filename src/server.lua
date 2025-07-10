
local function Server__gc(public,private)
    print("turning off chromedriver on port " .. private.port)
    os.execute(string.format(
        'curl -X DELETE "http://127.0.0.1:%d/shutdown" >/dev/null 2>&1',
        private.port
    ))
end

local function Server_newSession(public,private)
       return Private.newSession({url = private.url, fetch = private.fetch})
end

WebDriver.newLocalServer = function(props)

    if not props.chromedriver_command then
        error("chromedriver_command is required")
    end
    if not props.chrome_binary then
        error("chrome_binary is required")
    end

    local selfobj = herigitage.newMetaObject({private=props})
    selfobj.set_meta_method("__gc", Server__gc)
    selfobj.set_public_method("newSession", Server_newSession)
    
    -- Start chromedriver with proper command formatting
    local command = "%s --port=%d --binary=%s &"
    command = command:format(props.chromedriver_command, props.port, props.chrome_binary)
    
    print("Starting chromedriver with command: " .. command)
    os.execute(command)
    
    -- Wait for chromedriver to start
    os.execute("sleep 2")
    
    return selfobj
end



Private.WebDriver_aply__gc_method = function (selfobj)
    
    function turnoff_chromedriver()
        print("turning off chromedriver on port " .. selfobj.port)
        os.execute(string.format(
            'curl -X DELETE "http://127.0.0.1:%d/shutdown" >/dev/null 2>&1',
            selfobj.port
        ))
    end    
    setmetatable(selfobj,{__gc = turnoff_chromedriver})
end

Private.WebDriver_aply_new_session_method = function (selfobj,props)
    selfobj.newSession = function ()
       return Private.newSession({url = props.url, fetch = props.fetch})
    end
end

WebDriver.newLocalServer = function(props)

    if not props.chromedriver_command then
        error("chromedriver_command is required")
    end
    if not props.chrome_binary then
        error("chrome_binary is required")
    end

    local selfobj = {}
    Private.WebDriver_aply__gc_method(selfobj)
    Private.WebDriver_aply_new_session_method(selfobj,{
        fetch = props.fetch,
        url = selfobj.url
    })
    
    -- Start chromedriver with proper command formatting
    local command = "%s --port=%d --binary=%s &"
    command = command:format(props.chromedriver_command, props.port, props.chrome_binary)
    
    print("Starting chromedriver with command: " .. command)
    os.execute(command)
    
    -- Wait for chromedriver to start
    os.execute("sleep 2")
    
    return selfobj
end
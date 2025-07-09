



WebDriver.newLocalServer = function(props)

    if not props.chromedriver_command then
        error("chromedriver_command is required")
    end
    if not props.chrome_binary then
        error("chrome_binary is required")
    end

    local selfobj = {
        port = props.port or 4444,
    }

    function turnoff_chromedriver()
        if props.fetch then
            props.fetch({
                url="http://127.0.0.1:"..selfobj.port.."/shutdown",
                method="DELETE",
            })
        end
    end
    
    setmetatable(selfobj,{__gc = turnoff_chromedriver})
    
    -- Start chromedriver with proper command formatting
    local command = "%s --port=%d --binary=%s &"
    command = command:format(props.chromedriver_command, selfobj.port, props.chrome_binary)
    
    print("Starting chromedriver with command: " .. command)
    os.execute(command)
    
    -- Wait for chromedriver to start
    os.execute("sleep 2")
    
    return selfobj
end
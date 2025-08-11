Server.close = function(public,private)
    if private.closed then 
        return
    end
    print("turning off chromedriver on port " .. private.port)
    
    private.fetch({
        http_version = "1.1",
        url=string.format("http://127.0.0.1:%d/shutdown", private.port),
    })
    private.closed = true
end


Server.__gc = function (public,private)
    public.close()
end

Server.newSession = function(public,private, props)
    if not props then 
        error("props is required")
    end
    if not props.binary_location then
        error("binary_location is required")
    end

    local created =  Session.newSession(private, props)
    created.server = public
    return created
end


WebDriver.newLocalServer = function(props)
    print("iniciou o server")
    if not props.chromedriver_command then
        error("chromedriver_command is required")
    end
    
    if not props.fetch then
        error("fetch is required")
    end
    local selfobj = Heregitage.newMetaObject()
    selfobj.private_props_extends(props)
    selfobj.set_meta_method("__gc", Server.__gc)
    selfobj.set_meta_method("close", Server.close)
    selfobj.set_public_method("newSession", Server.newSession)
    
    if props.port then 
        
        selfobj.private.url = "http://127.0.0.1:"..selfobj.private.port
        local command = "%s --port=%d &"
        command = command:format(props.chromedriver_command, props.port)
        print("Starting chromedriver with command: " .. command)
        local ok = os.execute(command)
        if ok then
            error("Failed to start chromedriver with command: " .. command)
        end    
    else
        local started = false
        for i = 4444, 65535 do
            selfobj.private.port = i
            selfobj.private.url = "http://127.0.0.1:"..selfobj.private.port

            -- Start chromedriver with proper command formatting
            local command = "%s --port=%d &"
            command = command:format(props.chromedriver_command, selfobj.private.port)
            print("Starting chromedriver with command: " .. command)
            local ok = os.execute(command)
            if ok then
                started = true
                break
            end
        end
        if not started then
            error("Failed to start chromedriver on any port between 4444 and 65535")
        end
    end

    -- Wait for chromedriver to start
    os.execute("sleep 2")
    
    return selfobj.public
end

WebDriver.newRemoteServer = function(props)
    if not props.url then
        error("url is required")
    end

    if not props.fetch then
        error("fetch is required")
    end

    local selfobj = Heregitage.newMetaObject()
    selfobj.private_props_extends(props)
    selfobj.private.url = props.url
    selfobj.set_meta_method("__gc", Server.__gc)
    selfobj.set_public_method("newSession", Server.newSession)

    return selfobj.public
end
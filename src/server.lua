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

    if not props.chromedriver_command then
        error("chromedriver_command is required")
    end
    
    if not props.fetch then
        error("fetch is required")
    end

    local selfobj = Heregitage.newMetaObject()
    selfobj.private_props_extends(props)
    selfobj.private.url = "http://127.0.0.1:"..selfobj.private.port
    selfobj.set_meta_method("__gc", Server.__gc)
    selfobj.set_meta_method("close", Server.close)
    selfobj.set_public_method("newSession", Server.newSession)


    -- Start chromedriver with proper command formatting
    local command = "%s --port=%d &"
    command = command:format(props.chromedriver_command, props.port)
    
    print("Starting chromedriver with command: " .. command)
    os.execute(command)
    
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
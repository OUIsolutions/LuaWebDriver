



WebDriver.newLocalServer = function(props)

    if not props.chromedriver_comand then
        error("chromedriver_command is required")
    end
    if not props.chrome_binary then
        error("chrome_binary is required")
    end

    local selfobj = {
        port = props.port or 4444,
    }

    function turnof_chromedriver()
        props.fetch({
            url="127.0.1:"..selfobj.port.."/shutdown",
            method="DELETE",
        })

    end
    setmetatable(selfobj,{__gc = turnof_chromedriver})
    local command = "%s --port=%d --binary=%s & "
    command = command:format(props.chromedriver_comand, selfobj.port, props.chrome_binary)
    os.execute(command)
    --sleep for 1 second to allow the server to start
    os.execute("sleep 1")
    return selfobj
end
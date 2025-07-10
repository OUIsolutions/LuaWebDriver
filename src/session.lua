

-- Helper function to get Chrome process PID after session creation
local function findChromePid(binary_location)
    -- Get the most recently started Chrome process
    local handle = io.popen("ps -eo pid,lstart,cmd | grep '" .. binary_location .. "' | grep -v grep | sort -k2 | tail -1 | awk '{print $1}'")
    if not handle then
        return nil
    end
    local pid = handle:read("*a")
    handle:close()
    return pid and pid:match("(%d+)") or nil
end

Session.__gc = function (public, private)
    print("Closing session with ID: " .. private.session_id)
    
    -- First, close the WebDriver session
    local result = private.props.fetch({
        url = private.props.url .. "/session/" .. private.session_id,
        method = "DELETE",
        http_version = "1.1"
    })
    if result.status_code ~= 200 then
        print("Failed to close session: " .. result.read_body())
    end
    
    -- Then, force kill the Chrome process if we have its PID
    if private.chrome_pid then
        print("Killing Chrome process with PID: " .. private.chrome_pid)
        os.execute("kill -9 " .. private.chrome_pid .. " 2>/dev/null")
    else
        -- Fallback: kill all Chrome processes started with our binary
        print("Killing Chrome processes (fallback method)")
        local chrome_binary = private.props.binary_location or "chrome"
        os.execute("pkill -f '" .. chrome_binary .. "' 2>/dev/null")
    end
end


Session.newSession = function (props)

    local selfobject = Heregitage.newMetaObject()
    selfobject.private_props_extends(props)
    selfobject.set_meta_method("__gc", Session.__gc)
    
    local result = props.fetch({
        url=props.url.."/session",
        method = "POST",
        http_version = "1.1",
        body = {
            capabilities = {
                alwaysMatch = {
                    browserName = "chrome",
                    ["goog:chromeOptions"] = {
                        binary = props.binary_location
                    }
                }
            }
        }
    })
    local body = result.read_body_json()
    selfobject.private.session_id = body.value.sessionId
    
    -- Try to find and store the Chrome process PID
    if props.binary_location then
        local chrome_pid = findChromePid(props.binary_location)
        if chrome_pid then
            selfobject.private.chrome_pid = chrome_pid
            print("Found Chrome process PID: " .. chrome_pid)
        else
            print("Warning: Could not find Chrome process PID")
        end
    end
    
    return selfobject.public

end


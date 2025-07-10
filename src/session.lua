

Session.__gc = function (public, private)
    print("Closing session with ID: " .. private.session_id)
    
    -- First, close the WebDriver session
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id,
        method = "DELETE",
        http_version = "1.1"
    })
    if result.status_code ~= 200 then
        print("Failed to close session: " .. result.read_body())
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
    return selfobject.public

end


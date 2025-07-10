


Session.newSession = function (props)

    local selfobject = Heregitage.newMetaObject()
    selfobject.private_props_extends(props)
    selfobject.set_meta_method("__gc", Session.__gc)
    selfobject.public_method_extends(PublicSession)

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


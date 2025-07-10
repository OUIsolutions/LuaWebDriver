
Session.newSession = function (props)

    local selfobject = Heregitage.newMetaObject()
    selfobject.private_props_extends(props)
    
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
    print(result.status_code)
    print(result.read_body())
    return selfobject.public

end
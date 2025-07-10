
Private.newSession = function (props)
    local result = props.fetch({
        url = string.format(props.url .. "/session"),
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


end

Private.newSession = function (props)
    local result = props.fetch({
        url = string.format(props.url .."/session"),
        method = "POST",
        body ={
            capabilities = {
                alwaysMatch = {
                    browserName = "chrome",
                 
                }
            }
        }
    })
    print(result.status_code)


end
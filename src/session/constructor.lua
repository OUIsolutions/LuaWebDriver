



Session.newSession = function (private_server_props,props)

    local selfobject = Heregitage.newMetaObject()
    selfobject.private_props_extends(private_server_props)
    selfobject.private_props_extends(props)
    selfobject.meta_method_extends(MetaSession)
    selfobject.public_method_extends(PublicSession)


    local body = props.body
    if not body then 

        local args = props.args 
        if not args then 
            args = {
                "--disable-blink-features=AutomationControlled",
                "--disable-infobars",
                "--disable-notifications",
                "--disable-popup-blocking",
                "--disable-extensions",
                "--no-sandbox",
                "--ignore-certificate-errors",
                "--window-size=1920,1080",
                "--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"
            }
        end 
        
        local use_automation_extension = props.use_automation_extension or false
        body = {
                capabilities = {
                    alwaysMatch = {
                        browserName = "chrome",
                        ["goog:chromeOptions"] = {
                            binary = props.binary_location,
                            args =args,
                            prefs={
                                ["download.default_directory"]= props.download_directory
                            },
                            excludeSwitches = {"enable-automation"},
                            useAutomationExtension = use_automation_extension
                        }
                    }
                }
        }
        
    end

    local requisition = {
            url =selfobject.private.url.."/session",
            method = "POST",
            http_version = "1.1",
            body=body   
    }
    
    local result = selfobject.private.fetch(requisition)

    
    local response_body = result.read_body_json()
    selfobject.private.session_id = response_body.value.sessionId

    if not selfobject.private.session_id then 
         error(json.dumps_to_string(response_body))
    end

    return selfobject.public

end


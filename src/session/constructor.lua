


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
                    binary = props.binary_location,
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
                    },
                    excludeSwitches = {"enable-automation"},
                    useAutomationExtension = false
                }
            }
        }
    }
})
    local body = result.read_body_json()
    selfobject.private.session_id = body.value.sessionId
    return selfobject.public

end


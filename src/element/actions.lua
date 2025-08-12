PublicElement.send_keys = function(public, private, keys)
    -- Check if the keys parameter is a string
    if type(keys) ~= "string" then
        error("Keys must be a string")
    end

    -- Send the request to the WebDriver server
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. private.element_id .. "/value",
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json"
        },
        body = {text=keys},
        http_version = "1.1"
    })

    -- Check for errors in the response
    if result.status_code  ~= 200 then
        error("Failed to send keys: " .. (result.read_body() or "Unknown error"))
    end

    return true
end

PublicElement.clear = function(public, private)
    -- Send a POST request to clear the element's value
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. private.element_id .. "/clear",
        method = "POST",
        http_version = "1.1",
        body = {}
    })

    -- Check for errors in the response
    if result.status_code ~= 200 then
        error("Failed to clear element: " .. (result.read_body() or "Unknown error"))
    end

    return true
end

PublicElement.click = function(public, private)
    -- Send a POST request to click the element
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. private.element_id .. "/click",
        method = "POST",
        http_version = "1.1",
        body={}
    })
    -- Check for errors in the response
    if result.status_code  ~= 200 then
        error("Failed to send keys: " .. (result.read_body() or "Unknown error"))
    end

    return true
end
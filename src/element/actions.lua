
PublicElement.send_keys = function(public, private, keys)
    -- Check if the keys parameter is a string
    if type(keys) ~= "string" then
        error("Keys must be a string")
    end

    -- Prepare the request body
    local body = {
        value = { keys }
    }

    -- Send the request to the WebDriver server
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. public.element_id .. "/value",
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json"
        },
        body = body,
        http_version = "1.1"
    })

    -- Check for errors in the response
    if not result or not result.is_success() then
        error("Failed to send keys: " .. (result and result.read_body() or "Unknown error"))
    end

    return true
end

PublicElement.click = function(public, private)
    -- Send a POST request to click the element
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. public.element_id .. "/click",
        method = "POST",
        http_version = "1.1"
    })

    -- Check for errors in the response
    if not result or not result.is_success() then
        error("Failed to click element: " .. (result and result.read_body() or "Unknown error"))
    end

    return true
end
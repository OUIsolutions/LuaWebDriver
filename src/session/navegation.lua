PublicSession.navegate_to = function(public,private,url)
   
    if not url then 
        error("URL is required for navigation")
    end
    --make a requisiton to navegate_to a url
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/url",
        method = "POST",
        http_version = "1.1",
        body = {
            url = url
        }
    })
    if result.status_code ~= 200 then
        error("Failed to navigate to URL: " .. result.read_body())
    end
end


-- Switch to a specific window by handle
PublicSession.switch_to_window = function(public, private, index)
    if not index or type(index) ~= "number" then
        error("Window index is required for switching windows")
    end

    local handles_request = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/window/handles",
        method = "GET",
        http_version = "1.1"
    })
    local handles = handles_request.read_body_json().value or {}
    if index < 1 or index > #handles then
        error("Invalid window index: " .. index)
    end
    local window_handle = handles[index]
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/window",
        method = "POST",
        http_version = "1.1",
        body = {
            handle = window_handle
        }
    })
    if result.status_code ~= 200 then
        error("Failed to switch to window: " .. result.read_body())
    end
end

PublicSession.open_new_tab = function(public, private)
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/window/new",
        method = "POST",
        http_version = "1.1",
        body = {
            type = "tab"
        }
    })
    if result.status_code ~= 200 then
        error("Failed to create new window: " .. result.read_body())
    end
end

-- Open a new window or tab
PublicSession.open_new_window = function(public, private)
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/window/new",
        method = "POST",
        http_version = "1.1",
        body = {
            type = "Window"
        }
    })
    if result.status_code ~= 200 then
        error("Failed to create new window: " .. result.read_body())
    end
end



-- Close the current window
PublicSession.close_window = function(public, private)
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/window",
        method = "DELETE",
        http_version = "1.1"
    })
    
    if result.status_code ~= 200 then
        error("Failed to close window: " .. result.read_body())
    end
    
    local body = result.read_body_json()
    return body.value or {}
end


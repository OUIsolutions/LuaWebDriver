MetaSession.__gc = function (public, private)
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


PublicSession.get_session_id = function(public, private)
    return private.session_id
end

PublicSession.accept_alert = function(public, private)
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/alert/accept",
        method = "POST",
        http_version = "1.1"
    })
    
    if result.status_code ~= 200 then
        error("Failed to accept alert: " .. result.read_body())
    end
end
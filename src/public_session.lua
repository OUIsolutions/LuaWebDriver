
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

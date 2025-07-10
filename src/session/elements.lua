

PublicSession.get_element = function(public,private,by, value)
    if not by or not value then
        error("by and value are required to get an element")
    end

    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/element",
        method = "POST",
        http_version = "1.1",
        body = {
            using = by,
            value = value
        }
    })
    
    if result.status_code ~= 200 then
        error("Failed to get element: " .. result.read_body())
    end
    local body = result.read_body_json()
    local id = body.value["element-6066-11e4-a52e-4f735466cecf"]
    return Element.newElement({
        element_id = id,
        url = private.url,
        session_id = private.session_id,
        fetch = private.fetch
   })
   
end

PublicSession.get_elements = function(public,private,by, value)
    if not by or not value then
        error("by and value are required to get elements")
    end

    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/elements",
        method = "POST",
        http_version = "1.1",
        body = {
            using = by,
            value = value
        }
    })
    
    if result.status_code ~= 200 then
        error("Failed to get elements: " .. result.read_body())
    end
    
    return result.read_body_json().value
end


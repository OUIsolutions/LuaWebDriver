PublicElement.get_element = function(public, private, selector, value)
    local payload = {
        using = selector,
        value = value
    }
    local response = private.fetch({
        method = "POST",
        http_version = "1.1",
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. private.element_id .. "/element",
        body = payload
    })
    
    if response.status_code == 200 then
        local body = response.read_body_json()
        if body.value and body.value["element-6066-11e4-a52e-4f735466cecf"] then
            local element = Element.newElement({
                element_id = body.value["element-6066-11e4-a52e-4f735466cecf"],
                session_id = private.session_id,
                url = private.url,
                fetch = private.fetch
            })
            return element
        end
    end
    return nil
end

PublicElement.get_elements = function(public, private, selector, value)
    local payload = {
        using = selector,
        value = value
    }
    local response = private.fetch({
        method = "POST",
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. private.element_id .. "/elements",
        body = payload
    })

    if response.status_code == 200 then
        local body = response.read_body_json()
        if body.value and #body.value > 0 then
            local elements = {}
            for _, element_data in ipairs(body.value) do
                local element = Element.newElement({
                    element_id = element_data["element-6066-11e4-a52e-4f735466cecf"],
                    session_id = private.session_id,
                    http_version = "1.1",
                    url = private.url,
                    fetch = private.fetch
                })
                table.insert(elements, element)
            end
            return elements
        end
    end
    return {}
end

PublicElement.get_element_by_index = function(public, private, index)
    if not index or type(index) ~= "number" or index < 1 then
        error("Index must be a positive integer")
    end
    

    local elements = public.get_elements("css selector", "*")
    return elements[index]
    
end

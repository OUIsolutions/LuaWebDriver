

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
PublicSession.get_element_by_id = function(public,private,element_id)
    if not element_id then
        error("element_id is required to get an element by ID")
    end
    return public.get_element( "xpath", "//*[@id='" .. element_id .. "']")
end

PublicSession.get_element_by_css_selector = function(public,private,selector)
    if not selector then
        error("selector is required to get an element by CSS selector")
    end
    return public.get_element("css selector", selector)
end

PublicSession.get_element_by_xpath = function(public,private,xpath)
    if not xpath then
        error("xpath is required to get an element by XPath")
    end
    return public.get_element( "xpath", xpath)
end

PublicSession.get_element_by_class_name = function(public,private,class_name)
    if not class_name then
        error("class_name is required to get an element by class name")
    end
    return public.get_element("class name", class_name)
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
    
    local body = result.read_body_json()
    local elements = {}
    
    if body.value and #body.value > 0 then
        for _, element_data in ipairs(body.value) do
            local element = Element.newElement({
                element_id = element_data["element-6066-11e4-a52e-4f735466cecf"],
                url = private.url,
                session_id = private.session_id,
                fetch = private.fetch
            })
            elements[#elements + 1] = element
        end
    end
    
    return elements
end


PublicSession.get_elements_by_css_selector = function(public,private,selector)
    if not selector then
        error("selector is required to get elements by CSS selector")
    end
    return public.get_elements("css selector", selector)
end

PublicSession.get_elements_by_xpath = function(public,private,xpath)
    if not xpath then
        error("xpath is required to get elements by XPath")
    end
    return public.get_elements( "xpath", xpath)
end

PublicSession.get_elements_by_class_name = function(public,private,class_name)
    if not class_name then
        error("class_name is required to get elements by class name")
    end
    return public.get_elements("class name", class_name)
end

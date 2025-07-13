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
PublicElement.get_element_by_id = function(public, private, element_id)
    if not element_id then
        error("element_id is required to get an element by ID")
    end
    return public.get_element("xpath", "//*[@id='" .. element_id .. "']")
end

PublicElement.get_element_by_css_selector = function(public, private, selector)
    if not selector then
        error("selector is required to get an element by CSS selector")
    end
    return public.get_element("css selector", selector)
end

PublicElement.get_element_by_xpath = function(public, private, xpath)
    if not xpath then
        error("xpath is required to get an element by XPath")
    end
    return public.get_element("xpath", xpath)
end

PublicElement.get_element_by_class_name = function(public, private, class_name)
    if not class_name then
        error("class_name is required to get an element by class name")
    end
    return public.get_element("class name", class_name)
end



PublicElement.get_elements = function(public, private, selector, value)
    local payload = {
        using = selector,
        value = value
    }
    local response = private.fetch({
        method = "POST",
        http_version="1.1",
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
                    url = private.url,
                    fetch = private.fetch
                })
                elements[#elements + 1] = element
            end
            return elements
        end
    end
    return {}
end

PublicElement.get_elements_by_css_selector = function(public, private, selector)
    if not selector then
        error("selector is required to get elements by CSS selector")
    end
    return public.get_elements("css selector", selector)
end

PublicElement.get_elements_by_xpath = function(public, private, xpath)
    if not xpath then
        error("xpath is required to get elements by XPath")
    end
    return public.get_elements("xpath", xpath)
end

PublicElement.get_elements_by_class_name = function(public, private, class_name)
    if not class_name then
        error("class_name is required to get elements by class name")
    end
    return public.get_elements("class name", class_name)
end


PublicElement.get_element_by_index_recursively = function(public, private, index)
    if not index or type(index) ~= "number" or index < 1 then
        error("Index must be a positive integer")
    end

    local elements = public.get_elements("css selector", "*")
    return elements[index]    
end


PublicElement.get_element_by_index = function(public, private, index)
    if not index or type(index) ~= "number" or index < 1 then
        error("Index must be a positive integer")
    end
    
    -- Get only direct children (siblings at the same level)
    local elements = public.get_elements("xpath", "./child::*")
    return elements[index]
    
end

PublicElement.get_children_size = function(public, private)
    local elements = public.get_elements("xpath", "./child::*")
    return #elements
end


PublicElement.get_all_children_size = function(public, private)
    local elements = public.get_elements("css selector", "*")
    return #elements
end

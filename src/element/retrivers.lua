PublicElement.get_html = function(public, private)
    local response = private.fetch({
        method = "GET",
        http_version = "1.1",
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. private.element_id .. "/property/outerHTML"
    })
    
    if response.status_code == 200 then
        local body = response.read_body_json()
        if body and body.value then
            return body.value
        end
    end
    return nil
end




PublicElement.get_text = function(public, private)
    local response = private.fetch({
        method = "GET",
        http_version = "1.1",
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. private.element_id .. "/text"
    })
    
    if response.status_code == 200 then
        local body = response.read_body_json()
        if body and body.value then
            return body.value
        end
    end
    return nil
end



PublicElement.get_attribute = function(public, private, attribute_name)
    if not attribute_name or type(attribute_name) ~= "string" then
        error("Nome do atributo deve ser uma string não vazia")
    end
    
    local response = private.fetch({
        method = "GET",
        http_version = "1.1",
        url = private.url .. "/session/" .. private.session_id .. "/element/" .. private.element_id .. "/attribute/" .. attribute_name
    })
    
    if response.status_code == 200 then
        local body = response.read_body_json()
        if body and body.value ~= nil then
            return body.value
        end
    end
    return nil
end


PublicElement.get_requisition_props = function(public, private, script, ...)
    if not script or type(script) ~= "string" then
        error("Script should be a non-empty string")
    end
    
    -- Prepare arguments - the element is passed as the first argument, followed by any additional arguments
    local args = {...}
    -- Insert the element reference as the first argument (arguments[0] in JavaScript)
    local element_ref = {["element-6066-11e4-a52e-4f735466cecf"] = private.element_id}
    table.insert(args, 1, element_ref)
    return  {
        method = "POST",
        http_version = "1.1",
        url = private.url .. "/session/" .. private.session_id .. "/execute/sync",
        body = {
            script = script,
            args = args
        }
    }
end 

PublicElement.execute_script = function(public, private, script, ...)
    local requisition_props = public.get_requisition_props(script, ...)
    local response = private.fetch(requisition_props)
          
    if response.status_code == 200 then
        local body = response.read_body_json()
        if body then
            return body.value
        end
    else
        local error_body = response.read_body()
        error("Failed to execute script: " .. (error_body or "Unknown error"))
    end
    return nil
end


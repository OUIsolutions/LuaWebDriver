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


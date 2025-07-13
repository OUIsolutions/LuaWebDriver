-- Função para obter o HTML do elemento
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

-- Função para obter um atributo específico do elemento
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

-- Função para listar todos os atributos do elemento
PublicElement.list_attributes = function(public, private)
    local attributes = {}
    
    -- Lista de atributos comuns para verificar
    local common_attributes = {
        "id", "class", "name", "value", "type", "placeholder", "href", "src", 
        "alt", "title", "style", "onclick", "onchange", "onfocus", 
        "onblur", "disabled", "readonly", "required", "checked", "selected",
        "maxlength", "minlength", "min", "max", "step", "pattern", "autocomplete",
        "tabindex", "role", "aria-label", "aria-describedby", "target",
        "rel", "download", "accept", "multiple", "rows", "cols", "wrap"
    }
    
    -- Verifica cada atributo comum
    for _, attr in ipairs(common_attributes) do
        local value = public.get_attribute(attr)
        if value ~= nil then
            attributes[attr] = value
        end
    end
    
    -- Tenta obter atributos data-* verificando alguns comuns
    local data_attributes = {
        "data-toggle", "data-target", "data-dismiss", "data-placement",
        "data-content", "data-original-title", "data-trigger"
    }
    
    for _, attr in ipairs(data_attributes) do
        local value = public.get_attribute(attr)
        if value ~= nil then
            attributes[attr] = value
        end
    end
    
    return attributes
end


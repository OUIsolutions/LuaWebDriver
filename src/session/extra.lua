PublicSession.get_session_id = function(public, private)
    return private.session_id
end

-- Retorna a quantidade de abas (janelas) abertas na sessão
PublicSession.get_window_count = function(public, private)
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/window/handles",
        method = "GET",
        http_version = "1.1"
    })
    if result.status_code ~= 200 then
        error("Failed to get window handles: " .. result.read_body())
    end
    local body = result.read_body_json()
    if not body.value or type(body.value) ~= "table" then
        error("Unexpected response for window handles")
    end
    return #body.value
end

-- Retorna a URL da guia (janela) atual na sessão
PublicSession.get_current_url = function(public, private)
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/url",
        method = "GET",
        http_version = "1.1"
    })
    if result.status_code ~= 200 then
        error("Failed to get current URL: " .. result.read_body())
    end
    local body = result.read_body_json()
    if not body.value or type(body.value) ~= "string" then
        error("Unexpected response for current URL")
    end
    return body.value
end


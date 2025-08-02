PublicSession.get_session_id = function(public, private)
    return private.session_id
end
PublicSession.close = function (public, private)
    if private.closed then 
        return
    end

    print("Closing session with ID: " .. private.session_id)
    
    -- First, close the WebDriver session
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id,
        method = "DELETE",
        http_version = "1.1"
    })
    if result.status_code ~= 200 then
        print("Failed to close session: " .. result.read_body())
    end
    private.closed = true
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

-- Troca para um frame específico usando um elemento frame
PublicSession.switch_to_frame = function(public, private, element_frame)
    if not element_frame then
        error("element_frame is required to switch to frame")
    end
    
    local frame_id = element_frame.get_chromedriver_id()
    
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/frame",
        method = "POST",
        http_version = "1.1",
        body = {
            id = {
                ["element-6066-11e4-a52e-4f735466cecf"] = frame_id
            }
        }
    })
    
    if result.status_code ~= 200 then
        error("Failed to switch to frame: " .. result.read_body())
    end
    
    return true
end

-- Troca para um frame específico usando um elemento frame
PublicSession.go_back_to_original_frame = function(public, private)
       
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/frame",
        method = "POST",
        http_version = "1.1",
        body = {
            id = {
                ["element-6066-11e4-a52e-4f735466cecf"] = "nil"
            }
        }
    })
    
    if result.status_code ~= 200 then
        error("Failed to switch to frame: " .. result.read_body())
    end
    
    return true
end


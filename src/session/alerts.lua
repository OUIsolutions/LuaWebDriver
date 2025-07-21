-- Aceita o alerta (clica em "OK")
PublicSession.accept_alert = function(public, private)
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/alert/accept",
        method = "POST",
        http_version = "1.1"
    })
    if result.status_code ~= 200 then
        error("Failed to accept alert: " .. result.read_body())
    end
end

-- Rejeita o alerta (clica em "Cancelar")
PublicSession.dismiss_alert = function(public, private)
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/alert/dismiss",
        method = "POST",
        http_version = "1.1"
    })
    if result.status_code ~= 200 then
        error("Failed to dismiss alert: " .. result.read_body())
    end
end

-- Lê o texto do alerta
PublicSession.get_alert_text = function(public, private)
    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/alert/text",
        method = "GET",
        http_version = "1.1"
    })
    if result.status_code ~= 200 then
        error("Failed to get alert text: " .. result.read_body())
    end
    return result.read_body_json()["value"]
end

-- Envia texto para um prompt (somente se for um `prompt()`)
PublicSession.send_alert_text = function(public, private, text)
    if type(text) ~= "string" then
        error("Text must be a string")
    end

    local result = private.fetch({
        url = private.url .. "/session/" .. private.session_id .. "/alert/text",
        method = "POST",
        http_version = "1.1",
        body = {
            text = text
        }
    })
    if result.status_code ~= 200 then
        error("Failed to send alert text: " .. result.read_body())
    end
end

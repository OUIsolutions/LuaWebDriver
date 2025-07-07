
Private = Private

--- Função para criar uma nova sessão, (Está incompleta!!!)
---@param self LuaServer
---@return LuaSession
Private.newSession  = function(self)
    local selfobj = {}
    selfobj.sessionID = ""
    selfobj.request = self.request
    selfobj.route = self.args.route

    local path = selfobj.route .. "/session"

    local response = selfobj.request({url = path, method = "POST"})

    print("\n\tPATH:", path, "\n")--, response.read_body())
    print(response.read_body())

    return selfobj
end

-- Função simples para se conectar a uma sessão já existente
---@param self LuaServer
---@param session string
---@return LuaSession
Private.connectSession = function(self, session)

    local selfobj = {}
    selfobj.sessionID = session
    selfobj.request = self.request
    selfobj.route = self.args.route

    return selfobj
end

Private.status = function(self)
end

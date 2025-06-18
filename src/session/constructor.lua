
---@return LuaSession
Private.newSession  = function(args, request_provider)
    local selfobj = {}
    selfobj.ip = args.ip
    selfobj.port = args.port
    --selfobj.sessionID = ""
    selfobj.request_maker = request_provider
    selfobj.protocol = args.protocol

    local path = selfobj.protocol .. selfobj.ip .. ":" .. selfobj.port .. "/session"

    --local response = selfobj.request_maker({url = path, method = "POST"})

    print("\n\tPATH:", path, "\n")--, response.read_body())

    return selfobj
end

---@return LuaSession
Private.connectSession = function(args, session, request_provider)

    local selfobj = {}
    selfobj.ip = args.ip
    selfobj.port = args.port
    selfobj.sessionID = session
    selfobj.request_maker = request_provider
    selfobj.protocol = args.protocol

    return selfobj
end

Private.status = function(args, request_provider)
end

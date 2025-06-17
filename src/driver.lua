


---@param flags WebDriverFlags
---@param args table
---@return string
local function private_LuaWebDriver_format_command(flags, args)

   --if flags.rawCommand then
      --return flags.rawCommand
   --end

   local command_formated = flags.chromedriver_path .. " " -- Coloquei a concatenação de proposito para quebrar se não passar da forma correta.
   local port = "9515"
   if flags.port then
      port = flags.port
   end

   args.port = port
   args.ip = "127.0.0.1"

   local not_verbose = ""
   if flags.verbose then
      not_verbose = " --verbose "
   end
   local allowedClients = ""
   if flags.allowedClients then
      allowedClients = "--allowed-ips=*"
   end

   command_formated = command_formated .. "--port=" .. port .. not_verbose .. allowedClients .. "&"

   return command_formated

end

local function private_driver_functions(selfobj, args)

    if not args.protocol then
      args.protocol = "http://"
   end

   selfobj.newServer = function()

      return Private.newSession(args, selfobj.request_provider)

   end

   selfobj.connectSession = function(session)

      return Private.connectSession(args, session, selfobj.request_provider)

   end

   selfobj.status = function()

      return Private.status(args, selfobj.request_provider)

   end

   return selfobj

end

---@param flags WebDriverFlags
---@param request_provider fun(props: RequestProps):RequestResponse
---@return LuaServer
WebDriver.newServer = function(flags, request_provider)

   local selfobj = {}

   selfobj.request_provider = request_provider

   local args = {}
   os.execute(private_LuaWebDriver_format_command(flags, args))

   if not args.protocol then
      args.protocol = "http://"
   end

   selfobj.newServer = function()

      return Private.newSession(args, selfobj.request_provider)

   end

   selfobj.connectSession = function(session)

      return Private.connectSession(args, session, selfobj.request_provider)

   end

   selfobj.status = function()

      return Private.status(args, selfobj.request_provider)

   end

   return selfobj

end

WebDriver.newClient = function(args, request_provider)

   local selfobj = {}

   selfobj.request_provider = request_provider

   private_driver_functions(selfobj, args)

   return selfobj
end








Private = Private

---Essa função formata o comando para iniciar o binario chromedriver
---@param flags WebDriverFlags
---@param args table
---@return string
local function private_LuaWebDriver_format_command(flags, args)

   local command_formated = flags.chromedriver_path .. " " -- Coloquei a concatenação de proposito para quebrar se não passar da forma correta.
   local port = "9515"
   if flags.port then
      port = flags.port
   end

   args.port = port
   args.ip = "127.0.0.1"
   args.protocol = "http://"
   args.route = args.protocol .. args.ip .. ":" .. args.port

   local not_verbose = ""
   if flags.verbose then
      not_verbose = " --verbose "
   end
   local allowedClients = ""
   if flags.allowedClients then
      allowedClients = "--allowed-ips=*" -- Permite o ascesso de fora da maquina.
   end

   command_formated = command_formated .. "--port=" .. port .. not_verbose .. allowedClients .. "&"

   return command_formated

end

--- Essa função é o construtor do newserver
---@param flags WebDriverFlags
---@param request_provider fun(props: RequestProps):RequestResponse
---@return LuaServer
WebDriver.newServer = function(flags, request_provider)

   local selfobj = {}

   selfobj.request = request_provider

   local args = {}
   os.execute(private_LuaWebDriver_format_command(flags, args)) --- Chama a função que formata o comando e já chama o comando no terminal.

   Private.driver_functions(selfobj)

   selfobj.args = args

   return selfobj

end







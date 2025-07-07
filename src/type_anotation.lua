
-- Params in newDriver

---@class RequestResponse
---@field status number
---@field headers table<string, string>
---@field read_body fun(): string

---@class RequestProps
---@field url string
---@field method string | nil
---@field headers table<string, string> | nil
---@field body table | string | nil

---@class WebDriverFlags
---@field chromedriver_path string -- O binario do chromedriver
---@field port string | nil
---@field verbose boolean | nil
---@field allowedClients boolean | nil
----@field rawCommand string | nil

--- O Lua session é para ter os callbacks de sessão exemplo, abrir um link, clicar em um botão, etc....
---@class LuaSession
---@field sessionID string
---@field route string
---@field request fun(props: RequestProps):RequestResponse | nil

---@class LuaArgumentsServer
---@field ip string
---@field route string
---@field port string
---@field protocol string

---@class LuaServer
---@field request fun(props: RequestProps):RequestResponse
---@field args LuaArgumentsServer
---@field newSession fun():LuaSession
---@field connectSession fun(sessionID: string) : LuaSession
---@field status fun()

---O cliente precisa somente se conectar!
---@class LuaArgsClient
---@field ip string -- ip da maquina do server
---@field port string
---@field protocol string | nil -- Protocolo http ou https

---@class LuaDriverModule
---@field newServer fun(flags: WebDriverFlags, request_maker: fun(props: RequestProps):RequestResponse): LuaServer

---@type LuaDriverModule
WebDriver = WebDriver

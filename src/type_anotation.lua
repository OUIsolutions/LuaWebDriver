
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
---@field chromedriver_path string
---@field chrome_path string | nil
---@field port string | nil
---@field verbose boolean | nil
---@field allowedClients boolean | nil
----@field rawCommand string | nil

---@class LuaSession
---@field ip string
---@field port string
---@field sessionID string
---@field request_maker fun(props: RequestProps):RequestResponse | nil
---@field protocol string

---@class LuaServer
---@field request_maker fun(props: RequestProps):RequestResponse
---@field newSession fun():LuaSession
---@field connectSession fun(sessionID: string) : LuaSession
---@field status fun() : string

---@class LuaArgsClient
---@field ip string
---@field port string
---@field protocol string | nil

---@class LuaDriverModule
---@field newServer fun(flags: WebDriverFlags, request_maker: fun(props: RequestProps):RequestResponse): LuaServer
---@field newClient fun(args: LuaArgsClient, request_maker: fun(props: RequestProps):RequestResponse): LuaServer

---@type LuaDriverModule
WebDriver = WebDriver

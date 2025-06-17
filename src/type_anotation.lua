
---@class RequestResponse
---@field status number
---@field headers table<string, string>
---@field read_body fun(): string

---@class RequestProps
---@field url string
---@field method string
---@field headers table<string, string>
---@field body table

---@class LuaDriver
---@field newDriver fun(chromedriver_path: string, chrome_path: string, request_maker: fun(props: RequestProps):RequestResponse): LuaDriver

---@type LuaDriver
WebDriver = WebDriver
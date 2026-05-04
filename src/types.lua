---@class WebDriverServerProps
---@field chromedriver_command string Path to the chromedriver executable
---@field fetch fun(props: table): WebDriverResponse HTTP fetch function
---@field port? integer Optional port to start chromedriver on (auto-detected if omitted)
---@field binary_location? string Path to the browser binary

---@class WebDriverResponse
---@field status_code integer HTTP status code of the response
---@field read_body fun(): string Reads the raw response body as a string
---@field read_body_json fun(): table Reads and parses the response body as JSON

---@class WebDriverServer
---@field close fun() Closes the chromedriver process
---@field newSession fun(props: WebDriverSessionProps): WebDriverSession Creates a new browser session

---@class WebDriverSessionProps
---@field body? table Raw capabilities body (overrides all other session options when provided)
---@field args? string[] Chrome command-line arguments
---@field binary_location string Path to the Chrome browser binary
---@field download_directory? string Default download directory for the browser
---@field use_automation_extension? boolean Whether to use the automation extension (default: false)

---@class WebDriverSession
---@field close fun() Closes the WebDriver session
---@field get_session_id fun(): string Returns the current session ID
---@field navegate_to fun(url: string) Navigates the browser to the given URL
---@field switch_to_window fun(index: integer) Switches to the window at the given 1-based index
---@field open_new_tab fun() Opens a new browser tab
---@field open_new_window fun() Opens a new browser window
---@field close_window fun(): string[] Closes the current window and returns the remaining window handles
---@field get_window_count fun(): integer Returns the number of open windows/tabs in the session
---@field get_current_url fun(): string Returns the URL of the current page
---@field execute_cdp_cmd fun(cmd: string, params?: table): any Executes a Chrome DevTools Protocol command
---@field switch_to_frame fun(element_frame: WebDriverElement): boolean Switches context into the given frame element
---@field go_back_to_original_frame fun(): boolean Switches context back to the top-level frame
---@field get_element fun(by: string, value: string): WebDriverElement Finds a single element using the given strategy and value
---@field get_element_by_id fun(element_id: string): WebDriverElement Finds a single element by its HTML id attribute
---@field get_element_by_css_selector fun(selector: string): WebDriverElement Finds a single element by CSS selector
---@field get_element_by_xpath fun(xpath: string): WebDriverElement Finds a single element by XPath expression
---@field get_element_by_class_name fun(class_name: string): WebDriverElement Finds a single element by class name
---@field get_elements fun(by: string, value: string): WebDriverElement[] Finds all elements matching the given strategy and value
---@field get_elements_by_css_selector fun(selector: string): WebDriverElement[] Finds all elements matching a CSS selector
---@field get_elements_by_xpath fun(xpath: string): WebDriverElement[] Finds all elements matching an XPath expression
---@field get_elements_by_class_name fun(class_name: string): WebDriverElement[] Finds all elements matching a class name
---@field accept_alert fun() Accepts the currently open alert dialog
---@field dismiss_alert fun() Dismisses (cancels) the currently open alert dialog
---@field get_alert_text fun(): string Returns the text of the currently open alert dialog
---@field send_alert_text fun(text: string) Sends text to a prompt dialog

---@class WebDriverElement
---@field click fun(): boolean Clicks the element
---@field send_keys fun(keys: string): boolean Types the given string into the element
---@field clear fun(): boolean Clears the element's current value
---@field get_text fun(): string|nil Returns the visible text content of the element
---@field get_html fun(): string|nil Returns the outer HTML of the element
---@field get_attribute fun(attribute_name: string): string|nil Returns the value of the given HTML attribute
---@field get_chromedriver_id fun(): string Returns the internal WebDriver element ID
---@field execute_script fun(script: string, ...): any Executes a JavaScript snippet with the element as the first argument
---@field get_requisition_props fun(script: string, ...): table Builds the request payload for a script execution without sending it
---@field get_element fun(selector: string, value: string): WebDriverElement|nil Finds a child element using the given strategy and value
---@field get_element_by_id fun(element_id: string): WebDriverElement|nil Finds a child element by its HTML id attribute
---@field get_element_by_css_selector fun(selector: string): WebDriverElement|nil Finds a child element by CSS selector
---@field get_element_by_xpath fun(xpath: string): WebDriverElement|nil Finds a child element by XPath expression
---@field get_element_by_class_name fun(class_name: string): WebDriverElement|nil Finds a child element by class name
---@field get_elements fun(selector: string, value: string): WebDriverElement[] Finds all child elements using the given strategy and value

---@class WebDriver
---@field newLocalServer fun(props: WebDriverServerProps): WebDriverServer Starts a local chromedriver process and returns a server instance

---@type WebDriver
WebDriver = WebDriver


---@class WebDriverPrivateFunctions

---@type WebDriverPrivateFunctions
Private = Private

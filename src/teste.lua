
WebDriver.newDriver = function(chromedriver_path,chrome_path,request_provider)

    local example = request_provider({url="https://example.com/"})
    local content = example.read_body()
    print(content)
end 
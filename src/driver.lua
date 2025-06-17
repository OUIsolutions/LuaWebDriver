
WebDriver.newDriver = function(chromedriver_path,chrome_path,request_provider)

   local selfobj = {}
   selfobj.request_provider = request_provider 
   selfobj.newSession = function()
        return Private.newSession(selfobj.request_provider)
   end
   return selfobj

end 
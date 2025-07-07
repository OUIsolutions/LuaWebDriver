
Private = Private

---@param selfobj LuaServer
Private.driver_functions = function(selfobj)

   selfobj.newSession = function()

      return Private.newSession(selfobj)

   end

   selfobj.connectSession = function(session)

      return Private.connectSession(selfobj, session)

   end

   selfobj.status = function()

      return Private.status(selfobj)

   end

end



local herigitage = {}

herigitage.set_method = function (props)
    props.obj[props.method_name] = function (...)
       if props.internal_args then 
           return props.callback(props.obj, props.internal_args, ...)
       end
      return props.callback(props.obj, ...)
   end
end

herigitage.set_meta_method = function(props)

    local metatable = getmetatable(props.obj)
    if not metatable then
        metatable = {}
        setmetatable(props.obj, metatable)
    end 
    herigitage.set_method({
        obj = metatable,
        method_name = props.method_name,
        internal_args = props.internal_args,
        callback = props.callback
    })

end


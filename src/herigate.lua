

local herigitage = {}

herigitage.newMetaObject = function (props)
    if not props then
        props = {}
    end
    local selfobject = {}
    selfobject.public = props.public or {}
    selfobject.private = props.private or {}
    selfobject.meta_table =  props.meta_table or {}
    
    selfobject.set_meta_method = function (method_name,callback)
        selfobject.meta_table[method_name] = function (...)
            return callback(selfobject.public,selfobject.private, ...)
        end
        setmetatable(selfobject.public, selfobject.meta_table)
    end


    
    selfobject.set_public_method = function (method_name, callback)
        selfobject.public[method_name] = function (...)
            return callback(selfobject.public,selfobject.private, ...)
        end
    end

    selfobject.set_private_method = function (method_name, callback)
        selfobject.private[method_name] = function (...)
            return callback(selfobject.public,selfobject.private, ...)
        end
    end
    selfobject.private_extends = function (props)
        for k,v in pairs(props) do
            local item = selfobject.private[k]
            if type(item) == "function" then
                selfobject.set_private_method(k, v)
            else
                selfobject.private[k] = v
            end
        end
        
    end

    return selfobject
end 






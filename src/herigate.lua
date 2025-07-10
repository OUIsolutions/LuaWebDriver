

local herigitage = {}

herigitage.newMetaObject = function (props)
    if not props then
        props = {}
    end
    local selfobject = {}
    selfobject.public = props.public or {}
    selfobject.private = props.private or {}
    selfobject.meta_table = props.meta_table or {}
    setmetatable(selfobject, selfobject.meta_table)
    
    
    selfobject.set_public_method = function (method_name, callback)
        selfobject.public[method_name] = function (...)
            return callback(selfobject.public,selfobject.private, ...)
        end
    end

    selfobject.set_metha_metod = function (method_name,callback)
        selfobject.meta_table[method_name] = function (...)
            return callback(selfobject.public,selfobject.private, ...)
        end
    end

    selfobject.set_private_method = function (method_name, callback)
        selfobject.private[method_name] = function (...)
            return callback(selfobject.public,selfobject.private, ...)
        end
    end

    return selfobject
end 






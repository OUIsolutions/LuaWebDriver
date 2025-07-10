

local herigitage = {}

herigitage.aplly_method = function (selfobj,method_name,internal_props,callback,...)
   selfobj[method_name] = function (...)
      return callback(internal_props, ...)
   end
end

herigitage.apply_meta_method = function (selfobj,method_name,internal_props,callback,...)
   local meta_table = getmetatable(selfobj)
    if not meta_table then
        meta_table = {}
        setmetatable(selfobj, meta_table)
    end
    meta_table[method_name] = function (...)
        return callback(internal_props, ...)
    end
end
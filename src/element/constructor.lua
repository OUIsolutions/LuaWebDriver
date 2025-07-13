Element.__tostring = function (public,private)
    return public.get_html()
end


Element.newElement = function (props)
    local selfobject = Heregitage.newMetaObject()
    selfobject.private_props_extends(props)
    selfobject.public_method_extends(PublicElement)
    selfobject.set_meta_method("__tostring", Element.__tostring)
    return selfobject.public
end 
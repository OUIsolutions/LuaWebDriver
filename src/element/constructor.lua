

Element.newElement = function (props)
    local selfobject = Heregitage.newMetaObject()
    selfobject.private_props_extends(props)
    selfobject.public_method_extends(PublicElement)
    return selfobject.public
end 
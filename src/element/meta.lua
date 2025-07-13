MetaElement.__tostring = function (public,private)
    return public.get_html()
end
MetaElement.__index = function (public,private,self,index)
    return public.get_by_index(index)
end
Private.newSession  = function(request_provider)
    local selfobj = {}
    selfobj.request_provider = request_provider
    Private.create_print_function(selfobj)
    return selfobj
end
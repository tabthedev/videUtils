local vide = require("../../vide")

return function(childName: string, recursive: boolean?)
    return function(props: {[string | number]: any})
        return vide.action(function(instance)
            local childInstance = instance:FindFirstChild(childName, recursive)
            if not childInstance then
                return
            end

            vide.apply(props)
        end)
    end
end
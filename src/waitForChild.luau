local vide = require("../../vide")

return function(childName: string, timeout: number?)
    return function(props: {[string | number]: any})
        return vide.action(function(instance)
            local childInstance = instance:WaitForChild(childName, timeout or 10)
            if not childInstance then
                return
            end

            vide.apply(props)
        end)
    end
end
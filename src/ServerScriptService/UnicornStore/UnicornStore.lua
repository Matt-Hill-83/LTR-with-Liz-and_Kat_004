local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

function module.initUnicornStore(props)
    local parentFolder = props.parentFolder
    local unicornStore = Utils.getFirstDescendantByName(parentFolder, 'UnicornStore')

    print('unicornStore' .. ' - start')
    print(unicornStore)

    return {}
end

return module

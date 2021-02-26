local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local Rink = require(Sss.Source.Rink.Rink)

local module = {}

function module.initVendingMachine(props)
    local parentFolder = props.parentFolder

    local vendingMachines = Utils.getByTagInParent({parent = parentFolder, tag = 'M-VendingMachine'})
    -- local config = Utils.getFirstDescendantByName(region, 'StrayConfig')
    for _, vendingMachine in ipairs(vendingMachines) do
        print('vendingMachine' .. ' - start')
        print(vendingMachine)
    end
end

return module

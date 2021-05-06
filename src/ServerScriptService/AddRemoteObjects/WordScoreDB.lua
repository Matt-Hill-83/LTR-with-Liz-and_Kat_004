local DataStoreService = game:GetService('DataStoreService')
local Sss = game:GetService('ServerScriptService')

local Constants = require(Sss.Source.Constants.Constants)

local module = {}

function module.updateWordStore(props)
    local player = props.player
    local word = props.word
    local adder = props.adder

    local newStore = DataStoreService:GetOrderedDataStore(word)

    local success, newExperience =
        pcall(
        function()
            return newStore:IncrementAsync(player.UserId, adder)
        end
    )

    if success then
        local refreshFunc = Constants.portals[word]['refreshFunc']
        refreshFunc(newStore)
    end
end

return module

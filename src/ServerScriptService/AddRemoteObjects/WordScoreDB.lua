local DataStoreService = game:GetService('DataStoreService')
local Sss = game:GetService('ServerScriptService')

local Constants = require(Sss.Source.Constants.Constants)

local module = {}

function module.updateWordStore(props)
    local player = props.player
    local word = props.word
    local adder = props.adder
    print('updateWordStore===========================>>>' .. word)

    local newStore = DataStoreService:GetOrderedDataStore(word)

    local success, newExperience =
        pcall(
        function()
            return newStore:IncrementAsync(player.UserId, adder)
        end
    )

    if success then
        if Constants.portals[word] then
            local refreshFunc = Constants.portals[word]['refreshFunc']
            if refreshFunc then
                refreshFunc(newStore)
            end
        end
    end
end

return module

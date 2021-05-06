local DataStoreService = game:GetService('DataStoreService')
local Sss = game:GetService('ServerScriptService')

local Constants = require(Sss.Source.Constants.Constants)

local module = {}

function module.updateWordStore(props)
    print('updateWordStore')
    print('updateWordStore')
    print('updateWordStore')
    print('props' .. ' - start')
    print(props)
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
        print('--------------------------->>>>')
        print('--------------------------->>>>')
        print('--------------------------->>>>')
        print('New Experience:', newExperience)
        print('Constants.portals' .. ' - start')
        print(Constants.portals)
        local refreshFunc = Constants.portals[word]['refreshFunc']
        refreshFunc(newStore)
        print('refreshFunc' .. ' - start')
        print(refreshFunc)
    end
end

return module

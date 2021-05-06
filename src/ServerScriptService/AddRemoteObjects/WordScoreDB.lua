local DataStoreService = game:GetService('DataStoreService')

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
    end
end

return module

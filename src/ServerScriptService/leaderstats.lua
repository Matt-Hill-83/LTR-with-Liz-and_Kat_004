game.Players.PlayerAdded:Connect(
    function(player)
        local leaderstats = Instance.new('Folder')
        leaderstats.Name = 'leaderstats'
        leaderstats.Parent = player

        local Wins = Instance.new('IntValue')
        Wins.Name = 'Wins'
        Wins.Parent = leaderstats

        local money = Instance.new('IntValue')
        money.Name = 'Money'
        money.Value = 5000
        money.Parent = leaderstats
    end
)

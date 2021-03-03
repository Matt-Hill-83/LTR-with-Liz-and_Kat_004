local module = {}

local hexIslandConfigs = {
    {
        hexNum = 1,
        material = Enum.Material.Grass,
        statueConfigs = {},
        bridgeConfigs = {
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'BAT'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'RAT'}
                },
                material = Enum.Material.LeafyGrass
            }
        }
    }
}

module.teleporter = 'xxx'
module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        {
            -- {word = 'CAT', target = 1, found = 0},
            {word = 'BAT', target = 1, found = 0},
            {word = 'RAT', target = 1, found = 0}
        }
    }
end

return module

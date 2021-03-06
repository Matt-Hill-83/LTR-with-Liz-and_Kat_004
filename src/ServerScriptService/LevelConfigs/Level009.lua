local module = {}

local hexIslandConfigs = {
    {
        hexNum = 1,
        material = Enum.Material.Grass,
        statueConfigs = {},
        bridgeConfigs = {
            {
                item = 'Rink2',
                itemConfig = {
                    grabbers = {'DOG', 'LOG', 'FOG', 'DOG', 'LOG', 'FOG', 'DOG', 'LOG', 'FOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            }
        }
    }
}

module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        {
            {word = 'DOG', target = 1, found = 0},
            {word = 'LOG', target = 1, found = 0},
            {word = 'HOG', target = 1, found = 0},
            {word = 'BOG', target = 1, found = 0}
        }
    }
end

return module

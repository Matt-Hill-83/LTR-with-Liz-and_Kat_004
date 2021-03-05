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
                    grabbers = {'FOX', 'BOX'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink2',
                itemConfig = {
                    grabbers = {'LOX', 'OX'}
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
            {word = 'FOX', target = 1, found = 0},
            {word = 'BOX', target = 1, found = 0},
            {word = 'OX', target = 1, found = 0},
            {word = 'LOX', target = 1, found = 0}
        }
    }
end

return module

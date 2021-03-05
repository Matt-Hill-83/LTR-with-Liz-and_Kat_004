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
                    grabbers = {'TROLL'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink2',
                itemConfig = {
                    grabbers = {'NEED', 'GOLD'}
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
            {word = 'TROLL', target = 1, found = 0},
            {word = 'NEED', target = 1, found = 0},
            {word = 'GOLD', target = 1, found = 0}
        }
    }
end

return module

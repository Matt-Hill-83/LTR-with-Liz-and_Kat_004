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
                    grabbers = {'YAY'}
                },
                material = Enum.Material.LeafyGrass
            }
            -- {
            --     item = 'Rink2',
            --     itemConfig = {
            --         grabbers = {'WIN'}
            --     },
            --     material = Enum.Material.LeafyGrass
            -- }
        }
    }
}

module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        {
            {word = 'YAY', target = 1, found = 0},
            {word = 'WIN', target = 1, found = 0}
        }
    }
end

return module

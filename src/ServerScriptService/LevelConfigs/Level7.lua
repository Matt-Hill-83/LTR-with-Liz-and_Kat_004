local module = {}

local hexIslandConfigs = {
    {
        hexNum = 1,
        material = Enum.Material.Grass,
        statueConfigs = {},
        bridgeConfigs = {
            {item = nil}
        }
    }
}

module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        {
            {word = 'FUN', target = 1, found = 0},
            {word = 'IN', target = 1, found = 0},
            {word = 'THE', target = 1, found = 0},
            {word = 'SUN', target = 1, found = 0}
        }
    }
end

return module

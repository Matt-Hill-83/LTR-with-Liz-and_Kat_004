local Sss = game:GetService('ServerScriptService')

local module = {}

local hexIslandConfigs = {
    {
        hexNum = 1,
        statueConfigs = {},
        bridgeConfigs = {
            {item = nil},
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'CAT'}
                }
            },
            {item = nil}
        }
    },
    {
        hexNum = 2,
        statueConfigs = {},
        bridgeConfigs = {
            {item = nil},
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'HAT'}
                }
            },
            {item = nil}
        }
    },
    {
        hexNum = 3,
        statueConfigs = {},
        bridgeConfigs = {
            {item = nil},
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'RAT'}
                }
            },
            {item = nil}
        }
    }
}

module.teleporter = 'xxx'
module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        {
            {word = 'CAT', target = 1, found = 0},
            {word = 'HAT', target = 1, found = 0},
            {word = 'RAT', target = 1, found = 0}
        }
    }
end

return module

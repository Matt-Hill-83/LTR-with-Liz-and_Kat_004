local module = {}

local sector1Config = {
    freezeConveyor = true,
    words = {
        'NAP',
        'TAP',
        'RAP',
        'ZAP',
        'MAP',
        'GAP',
        'LAP'
    }
}
local sector2Config = {
    freezeConveyor = true,
    words = {
        'CAT',
        'BAT',
        'RAT',
        'HAT',
        'MAT',
        'BAT',
        'PAT',
        'SAT'
    }
}
local sector3Config = {
    freezeConveyor = true,
    words = {
        'VAT',
        'VAN',
        'MAN',
        'MOM'
    }
}
local sector4Config = {
    freezeConveyor = true,
    words = {
        'DAD',
        'DOG',
        'HOG',
        'LOG',
        'BOG'
    }
}

local sectorConfigs = {
    sector1Config,
    sector2Config,
    sector3Config,
    sector4Config
}

local hexIslandConfigs = {
    {
        hexNum = 1,
        statueConfigs = {},
        bridgeConfigs = {
            {item = nil},
            {
                item = 'Rink',
                itemConfig = {}
            },
            {item = nil}
        }
    }
}

module.teleporter = '6460817067'
module.sectorConfigs = sectorConfigs
module.hexIslandConfigs = hexIslandConfigs
module.vendingMachines = {{targetWordIndex = 2}}

function module.getTargetWords()
    return {
        {
            {word = 'RAT', target = 1, found = 0},
            {word = 'BAT', target = 1, found = 0}
        },
        {
            {word = 'CAT', target = 3, found = 0}
        }
    }
end

return module

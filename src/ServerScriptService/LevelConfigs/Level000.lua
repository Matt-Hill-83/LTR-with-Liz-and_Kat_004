local module = {}

local sector1Config = {
    freezeConveyor = true,
    words = {
        'NAP', --
        'TAP', --
        'RAP', --
        'ZAP' --
    }
}

local sectorConfigs = {
    sector1Config --
}

module.sectorConfigs = sectorConfigs

function module.getTargetWords()
    return {
        {
            {word = 'RAT', target = 1, found = 0},
            {word = 'BAT', target = 1, found = 0}
        }
    }
end

return module

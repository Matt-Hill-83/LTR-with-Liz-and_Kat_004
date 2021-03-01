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

local hexIslandConfigs = {
    {
        hexNum = 1,
        statueConfigs = {},
        bridgeConfigs = {
            {item = nil},
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'RAT'}
                }
            },
            {item = nil},
            {item = nil},
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'BAT'}
                }
            },
            {item = nil}
        }
    },
    {
        hexNum = 2,
        bridgeConfigs = {
            {item = nil},
            {item = nil},
            {item = nil},
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
        hexNum = 3,
        bridgeConfigs = {
            {item = nil},
            {item = nil},
            {item = nil},
            {item = nil},
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'HAT'}
                },
                {item = nil}
            }
        }
    },
    {
        hexNum = 4,
        bridgeConfigs = {
            {item = nil},
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'RAT'}
                    -- words = {'CAT', 'RAT'}
                }
            },
            {item = nil},
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
        hexNum = 5,
        bridgeConfigs = {
            {item = nil},
            {item = nil},
            {item = nil},
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
        hexNum = 6,
        bridgeConfigs = {
            {item = nil},
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'PAT'}
                }
            },
            {item = nil}
        }
    }
}

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
            {word = 'CAT', target = 3, found = 0},
            {word = 'RAT', target = 3, found = 0},
            {word = 'BAT', target = 3, found = 0},
            {word = 'HAT', target = 3, found = 0}
        }
        -- {
        --     {word = 'CAT', target = 1, found = 0}
        -- }
    }
end

return module

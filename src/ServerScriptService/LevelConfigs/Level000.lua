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
module.sectorConfigs = sectorConfigs

local c0r0 = {
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {
        {
            item = 'Rink',
            itemConfig = {}
        },
        {
            item = 'Rink',
            itemConfig = {}
        },
        {
            item = 'Rink',
            itemConfig = {}
        },
        {
            item = 'Rink',
            itemConfig = {}
        },
        {
            item = 'Rink',
            itemConfig = {}
        },
        {
            item = 'Rink',
            itemConfig = {}
        }
    },
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'C',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = -0.8,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'A',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'T',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'B',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = -0.8,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'R',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'H',
            discHeight = 1
        }
    }
}

local hexIslandConfigs = {
    c0r0
}

module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        -- {
        --     {word = 'CAT', target = 3, found = 0}
        -- }
        {
            {word = 'RAT', target = 1, found = 0},
            {word = 'BAT', target = 1, found = 0},
            {word = 'CAT', target = 3, found = 0}
        }
    }
end

return module

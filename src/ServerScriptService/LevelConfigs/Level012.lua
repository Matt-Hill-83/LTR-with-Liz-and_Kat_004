local module = {}

local blank = {
    -- material = Enum.Material.Air,
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
    orbiterConfigs = {}
}

local c1r1 = {
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
            angularVelocity = 0.2,
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
            angularVelocity = 0.2,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = true,
            collideBlock = false,
            singleWord = 'B',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.2,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = true,
            collideBlock = false,
            singleWord = 'R',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = -0.4,
            -- diameter = 32,
            -- discTransparency = 0.7,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'H'
        }
    }
}

local c1r2 = {
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
            angularVelocity = 0.2,
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
            angularVelocity = 0.2,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = true,
            collideBlock = false,
            singleWord = 'T',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.2,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = true,
            collideBlock = false,
            singleWord = 'R',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = -0.4,
            -- diameter = 32,
            -- discTransparency = 0.7,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'H'
        }
    }
}

local c0r0 = blank

local hexIslandConfigs = {
    c0r0,
    c1r1,
    c1r2,
    c1r1,
    c1r1,
    c1r1,
    c1r1,
    c1r1,
    c1r1,
    c1r1
}

module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        {
            {word = 'CAT', target = 3, found = 0}
        }
        -- {
        --     {word = 'CAT', target = 1, found = 0},
        --     {word = 'BAT', target = 1, found = 0},
        --     {word = 'RAT', target = 1, found = 0},
        --     -- {word = 'PAT', target = 1, found = 0},
        --     {word = 'HAT', target = 1, found = 0}
        -- }
        -- {
        --     {word = 'DOG', target = 1, found = 0},
        --     {word = 'LOG', target = 1, found = 0},
        --     {word = 'HOG', target = 1, found = 0},
        --     {word = 'BOG', target = 1, found = 0}
        -- }
    }
end

return module

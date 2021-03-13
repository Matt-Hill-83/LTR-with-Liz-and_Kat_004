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

local r2c1 = {
    material = Enum.Material.Air,
    -- material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {},
    orbiterConfigs = {}
}
local r2c3 = {
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
            collideDisc = true,
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
            singleWord = 'A'
        }
    }
}
local r1c4 = {
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
        }
    },
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.2,
            -- diameter = 32,
            discTransparency = 0.7,
            collideDisc = true,
            collideBlock = false,
            singleWord = 'S',
            discHeight = 1
        }
    }
}
local r3c4 = {
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
        }
    },
    orbiterConfigs = {
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
        }
    }
}

local r2c5 = {
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
        }
    },
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = -0.2,
            -- diameter = 32,
            -- discTransparency = 0.7,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'H'
        }
    }
}

local r2c7 = blank
local r2c9 = blank
local r2c9a = blank
local r2c9b = blank

local hexIslandConfigs = {
    r1c4,
    r2c1,
    r2c3,
    r2c5,
    r2c7,
    r2c9,
    r2c9a,
    r2c9b,
    r3c4
}

module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        -- {
        --     {word = 'CAT', target = 1, found = 0}
        -- }
        {
            {word = 'CAT', target = 3, found = 0},
            {word = 'BAT', target = 3, found = 0},
            {word = 'RAT', target = 3, found = 0},
            -- {word = 'PAT', target = 3, found = 0},
            {word = 'HAT', target = 3, found = 0}
        }
        -- {
        --     {word = 'DOG', target = 1, found = 0},
        --     {word = 'LOG', target = 1, found = 0},
        --     {word = 'HOG', target = 1, found = 0},
        --     {word = 'BOG', target = 1, found = 0}
        -- }
    }
end

return module

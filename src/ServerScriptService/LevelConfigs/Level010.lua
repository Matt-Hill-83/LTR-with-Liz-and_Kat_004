local module = {}

local r2c1 = {
    hexNum = 'R1-C4',
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {'CAT'}
            }
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {'BAT'}
            }
        }
    },
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 13,
            angularVelocity = -0.2,
            -- diameter = 32,
            showDisc = false,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'CCC'
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 13,
            angularVelocity = -0.2,
            -- diameter = 32,
            showDisc = false,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'BBB'
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 13,
            angularVelocity = -0.2,
            -- diameter = 32,
            showDisc = false,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'RRR'
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 13,
            angularVelocity = 0.2,
            -- diameter = 32,
            showDisc = false,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'HHH'
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 13,
            angularVelocity = 0.2,
            -- diameter = 32,
            showDisc = false,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'MMM'
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 13,
            angularVelocity = 0.2,
            -- diameter = 32,
            showDisc = false,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'MMM'
        }
    }
}
local r2c3 = {
    hexNum = 'R1-C4',
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {},
    orbiterConfigs = {
        {
            words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 13,
            angularVelocity = -0.2,
            -- diameter = 32,
            showDisc = false,
            collideDisc = false,
            collideBlock = false
            -- singleWord = 'T'
        }
    }
}

local r2c5 = {
    hexNum = 'R1-C4',
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {},
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 13,
            angularVelocity = -0.2,
            -- diameter = 32,
            showDisc = false,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'T'
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 13,
            angularVelocity = -0.2,
            -- diameter = 32,
            showDisc = false,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'A'
        }
    }
}

local hexIslandConfigs = {
    {},
    r2c1,
    r2c3,
    r2c5
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

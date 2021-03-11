local module = {}

local island01 = {
    hexNum = 'R1-C4',
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {'CAT'},
                -- grabbers = {'HOG'},
                words = {'CAT', 'CAT'}
            },
            material = Enum.Material.Glacier
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {'CAT'},
                -- grabbers = {'HOG'},
                words = {'CAT', 'CAT'}
            },
            material = Enum.Material.Glacier
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {'CAT'},
                -- grabbers = {'HOG'},
                words = {'CAT', 'CAT'}
            },
            material = Enum.Material.Glacier
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {'CAT'},
                -- grabbers = {'HOG'},
                words = {'CAT', 'CAT'}
            },
            material = Enum.Material.Glacier
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {'CAT'},
                -- grabbers = {'HOG'},
                words = {'CAT', 'CAT'}
            },
            material = Enum.Material.Glacier
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

local hexIslandConfigs = {
    island01,
    island01
}

module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        {
            {word = 'CAT', target = 1, found = 0}
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

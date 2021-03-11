local module = {}

local hexIslandConfigs = {
    {
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
        }
    }
}

module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs
module.orbiterConfigs = {
    {
        words = {'CAT', 'CAT', 'CAT'},
        numBlocks = 24,
        angularVelocity = 0.2,
        -- diameter = 32,
        showDisc = false,
        discTransparency = 0.8,
        collideDisc = false,
        collideBlock = false
    },
    {
        words = {'CAT'},
        numBlocks = 24,
        angularVelocity = -0.2,
        -- diameter = 32,
        showDisc = false,
        discTransparency = 0.8,
        collideDisc = false,
        collideBlock = false
    },
    {
        words = {'CAT'},
        numBlocks = 24,
        angularVelocity = 0.2,
        -- diameter = 32,
        showDisc = false,
        discTransparency = 0.8,
        collideDisc = false,
        collideBlock = false
    },
    {
        words = {'CAT'},
        numBlocks = 24,
        angularVelocity = -0.2,
        -- diameter = 32,
        showDisc = false,
        discTransparency = 0.8,
        collideDisc = false,
        collideBlock = false
    },
    {
        words = {'CAT'},
        numBlocks = 24,
        angularVelocity = 0.2,
        -- diameter = 32,
        showDisc = false,
        discTransparency = 0.8,
        collideDisc = false,
        collideBlock = false
    },
    {
        words = {'FIONA'},
        numBlocks = 24,
        angularVelocity = -0.2,
        -- diameter = 32,
        showDisc = false,
        discTransparency = 0.8,
        collideDisc = false,
        collideBlock = false
    },
    {
        words = {'FIONA'},
        numBlocks = 24,
        angularVelocity = 0.2,
        -- diameter = 32,
        showDisc = false,
        discTransparency = 0.8,
        collideDisc = false,
        collideBlock = false
    },
    {
        words = {'999999999999'},
        numBlocks = 24,
        angularVelocity = -0.2,
        -- diameter = 32,
        showDisc = false,
        discTransparency = 0.8,
        collideDisc = false,
        collideBlock = false
    }
}

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

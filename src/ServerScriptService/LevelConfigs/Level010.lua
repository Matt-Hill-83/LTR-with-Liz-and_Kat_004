local module = {}

local hexIslandConfigs = {
    {
        hexNum = 'R1-C4',
        material = Enum.Material.Grass,
        statueConfigs = {},
        bridgeConfigs = {
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'CAT'},
                    -- grabbers = {'HOG'},
                    words = {'CAT', 'CAT'}
                },
                material = Enum.Material.LeafyGrass
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
        showDisc = true,
        discTransparency = 0.8,
        collideDisc = true,
        -- diameter = 32,
        collideBlock = true
    },
    {
        words = {'CAT'},
        numBlocks = 24,
        angularVelocity = 0.2,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 32,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'CAT'},
        numBlocks = 24,
        angularVelocity = 0.2,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 32,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'CAT'},
        numBlocks = 24,
        angularVelocity = 0.2,
        showDisc = true,
        discTransparency = 0.8,
        collideDisc = true,
        -- diameter = 32,
        collideBlock = true
    },
    {
        words = {'CAT'},
        numBlocks = 24,
        angularVelocity = 0.2,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 32,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'FIONA'},
        numBlocks = 24,
        angularVelocity = 0.2,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 64,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'FIONA'},
        numBlocks = 24,
        angularVelocity = 0.2,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 64,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'999999999999'},
        numBlocks = 24,
        angularVelocity = 0.2,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 64,
        collideDisc = true,
        collideBlock = true
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

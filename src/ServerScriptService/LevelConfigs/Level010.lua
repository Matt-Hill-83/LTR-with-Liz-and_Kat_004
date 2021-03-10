local module = {}

local hexIslandConfigs = {
    {
        hexNum = 'R1-C4',
        material = Enum.Material.Grass,
        statueConfigs = {},
        bridgeConfigs = {
            {
                item = 'Rink2',
                itemConfig = {
                    grabbers = {'HOG'},
                    words = {'HOG', 'LOG', 'DOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'MOM'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DAD'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'CAT'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'RAT'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'BAT'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'MAT'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'SAT'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'PAT'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'BOG'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'FOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'HOG'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'LOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'},
                    words = {'HOG', 'BOG'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'}
                    -- words = {'DDDDDDDDDDDDD'}
                },
                material = Enum.Material.LeafyGrass
            },
            {
                item = 'Rink',
                itemConfig = {
                    grabbers = {'DOG'},
                    words = {'HOG', 'BOG'}
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
        words = {'HOG'},
        numBlocks = 16,
        angularVelocity = 0.5,
        showDisc = true,
        discTransparency = 0.8,
        collideDisc = true,
        -- diameter = 32,
        collideBlock = true
    },
    {
        words = {'CAT'},
        numBlocks = 16,
        angularVelocity = 0.5,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 32,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'CAT'},
        numBlocks = 16,
        angularVelocity = 0.5,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 32,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'CAT'},
        numBlocks = 16,
        angularVelocity = 0.5,
        showDisc = true,
        discTransparency = 0.8,
        collideDisc = true,
        -- diameter = 32,
        collideBlock = true
    },
    {
        words = {'CAT'},
        numBlocks = 16,
        angularVelocity = 0.5,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 32,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'FIONA'},
        numBlocks = 16,
        angularVelocity = 0.5,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 64,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'FIONA'},
        numBlocks = 16,
        angularVelocity = 0.5,
        showDisc = true,
        discTransparency = 0.8,
        -- diameter = 64,
        collideDisc = true,
        collideBlock = true
    },
    {
        words = {'999999999999'},
        numBlocks = 16,
        angularVelocity = 0.5,
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
            {word = 'DOG', target = 1, found = 0},
            {word = 'LOG', target = 1, found = 0},
            {word = 'HOG', target = 1, found = 0},
            {word = 'BOG', target = 1, found = 0}
        }
    }
end

return module

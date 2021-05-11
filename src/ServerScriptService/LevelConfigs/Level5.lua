local Sss = game:GetService('ServerScriptService')
local Colors = require(Sss.Source.Constants.Const_02_Colors)

local Constants = require(Sss.Source.Constants.Constants)
local module = {}

local tallWalls = Constants.tallWalls

local dummy01 = {
    material = Enum.Material.Glacier,
    statueConfigs = {
        Liz = {
            sentence = {'I', 'SEE', 'A', 'CAT'},
            character = 'lizHappy',
            -- songId = '6342102168',
            keyColor = Colors.colors.yellow
        },
        Kat = {
            sentence = {'NOT', 'A', 'CAT'},
            character = 'katScared',
            songId = '6342102168'
        },
        Troll = {
            sentence = {'TROLL', 'NEED', 'GOLD'},
            character = 'babyTroll04',
            songId = '6338745550'
        }
    }
}

local region001 = {
    bridgeConfigs = {{invisiWallProps = tallWalls, straysOnBridges = false}},
    invisiWallProps = tallWalls,
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'FFFFFFFFFFF~',
            discHeight = 1,
            blockSize = 8
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'O',
            discHeight = 1,
            blockSize = 8
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'X',
            discHeight = 1
        }
    },
    hexIslandConfigs = {
        dummy01,
        dummy01
    },
    getTargetWords = function()
        return {
            {
                {word = 'FOX', target = 3, found = 0}
            }
        }
    end
}

local region002 = {
    hexGearConfigs = {
        {
            words = {
                'FOX',
                'BOX',
                'LOX'
            }
        }
    },
    invisiWallProps = tallWalls,
    bridgeConfigs = {{invisiWallProps = tallWalls, straysOnBridges = false}},
    strayRegions = {
        {
            words = {'FOX'},
            -- maxLetters = 6
            useArea = true
        }
    },
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'CAT',
            discHeight = 1
        }
    },
    hexIslandConfigs = {
        dummy01,
        dummy01
    },
    getTargetWords = function()
        return {
            {
                {word = 'FOX', target = 1, found = 0}
            }
        }
    end
}

local region003 = {
    hexGearConfigs = {
        {
            words = {
                'FOX',
                'BOX',
                'LOX'
            }
        }
    },
    invisiWallProps = tallWalls,
    bridgeConfigs = {{invisiWallProps = tallWalls, straysOnBridges = false}},
    strayRegions = {
        {
            words = {'FOX'},
            -- maxLetters = 6
            useArea = true
        }
    },
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'CAT',
            discHeight = 1
        }
    },
    hexIslandConfigs = {
        dummy01,
        dummy01
    },
    getTargetWords = function()
        return {
            {
                {word = 'FOX', target = 1, found = 0}
            }
        }
    end
}

local dummyRegion = {
    hexGearConfigs = {
        {
            words = {
                'CAT',
                'BAT',
                'HAT'
            }
        }
        -- hexGearWords02,
        -- hexGearWords03
    },
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'ISEEAFOXINABOX',
            discHeight = 1
        }
    },
    hexIslandConfigs = {
        dummy01
    },
    strayRegions = {
        {
            words = {'ABCDEFGHIJKLMNOPQRSTUVWXYZAAAAAAAAATTTTTTT'},
            -- words = {'CAT'},
            randomLetterMultiplier = 1,
            -- maxLetters = 6,
            useArea = true
        }
    },
    getTargetWords = function()
        return {
            {
                {word = 'HAT', target = 1, found = 0}
            }
        }
    end
}

module.regions = {
    region001,
    region002,
    region003,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion
}

return module

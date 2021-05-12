local Sss = game:GetService('ServerScriptService')

local Configs = require(Sss.Source.Constants.Const_08_Configs)

local Constants = require(Sss.Source.Constants.Constants)
local module = {}

local tallWalls = Constants.tallWalls

local r001 = {
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
    getTargetWords = function()
        return {
            {
                {word = 'FOX', target = 3, found = 0}
            }
        }
    end
}

local r002 = {
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
    getTargetWords = function()
        return {
            {
                {word = 'FOX', target = 1, found = 0}
            }
        }
    end
}

local r003 = {
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
    getTargetWords = function()
        return {
            {
                {word = 'FOX', target = 1, found = 0}
            }
        }
    end
}

local regions = {
    r001 = r001,
    r002 = r002,
    r003 = r003,
    r004 = r003,
    r005 = r003,
    r006 = r003
}

Configs.addDefaults(regions)

module.regions = regions
return module

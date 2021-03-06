local Sss = game:GetService('ServerScriptService')
local Words = require(Sss.Source.Constants.Const_07_Words)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Constants = require(Sss.Source.Constants.Constants)
local Configs = require(Sss.Source.Constants.Const_08_Configs)

local tallWalls = Configs.tallWalls
local module = {}

local hexGearWords01 = {words = Words.allWords}

local r001 = {
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'CAT',
            discHeight = 1
        }
    },
    getTargetWords = function()
        return {{{word = 'CAT', target = 1, found = 0}}}
    end
}

local r002 = {
    getTargetWords = function()
        return {{{word = 'BAT', target = 1, found = 0}}}
    end
}

local r003 = {
    getTargetWords = function()
        return {{{word = 'RAT', target = 1, found = 0}}}
    end
}

local r004 = {
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
                {word = 'RAT', target = 1, found = 0},
                {word = 'CAT', target = 1, found = 0},
                {word = 'BAT', target = 1, found = 0},
                {word = 'HAT', target = 1, found = 0},
                {word = 'MAT', target = 1, found = 0},
                {word = 'SAT', target = 1, found = 0},
                {word = 'PAT', target = 1, found = 0}
            }
        }
    end
}

local r005 = {
    getTargetWords = function()
        return {{{word = 'CAT', target = 1, found = 0}}}
    end
}
local r006 = {
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'ATANAP~~',
            discHeight = 1
        }
    },
    getTargetWords = function()
        return {{{word = 'CAT', target = 1, found = 0}}}
    end
}

local r007 = {
    bridgeConfigs = {invisiWallProps = tallWalls, straysOnBridges = false},
    invisiWallProps = tallWalls
}

local r008 = {
    hexGearConfigs = {
        {
            words = {
                '',
                '',
                '',
                'FOX',
                'FOX',
                'FOX'
            }
        }
    },
    -- invisiWallProps = tallWalls,
    -- hexIslandConfigs = {invisiWallProps = tallWalls},
    bridgeConfigs = {invisiWallProps = tallWalls, straysOnBridges = false},
    strayRegions = {
        {
            words = {'FOX'},
            -- maxLetters = 6
            useArea = true
        }
    },
    getTargetWords = function()
        return {{{word = 'FOX', target = 1, found = 0}}}
    end
}
local regions = {
    r001 = r001,
    r002 = r002,
    r003 = r003,
    r004 = r004,
    r005 = r005,
    r006 = r006,
    r007 = r007,
    r008 = r008
}

Configs.addDefaults(regions)

module.regions = regions
return module

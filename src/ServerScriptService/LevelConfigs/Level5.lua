local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Configs = require(Sss.Source.Constants.Const_08_Configs)
local Words = require(Sss.Source.Constants.Const_07_Words)
local module = {}

local tallWalls = Configs.tallWalls

-- 'words01',
-- 'words02',
-- 'words03',
-- 'words04',
-- 'words05',
-- 'words06',
-- 'words07',
-- 'words08',

local r007 = {
    bridgeConfigs = {
        -- invisiWallProps = tallWalls,
        straysOnBridges = false,
        material = Enum.Material.Grass,
        bridgeTemplateName = Configs.bridges.default
    }
    -- invisiWallProps = tallWalls
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
    bridgeConfigs = {
        -- invisiWallProps = tallWalls,
        straysOnBridges = false,
        material = Enum.Material.Grass,
        bridgeTemplateName = Configs.bridges.default
    },
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
    r007 = r007,
    r008 = r008,
    r009 = r008
}

local statueConfigs = {
    Liz = {
        sentence = {'I', 'SEE', 'A', 'CAT'},
        character = 'lizHappy'
        -- songId = '6342102168',
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

function module.getRegionTemplate(props)
    local hexGearWords = props.hexGearWords
    local strayRegionWords = props.strayRegionWords
    local targetWords = props.targetWords
    local statueConfigs2 = props.statueConfigs
    local wordSet = props.wordSet

    local regionTemplate = {
        wordSet = wordSet,
        hexGearConfigs = hexGearWords,
        bridgeConfigs = {
            invisiWallProps = tallWalls,
            straysOnBridges = false,
            bridgeTemplateName = Configs.bridges.default
        },
        strayRegions = {{words = strayRegionWords}},
        statueConfigs = statueConfigs2,
        getTargetWords = function()
            return {targetWords}
        end
    }

    return regionTemplate
end

local numRegions = 10
local regionNumberStart = 10
local numWordsPerRegion = 3

function module.getWordSet(props)
    local numWordsPerRegion2 = props.numWordsPerRegion
    local index = props.index

    local startIndex = (index * 3) - 2
    local endIndex = startIndex + numWordsPerRegion2 - 1
    local wordSet = {table.unpack(Words.allWords, startIndex, endIndex)}

    return wordSet
end

-- Autogenerate the regions
for index = 1, numRegions do
    local regionName = 'r0' .. (index - 1) + regionNumberStart

    local wordSet =
        module.getWordSet(
        {
            numWordsPerRegion = numWordsPerRegion,
            index = index
        }
    )

    local mod = (index + 2) % 3
    local statueConfig = statueConfigs[mod + 1]

    local targetWords = {}
    for _, word in ipairs(wordSet) do
        table.insert(targetWords, {word = word, target = 1, found = 0})
    end

    local props = {
        hexGearWords = {{words = Utils.concatArray({'', '', ''}, wordSet)}},
        strayRegionWords = wordSet,
        wordSet = wordSet,
        targetWords = targetWords,
        statueConfigs = {statueConfig}
    }

    local region = module.getRegionTemplate(props)
    regions[regionName] = region
end

module.regions = regions
Configs.addDefaults(regions)

return module

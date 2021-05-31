local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Configs = require(Sss.Source.Constants.Const_08_Configs)
local Words = require(Sss.Source.Constants.Const_07_Words)
local module = {}

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)
local tallWalls = Configs.tallWalls

local numStatuesPerHex = 9
local numHexes = 3

local hexGearConfigs = {}
for i = 0, numHexes do
    local startIndex = i * numStatuesPerHex
    local endIndex = (i + 1) * numStatuesPerHex + 1
    local words = Utils.arraySubset(Words.allWords, startIndex, endIndex)
    local newConfig = {words = words}
    table.insert(hexGearConfigs, newConfig)
end

local numWordsPerLF = 8
local numLFs = 3

local lFConfigs = {}
for i = 0, numLFs do
    local startIndex = i * numWordsPerLF
    local endIndex = (i + 1) * numStatuesPerHex + 1
    local words = Utils.arraySubset(Words.allWords, startIndex, endIndex)
    local newConfig = {words = words}
    table.insert(lFConfigs, newConfig)
end

local numOrbiters = 24
local orbiterConfigs2 = {}

local chars = 'ATNPGDMBCDFHIJLRSXYZ'

for i = 1, numOrbiters do
    local char = chars:sub(i, i)
    local polarity = i % 2 == 0 and 1 or -1

    local newConfig = {
        -- words = {'AT'},
        numBlocks = 12,
        angularVelocity = 0.8 * polarity,
        -- diameter = 32,
        discTransparency = 1,
        collideDisc = false,
        collideBlock = false,
        singleWord = char,
        discHeight = 1
    }
    table.insert(orbiterConfigs2, newConfig)
end

local r006 = {
    bridgeConfigs = {
        invisiWallProps = tallWalls,
        straysOnBridges = false,
        material = Enum.Material.Grass,
        bridgeTemplateName = Configs.bridges.default
    },
    invisiWallProps = tallWalls
    -- hexGearConfigs = hexGearConfigs
}

local r007 = {
    bridgeConfigs = {
        invisiWallProps = tallWalls,
        straysOnBridges = false,
        material = Enum.Material.Grass,
        bridgeTemplateName = Configs.bridges.default
    },
    orbiterConfigs = orbiterConfigs2,
    invisiWallProps = tallWalls,
    hexGearConfigs = hexGearConfigs,
    letterFallConfigs = lFConfigs
}

local r100 = {
    bridgeConfigs = {
        -- invisiWallProps = tallWalls,
        straysOnBridges = false,
        material = Enum.Material.Grass,
        bridgeTemplateName = Configs.bridges.default
    },
    orbiterConfigs = {
        {
            -- words = {'AT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'W',
            discHeight = 1
        },
        {
            -- words = {'AT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'I',
            discHeight = 1
        },
        {
            -- words = {'BAT'},
            numBlocks = 12,
            angularVelocity = -0.7,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'N',
            discHeight = 1
        }
    },
    getTargetWords = function()
        return {{{word = 'WIN', target = 1, found = 0}}}
    end
    -- invisiWallProps = tallWalls
}

local regions = {
    r006 = r006,
    r007 = r007,
    r008 = r007,
    r009 = r007,
    r099 = r100,
    r100 = r100
}

local statueConfigs = {
    {
        name = 'Liz',
        sentence = {'I', 'SEE', 'A', 'CAT'},
        character = 'lizHappy'
        -- songId = '6342102168',
    },
    {
        name = 'Kat',
        sentence = {'NOT', 'A', 'CAT'},
        character = 'katScared'
        -- songId = '6342102168'
    },
    {
        name = 'Troll',
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

    local orbiterConfigs = {}

    local uniqueLettersFromWords = LetterUtils.getUniqueLettersFromWords(wordSet)

    for letterIndex, letter in ipairs(uniqueLettersFromWords) do
        local polarity = letterIndex % 2 == 0 and 1 or -1

        local orbiterConfig = {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8 * polarity,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = letter,
            discHeight = 1
        }

        table.insert(orbiterConfigs, orbiterConfig)
    end

    local regionTemplate = {
        wordSet = wordSet,
        hexGearConfigs = hexGearWords,
        bridgeConfigs = {
            -- invisiWallProps = tallWalls,
            straysOnBridges = false,
            bridgeTemplateName = Configs.bridges.default
        },
        strayRegions = {{words = strayRegionWords}},
        statueConfigs = statueConfigs2,
        orbiterConfigs = orbiterConfigs,
        getTargetWords = function()
            return {targetWords}
        end
    }

    return regionTemplate
end

function module.getWordSet(props)
    local numWordsPerRegion2 = props.numWordsPerRegion
    local index = props.index
    local wordList = props.wordList

    local startIndex = (index * 3) - 2
    local endIndex = startIndex + numWordsPerRegion2 - 1
    local wordSet = {table.unpack(wordList, startIndex, endIndex)}

    return wordSet
end

local regionNumberStart = 10
module.regionNum = regionNumberStart
module.wordIndex = 1

function module.autoCreateRegions(props)
    local numRegions = props.numRegions
    local numWordsPerRegion = props.numWordsPerRegion
    local numEachWord = props.numEachWord
    local wordList = props.wordList

    for index = 1, numRegions do
        local regionName = 'r0' .. module.regionNum
        module.regionNum = module.regionNum + 1

        local wordSet =
            module.getWordSet({numWordsPerRegion = numWordsPerRegion, index = module.wordIndex, wordList = wordList})
        module.wordIndex = module.wordIndex + 1

        local mod = (index + 2) % #statueConfigs
        local statueConfig = statueConfigs[mod + 1]

        local targetWords = {}
        for _, word in ipairs(wordSet) do
            table.insert(targetWords, {word = word, target = numEachWord, found = 0})
        end

        local props2 = {
            hexGearWords = {{words = Utils.concatArray({'', '', ''}, wordSet)}},
            strayRegionWords = wordSet,
            wordSet = wordSet,
            targetWords = targetWords,
            statueConfigs = {statueConfig}
        }

        local region = module.getRegionTemplate(props2)
        regions[regionName] = region
    end
end

local wordList = Words.allWords

-- Get a pet
module.autoCreateRegions(
    {
        numRegions = 20,
        numWordsPerRegion = 1,
        numEachWord = 1,
        wordList = wordList
    }
)
-- Dome home
module.autoCreateRegions(
    {
        numRegions = 1,
        numWordsPerRegion = 1,
        numEachWord = 1,
        wordList = wordList
    }
)

-- the rest
module.autoCreateRegions(
    {
        numRegions = 20,
        numWordsPerRegion = 1,
        numEachWord = 1,
        wordList = wordList
    }
)

module.regions = regions
Configs.addDefaults(regions)

return module

local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Configs = require(Sss.Source.Constants.Const_08_Configs)
local Words = require(Sss.Source.Constants.Const_07_Words)
local module = {}

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)
local tallWalls = Configs.tallWalls

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
    bridgeConfigs = {
        -- invisiWallProps = tallWalls,
        straysOnBridges = false,
        material = Enum.Material.Grass,
        bridgeTemplateName = Configs.bridges.default
    }
    -- invisiWallProps = tallWalls
}

local regions = {
    r007 = r007,
    r008 = r008
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

function module.autoCreateRegions(props)
    local numRegions = props.numRegions
    local numWordsPerRegion = props.numWordsPerRegion
    local numEachWord = props.numEachWord
    local wordList = props.wordList

    for index = 1, numRegions do
        local regionName = 'r0' .. module.regionNum
        module.regionNum = module.regionNum + 1

        local wordSet = module.getWordSet({numWordsPerRegion = numWordsPerRegion, index = index, wordList = wordList})

        local mod = (index + 2) % 3
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

module.autoCreateRegions(
    {
        numRegions = 10,
        numWordsPerRegion = 1,
        numEachWord = 1,
        wordList = wordList
    }
)

module.autoCreateRegions(
    {
        numRegions = 1,
        numWordsPerRegion = 1,
        numEachWord = 1,
        wordList = wordList
    }
)

-- module.autoCreateRegions(
--     {
--         numRegions = 1,
--         numWordsPerRegion = 8,
--         numEachWord = 1,
--         wordList = {table.unpack(wordList, 1, 9)}
--     }
-- )

module.autoCreateRegions(
    {
        numRegions = 10,
        numWordsPerRegion = 1,
        numEachWord = 1,
        wordList = wordList
    }
)
-- module.autoCreateRegions({numRegions = 2, numWordsPerRegion = 1, numEachWord = 1})
-- module.autoCreateRegions({numRegions = 1, numWordsPerRegion = 1, numEachWord = 2})
-- module.autoCreateRegions({numRegions = 10, numWordsPerRegion = 3, numEachWord = 1})

module.regions = regions
print('regions' .. ' - start')
print(regions)
Configs.addDefaults(regions)

return module

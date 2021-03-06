local CS = game:GetService('CollectionService')
local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local LetterFallUtils = require(Sss.Source.LetterFall.LetterFallUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local module = {}

function module.initWord(props)
    local wordIndex = props.wordIndex
    local word = props.word
    local wordBox = props.wordBox
    local wordLetters = props.wordLetters
    local letterBlockTemplate = props.letterBlockTemplate
    local wordSetFooter = props.wordSetFooter

    local wordBoxClone = wordBox:Clone()
    wordBoxClone.Parent = wordBox.Parent

    local wordNameStub = '-W' .. wordIndex
    wordBoxClone.Name = wordBoxClone.Name .. 'ssss' .. wordNameStub

    local wordBench = Utils.getFirstDescendantByName(wordBoxClone, 'WordBench')

    local letterSize = letterBlockTemplate.Size.Y

    local spacingFactorY = 1.1
    local spacingFactorX = 1.05
    local wordSpacingY = letterSize * spacingFactorY
    local positionY = wordSpacingY * wordIndex

    local wordBenchSizeX = #word * letterSize * spacingFactorX
    wordBench.Size = Vector3.new(wordBenchSizeX, wordBench.Size.Y, letterSize)

    local backPlate = Utils.getFirstDescendantByName(wordBoxClone, 'BackPlate')
    local backPlateSizeX = (letterSize / 2) + wordBench.Size.X
    backPlate.Size = Vector3.new(backPlateSizeX, letterSize * 1.5, wordBench.Size.Z)

    wordBench.Position =
        Vector3.new(wordSetFooter.Position.X, wordSetFooter.Position.Y + positionY, wordSetFooter.Position.Z)
    backPlate.Position =
        Vector3.new(wordBench.Position.X + letterSize / 8, wordBench.Position.Y + letterSize / 2, wordBench.Position.Z)
    wordBench.Anchored = true
    backPlate.Anchored = true

    local lettersInWord = {}
    local templateName = LetterFallUtils.letterBlockStyleDefs.word.Available

    local styleTemplate = Utils.getFromTemplates(templateName)
    -- if true then
    -- if false then
    for letterIndex = 1, #word do
        local letterNameStub = wordNameStub .. '-L' .. letterIndex
        local letter = string.sub(word, letterIndex, letterIndex)

        local newLetter = letterBlockTemplate:Clone()

        LetterUtils.applyStyleFromTemplate(
            {targetLetterBlock = newLetter, templateName = templateName, template = styleTemplate}
        )

        newLetter.Name = 'wordLetter-' .. letterNameStub

        local letterPositionZ = newLetter.Size.Z * (letterIndex - 2) * spacingFactorX

        CS:AddTag(newLetter, LetterFallUtils.tagNames.WordLetter)
        LetterFallUtils.applyLetterText({letterBlock = newLetter, char = letter})

        Utils3.setCFrameFromDesiredEdgeOffset2(
            {
                parent = wordBench,
                child = newLetter,
                childIsPart = true,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, 1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = Vector3.new(letterPositionZ, 0, 0)
                }
            }
        )

        newLetter.Parent = wordBoxClone
        newLetter.Anchored = true

        table.insert(wordLetters, {char = letter, found = false, instance = newLetter})
        table.insert(lettersInWord, {char = letter, found = false, instance = newLetter})
    end

    local newWordObj = {
        word = wordBoxClone,
        letters = lettersInWord,
        wordChars = word
    }
    return newWordObj
    -- end
end

function module.initWords(miniGameState)
    local wordLetters = miniGameState.wordLetters
    local clonedLetterFallModel = miniGameState.clonedLetterFallModel

    for i, letter in ipairs(wordLetters) do
        if letter.instance then
            letter.instance:Destroy()
        end
        wordLetters[i] = nil
    end
    Utils.clearTable(wordLetters)

    local letterFallFolder = miniGameState.letterFallFolder
    local wordBoxFolder = Utils.getFirstDescendantByName(letterFallFolder, 'WordBoxFolder')
    local wordBoxes = Utils.getDescendantsByName(wordBoxFolder, 'WordBox')

    local words = miniGameState.words
    local numWords = #words
    local numWords1 = math.ceil(numWords / 2)
    local numWords2 = numWords - numWords1

    local wordGroupSizes = {numWords1, numWords2}
    local wordSetFooters = {
        Utils.getFirstDescendantByName(clonedLetterFallModel, 'FooterRight'),
        Utils.getFirstDescendantByName(clonedLetterFallModel, 'FooterLeft')
    }

    local offsetConfigs = {
        {
            useParentNearEdge = Vector3.new(0, -1, -1),
            useChildNearEdge = Vector3.new(0, -1, 1),
            offsetAdder = Vector3.new(-3, 0, 0)
        },
        {
            useParentNearEdge = Vector3.new(0, -1, 1),
            useChildNearEdge = Vector3.new(0, -1, -1),
            offsetAdder = Vector3.new(-3, 0, 0)
        }
    }

    local frameBottom = Utils.getFirstDescendantByName(clonedLetterFallModel, 'Bottom')

    local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
    local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_4_blank')

    local prevFinish = 0

    for wbIndex, wordBox in ipairs(wordBoxes) do
        local numWordsInSet = wordGroupSizes[wbIndex]

        local start = prevFinish + 1
        local finish = prevFinish + numWordsInSet
        prevFinish = finish

        local wordSet = Utils.arraySubset(words, start, finish)
        local wordSetFooter = wordSetFooters[wbIndex]

        local wordSetFooterLength = 16
        wordSetFooter.Size = Vector3.new(wordSetFooter.Size.X, wordSetFooter.Size.Y, wordSetFooterLength)

        local offsetConfig = offsetConfigs[wbIndex]

        Utils3.setCFrameFromDesiredEdgeOffset2(
            {
                parent = frameBottom,
                child = wordSetFooter,
                childIsPart = true,
                offsetConfig = offsetConfig
            }
        )

        for wordIndex, word in ipairs(wordSet) do
            local wordProps = {
                wordIndex = wordIndex,
                clonedLetterFallModel = clonedLetterFallModel,
                wordBox = wordBox,
                wordLetters = wordLetters,
                word = word,
                wordSetFooter = wordSetFooter,
                letterBlockTemplate = letterBlockTemplate
            }

            local newWordObj = module.initWord(wordProps)
            table.insert(miniGameState.renderedWords, newWordObj)
        end
        wordBox:Destroy()
    end
end

function getWordFolder(miniGameState)
    local letterFallFolder = miniGameState.letterFallFolder
    local runtimeFolder =
        Utils.getOrCreateFolder(
        {
            name = 'RunTimeFolder',
            parent = letterFallFolder
        }
    )

    return (Utils.getOrCreateFolder(
        {
            name = 'RunTimeWordBoxFolder',
            parent = runtimeFolder
        }
    ))
end

return module

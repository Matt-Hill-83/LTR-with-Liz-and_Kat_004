local CS = game:GetService('CollectionService')
local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local LetterFallUtils = require(Sss.Source.LetterFall.LetterFallUtils)

local module = {}

function initWord(props)
    local miniGameState = props.miniGameState
    local wordIndex = props.wordIndex
    local word = props.word
    local wordLetters = props.wordLetters

    local letterFallFolder = miniGameState.letterFallFolder
    local wordBoxFolder = Utils.getFirstDescendantByName(letterFallFolder, 'WordBoxFolder')

    local wordBox = Utils.getFirstDescendantByName(wordBoxFolder, 'WordBox')
    local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')

    local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LBPinkPurple')

    local wordBoxClone = wordBox:Clone()
    wordBoxClone.Parent = wordBox.Parent

    local wordNameStub = '-W' .. wordIndex
    wordBoxClone.Name = wordBoxClone.Name .. 'ssss' .. wordNameStub

    local wordBench = Utils.getFirstDescendantByName(wordBoxClone, 'WordBench')
    local letterPositioner = Utils.getFirstDescendantByName(wordBoxClone, 'WordLetterBlockPositioner')

    local spacingFactorY = 1.25
    local spacingFactorZ = 1.0
    local wordSpacingY = letterBlockTemplate.Size.Y * spacingFactorY
    local positionY = wordSpacingY * wordIndex

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = wordBox.PrimaryPart,
            childModel = wordBoxClone,
            offsetConfig = {
                useParentNearEdge = Vector3.new(0, 0, 0),
                useChildNearEdge = Vector3.new(0, 0, 0),
                offsetAdder = Vector3.new(0, positionY, 0)
            }
        }
    )
    wordBench.Anchored = true

    letterPositioner.Name = letterPositioner.Name .. wordNameStub

    local lettersInWord = {}
    for letterIndex = 1, #word do
        local letterNameStub = wordNameStub .. '-L' .. letterIndex
        local letter = string.sub(word, letterIndex, letterIndex)

        local newLetter = letterBlockTemplate:Clone()
        newLetter.Name = 'wordLetter-' .. letterNameStub

        local letterPositionZ = newLetter.Size.Z * (letterIndex - 2) * spacingFactorZ

        CS:AddTag(newLetter, LetterFallUtils.tagNames.WordLetter)
        LetterFallUtils.applyLetterText({letterBlock = newLetter, char = letter})

        newLetter.CFrame = letterPositioner.CFrame * CFrame.new(Vector3.new(0, 0, letterPositionZ))
        newLetter.Parent = wordBoxClone
        newLetter.Anchored = true

        table.insert(wordLetters, {char = letter, found = false, instance = newLetter})
        table.insert(lettersInWord, {char = letter, found = false, instance = newLetter})
    end

    local wordBenchSizeX = #word * letterBlockTemplate.Size.X * spacingFactorZ

    wordBench.Size = Vector3.new(wordBenchSizeX, wordBench.Size.Y, wordBench.Size.Z)

    local newWordObj = {
        word = wordBoxClone,
        letters = lettersInWord,
        wordChars = word
    }
    return newWordObj
end

function initWords(miniGameState)
    local wordLetters = miniGameState.wordLetters

    for i, letter in ipairs(wordLetters) do
        if letter.instance then
            letter.instance:Destroy()
        end
        wordLetters[i] = nil
    end
    Utils.clearTable(wordLetters)

    for wordIndex, word in ipairs(miniGameState.words) do
        local wordProps = {
            miniGameState = miniGameState,
            wordIndex = wordIndex,
            wordLetters = wordLetters,
            word = word
        }

        local newWordObj = initWord(wordProps)
        table.insert(miniGameState.renderedWords, newWordObj)
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

module.initWords = initWords
module.initWord = initWord

return module

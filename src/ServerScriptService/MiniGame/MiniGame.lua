local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local LetterFall = require(Sss.Source.LetterFall.LetterFall)
local LetterFallUtils = require(Sss.Source.LetterFall.LetterFallUtils)
local InitLetterRack = require(Sss.Source.LetterFall.InitLetterRack)
local InitWord = require(Sss.Source.LetterFall.InitWord)

local module = {}
function module.initLetterFall(miniGameState)
    LetterFall.initGameToggle(miniGameState)
    InitLetterRack.initLetterRack(miniGameState)
    InitWord.initWords(miniGameState)

    LetterFallUtils.styleLetterBlocks(
        {
            miniGameState = miniGameState,
            availWords = miniGameState.words
        }
    )
end

function module.addMiniGame(props)
    local parent = props.parent
    local sceneIndex = props.sceneIndex
    local questIndex = props.questIndex
    local words = props.words
    -- local positionOffset = props.positionOffset or Vector3.new(0, 0, 0)

    local letterFallTemplate = Utils.getFromTemplates('LetterFallTemplate')

    local allLetters = {
        'A',
        'B',
        'C',
        'D',
        'E',
        'F',
        'G',
        'H',
        'I',
        'J',
        'K',
        'L',
        'M',
        'N',
        'O',
        'P',
        'Q',
        'R',
        'S',
        'T',
        'U',
        'V',
        'W',
        'X',
        'Y',
        'Z'
    }

    local miniGameState = {
        activeWord = nil,
        activeWordIndex = 1,
        allLetters = allLetters,
        availLetters = {},
        availWords = {},
        currentLetterIndex = 1,
        foundLetters = {},
        foundWords = {},
        renderedWords = {},
        wordLetters = {},
        words = words,
        questIndex = questIndex
    }

    local miniGame = {}

    local clonedLetterFallModel = letterFallTemplate:Clone()
    clonedLetterFallModel.Name = clonedLetterFallModel.Name .. 'Clone' .. '-Q' .. questIndex .. '-S' .. sceneIndex

    local letterFallFolder = Utils.getFirstDescendantByName(clonedLetterFallModel, 'LetterFallFolder')
    miniGameState.letterFallFolder = letterFallFolder

    clonedLetterFallModel.Parent = parent

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = parent,
            childModel = clonedLetterFallModel,
            offsetConfig = {
                useParentNearEdge = Vector3.new(0, -1, 0),
                useChildNearEdge = Vector3.new(0, -1, 0)
                -- offsetAdder = Vector3.new(0, 0, 0)
            }
        }
    )

    module.initLetterFall(miniGameState)
    miniGame = clonedLetterFallModel

    return miniGame
end

return module

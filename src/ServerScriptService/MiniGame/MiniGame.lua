local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local LetterFallUtils = require(Sss.Source.LetterFall.LetterFallUtils)
local InitLetterRack = require(Sss.Source.LetterFall.InitLetterRack)
local InitWord = require(Sss.Source.LetterFall.InitWord)
local HandleClick = require(Sss.Source.LetterFall.HandleClick)

local module = {}

function module.addMiniGame(props)
    local parent = props.parent
    local sceneIndex = props.sceneIndex
    local questIndex = props.questIndex
    local words = props.words

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

    local clonedLetterFallModel = letterFallTemplate:Clone()
    clonedLetterFallModel.Name = clonedLetterFallModel.Name .. 'Clone' .. '-Q' .. questIndex .. '-S' .. sceneIndex
    clonedLetterFallModel.Parent = parent

    miniGameState.letterFallFolder = Utils.getFirstDescendantByName(clonedLetterFallModel, 'LetterFallFolder')

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = parent,
            childModel = clonedLetterFallModel,
            offsetConfig = {
                useParentNearEdge = Vector3.new(0, -1, 0),
                useChildNearEdge = Vector3.new(0, -1, 0)
            }
        }
    )

    HandleClick.initClickHandler(miniGameState)
    LetterFallUtils.createBalls(miniGameState)
    InitLetterRack.initLetterRack(miniGameState)
    InitWord.initWords(miniGameState)

    LetterFallUtils.styleLetterBlocks(
        {
            miniGameState = miniGameState,
            availWords = miniGameState.words
        }
    )

    return clonedLetterFallModel
end

return module

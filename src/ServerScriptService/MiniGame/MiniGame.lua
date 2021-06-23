local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local LetterFallUtils = require(Sss.Source.LetterFall.LetterFallUtils)
local InitLetterRack = require(Sss.Source.LetterFall.InitLetterRack)
local InitWord = require(Sss.Source.LetterFall.InitWord)
local HandleClick = require(Sss.Source.LetterFall.HandleClick)

local module = {}

function module.addMiniGame(props)
    local parentFolder = props.parentFolder
    -- local parent = props.parent
    local positioner = props.positioner
    local questIndex = props.questIndex
    local words = props.words

    local letterFallTemplate = Utils.getFromTemplates('LetterFallTemplate-001')
    if not letterFallTemplate then
        return
    end

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
        foundWordLettersBlocks = {},
        foundRackLettersBlocks = {},
        foundWords = {},
        renderedWords = {},
        wordLetters = {},
        words = words,
        positioner = positioner,
        questIndex = questIndex
    }

    local clonedLetterFallModel = letterFallTemplate:Clone()
    clonedLetterFallModel.Name = clonedLetterFallModel.Name .. 'Clone' .. '-Q'

    miniGameState.letterFallFolder = Utils.getFirstDescendantByName(clonedLetterFallModel, 'LetterFallFolder')
    clonedLetterFallModel.Parent = parentFolder
    miniGameState.clonedLetterFallModel = clonedLetterFallModel

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = positioner,
            childModel = clonedLetterFallModel,
            offsetConfig = {
                useParentNearEdge = Vector3.new(0, -1, 0),
                useChildNearEdge = Vector3.new(0, -1, 0)
            }
        }
    )

    HandleClick.initClickHandler(miniGameState)
    InitLetterRack.initLetterRack(miniGameState)
    InitWord.initWords(miniGameState)
    LetterFallUtils.createBalls(miniGameState)

    LetterFallUtils.styleLetterBlocks(
        {
            miniGameState = miniGameState,
            availWords = miniGameState.words
        }
    )

    return clonedLetterFallModel
end

return module

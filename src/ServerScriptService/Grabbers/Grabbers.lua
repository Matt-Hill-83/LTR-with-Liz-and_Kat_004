local Sss = game:GetService('ServerScriptService')
local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local module = {}

function module.initGrabbers(props)
    local parentFolder = props.parentFolder

    local positioners =
        Utils.getByTagInParent(
        {
            parent = parentFolder,
            tag = 'LetterGrabberPositioner'
        }
    )

    for _, positioner in ipairs(positioners) do
        local grabbersConfig = {
            word = positioner.Name,
            parentFolder = parentFolder,
            positioner = positioner
        }

        LetterGrabber.initLetterGrabber(grabbersConfig)
    end
end

function module.getLetterMatrix(props)
    local levelConfig = props.levelConfig
    local numRods = props.numRods

    local signTargetWords = levelConfig.getTargetWords()[1]
    local words = {}
    for _, word in ipairs(signTargetWords) do
        table.insert(words, word.word)
    end

    local letterMatrix = LetterUtils.createRandomLetterMatrix({words = words, numBlocks = numRods})
    return letterMatrix
end

function module.initPlayerGrabber(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig

    local miniGameState = {
        activeStyle = 'BD_available',
        inActiveStyle = 'BD_not_available', -- Rack starts with this one:
        --
        activeWord = nil,
        activeWordIndex = 1,
        availLetters = {},
        availWords = {},
        currentLetterIndex = 1,
        foundLetters = {},
        initCompleted = false,
        rackLetterBlockObjs = {},
        renderedWords = {}
        -- sectorConfig = sectorConfig,
        -- rackLetterSize = rackLetterSize,
        -- sectorFolder = sectorFolder,
        -- wordLetterSize = 16,
    }
    -- miniGameState.words = words
end

return module

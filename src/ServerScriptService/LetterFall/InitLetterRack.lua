local CS = game:GetService('CollectionService')
local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local LetterFallUtils = require(Sss.Source.LetterFall.LetterFallUtils)

local module = {}

function isDeadLetter(props)
    local rowIndex = props.rowIndex
    local colIndex = props.colIndex
    local deadLetters = props.deadLetters

    local isDead = false
    for i, deadLetter in ipairs(deadLetters) do
        if deadLetter.row == rowIndex and deadLetter.col == colIndex then
            isDead = true
            break
        end
    end
    return isDead
end

function generateDeadLetters(props)
    local numCol = props.numCol
    local numRow = props.numRow
    local lettersPerCol = props.lettersPerCol

    local output = {}
    for colIndex = 2, numCol do
        for letterIndex = 1, lettersPerCol do
            local rowIndex = Utils.genRandom(1, numRow)
            table.insert(output, {row = rowIndex, col = colIndex})
        end
    end
    return output
end

function initLetterRack(miniGameState)
    local runTimeLetterFolder = LetterFallUtils.getRunTimeLetterFolder(miniGameState)
    miniGameState.runTimeLetterFolder = runTimeLetterFolder

    local letterFallFolder = miniGameState.letterFallFolder
    local letterRackFolder = Utils.getFirstDescendantByName(letterFallFolder, 'LetterRackFolder')
    local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')

    local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LBRack2')
    local letterPositioner = Utils.getFirstDescendantByName(letterRackFolder, 'RackLetterBlockPositioner')
    local pCBaseTemplate = Utils.getFirstDescendantByName(letterRackFolder, 'PCBase')

    local numRow = 10
    -- local numRow = 30
    local numCol = 9
    local spacingFactorX = 1.01
    local spacingFactorY = 1.0

    local lettersFromWords = {}
    for wordIndex, word in ipairs(miniGameState.words) do
        for letterIndex = 1, #word do
            local letter = string.sub(word, letterIndex, letterIndex + 0)
            table.insert(lettersFromWords, letter)
            table.insert(lettersFromWords, letter)
            table.insert(lettersFromWords, letter)
            table.insert(lettersFromWords, letter)
            table.insert(lettersFromWords, letter)
            table.insert(lettersFromWords, letter)
            table.insert(lettersFromWords, letter)
        end
    end

    local deadLetters =
        generateDeadLetters(
        {
            numCol = numCol,
            numRow = numRow,
            lettersPerCol = 2
        }
    )

    for colIndex = 1, numCol do
        local newPCBase = pCBaseTemplate:Clone()
        newPCBase.Parent = pCBaseTemplate.Parent

        local letterHeight = letterBlockTemplate.Size.X
        local letterPosX = -letterHeight * (colIndex - 1) * spacingFactorX
        newPCBase.Size = pCBaseTemplate.Size
        -- newPCBase.CFrame = letterPositioner.CFrame * CFrame.new(Vector3.new(letterPosX, 0, 0))
        Utils3.setCFrameFromDesiredEdgeOffset2(
            {
                parent = letterPositioner,
                child = newPCBase,
                childIsPart = true,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = Vector3.new(letterPosX, 0, 0)
                }
            }
        )

        local pcBaseAtt = newPCBase.Attachment

        for rowIndex = 1, numRow do
            local rand = Utils.genRandom(1, #lettersFromWords)

            local char = lettersFromWords[rand]
            local newLetter = letterBlockTemplate:Clone()

            local newLetterPC = newLetter.PrismaticConstraint
            newLetterPC.Attachment1 = pcBaseAtt

            LetterFallUtils.applyStyleFromTemplate(
                {
                    targetLetterBlock = newLetter,
                    templateName = 'LBPurpleLight',
                    miniGameState = miniGameState
                }
            )
            local letterId = 'ID--R' .. rowIndex .. 'C' .. colIndex
            local name = 'rackLetter-' .. char .. '-' .. letterId .. 'zzzzz'
            newLetter.Name = name

            local isDeadLetter =
                isDeadLetter(
                {
                    rowIndex = rowIndex,
                    colIndex = colIndex,
                    deadLetters = deadLetters
                }
            )

            CS:AddTag(newLetter, LetterFallUtils.tagNames.RackLetter)
            if isDeadLetter then
                CS:AddTag(newLetter, LetterFallUtils.tagNames.DeadLetter)
            else
                CS:AddTag(newLetter, LetterFallUtils.tagNames.NotDeadLetter)
            end

            LetterFallUtils.applyLetterText({letterBlock = newLetter, char = char})

            local offsetY = (newLetter.Size.Y - letterPositioner.Size.Y) / 2
            local letterPosY = newLetter.Size.Y * (rowIndex - 1) * spacingFactorY + offsetY

            Utils3.setCFrameFromDesiredEdgeOffset2(
                {
                    parent = newPCBase,
                    child = newLetter,
                    childIsPart = true,
                    offsetConfig = {
                        useParentNearEdge = Vector3.new(0, 1, 0),
                        useChildNearEdge = Vector3.new(0, -1, 0),
                        offsetAdder = Vector3.new(0, letterPosY, 0)
                    }
                }
            )

            newLetter.Parent = runTimeLetterFolder
            newLetter.Anchored = true
        end
    end

    LetterFallUtils.configDeadLetters(
        {
            parentFolder = runTimeLetterFolder,
            miniGameState = miniGameState
        }
    )
end

module.initLetterRack = initLetterRack

return module

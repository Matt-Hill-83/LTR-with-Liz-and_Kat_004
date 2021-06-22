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
    local positioner = miniGameState.positioner
    print('positioner' .. ' - start=============================')
    print(positioner)

    local letterRackFolder = Utils.getFirstDescendantByName(letterFallFolder, 'LetterRackFolder')
    local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')

    -- local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LBRack2')
    local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LBRack_3')
    local letterPositioner = Utils.getFirstDescendantByName(letterRackFolder, 'RackLetterBlockPositioner')
    local pCBaseTemplate = Utils.getFirstDescendantByName(letterRackFolder, 'PCBase')
    local gemTemplate = Utils.getFirstDescendantByName(letterRackFolder, 'GemModel')

    --
    --
    local letterFallBase = Utils.getFirstDescendantByName(letterFallFolder, 'LetterFallBase')
    local footerRight = Utils.getFirstDescendantByName(letterFallFolder, 'FooterRight')

    print('letterFallBase' .. ' - start======================')
    print(letterFallBase)
    print('footerRight' .. ' - start========================')
    print(footerRight)

    local frameFolder = Utils.getFirstDescendantByName(letterRackFolder, 'Frame')
    local frameBottom = Utils.getFirstDescendantByName(frameFolder, 'Bottom')
    local frameLeft = Utils.getFirstDescendantByName(frameFolder, 'Left')
    local frameRight = Utils.getFirstDescendantByName(frameFolder, 'Right')
    local frameBack = Utils.getFirstDescendantByName(frameFolder, 'Back')
    local frameTop = Utils.getFirstDescendantByName(frameFolder, 'Top')
    local frameFront = Utils.getFirstDescendantByName(frameFolder, 'InvisibleFront')

    local numRow = positioner.Size.Y / 3
    local numCol = positioner.Size.Z / 3
    -- local numRow = 10
    -- local numCol = 8
    local spacingFactorX = 1.01
    local spacingFactorY = 1.0
    local rackPadding = 0.2
    local letterHeight = letterBlockTemplate.Size.X
    local wallThickness = 0.5

    local rackSizeZ =
        wallThickness * 2 + rackPadding * 2 + (numCol - 1) * spacingFactorX * letterHeight + (letterHeight)

    local rackSizeX = wallThickness * 2 + rackPadding * 2 + letterHeight
    local rackSizeY = wallThickness * 2 + rackPadding * 2 + (numRow + 1) * letterHeight * spacingFactorY

    frameBottom.Size = Vector3.new(rackSizeX, wallThickness, rackSizeZ)
    frameTop.Size = frameBottom.Size
    frameLeft.Size = Vector3.new(rackSizeX, rackSizeY, wallThickness)
    frameRight.Size = frameLeft.Size
    frameBack.Size = Vector3.new(wallThickness, rackSizeY, rackSizeZ)
    frameFront.Size = frameBack.Size
    frameFront.Transparency = 1
    -- frameFront.Transparency = 0.7

    local edgeOffset = rackPadding + wallThickness
    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = frameBottom,
            child = letterPositioner,
            childIsPart = true,
            offsetConfig = {
                useParentNearEdge = Vector3.new(-1, 1, -1),
                useChildNearEdge = Vector3.new(-1, -1, -1),
                offsetAdder = Vector3.new(edgeOffset, 0, edgeOffset)
            }
        }
    )

    local topOffset = (numRow + 1) * letterHeight * spacingFactorY + 2 * wallThickness

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = frameBottom,
            child = frameTop,
            childIsPart = true,
            offsetConfig = {
                useParentNearEdge = Vector3.new(0, 0, 0),
                useChildNearEdge = Vector3.new(0, 0, 0),
                offsetAdder = Vector3.new(0, topOffset, 0)
            }
        }
    )

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = frameTop,
            childModel = gemTemplate,
            -- childIsPart = false,
            offsetConfig = {
                useParentNearEdge = Vector3.new(0, 0, 0),
                useChildNearEdge = Vector3.new(0, 0, 0),
                offsetAdder = Vector3.new(0, -letterHeight, 0)
            }
        }
    )

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = frameBottom,
            child = frameLeft,
            childIsPart = true,
            offsetConfig = {
                useParentNearEdge = Vector3.new(-1, -1, -1),
                useChildNearEdge = Vector3.new(-1, -1, -1),
                offsetAdder = Vector3.new(0, 0, 0)
            }
        }
    )

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = frameBottom,
            child = frameRight,
            childIsPart = true,
            offsetConfig = {
                useParentNearEdge = Vector3.new(-1, -1, 1),
                useChildNearEdge = Vector3.new(-1, -1, 1),
                offsetAdder = Vector3.new(0, 0, 0)
            }
        }
    )

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = frameBottom,
            child = frameBack,
            childIsPart = true,
            offsetConfig = {
                useParentNearEdge = Vector3.new(1, -1, 1),
                useChildNearEdge = Vector3.new(1, -1, 1),
                offsetAdder = Vector3.new(0, 0, 0)
            }
        }
    )

    Utils3.setCFrameFromDesiredEdgeOffset2(
        {
            parent = frameBottom,
            child = frameFront,
            childIsPart = true,
            offsetConfig = {
                useParentNearEdge = Vector3.new(-1, -1, 1),
                useChildNearEdge = Vector3.new(-1, -1, 1),
                offsetAdder = Vector3.new(0, 0, 0)
            }
        }
    )

    -- Utils3.setCFrameFromDesiredEdgeOffset2(
    --     {
    --         parent = frameBottom,
    --         child = footerRight,
    --         childIsPart = true,
    --         offsetConfig = {
    --             useParentNearEdge = Vector3.new(-1, 1, 1),
    --             useChildNearEdge = Vector3.new(-1, -1, -1)
    --             -- offsetAdder = Vector3.new(10, 10, 100)
    --         }
    --     }
    -- )

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

        -- local letterHeight = letterBlockTemplate.Size.X
        local letterPosZ = letterHeight * (colIndex - 1) * spacingFactorX
        -- local letterPosZ = letterHeight * (colIndex - 1) * spacingFactorX + wallThickness
        newPCBase.Size = pCBaseTemplate.Size

        Utils3.setCFrameFromDesiredEdgeOffset2(
            {
                parent = letterPositioner,
                child = newPCBase,
                childIsPart = true,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = Vector3.new(0, 0, letterPosZ)
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

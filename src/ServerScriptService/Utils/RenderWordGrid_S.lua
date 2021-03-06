local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local ImageConst = require(Sss.Source.Constants.Const_06_Images)

local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)

local module = {}

local renderGrid = function(props)
    local targetWords = props.targetWords
    local sgui = props.sgui
    local displayHeight = props.displayHeight
    local displayWidth = props.displayWidth
    local mainFramePosition = props.mainFramePosition
    local hideCounter = props.hideCounter
    local player = props.player

    local words = targetWords or {}

    local mainGui = sgui
    mainGui.Enabled = true
    local mainFrame = Utils.getFirstDescendantByName(mainGui, 'MainFrame')
    local messageFrame = Utils.getFirstDescendantByName(mainGui, 'MessageFrame')

    local longestWordLength = 0

    for _, word in ipairs(words) do
        if #word > longestWordLength then
            longestWordLength = #word
        end
    end

    local lettersInWord = 3
    local scrollBarThickness = 30
    local maxWordsInFrame = 8

    if (#words <= maxWordsInFrame) then
        scrollBarThickness = 0
    end

    local numWordsInFrame = math.min(maxWordsInFrame, #words)

    -- letter stuff
    local letterHeight = displayHeight / 20
    local letterWidth = letterHeight
    local letterGapX = letterWidth / 20
    local totalLetterWidth = letterWidth + letterGapX
    local letterBorderSizePixel = letterWidth / 10

    --

    local paddingInPx = letterHeight * 0.1
    -- local paddingInPx = 10
    local doublePad = paddingInPx * 2

    -- row stuff
    local rowGapY = paddingInPx / 2
    local rowHeight = letterHeight
    local totalRowHeight = letterHeight + rowGapY
    local foundLabelWidth = letterWidth * 1
    -- local foundLabelWidth = letterWidth * 2
    local totalFoundLabelWidth = foundLabelWidth + paddingInPx
    local wordWidth = (lettersInWord * letterWidth) + (lettersInWord - 1) * letterGapX

    local rowWidth
    if false then
        -- if hideCounter then
        rowWidth = wordWidth
    else
        rowWidth = wordWidth + totalFoundLabelWidth - paddingInPx
    end
    --  scroller stuff
    local scrollingFrame = Utils.getFirstDescendantByName(sgui, 'WordScroller')
    local scrollerWidth = rowWidth + scrollBarThickness + doublePad + 0
    local scrollerHeight = numWordsInFrame * totalRowHeight + paddingInPx
    local guiWidth = scrollerWidth + 0
    local guiHeight = scrollerHeight

    scrollingFrame.ScrollBarThickness = scrollBarThickness

    local fixRoundingError = 10
    scrollingFrame.Size = UDim2.new(0, scrollerWidth + fixRoundingError, 0, scrollerHeight)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 0)

    local scrollerCanvasHeight = #words * totalRowHeight + doublePad - rowGapY
    scrollingFrame.CanvasSize = UDim2.new(0, scrollerWidth - scrollBarThickness, 0, scrollerCanvasHeight)

    mainFrame.Size = UDim2.new(0, guiWidth, 0, guiHeight)
    local mainFrameY = displayHeight * 0.25 - mainFrame.Size.Y.Offset / 2

    local defaultPosition = UDim2.new(0, 0, 0, mainFrameY)
    mainFrame.Position = mainFramePosition or defaultPosition

    if messageFrame then
        messageFrame.Position = mainFrame.Position + UDim2.new(0, 0, 0, mainFrame.Size.Y.Offset)
    end

    --
    -- Gems frame stuff
    local gemsFrame = Utils.getFirstDescendantByName(mainGui, 'GemsFrame')
    if player then
        local gameState = PlayerStatManager.getGameState(player)
        local gemPoints = gameState.gemPoints

        if gemsFrame then
            local width = letterHeight * 1
            gemsFrame.Position = UDim2.new(0, displayWidth * 0.5 - width, 0, 0)
            gemsFrame.Size = UDim2.new(0, letterHeight * 2, 0, width)

            local gemsImageLabel = Utils.getFirstDescendantByType(gemsFrame, 'ImageLabel')
            local gemsTextLabel = Utils.getFirstDescendantByType(gemsFrame, 'TextBox')

            gemsTextLabel.Position = UDim2.new(0.5, 0, 0, 0)
            gemsTextLabel.Size = UDim2.new(0.5, 0, 1, 0)
            gemsTextLabel.Text = gemPoints or 0
            gemsTextLabel.TextScaled = true

            gemsImageLabel.Position = UDim2.new(0, 0, 0, 0)
            gemsImageLabel.Size = UDim2.new(0.5, 0, 1, 0)
            gemsImageLabel.Image = Utils.createImageUri(ImageConst.general.coin_dragon_001.imageId)
        end
    end
    Utils.addPadding(
        {
            parent = scrollingFrame,
            padding = paddingInPx,
            inPx = true
        }
    )

    local rowTemplate = Utils.getFirstDescendantByName(sgui, 'RowTemplate')
    rowTemplate.Visible = true
    rowTemplate.Position = UDim2.new(0, -100, 0, -100)
    local rowFolder =
        Utils.getOrCreateFolder(
        {
            name = 'RowFolder',
            parent = rowTemplate.Parent
        }
    )

    local oldRows = rowFolder:GetChildren()
    -- remove previously created rows
    for _, row in ipairs(oldRows) do
        row:Destroy()
    end

    for wordIndex, item in ipairs(words) do
        local word = item.word
        local newRow = rowTemplate:Clone()

        newRow.Parent = rowFolder
        newRow.Name = rowTemplate.Name .. '--row--ooo--' .. wordIndex
        newRow.Size = UDim2.new(0, rowWidth, 0, rowHeight)

        local rowOffsetY = (wordIndex - 1) * totalRowHeight
        newRow.Position = UDim2.new(0, 0, 0, rowOffsetY)

        local imageLabelTemplate = Utils.getFirstDescendantByName(newRow, 'BlockChar')

        for letterIndex = 1, #word do
            local letterNameStub = word .. '-L' .. letterIndex
            local char = string.sub(word, letterIndex, letterIndex)

            local newTextLabel = imageLabelTemplate:Clone()

            newTextLabel.Name = 'wordLetter-' .. letterNameStub
            newTextLabel.Size = UDim2.new(0, letterHeight, 0, letterHeight)
            newTextLabel.Position = UDim2.new(0, (letterIndex - 1) * totalLetterWidth, 0, 0)
            newTextLabel.Text = char
            newTextLabel.BorderSizePixel = letterBorderSizePixel

            -- Do this last to avoid tweening
            newTextLabel.Parent = newRow
        end
        imageLabelTemplate:Destroy()

        local gemFrame = newRow.Frame
        local imageLabelGem = newRow.Frame.ImageLabelGem
        imageLabelGem.Visible = true

        local textLabelGem = newRow.Frame.TextLabelGem
        textLabelGem.Visible = true

        local checkMark = Utils.createImageUri(ImageConst.general.check_mark_001.imageId)

        imageLabelGem.Visible = false
        textLabelGem.Visible = false
        if true then
            -- if not hideCounter then
            gemFrame.Position = UDim2.new(0, wordWidth + paddingInPx, 0, 0)
            gemFrame.Size = UDim2.new(0, letterHeight, 0, letterHeight)

            local newTextLabel = textLabelGem:Clone()
            newTextLabel.Visible = true
            newTextLabel.Parent = newRow

            if hideCounter then
                newTextLabel.Text = item.target
            else
                newTextLabel.Text = item.found .. ' of ' .. item.target
            end

            newTextLabel.Position = UDim2.new(0, wordWidth + paddingInPx, 0, 0)
            newTextLabel.Size = UDim2.new(0, letterHeight, 0, letterHeight)

            if item.found >= item.target then
                newTextLabel.TextYAlignment = 'Bottom'

                local newImageLabel = imageLabelGem:Clone()
                newImageLabel.Visible = true
                newImageLabel.Parent = newRow
                newImageLabel.Image = checkMark
                newImageLabel.Position = UDim2.new(0, wordWidth + paddingInPx, 0, 0)
                newImageLabel.Size = UDim2.new(0, letterHeight, 0, letterHeight)
                newImageLabel.ZIndex = 0
            end
        end
    end
    rowTemplate.Visible = false
    return {scrollingFrameSize = scrollingFrame.Size, scrollingFrame = scrollingFrame}
end

module.renderGrid = renderGrid
return module

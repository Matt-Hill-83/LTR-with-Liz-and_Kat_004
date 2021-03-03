local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local ImageConst = require(Sss.Source.Constants.Const_06_Images)
local module = {}

local renderGrid = function(props)
    local targetWords = props.targetWords
    local sgui = props.sgui
    local displayHeight = props.displayHeight
    local displayWidth = props.displayWidth
    local mainFramePosition = props.mainFramePosition

    local words = targetWords

    local mainGui = sgui
    mainGui.Enabled = true
    local mainFrame = Utils.getFirstDescendantByName(mainGui, 'MainFrame')

    local paddingInPx = 10
    local doublePad = paddingInPx * 2

    local lettersInWord = 3
    local scrollBarThickness = 30
    local maxWordsInFrame = 4

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

    -- row stuff
    local rowGapY = paddingInPx / 2
    local rowHeight = letterHeight
    local totalRowHeight = letterHeight + rowGapY
    local foundLabelWidth = letterWidth * 2
    local totalFoundLabelWidth = foundLabelWidth + paddingInPx
    local wordWidth = (lettersInWord * letterWidth) + (lettersInWord - 1) * letterGapX

    local rowWidth = wordWidth + totalFoundLabelWidth

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
    local mainFrameY = displayHeight / 2 - mainFrame.Size.Y.Offset / 2

    local defaultPosition = UDim2.new(0, 0, 0, mainFrameY)
    mainFrame.Position = mainFramePosition or defaultPosition

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
            name = 'RunTimeWordFolder',
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

        local gemHeight = letterHeight / 3
        local gemWidth = gemHeight
        local gemImageRed = Utils.createImageUri(ImageConst.general.gem_purple_001.imageId)
        local gemImageGrey = Utils.createImageUri(ImageConst.general.gem_grey_001.imageId)

        gemFrame.Position = UDim2.new(0, wordWidth + paddingInPx, 0, 0)
        gemFrame.Size = UDim2.new(0, letterHeight, 0, letterHeight)

        if item.found >= item.target then
            local newImageLabel = imageLabelGem:Clone()
            newImageLabel.Parent = newRow
            newImageLabel.Image = gemImageRed
            newImageLabel.Position = UDim2.new(0, wordWidth + paddingInPx, 0, 0)
            newImageLabel.Size = UDim2.new(0, letterHeight, 0, letterHeight)
        else
            -- Only create blanks for as many as are required
            local numGemsCreated = 0

            local numRow = 3
            local numCol = 3

            local gemNum = 1
            for rowIndex = 0, numRow - 1 do
                local positionY = rowIndex * gemHeight + 0
                for colIndex = 0, numCol - 1 do
                    if numGemsCreated < item.target then
                        local positionX = colIndex * gemWidth + paddingInPx
                        local newImageLabel = imageLabelGem:Clone()
                        newImageLabel.Parent = newRow

                        local gemImage = gemNum <= item.found and gemImageRed or gemImageGrey
                        newImageLabel.Image = gemImage
                        newImageLabel.Position = UDim2.new(0, wordWidth + positionX, 0, positionY)
                        newImageLabel.Size = UDim2.new(0, gemWidth, 0, gemHeight)
                        gemNum = gemNum + 1
                        numGemsCreated = numGemsCreated + 1
                    end
                end
            end
        end
        imageLabelGem.Visible = false
    end
    rowTemplate.Visible = false
end

-- function module.getGemFrame()
--     --
-- end

module.renderGrid = renderGrid
return module

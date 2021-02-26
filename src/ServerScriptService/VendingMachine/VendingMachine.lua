local Sss = game:GetService('ServerScriptService')
local SGUI = game:GetService('StarterGui')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local RenderWordGrid = require(Sss.Source.Utils.RenderWordGrid_S)
local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)

local module = {}

function module.initVendingMachine(props)
    local parentFolder = props.parentFolder

    local vendingMachines = Utils.getByTagInParent({parent = parentFolder, tag = 'M-VendingMachine'})
    for _, vendingMachine in ipairs(vendingMachines) do
        local guiPart = Utils.getFirstDescendantByName(vendingMachine, 'GuiPart')
        local sgui = Utils.getFirstDescendantByName(vendingMachine, 'GuiVend')

        local levelConfig = LevelConfigs.levelConfigs[1]
        local targetWords = levelConfig.getTargetWords()

        local mainFrame = Utils.getFirstDescendantByName(SGUI, 'MainFrame')
        local newFrame = mainFrame:Clone()
        newFrame.Parent = sgui

        local pixelsPerStud = 50
        local scalingFactor = 1
        -- local scalingFactor = 1.8

        local displayHeight = guiPart.Size.Y * pixelsPerStud * scalingFactor

        local mainFrameY = displayHeight - mainFrame.Size.Y.Offset
        local mainFramePosition = UDim2.new(0, 0, 0, 0)

        RenderWordGrid.renderGrid(
            {
                sgui = sgui,
                targetWords = targetWords,
                levelConfig = levelConfig,
                displayHeight = displayHeight,
                mainFramePosition = mainFramePosition
            }
        )
    end
end

return module

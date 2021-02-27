local Sss = game:GetService('ServerScriptService')
local SGUI = game:GetService('StarterGui')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local RenderWordGrid = require(Sss.Source.Utils.RenderWordGrid_S)

local module = {}

function module.initVendingMachine(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig

    local vendingMachines = Utils.getByTagInParent({parent = parentFolder, tag = 'M-VendingMachine'})
    for vendingMachineIndex, vendingMachine in ipairs(vendingMachines) do
        local guiPart = Utils.getFirstDescendantByName(vendingMachine, 'GuiPart')
        local sgui = Utils.getFirstDescendantByName(vendingMachine, 'GuiVend')

        local targetWordIndex = levelConfig.vendingMachines[vendingMachineIndex]['targetWordIndex']
        local targetWords = levelConfig.getTargetWords()[targetWordIndex]

        local mainFrame = Utils.getFirstDescendantByName(SGUI, 'MainFrame')
        local newFrame = mainFrame:Clone()
        newFrame.Parent = sgui

        local pixelsPerStud = 50
        -- local scalingFactor = 1
        local scalingFactor = 1.7

        local displayHeight = guiPart.Size.Y * pixelsPerStud * scalingFactor

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

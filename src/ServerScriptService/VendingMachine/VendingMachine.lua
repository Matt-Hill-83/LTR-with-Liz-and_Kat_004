local Sss = game:GetService('ServerScriptService')
local SGUI = game:GetService('StarterGui')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local RenderWordGrid = require(Sss.Source.Utils.RenderWordGrid_S)

local ReplicatorFactory = require(Sss.Source.ReplicatorFactory.ReplicatorFactory)

local module = {}

function module.initVendingMachine(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig

    local vendingMachines = Utils.getByTagInParent({parent = parentFolder, tag = 'M-VendingMachine'})
    for vendingMachineIndex, vendingMachine in ipairs(vendingMachines) do
        local guiPart = Utils.getFirstDescendantByName(vendingMachine, 'GuiPart')
        local hitBox = Utils.getFirstDescendantByName(vendingMachine, 'HitBox')
        local replicatorPositioner = Utils.getFirstDescendantByName(vendingMachine, 'ReplicatorPositioner')
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

        local rewardTemplate = Utils.getFromTemplates('CupcakeToolTemplate')
        ReplicatorFactory.initReplicators(
            {parentFolder = parentFolder, positionerModel = replicatorPositioner, rewardTemplate = rewardTemplate}
        )

        local function hitBoxTouched()
            print('test')
            print('test')
            print('test')
        end

        hitBox.Touched:Connect(Utils.onTouchHuman(hitBox, hitBoxTouched))
    end
end

return module

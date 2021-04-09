local Sss = game:GetService('ServerScriptService')
local SGUI = game:GetService('StarterGui')
local ServerStorage = game:GetService('ServerStorage')
local Players = game:GetService('Players')

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local RenderWordGrid = require(Sss.Source.Utils.RenderWordGrid_S)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
-- local ReplicatorFactory = require(Sss.Source.ReplicatorFactory.ReplicatorFactory)

local module = {}

function module.initVendingMachine_002(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig
    local onComplete = props.onComplete
    local tag = props.tag

    local vendingMachines = Utils.getByTagInParent({parent = parentFolder, tag = tag})
    print('vendingMachines' .. ' - start')
    print('vendingMachines' .. ' - start')
    print('vendingMachines' .. ' - start')
    print('vendingMachines' .. ' - start')
    print(vendingMachines)
    for vendingMachineIndex, vendingMachine in ipairs(vendingMachines) do
        local guiPart = Utils.getFirstDescendantByName(vendingMachine, 'GuiPart')
        local hitBox = Utils.getFirstDescendantByName(vendingMachine, 'HitBox')

        local sgui = Utils.getFirstDescendantByName(vendingMachine, 'GuiVend')

        if not levelConfig.vendingMachines then
            return
        end
        local targetWordIndex = levelConfig.vendingMachines[vendingMachineIndex]['targetWordIndex']
        local signTargetWords = levelConfig.getTargetWords()[targetWordIndex]
        print('signTargetWords----------------' .. ' - start')
        print(signTargetWords)

        local mainFrame = Utils.getFirstDescendantByName(SGUI, 'MainFrame')
        local newFrame = mainFrame:Clone()
        newFrame.Parent = sgui

        local pixelsPerStud = 50
        local scalingFactor = 1.7

        local displayHeight = guiPart.Size.Y * pixelsPerStud * scalingFactor

        local mainFramePosition = UDim2.new(0, 0, 0, 0)

        local test =
            RenderWordGrid.renderGrid(
            {
                sgui = sgui,
                targetWords = signTargetWords,
                levelConfig = levelConfig,
                displayHeight = displayHeight,
                mainFramePosition = mainFramePosition,
                hideCounter = true
            }
        )

        print('test.scrollingFrameSize' .. ' - start')
        print(test.scrollingFrameSize)

        local pixelsPerStud2 = test.scrollingFrame.Parent.Parent.PixelsPerStud
        guiPart.Size =
            Vector3.new(
            test.scrollingFrameSize.X.Offset / pixelsPerStud2,
            test.scrollingFrameSize.Y.Offset / pixelsPerStud2,
            guiPart.Size.z
        )

        local function hitBoxTouched(touchedBlock, player)
            local gameState = PlayerStatManager.getGameState(player)
            local targetWords = gameState.targetWords
            local gateOpened = false

            local cardComplete = true

            for _, word in ipairs(targetWords) do
                if word.found ~= word.target then
                    cardComplete = false
                end
            end

            if cardComplete then
                if gateOpened == true then
                    return
                end
                gateOpened = true

                local keyWalls = Utils.getDescendantsByName(vendingMachine, 'KeyWall')
                local fires = Utils.getDescendantsByName(vendingMachine, 'Fire')

                -- local explosionSound = '262562442'
                -- Utils.playSound(explosionSound, 0.02)

                for _, keyWall in ipairs(keyWalls) do
                    if keyWall then
                        LetterUtils.styleImageLabelsInBlock(keyWall, {Visible = false})
                        keyWall.CanCollide = false
                        keyWall.Transparency = 1
                    end
                end

                for _, fire in ipairs(fires) do
                    if fire then
                        fire.Enabled = true
                    end
                end

                local function revertStyles()
                    for _, keyWall in ipairs(keyWalls) do
                        if keyWall then
                            LetterUtils.styleImageLabelsInBlock(keyWall, {Visible = true})
                            keyWall.CanCollide = true
                            keyWall.Transparency = 1
                        end
                    end

                    for _, fire in ipairs(fires) do
                        if fire then
                            fire.Enabled = false
                        end
                    end
                    gateOpened = false
                end

                delay(10, revertStyles)
                if onComplete then
                    onComplete(player)
                end
            end
        end

        hitBox.Touched:Connect(Utils.onTouchHuman(hitBox, hitBoxTouched))
    end
end

return module

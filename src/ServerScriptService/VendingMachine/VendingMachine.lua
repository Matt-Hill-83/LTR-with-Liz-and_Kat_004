local Sss = game:GetService('ServerScriptService')
local SGUI = game:GetService('StarterGui')
local ServerStorage = game:GetService('ServerStorage')
local Players = game:GetService('Players')

local Constants = require(Sss.Source.Constants.Constants)

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local RenderWordGrid = require(Sss.Source.Utils.RenderWordGrid_S)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local ReplicatorFactory = require(Sss.Source.ReplicatorFactory.ReplicatorFactory)
local TeleportModule = require(ServerStorage.Source.TeleportModule)

local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)

local module = {}

function module.initTeleporter(part, nextLevelId)
    print('nextLevelId' .. ' - start')
    print(nextLevelId)
    if not part then
        return
    end
    local teleportPart = part

    local function onPartTouch(otherPart)
        -- Get player from character
        local player = Players:GetPlayerFromCharacter(otherPart.Parent)

        if player and not player:GetAttribute('Teleporting') then
            player:SetAttribute('Teleporting', true)

            -- Teleport the player
            local teleportResult = TeleportModule.teleportWithRetry(nextLevelId, {player})

            player:SetAttribute('Teleporting', nil)
        end
    end

    teleportPart.Touched:Connect(onPartTouch)
end

function module.initVendingMachine(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig
    local nextLevelId = props.nextLevelId

    local vendingMachines = Utils.getByTagInParent({parent = parentFolder, tag = 'M-VendingMachine'})
    for vendingMachineIndex, vendingMachine in ipairs(vendingMachines) do
        local guiPart = Utils.getFirstDescendantByName(vendingMachine, 'GuiPart')
        local hitBox = Utils.getFirstDescendantByName(vendingMachine, 'HitBox')
        local teleporter = Utils.getFirstDescendantByName(vendingMachine, 'Teleporter')

        module.initTeleporter(teleporter, nextLevelId)
        -- module.initTeleporter(teleporter, levelConfig.teleporter)
        local replicatorPositioner = Utils.getFirstDescendantByName(vendingMachine, 'ReplicatorPositioner')
        local sgui = Utils.getFirstDescendantByName(vendingMachine, 'GuiVend')

        local targetWordIndex = levelConfig.vendingMachines[vendingMachineIndex]['targetWordIndex']
        local signTargetWords = levelConfig.getTargetWords()[targetWordIndex]

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
                targetWords = signTargetWords,
                levelConfig = levelConfig,
                displayHeight = displayHeight,
                mainFramePosition = mainFramePosition
            }
        )

        local rewardTemplate = Utils.getFromTemplates('CupcakeToolTemplate')
        ReplicatorFactory.initReplicators(
            {parentFolder = parentFolder, positionerModel = replicatorPositioner, rewardTemplate = rewardTemplate}
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
                local explosionSound = '262562442'

                Utils.playSound(explosionSound, 0.25)

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
            end
        end

        hitBox.Touched:Connect(Utils.onTouchHuman(hitBox, hitBoxTouched))
    end
end

return module

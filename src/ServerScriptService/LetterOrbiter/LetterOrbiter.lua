local Sss = game:GetService('ServerScriptService')
local SGUI = game:GetService('StarterGui')

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local RenderWordGrid = require(Sss.Source.Utils.RenderWordGrid_S)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local ReplicatorFactory = require(Sss.Source.ReplicatorFactory.ReplicatorFactory)
local AddModelFromPositioner = require(Sss.Source.AddModelFromPositioner.AddModelFromPositioner)

local module = {}

function module.initLetterOrbiter(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig

    print('parentFolder------------------------' .. ' - start')
    print('parentFolder------------------------' .. ' - start')
    print('parentFolder------------------------' .. ' - start')
    print(parentFolder)
    -- local vendingMachines = Utils.getByTagInParent({parent = parentFolder, tag = 'M-VendingMachine'})
    local letterOrbiterPositioners = Utils.getDescendantsByName(parentFolder, 'LetterOrbiterPositioner')
    print('letterOrbiterPositioners' .. ' - start')
    print(letterOrbiterPositioners)

    -- local packageId = '6367502314'
    -- local f = Instance.new('Folder', workspace)
    -- f.Name = packageId
    -- for _, id in pairs(game:GetService('AssetService'):GetAssetIdsForPackage(packageId)) do
    --     local m = game:GetService('InsertService'):LoadAsset(id)
    --     m.Name = id
    --     m.Parent = f
    -- end

    for _, letterOrbiterPositioner in ipairs(letterOrbiterPositioners) do
        print('letterOrbiterPositioner++++++++++++' .. ' - start')
        print(letterOrbiterPositioner)
        local newOrbiter =
            AddModelFromPositioner.addModel(
            {
                parentFolder = parentFolder,
                templateName = 'Orbiter_003',
                positionerModel = letterOrbiterPositioner,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = Vector3.new(0, 0, 0)
                }
            }
        )

        newOrbiter.Name = 'lll'
        local orbiterPart = newOrbiter.Disc

        local A = 90
        local R = 20
        local P = Vector3.new(0, 0, 0)
        local x = R * math.cos(A)
        local y = R * math.sin(A)
        local X = P + Vector3.new(x, 0, y)

        local test = Instance.new('Part', workspace)
        test.Position = X
        test.Name = 'zzz'
        test.Anchored = false

        test.CFrame =
            Utils3.setCFrameFromDesiredEdgeOffset(
            {
                parent = orbiterPart,
                child = test,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(1, 0, 0),
                    useChildNearEdge = Vector3.new(1, 0, 0),
                    offsetAdder = Vector3.new(0, 0, 0)
                }
            }
        )

        Utils.weld2Parts(orbiterPart, test)
    end

    -- (CFrame.new(P) * CFrame.Angles(0, A, 0) + CFrame.new(0, 0, -R)).Position

    if false then
        for vendingMachineIndex, vendingMachine in ipairs(letterOrbiterPositioners) do
            local guiPart = Utils.getFirstDescendantByName(vendingMachine, 'GuiPart')
            local hitBox = Utils.getFirstDescendantByName(vendingMachine, 'HitBox')
            local teleporter = Utils.getFirstDescendantByName(vendingMachine, 'Teleporter')

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
                -- if #targetWords == 0 then
                --     return
                -- end
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

                    Utils.playSound(explosionSound, 0.1)

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
end

return module

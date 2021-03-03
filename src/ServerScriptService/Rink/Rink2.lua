local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)
local StrayLetterBlocks = require(Sss.Source.StrayLetterBlocks.StrayLetterBlocks)
local InvisiWall = require(Sss.Source.InvisiWall.InvisiWall2)

local module = {}

function module.initPuck(puck)
    local thrust = Instance.new('BodyThrust', puck)
    thrust.Force = Vector3.new(0, 0, 2000)

    local av = Instance.new('BodyAngularVelocity', puck)
    av.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
    av.AngularVelocity = Vector3.new(0, 1, 0)
    av.P = 1250
end

function module.addRink2(props)
    local bridgeConfig = props.bridgeConfig
    local bridge = props.bridge
    local parentFolder = props.parentFolder
    local size = props.size

    local a = Vector3.new(5, 10, 15)
    local b = Vector3.new(5, 10, 15)

    local rinkOrigSize = Vector3.new(bridge.Size.X, bridge.Size.Y, bridge.Size.Z)
    local rinkFinalSize = Vector3.new(bridge.Size.X * 4, 2, bridge.Size.Z)

    local cloneProps = {
        parentTo = bridge.Parent,
        positionToPart = bridge.PrimaryPart,
        templateName = 'Rink2_001',
        fromTemplate = true,
        modelToClone = nil,
        offsetConfig = {
            useParentNearEdge = Vector3.new(0, 1, 0),
            useChildNearEdge = Vector3.new(0, -1, 0),
            offsetAdder = Vector3.new(0, 0, 0)
        }
    }

    local rinkModel = Utils.cloneModel(cloneProps)
    local rinkPart = rinkModel.PrimaryPart

    local targets =
        Utils.getInstancesByNameStub(
        {
            nameStub = 'Target_',
            parent = rinkModel
        }
    )

    Utils.sortListByObjectKey(targets, 'Name')
    local targetAttachments = {}
    for targetIndex, target in ipairs(targets) do
        target:SetAttribute('TargetIndex', targetIndex)
        LetterUtils.createPropOnLetterBlock(
            {
                letterBlock = target,
                propName = LetterUtils.letterBlockPropNames.Type,
                initialValue = LetterUtils.letterBlockTypes.TargetLetter,
                propType = 'StringValue'
            }
        )

        local attachment = Utils.getFirstDescendantByType(target, 'Attachment')
        attachment.Name = targetIndex
        table.insert(targetAttachments, attachment)
    end

    rinkPart.Size = Vector3.new(size.X * 4, rinkPart.Size.Y, size.Z)

    local grabbers = bridgeConfig.itemConfig.grabbers or {}
    local words = bridgeConfig.itemConfig.words or grabbers

    for grabberIndex, grabberWord in ipairs(grabbers) do
        local offsetX = (grabberIndex - 1) * 10
        local positioner = Instance.new('Part', rinkModel)
        positioner.CFrame =
            Utils3.setCFrameFromDesiredEdgeOffset(
            {
                parent = rinkPart,
                child = positioner,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = Vector3.new(offsetX, 0, 0)
                }
            }
        )

        positioner.CFrame = positioner.CFrame * CFrame.Angles(0, math.rad(180), 0)
        local grabbersConfig = {
            word = grabberWord,
            parentFolder = parentFolder,
            positioner = positioner
        }

        local newGrabber = LetterGrabber.initLetterGrabber(grabbersConfig)
        positioner:Destroy()
    end

    local strayRegion = Utils.getFirstDescendantByName(rinkModel, 'StrayRegion')

    local blockTemplate = Utils.getFirstDescendantByName(rinkModel, 'Puck')
    local blockTemplatePart = blockTemplate.PrimaryPart

    local wordLength = 3
    local requiredLetters = #words * wordLength

    InvisiWall.setAllInvisiWalls(
        {
            thickness = 3,
            height = 2,
            shortHeight = 0,
            shortWallProps = {
                Transparency = 0,
                BrickColor = BrickColor.new('Light yellow'),
                Material = Enum.Material.Grass
            },
            wallProps = {
                Transparency = 0,
                BrickColor = BrickColor.new('Alder'),
                Material = Enum.Material.Granite
            },
            part = rinkModel.PrimaryPart
        }
    )

    local strays =
        StrayLetterBlocks.initStraysInRegion(
        {
            parentFolder = parentFolder,
            numBlocks = math.floor(requiredLetters * 1.2),
            words = words,
            region = strayRegion,
            blockTemplate = blockTemplatePart,
            onTouchBlock = function()
            end
        }
    )

    local function setTarget(part, targetIndex)
        local alignPosition = Utils.getFirstDescendantByType(part, 'AlignPosition')
        alignPosition.Attachment1 = targetAttachments[targetIndex]
    end

    local function partTouched(touchedBlock, otherPart)
        if Utils.hasProperty(otherPart, 'Type') then
            if otherPart.Type.Value ~= LetterUtils.letterBlockTypes.TargetLetter then
                return
            end
            local otherPartTargetIndex = otherPart:GetAttribute('TargetIndex', 1)
            local touchedBlockTargetIndex = touchedBlock:GetAttribute('TargetIndex', 1)

            if otherPartTargetIndex ~= touchedBlockTargetIndex then
                return
            end

            local targetIndex = touchedBlock:GetAttribute('TargetIndex')
            local newIndex = targetIndex + 0
            local newTargetIndex = (newIndex % #targetAttachments) + 1
            touchedBlock:SetAttribute('TargetIndex', newTargetIndex)
            setTarget(touchedBlock, newTargetIndex)
        end
    end

    for strayIndex, stray in ipairs(strays) do
        local alignPosition = Utils.getFirstDescendantByType(stray, 'AlignPosition')
        alignPosition.MaxVelocity = 30 + strayIndex * 2

        stray:SetAttribute('TargetIndex', 1)
        local targetIndex = stray:GetAttribute('TargetIndex')

        stray.CanCollide = true
        setTarget(stray, targetIndex)
        stray.Touched:Connect(Utils.onTouchBlock(stray, partTouched))

        -- This helps it break free when there is a traffic jam
        local av = Instance.new('BodyAngularVelocity', stray)
        av.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
        av.AngularVelocity = Vector3.new(0, 1, 0)
        av.P = 1250
    end
    blockTemplate:Destroy()
    bridge:Destroy()
    return rinkModel
end

return module

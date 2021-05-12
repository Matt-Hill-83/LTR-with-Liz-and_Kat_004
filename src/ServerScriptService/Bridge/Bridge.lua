local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Constants = require(Sss.Source.Constants.Constants)
local Configs = require(Sss.Source.Constants.Const_08_Configs)

local InvisiWall = require(Sss.Source.InvisiWall.InvisiWall2)
local SingleStrays = require(Sss.Source.SingleStrays.SingleStrays)
local Grabbers = require(Sss.Source.Grabbers.Grabbers)
local Rink = require(Sss.Source.Rink.Rink)
local Rink2 = require(Sss.Source.Rink.Rink2)

local module = {count = 0}

function module.getPointAlongLine(p0, p1, dist)
    local direction = (p1 - p0).Unit
    local distance = (p0 - p1).Magnitude

    local distanceOffset = distance * dist / 100
    local maxDistance = 64
    if distanceOffset > maxDistance then
        distanceOffset = maxDistance
    end

    local pNew = p0 + (direction * distanceOffset)
    return pNew
end

function module.getPointAlongLine2(p0, p1, dist)
    local direction = (p1 - p0).Unit
    local distance = (p0 - p1).Magnitude

    local distanceOffset = distance * dist / 100

    local pNew = p0 + (direction * distanceOffset)
    return pNew
end

function module.createBridge2(props)
    local templateName = props.templateName
    local parentFolder = props.parentFolder
    local char = props.char

    local bridgeConfig = props.bridgeConfig
    local straysOnBridges = bridgeConfig.straysOnBridges

    local offsetY = 15
    -- local offsetY = 12
    local p0 = props.p0 + Vector3.new(0, offsetY, 0)
    local p1 = props.p1 + Vector3.new(0, offsetY, 0)

    local p2 = module.getPointAlongLine(p0, p1, 20)
    local p3 = module.getPointAlongLine(p1, p0, 20)
    local midPoint = module.getPointAlongLine2(p0, p1, 50)

    local platformStart = Vector3.new(p2.X, midPoint.Y, p2.Z)
    local platformEnd = Vector3.new(p3.X, midPoint.Y, p3.Z)

    local bridge1 =
        module.createBridge(
        {
            p0 = p0,
            p1 = platformStart,
            templateName = templateName,
            parentFolder = parentFolder,
            bridgeConfig = bridgeConfig
        }
    )

    if bridge1 then
        local bridgeTop1 = Utils.getFirstDescendantByName(bridge1, 'Top')
        bridgeTop1.BrickColor = BrickColor.new('Alder')
        bridgeTop1.Material = 'Concrete'
    end

    local bridge2 =
        module.createBridge(
        {
            p0 = platformEnd,
            p1 = p1,
            templateName = templateName,
            parentFolder = parentFolder,
            bridgeConfig = bridgeConfig
        }
    )

    if bridge2 then
        local bridgeTop2 = Utils.getFirstDescendantByName(bridge2, 'Top')
        bridgeTop2.BrickColor = BrickColor.new('Alder')
        bridgeTop2.Material = 'Concrete'
    end

    local material = bridgeConfig.material or Enum.Material.Grass

    -- Utils.convertItemAndChildrenToTerrain({parent = bridge1, material = material, ignoreKids = false})
    -- Utils.convertItemAndChildrenToTerrain({parent = bridge2, material = material, ignoreKids = false})

    local newBridge =
        module.createBridge(
        {
            p0 = platformStart,
            p1 = platformEnd,
            templateName = templateName,
            parentFolder = parentFolder,
            bridgeConfig = bridgeConfig
        }
    )

    if newBridge then
        local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
        local blockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_8_blank_bridge')

        if straysOnBridges ~= false then
            SingleStrays.initSingleStrays(
                {
                    parentFolder = newBridge,
                    blockTemplate = blockTemplate,
                    char = char or '?'
                }
            )
        end
    end
    return newBridge
end

function module.createBridgeWalls(bridge, bridgeConfig)
    local bridgeTop = Utils.getFirstDescendantByName(bridge, 'Top')

    local function getWallProps(wall)
        local invisiWallProps = bridgeConfig.invisiWallProps or Configs.wallProps_default
        invisiWallProps.part = wall
        return invisiWallProps
    end

    InvisiWall.setInvisiWallLeft(getWallProps(bridgeTop))
    InvisiWall.setInvisiWallRight(getWallProps(bridgeTop))
end

function module.createBridge(props)
    local templateName = props.templateName
    local parentFolder = props.parentFolder
    local bridgeConfig = props.bridgeConfig

    local p0 = props.p0
    local p1 = props.p1
    local distance = (p0 - p1).Magnitude

    -- Don't make tiny bridges
    if distance < 2 then
        return nil
    end

    local bridgeTemplate = Utils.getFromTemplates(templateName)

    local newBridge = bridgeTemplate:Clone()
    newBridge.Parent = parentFolder
    local bridgePart = newBridge.PrimaryPart

    newBridge:SetPrimaryPartCFrame(CFrame.new(p0, p1) * CFrame.new(0, 0, -distance / 2))
    bridgePart.Size = Vector3.new(bridgePart.Size.X, bridgePart.Size.Y, distance)

    bridgePart.Anchored = true
    local wallFolder = Utils.getFirstDescendantByName(newBridge, 'Walls')
    local walls = wallFolder:getChildren()

    for _, wall in ipairs(walls) do
        wall.Size = Vector3.new(wall.Size.X, wall.Size.Y, distance)
    end
    module.createBridgeWalls(newBridge, bridgeConfig)

    return newBridge
end

function module.rodIsValid(rod)
    local isValid = false

    local hasAtt0 = Utils.hasProperty(rod, 'Attachment0')
    local hasAtt1 = Utils.hasProperty(rod, 'Attachment1')

    if hasAtt0 == true and hasAtt1 == true then
        local hasParent0 = Utils.hasProperty(rod.Attachment0, 'Parent')
        local hasParent1 = Utils.hasProperty(rod.Attachment1, 'Parent')
        if
            hasParent0 and hasParent1 and rod.Attachment0.Parent and rod.Attachment0.Parent.Position and
                rod.Attachment1.Parent and
                rod.Attachment1.Parent.Position
         then
            isValid = true
        end
    end

    if isValid then
        table.insert(Constants.validRods, rod)
        table.insert(Constants.validRodAttachments, rod.Attachment0)
        table.insert(Constants.validRodAttachments, rod.Attachment1)
    end
    return isValid
end

function module.initBridges_64(props)
    local parentFolder = props.parentFolder
    local bridgeConfigs = props.bridgeConfigs
    local levelConfig = props.levelConfig
    local templateName = props.templateName or 'Bridge'

    local rods =
        Utils.getInstancesByNameStub(
        {
            nameStub = 'RodConstraint',
            parent = parentFolder
        }
    )

    Utils.sortListByObjectKey(rods, 'Name')

    local letterMatrix = Grabbers.getLetterMatrix({levelConfig = levelConfig, numRods = #rods})

    local bridges = {}
    for rodIndex, rod in ipairs(rods) do
        local bridgeConfig = bridgeConfigs[1] or {}

        local rodValid = module.rodIsValid(rod)

        -- use mod to cycle thru configs when there are more positioners than configs
        local mod = (#letterMatrix + rodIndex - 1) % #letterMatrix
        local char = letterMatrix[mod + 1]

        if rodValid then
            local bridge =
                module.createBridge2(
                {
                    p0 = rod.Attachment0.Parent.Position,
                    p1 = rod.Attachment1.Parent.Position,
                    templateName = templateName,
                    parentFolder = parentFolder,
                    char = char,
                    bridgeConfig = bridgeConfig
                }
            )
            rod:Destroy()

            if bridge then
                local bridgeTop = Utils.getFirstDescendantByName(bridge, 'Top')

                if bridgeConfig.item == 'Rink' then
                    Utils.convertItemAndChildrenToTerrain(
                        {parent = bridgeTop, material = 'Air', ignoreKids = true, canCollide = true}
                    )
                    local rinkProps = {
                        bridgeConfig = bridgeConfig,
                        bridge = bridge,
                        parentFolder = parentFolder,
                        size = bridgeTop.Size
                    }
                    local newRink = Rink.addRink(rinkProps)
                elseif bridgeConfig.item == 'Rink2' then
                    Utils.convertItemAndChildrenToTerrain(
                        {parent = bridgeTop, material = 'Air', ignoreKids = true, canCollide = true}
                    )

                    local rinkProps = {
                        bridgeConfig = bridgeConfig,
                        bridge = bridge,
                        parentFolder = parentFolder,
                        size = bridgeTop.Size
                    }
                    local newRink = Rink2.addRink2(rinkProps)
                else
                    if bridgeConfig and bridgeConfig.material then
                        -- Utils.convertItemAndChildrenToTerrain(
                        --     {parent = bridgeTop, material = bridgeConfig.material, ignoreKids = false}
                        -- )
                    else
                        -- Utils.convertItemAndChildrenToTerrain(
                        --     {parent = bridgeTop, material = Enum.Material.Grass, ignoreKids = true}
                        -- )
                    end
                end
                table.insert(bridges, bridge)
            end
        end
    end
    return bridges
end

return module

local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local Rink = require(Sss.Source.Rink.Rink)
local Rink2 = require(Sss.Source.Rink.Rink2)

local module = {}

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
    -- local maxDistance = 64
    -- if distanceOffset > maxDistance then
    --     distanceOffset = maxDistance
    -- end

    local pNew = p0 + (direction * distanceOffset)
    return pNew
end

function module.createBridge2(props)
    print('createBridge2')
    local templateName = props.templateName
    local parentFolder = props.parentFolder
    local bridgeConfig = props.bridgeConfig

    local offsetY = 12
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
            parentFolder = parentFolder
        }
    )

    local bridge2 =
        module.createBridge(
        {
            p0 = platformEnd,
            p1 = p1,
            templateName = templateName,
            parentFolder = parentFolder
        }
    )

    local material = bridgeConfig.material or Enum.Material.Grass

    Utils.convertItemAndChildrenToTerrain({parent = bridge1, material = material, ignoreKids = false})
    Utils.convertItemAndChildrenToTerrain({parent = bridge2, material = material, ignoreKids = false})

    local newBridge =
        module.createBridge(
        {
            p0 = platformStart,
            p1 = platformEnd,
            templateName = templateName,
            parentFolder = parentFolder
        }
    )
    return newBridge
end

function module.createBridge(props)
    print('createBridge')
    local templateName = props.templateName
    local parentFolder = props.parentFolder
    local p0 = props.p0
    local p1 = props.p1

    local bridgeTemplate = Utils.getFromTemplates(templateName)

    local newBridge = bridgeTemplate:Clone()
    newBridge.Parent = parentFolder
    local bridgePart = newBridge.PrimaryPart

    local distance = (p0 - p1).Magnitude
    bridgePart.CFrame = CFrame.new(p0, p1) * CFrame.new(0, 0, -distance / 2)
    bridgePart.Size = Vector3.new(bridgePart.Size.X, bridgePart.Size.Y, distance)

    bridgePart.Anchored = true
    local wallFolder = Utils.getFirstDescendantByName(newBridge, 'Walls')
    local walls = wallFolder:getChildren()

    for _, wall in ipairs(walls) do
        wall.Size = Vector3.new(wall.Size.X, wall.Size.Y, distance)
    end
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

    return isValid
end

function module.initBridges(props)
    local parentFolder = props.parentFolder
    local bridgeConfigs = props.bridgeConfigs
    local templateName = props.templateName or 'Bridge'

    local rods =
        Utils.getInstancesByNameStub(
        {
            nameStub = 'RodConstraint',
            parent = parentFolder
        }
    )

    Utils.sortListByObjectKey(rods, 'Name')

    local bridges = {}
    for rodIndex, rod in ipairs(rods) do
        local bridgeConfig = bridgeConfigs[rodIndex] or {}

        local rodValid = module.rodIsValid(rod)

        if rodValid then
            local bridge =
                module.createBridge(
                {
                    p0 = rod.Attachment0.Parent.Position,
                    p1 = rod.Attachment1.Parent.Position,
                    templateName = templateName,
                    parentFolder = parentFolder
                }
            )
            rod:Destroy()
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
            else
                if bridgeConfig and bridgeConfig.material then
                    Utils.convertItemAndChildrenToTerrain(
                        {parent = bridgeTop, material = bridgeConfig.material, ignoreKids = false}
                    )
                else
                    Utils.convertItemAndChildrenToTerrain(
                        {parent = bridgeTop, material = Enum.Material.Grass, ignoreKids = true}
                    )
                end
            end
            table.insert(bridges, bridge)
        end
    end
    return bridges
end

-- 3 segment bridge
function module.initBridges2(props)
    local parentFolder = props.parentFolder
    local bridgeConfigs = props.bridgeConfigs
    local templateName = props.templateName or 'Bridge'

    local rods =
        Utils.getInstancesByNameStub(
        {
            nameStub = 'RodConstraint',
            parent = parentFolder
        }
    )

    Utils.sortListByObjectKey(rods, 'Name')

    local bridges = {}
    for rodIndex, rod in ipairs(rods) do
        local bridgeConfig = bridgeConfigs[rodIndex] or {}

        local rodValid = module.rodIsValid(rod)

        if rodValid then
            local bridge =
                module.createBridge2(
                {
                    p0 = rod.Attachment0.Parent.Position,
                    p1 = rod.Attachment1.Parent.Position,
                    templateName = templateName,
                    parentFolder = parentFolder,
                    bridgeConfig = bridgeConfig
                }
            )
            rod:Destroy()
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
                    Utils.convertItemAndChildrenToTerrain(
                        {parent = bridgeTop, material = bridgeConfig.material, ignoreKids = false}
                    )
                else
                    Utils.convertItemAndChildrenToTerrain(
                        {parent = bridgeTop, material = Enum.Material.Grass, ignoreKids = true}
                    )
                end
            end
            table.insert(bridges, bridge)
        end
    end
    return bridges
end

return module

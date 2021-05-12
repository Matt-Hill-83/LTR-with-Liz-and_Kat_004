local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local Bridge = require(Sss.Source.Bridge.Bridge)

local InvisiWall = require(Sss.Source.InvisiWall.InvisiWall2)
local SingleStrays = require(Sss.Source.SingleStrays.SingleStrays)

local Constants = require(Sss.Source.Constants.Constants)

local module = {}

function module.initJunctions(props)
    local parentFolder = props.parentFolder
    local positionerName = props.positionerName
    local hexTemplate = props.hexTemplate

    local levelConfig = props.levelConfig
    local hexConfigs = levelConfig.hexIslandConfigs

    local template = Utils.getFromTemplates(hexTemplate)
    if not hexConfigs then
        return
    end

    local hexIslandFolderBox = Utils.getFirstDescendantByName(parentFolder, 'HexIslands')
    if not hexIslandFolderBox then
        return
    end

    local hexIslandFolders = hexIslandFolderBox:getChildren()
    Utils.sortListByObjectKey(hexIslandFolders, 'Name')

    -- create bridges
    local bridgeConfigs = levelConfig.bridgeConfigs or {}

    local bridgeTemplate = 'Bridge_32'
    Bridge.initBridges_64(
        {
            parentFolder = hexIslandFolderBox,
            bridgeConfigs = bridgeConfigs,
            levelConfig = levelConfig,
            templateName = bridgeTemplate
        }
    )
    local positioners = Utils.getDescendantsByName(hexIslandFolderBox, positionerName)

    for _, positioner in ipairs(positioners) do
        local newHex = template:Clone()
        newHex.Parent = positioner.Parent

        CS:AddTag(newHex, 'Hex_32')
        newHex.Name = positioner.Parent.Name

        local freeParts = Utils.freeAnchoredParts({item = newHex})

        local positionerPart = positioner.PrimaryPart

        Utils3.setCFrameFromDesiredEdgeOffset2(
            {
                parent = positionerPart,
                childModel = newHex,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, 1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = Vector3.new(0, 0, 0)
                }
            }
        )

        local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
        local blockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_flat')
        SingleStrays.initSingleStrays(
            {
                parentFolder = positioner.Parent,
                blockTemplate = blockTemplate,
                char = nil
            }
        )

        local wallPositioners = Utils.getDescendantsByName(newHex, 'WallPositioner')

        local facesWithWalls = {}

        for _, wallPositioner in ipairs(wallPositioners) do
            local faceHasBridge = false
            for _, point in ipairs(Constants.validRodAttachments) do
                local intersects = Utils.partIntersectsPoint(wallPositioner, point.WorldPosition, Enum.PartType.Block)

                if intersects then
                    faceHasBridge = true
                end
            end
            if not faceHasBridge then
                table.insert(facesWithWalls, wallPositioner)
            end
        end

        local function getWallProps(wall)
            local invisiWallProps =
                levelConfig.invisiWallProps or hexConfigs.invisiWallProps or Constants.wallProps_default
            invisiWallProps.part = wall
            return invisiWallProps
        end

        local rightWalls = facesWithWalls
        for _, wall in ipairs(rightWalls) do
            InvisiWall.setInvisiWallLeft(getWallProps(wall))
        end

        positioner:Destroy()

        Utils.anchorFreedParts(freeParts)
        -- local material = hexConfig.material or Enum.Material.Grass
        -- Utils.convertItemAndChildrenToTerrain({parent = newHex, material = material, ignoreKids = false})
    end
end

return module

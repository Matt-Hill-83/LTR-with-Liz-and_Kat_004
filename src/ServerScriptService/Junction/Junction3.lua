local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local Bridge = require(Sss.Source.Bridge.Bridge)
local LetterOrbiter = require(Sss.Source.LetterOrbiter.LetterOrbiter)
local InvisiWall = require(Sss.Source.InvisiWall.InvisiWall2)

local module = {}

function module.initJunctions3(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig
    local hexConfigs = levelConfig.hexIslandConfigs

    if not hexConfigs then
        return
    end
    local template = Utils.getFromTemplates('Hex_128_32_v2')

    local hexIslandFolderBox = Utils.getFirstDescendantByName(parentFolder, 'HexIslands')
    local hexIslandFolders = hexIslandFolderBox:getChildren()
    Utils.sortListByObjectKey(hexIslandFolders, 'Name')

    for hexIndex, hexIslandFolder in ipairs(hexIslandFolders) do
        local hexConfig = hexConfigs[hexIndex] or {}
        local bridgeConfigs = hexConfig.bridgeConfigs or {}
        local orbiterConfigs = hexConfig.orbiterConfigs or nil

        Bridge.initBridges2(
            {
                parentFolder = hexIslandFolder,
                bridgeConfigs = bridgeConfigs,
                templateName = 'Bridge2'
            }
        )

        LetterOrbiter.initLetterOrbiter({parentFolder = hexIslandFolder, orbiterConfigs = orbiterConfigs})

        local positioners = Utils.getDescendantsByName(hexIslandFolder, 'Hex_128_32_pos_v2')
        for posIndex, positioner in ipairs(positioners) do
            local newHex = template:Clone()
            newHex.Parent = positioner.Parent
            local newHexPart = newHex.PrimaryPart

            local freeParts = Utils.freeAnchoredParts({item = newHex})

            local positionerPart = positioner.PrimaryPart
            newHexPart.CFrame =
                Utils3.setCFrameFromDesiredEdgeOffset(
                {
                    parent = positionerPart,
                    child = newHexPart,
                    offsetConfig = {
                        useParentNearEdge = Vector3.new(0, -1, 1),
                        useChildNearEdge = Vector3.new(0, -1, 1),
                        offsetAdder = Vector3.new(0, 0, 0)
                    }
                }
            )

            local rightWalls = Utils.getByTagInParent({parent = newHex, tag = 'InvisiWallRight_Short'})
            for _, wall in ipairs(rightWalls) do
                InvisiWall.setInvisiWallRight(
                    {
                        thickness = 1,
                        height = 4,
                        shortHeight = 2,
                        shortWallProps = {
                            -- Transparency = 1,
                            Transparency = 0,
                            BrickColor = BrickColor.new('Alder'),
                            Material = Enum.Material.Cobblestone
                        },
                        wallProps = {
                            Transparency = 1,
                            BrickColor = BrickColor.new('Alder'),
                            Material = Enum.Material.Concrete
                        },
                        part = wall
                    }
                )
            end

            local leftWalls = Utils.getByTagInParent({parent = newHex, tag = 'InvisiWallLeft_Short'})
            for _, wall in ipairs(leftWalls) do
                InvisiWall.setInvisiWallLeft(
                    {
                        thickness = 1,
                        height = 4,
                        shortHeight = 2,
                        shortWallProps = {
                            -- Transparency = 1,
                            Transparency = 0,
                            BrickColor = BrickColor.new('Alder'),
                            Material = Enum.Material.Cobblestone
                        },
                        wallProps = {
                            Transparency = 1,
                            BrickColor = BrickColor.new('Alder'),
                            Material = Enum.Material.Concrete
                        },
                        part = wall
                    }
                )
            end
            positioner:Destroy()

            Utils.anchorFreedParts(freeParts)
            -- local material = hexConfig.material or Enum.Material.Grass
            -- Utils.convertItemAndChildrenToTerrain({parent = newHex, material = material, ignoreKids = false})
        end
    end
end

return module

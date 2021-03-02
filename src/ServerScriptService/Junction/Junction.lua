local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local Bridge = require(Sss.Source.Bridge.Bridge)

local module = {}

function module.initJunctions(props)
    local parentFolder = props.parentFolder or workspace

    local positioners = Utils.getDescendantsByName(parentFolder, 'Junction')
    local template = Utils.getFromTemplates('HexJunction')

    for _, positioner in ipairs(positioners) do
        local newHex = template:Clone()
        newHex.Parent = positioner.Parent
        local newHexPart = newHex.PrimaryPart

        -- Weld packages to parent, b/c packages break extrenal welds when they update
        local packageBases = Utils.getDescendantsByName(newHex, 'PackageBase')
        for _, packageBase in ipairs(packageBases) do
            local weld = Instance.new('WeldConstraint')
            weld.Name = 'Weld_ConstraintHex'
            weld.Parent = newHexPart
            weld.Part0 = newHexPart
            weld.Part1 = packageBase
        end

        local freeParts = Utils.freeAnchoredParts({item = newHex})

        local positionerPart = positioner.HexIsland_001_Md_Shell.PrimaryPart
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
        positioner:Destroy()

        Utils.anchorFreedParts(freeParts)
    end
end

function module.initJunctions2(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig
    local hexConfigs = levelConfig.hexIslandConfigs

    local positioners = Utils.getDescendantsByName(parentFolder, 'Hex_128_32_pos')
    local template = Utils.getFromTemplates('Hex_128_32')

    for posIndex, positioner in ipairs(positioners) do
        local newHex = template:Clone()
        newHex.Parent = positioner.Parent
        local newHexPart = newHex.PrimaryPart

        local hexConfig = hexConfigs[posIndex] or {}
        local bridgeConfigs = hexConfig.bridgeConfigs or {}
        Bridge.initBridges(
            {
                parentFolder = parentFolder,
                bridgeConfigs = bridgeConfigs,
                templateName = 'Bridge2'
            }
        )

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
        positioner:Destroy()

        Utils.anchorFreedParts(freeParts)
    end
end

return module

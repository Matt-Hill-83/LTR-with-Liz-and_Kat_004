local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local LevelPortal = require(Sss.Source.LevelPortal.LevelPortal)
local module = {}

function module.initHexGears(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig
    local hexGearConfigs = levelConfig.hexGearConfigs

    local hexGears = Utils.getByTagInParent({parent = parentFolder, tag = 'HexGear_001'})
    Utils.sortListByObjectKey(hexGears, 'Name')

    if not hexGearConfigs then
        return
    end

    for hexIndex, hexGear in ipairs(hexGears) do
        if hexGearConfigs[hexIndex] then
            local config = hexGearConfigs[hexIndex] or hexGearConfigs[1]
            local hexes = Utils.getDescendantsByName(hexGear, 'Hex_32_32_v1')

            local positioners = {}
            for i, hex in ipairs(hexes) do
                local partToPositionTo = hex.PrimaryPart
                local newPositioner = partToPositionTo:Clone()

                local word = config.words[i] or config.words[1]
                newPositioner.Parent = hex
                newPositioner.Name = word
                -- table.insert(positioners, newPositioner)

                local portal =
                    LevelPortal.initLevelPortal(
                    {parentFolder = hexGear, positioner = newPositioner, templateName = 'LevelPortal-001', word = word}
                    -- {parentFolder = hexGear, positioners = positioners, templateName = 'GrabberReplicatorTemplate_003'}
                )
                portal:SetAttribute('Word', word)
                Utils3.setCFrameFromDesiredEdgeOffset2(
                    {
                        parent = portal.PrimaryPart,
                        childModel = portal,
                        offsetConfig = {
                            useParentNearEdge = Vector3.new(0, 0, 0),
                            useChildNearEdge = Vector3.new(0, 0, 0),
                            offsetAdder = Vector3.new(0, 0, 0),
                            angles = Vector3.new(math.rad(60), 0, 0)
                        }
                    }
                )
                -- LevelPortal.initLevelPortal({portal = portal, word = word})
            end
        end
    end
end

return module

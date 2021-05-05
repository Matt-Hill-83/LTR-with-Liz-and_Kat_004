local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
-- local Constants = require(Sss.Source.Constants.Constants)

-- local Grabbers = require(Sss.Source.Grabbers.Grabbers)
local LevelPortal = require(Sss.Source.LevelPortal.LevelPortal)

local module = {}

function module.initHexGears(props)
    print('initHexGears' .. ' - start')

    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig
    local hexGearConfigs = levelConfig.hexGearConfigs

    local hexGears = Utils.getByTagInParent({parent = parentFolder, tag = 'HexGear_001'})
    Utils.sortListByObjectKey(hexGears, 'Name')

    if not hexGearConfigs then
        return
    end

    for hexIndex, hexGear in ipairs(hexGears) do
        local config = hexGearConfigs[hexIndex] or hexGearConfigs[1]
        local hexes = Utils.getDescendantsByName(hexGear, 'Hex_32_32_v1')
        -- local hexes = Utils.getDescendantsByName(hexGear, 'Hex_32_32_pos_v2')
        local positioners = {}
        for i, hex in ipairs(hexes) do
            local newPositioner = hex.PrimaryPart:Clone()
            newPositioner.Parent = hex
            newPositioner.Name = config.words[i] or config.words[1]
            table.insert(positioners, newPositioner)
        end

        local grabbers =
            LevelPortal.initGrabbers3(
            {parentFolder = hexGear, positioners = positioners, templateName = 'LevelPortal-001'}
            -- {parentFolder = hexGear, positioners = positioners, templateName = 'GrabberReplicatorTemplate_003'}
        )

        print('grabbers' .. ' - start')
        print(grabbers)

        for _, grabber in ipairs(grabbers) do
            local grabberPart = grabber.PrimaryPart

            Utils3.setCFrameFromDesiredEdgeOffset2(
                {
                    parent = grabberPart,
                    childModel = grabber,
                    offsetConfig = {
                        useParentNearEdge = Vector3.new(0, 0, 0),
                        useChildNearEdge = Vector3.new(0, 0, 0),
                        offsetAdder = Vector3.new(0, 0, 0)
                    }
                }
            )
        end
    end
end

return module

local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local LevelPortal = require(Sss.Source.LevelPortal.LevelPortal)
local module = {}

function module.initHexGears(props)
    local parentFolder = props.parentFolder
    local templateName = props.templateName
    local positionerTag = props.positionerTag
    local offsetAngle = props.offsetAngle

    local regionConfig = props.regionConfig
    local hexGearConfigs = regionConfig.hexGearConfigs
    local positioners = regionConfig.positioners

    local hexGears = Utils.getByTagInParent({parent = parentFolder, tag = 'HexGear_001'})
    Utils.sortListByObjectKey(hexGears, 'Name')

    if not hexGearConfigs then
        return
    end

    for hexIndex, hexGear in ipairs(hexGears) do
        if hexGearConfigs[hexIndex] then
            local config = hexGearConfigs[hexIndex] or hexGearConfigs[1]

            if not positioners then
                local hexes = Utils.getByTagInParent({parent = hexGear, tag = positionerTag})
                Utils.sortListByObjectKey(hexes, 'Name')

                local filteredHexes = {}
                for _, hex in ipairs(hexes) do
                    local firstChar = hex.Name:sub(1, 1)
                    if firstChar ~= '0' then
                        table.insert(filteredHexes, hex)
                    end
                end

                positioners = filteredHexes
            end

            -- for i, hex in ipairs(test) do
            for i, hex in ipairs(positioners) do
                local partToPositionTo = hex.PrimaryPart
                local newPositioner = partToPositionTo:Clone()

                local word = config.words[i]

                if word and word ~= '' then
                    newPositioner.Parent = hex
                    newPositioner.Name = word

                    local portal =
                        LevelPortal.initLevelPortal(
                        {
                            parentFolder = hexGear,
                            positioner = newPositioner,
                            templateName = templateName,
                            word = word
                        }
                    )
                    portal:SetAttribute('Word', word)
                    Utils3.setCFrameFromDesiredEdgeOffset2(
                        {
                            parent = portal.PrimaryPart,
                            childModel = portal,
                            angles = offsetAngle,
                            offsetConfig = {
                                useParentNearEdge = Vector3.new(0, 0, 0),
                                useChildNearEdge = Vector3.new(0, 0, 0),
                                offsetAdder = Vector3.new(0, 0, 0)
                            }
                        }
                    )
                end

                newPositioner:Destroy()
            end
        end
    end
end

return module

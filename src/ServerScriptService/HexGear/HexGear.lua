local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local LevelPortal = require(Sss.Source.LevelPortal.LevelPortal)
local module = {}

function module.initHexGears(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig
    local hexGearConfigs = levelConfig.hexGearConfigs
    local positioners = levelConfig.positioners
    local templateName = levelConfig.templateName

    local hexGears = Utils.getByTagInParent({parent = parentFolder, tag = 'HexGear_001'})
    Utils.sortListByObjectKey(hexGears, 'Name')

    if not hexGearConfigs then
        return
    end

    for hexIndex, hexGear in ipairs(hexGears) do
        if hexGearConfigs[hexIndex] then
            local config = hexGearConfigs[hexIndex] or hexGearConfigs[1]

            if not positioners then
                local hexes = Utils.getByTagInParent({parent = hexGear, tag = 'Hex_32'})

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

                if not word then
                    break
                end

                newPositioner.Parent = hex
                newPositioner.Name = word

                -- coroutine.wrap(
                --     function()
                -- wait(n)
                -- print('executed 2nd')
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
                        angles = CFrame.Angles(0, math.rad(-30), 0),
                        offsetConfig = {
                            useParentNearEdge = Vector3.new(0, 0, 0),
                            useChildNearEdge = Vector3.new(0, 0, 0),
                            offsetAdder = Vector3.new(0, 0, 0)
                        }
                    }
                )
                --     end
                -- )()
            end
        end
    end
end

return module

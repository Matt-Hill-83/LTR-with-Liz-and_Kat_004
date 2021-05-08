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
            Utils.sortListByObjectKey(hexes, 'Name')

            local test = {unpack(hexes, 1, 5)}

            local filteredHexes = {}
            for _, hex in ipairs(hexes) do
                if hex.Name ~= '0' then
                    table.insert(filteredHexes, hex)
                end
            end

            print('filteredHexes' .. ' - start')
            print(filteredHexes)

            -- for i, hex in ipairs(test) do
            for i, hex in ipairs(filteredHexes) do
                local partToPositionTo = hex.PrimaryPart
                local newPositioner = partToPositionTo:Clone()

                -- local word = config.words[i] or config.words[1]
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
                        templateName = 'LevelPortal-003',
                        -- templateName = 'LevelPortal-002',
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

local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local Constants = require(Sss.Source.Constants.Constants)

local Door = require(Sss.Source.Door.Door)

local module = {}

function module.initHexWalls(props)
    local parentFolder = props.parentFolder or workspace
    local wallPositioners = Utils.getDescendantsByName(parentFolder, 'WallProxy')

    local width = Constants.gameConfig.isDev and 20 or 32

    for _, positioner in ipairs(wallPositioners) do
        local label = Utils.getFirstDescendantByName(positioner, 'WallProxyLabel')

        local word = label.Text
        if word == '--NO DOOR--' or word == 'XXX' then
            --
        else
            local noGem

            if word == '--NO GEM--' or word == '---' then
                noGem = true
            else
                noGem = false
            end

            local doorProps = {
                positioner = positioner,
                parentFolder = parentFolder,
                keyName = word,
                width = width,
                noGem = noGem
            }

            local newDoor = Door.initDoor(doorProps)
            local doorPart = newDoor.PrimaryPart

            doorPart.CFrame =
                Utils3.setCFrameFromDesiredEdgeOffset(
                {
                    parent = positioner,
                    child = doorPart,
                    offsetConfig = {
                        useParentNearEdge = Vector3.new(0, 1, 0),
                        useChildNearEdge = Vector3.new(0, -1, 0),
                        offsetAdder = Vector3.new(0, 0, 0)
                    }
                }
            )

            doorPart.CFrame = doorPart.CFrame * CFrame.Angles(0, math.rad(90), 0)
        end
    end
end

return module

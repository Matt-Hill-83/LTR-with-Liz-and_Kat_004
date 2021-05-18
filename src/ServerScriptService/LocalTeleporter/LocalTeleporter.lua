local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
local module = {}
local tagName2 = 'AlreadyConverted'

function module.tagConvertedPart(part, tag)
    CS:AddTag(part, tag)
end

function module.shouldConvertPart(part)
    return not CS:HasTag(part, tagName2)
end

function module.initLocalTeleporter(props)
    local parentFolder = props.parentFolder

    local teleporterTop = Utils.getFirstDescendantByName(parentFolder, 'TeleporterTop')

    if not teleporterTop then
        return
    end

    local touchPadTop = Utils.getFirstDescendantByName(teleporterTop, 'pad')

    if not touchPadTop then
        return
    end

    local teleporterBottoms =
        Utils.getInstancesByNameStub(
        {
            nameStub = 'TeleporterBottom',
            parent = parentFolder
        }
    )

    -- local teleporterBottoms = Utils.getDescendantsByName(parentFolder, 'TeleporterBottom_002')
    for _, teleporterBottom in ipairs(teleporterBottoms) do
        local touchPadBottom = Utils.getFirstDescendantByName(teleporterBottom, 'pad')

        if touchPadBottom then
            local function teleport(props)
                local player = props.player
                local justTeleported = player:findFirstChild('JustTeleported')

                if not justTeleported then
                    -- player.Character:MoveTo(touchPadTop.Position + Vector3.new(0, -16, 0))

                    Utils3.setCFrameFromDesiredEdgeOffset2(
                        {
                            parent = touchPadTop,
                            childModel = player.Character,
                            offsetConfig = {
                                useParentNearEdge = Vector3.new(0, 0, 0),
                                useChildNearEdge = Vector3.new(0, 0, 0),
                                offsetAdder = Vector3.new(0, 4, 0)
                            }
                        }
                    )
                    -- player.Character:MoveTo(touchPadTop.CFrame.p + Vector3.new(0, -16, 0))
                    local t = Instance.new('Weld')
                    t.Name = 'JustTeleported'
                    t.Parent = player
                    delay(
                        1.5,
                        function()
                            t:Destroy()
                        end
                    )
                end
            end

            touchPadBottom.Touched:Connect(
                Utils.onTouchHuman2(
                    {
                        touchedBlock = touchPadBottom,
                        callBack = teleport
                    }
                )
            )
        end
    end
end

return module

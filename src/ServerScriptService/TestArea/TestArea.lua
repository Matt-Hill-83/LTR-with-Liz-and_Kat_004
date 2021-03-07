local Sss = game:GetService('ServerScriptService')
local ServerStorage = game:GetService('ServerStorage')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local TeleportModule = require(ServerStorage.Source.TeleportModule)
local Players = game:GetService('Players')

local module = {}

function module.initTeleporter(part, nextLevelId)
    if not part then
        return
    end
    local teleportPart = part

    local function onPartTouch(otherPart)
        print('onPartTouch' .. ' - start')
        print('onPartTouch' .. ' - start')
        print('onPartTouch' .. ' - start')
        -- Get player from character
        local player = Players:GetPlayerFromCharacter(otherPart.Parent)
        if player then
            local teleporting = player:GetAttribute('Teleporting')
            if not teleporting then
                player:SetAttribute('Teleporting', true)

                -- Teleport the player
                local teleportResult = TeleportModule.teleportWithRetry(nextLevelId, {player})

                player:SetAttribute('Teleporting', nil)
            end
        end
    end

    teleportPart.Touched:Connect(onPartTouch)
end

function module.configTestArea(props)
    print('configTestArea')
    print('configTestArea')
    print('configTestArea')
    local parentFolder = props.parentFolder

    -- local hexConfig = hexConfigs[islandIndex] or {}
    local teleporter = Utils.getFirstDescendantByName(parentFolder, 'TestArea')
    if teleporter then
        local telepad = Utils.getFirstDescendantByName(teleporter, 'Telepad')
        print('telepad' .. ' - start')
        print(telepad)

        local testAreaPlaceId = '6478277568'
        module.initTeleporter(telepad, testAreaPlaceId)
    end

    -- For the return trip
    local teleportToMain = Utils.getFirstDescendantByName(parentFolder, 'TeleportToMain')
    if teleportToMain then
        local telepad2 = Utils.getFirstDescendantByName(teleportToMain, 'Telepad')
        local mainAreaPlaceId = '6358192824'
        module.initTeleporter(telepad2, mainAreaPlaceId)
    end
end

return module
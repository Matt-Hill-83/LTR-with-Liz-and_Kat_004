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
    local parentFolder = props.parentFolder

    local testArea = Utils.getFirstDescendantByName(parentFolder, 'TestArea')
    if testArea then
        local telepad = Utils.getFirstDescendantByName(testArea, 'Telepad')

        -- local testAreaPlaceId = '6478277568'
        local testAreaPlaceId = '6486874682'
        module.initTeleporter(telepad, testAreaPlaceId)
    end

    local wordScramble = Utils.getFirstDescendantByName(parentFolder, 'WordScramble')
    if wordScramble then
        local telepad = Utils.getFirstDescendantByName(wordScramble, 'Telepad')

        local testAreaPlaceId = '6241554880'
        module.initTeleporter(telepad, testAreaPlaceId)
    end

    local trollGame = Utils.getFirstDescendantByName(parentFolder, 'TrollGame')
    if trollGame then
        local telepad = Utils.getFirstDescendantByName(trollGame, 'Telepad')

        local testAreaPlaceId = '6176867408'
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

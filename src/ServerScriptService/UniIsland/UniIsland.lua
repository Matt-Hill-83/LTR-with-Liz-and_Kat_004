local Sss = game:GetService('ServerScriptService')
local ServerStorage = game:GetService('ServerStorage')
local Players = game:GetService('Players')
local TeleportModule = require(ServerStorage.Source.TeleportModule)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)

local module = {}

function module.initUniIslands(props)
    local parentFolder = props.parentFolder

    local islandFolderBox = Utils.getFirstDescendantByName(parentFolder, 'UniIslands')
    if not islandFolderBox then
        return
    end
    local islandFolders = islandFolderBox:getChildren()
    Utils.sortListByObjectKey(islandFolders, 'Name')

    for islandIndex, islandFolder in ipairs(islandFolders) do
        local teleporter = Utils.getFirstDescendantByName(islandFolder, 'Teleporter')
        if teleporter then
            local telepad = Utils.getFirstDescendantByName(teleporter, 'Telepad')

            local levelDefs = LevelConfigs.levelDefs
            local placeId = levelDefs[(islandIndex % #levelDefs) + 1]

            module.initTeleporter(telepad, placeId.id)
        end
    end
end

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

return module

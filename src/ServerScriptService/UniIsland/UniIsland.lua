local Sss = game:GetService('ServerScriptService')
local ServerStorage = game:GetService('ServerStorage')
local Players = game:GetService('Players')
local TeleportModule = require(ServerStorage.Source.TeleportModule)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)

local module = {}

function module.initUniIslands(props)
    local hexConfigs = props.configs or {}
    local parentFolder = props.parentFolder

    local islandFolderBox = Utils.getFirstDescendantByName(parentFolder, 'UniIslands')
    local islandFolders = islandFolderBox:getChildren()
    Utils.sortListByObjectKey(islandFolders, 'Name')

    for islandIndex, islandFolder in ipairs(islandFolders) do
        local hexConfig = hexConfigs[islandIndex] or {}
        local teleporter = Utils.getFirstDescendantByName(islandFolder, 'Teleporter')
        local telepad = Utils.getFirstDescendantByName(teleporter, 'Telepad')

        print('telepad' .. ' - start')
        print(telepad)

        local levelDefs = LevelConfigs.levelDefs
        print('levelDefs' .. ' - start')
        print(levelDefs)
        local placeId = levelDefs[(islandIndex % #levelDefs) + 1]

        module.initTeleporter(telepad, placeId)
    end
end

function module.initTeleporter(part, nextLevelId)
    print('nextLevelId' .. ' - start')
    print(nextLevelId)
    if not part then
        return
    end
    local teleportPart = part

    local function onPartTouch(otherPart)
        -- Get player from character
        local player = Players:GetPlayerFromCharacter(otherPart.Parent)

        local teleporting = player:GetAttribute('Teleporting')
        if player and not teleporting then
            print('teleporting' .. ' - start')
            print('teleporting' .. ' - start')
            print('teleporting' .. ' - start')
            print(teleporting)
            player:SetAttribute('Teleporting', true)

            -- Teleport the player
            local teleportResult = TeleportModule.teleportWithRetry(nextLevelId, {player})

            player:SetAttribute('Teleporting', nil)
        end
    end

    teleportPart.Touched:Connect(onPartTouch)
end

return module

local Sss = game:GetService('ServerScriptService')
local ServerStorage = game:GetService('ServerStorage')
local Players = game:GetService('Players')
local TeleportModule = require(ServerStorage.Source.TeleportModule)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)

local module = {}

function module.initPetBox(props)
    local hexConfigs = props.configs or {}
    local parentFolder = props.parentFolder

    local islandFolderBox = Utils.getFirstDescendantByName(parentFolder, 'UniIslands')
    if not islandFolderBox then
        return
    end
    local islandFolders = islandFolderBox:getChildren()
    Utils.sortListByObjectKey(islandFolders, 'Name')

    for islandIndex, islandFolder in ipairs(islandFolders) do
        -- local hexConfig = hexConfigs[islandIndex] or {}
        local teleporter = Utils.getFirstDescendantByName(islandFolder, 'Teleporter')
        if not teleporter then
            return
        end
        local telepad = Utils.getFirstDescendantByName(teleporter, 'Telepad')

        local levelDefs = LevelConfigs.levelDefs
        local placeId = levelDefs[(islandIndex % #levelDefs) + 1]

        module.initTeleporter(telepad, placeId.id)
    end
end

return module

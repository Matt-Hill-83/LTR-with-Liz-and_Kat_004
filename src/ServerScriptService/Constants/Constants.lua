local RunService = game:GetService('RunService')

local isDev
isDev = false
isDev = true
--
--
--
local activeSpawn

if isDev then
    activeSpawn = 'SpawnLocation_Hex3'
    activeSpawn = 'SpawnLocation_Hex1'
    activeSpawn = 'SpawnLocation_ramp'
    activeSpawn = 'SpawnLocation_L2H1'
    activeSpawn = 'Spawn-L2'
    activeSpawn = 'SpawnLocation_L3H4'
    activeSpawn = 'Spawn_UniIsland'
    activeSpawn = 'SpawnLocation_L3_ramp'
    activeSpawn = 'SpawnLocation_L3H1'
    activeSpawn = 'Spawn_Start'
    activeSpawn = 'Spawn_Center'
else
    activeSpawn = 'SpawnLocation_L3_ramp'
    activeSpawn = 'Spawn_Center'
    activeSpawn = 'Spawn_Start'
end

-- over ride isDev setting for when I forget to switch it when I deploy
-- if not RunService:IsStudio() then
--     isDev = false
-- end

local devGameConfig = {
    singleIsland = false,
    -- singleIsland = true,
    -- transparency = false,
    transparency = true,
    -- walkSpeed = 30,
    walkSpeed = 80
}

local prodGameConfig = {
    singleIsland = false,
    -- singleIsland = true,
    transparency = true,
    walkSpeed = 30
    -- walkSpeed = 80
}

local gameConfig = isDev and devGameConfig or prodGameConfig

gameConfig.activeSpawn = activeSpawn
gameConfig.isDev = isDev

local module = {
    gameConfig = gameConfig, --
    walkSpeed = gameConfig.walkSpeed, --
    gameData = {letterGrabbers = {}},
    startPlaceId = '6358192824'
}

return module

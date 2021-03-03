local isDev
isDev = true
isDev = false
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
    activeSpawn = 'Spawn_Center'
    activeSpawn = 'SpawnLocation_L3_ramp'
    activeSpawn = 'Spawn_Start'
end

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
    gameData = {letterGrabbers = {}}
}

return module

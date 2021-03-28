local RunService = game:GetService('RunService')

local isDev
isDev = false
isDev = true
--
--
--
local activeSpawn
-- level 8
-- local startPlaceId = '6477887663'
-- main level
local startPlaceId = '6358192824'

-- over ride isDev setting for when I forget to switch it when I deploy
if not RunService:IsStudio() then
    isDev = false
end

if isDev then
    activeSpawn = 'Spawn_Start'
    activeSpawn = 'Spawn_1'
else
    activeSpawn = 'Spawn_Center'
    activeSpawn = 'Spawn_Start'
end

local devGameConfig = {
    singleIsland = false,
    -- singleIsland = true,
    -- transparency = false,
    transparency = true,
    -- walkSpeed = 200
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

local packageIds = {
    LetterOrbiter = 'xxx'
}

local module = {
    testAreaId = '6508386322',
    gameConfig = gameConfig,
    packageIds = packageIds,
    walkSpeed = gameConfig.walkSpeed,
    gameData = {letterGrabbers = {}},
    startPlaceId = startPlaceId
}

return module

local RunService = game:GetService('RunService')

local isDev
isDev = false
isDev = true
--
--
--
local activeSpawn
local startPlaceId = '6358192824'

local playAmbient
playAmbient = true
playAmbient = false

local enabledItems
enabledItems = {
    cardSwap = false,
    petBox = false,
    hexGear = true,
    strayLetterBlocks = false,
    junction4 = true,
    statueGate = false,
    grabbers = true,
    letterGrabber = true,
    theater = false,
    entrance = false
}

-- over ride isDev setting for when I forget to switch it when I deploy
if not RunService:IsStudio() then
    isDev = false
end

if isDev then
    activeSpawn = 'Spawn_Snowflake_8'
    activeSpawn = 'Spawn_Snowflake_4'
    activeSpawn = 'Spawn_05'
else
    activeSpawn = 'Spawn_Snowflake_8'
    activeSpawn = 'Spawn_Snowflake_4'
end

local devGameConfig = {
    transparency = true,
    walkSpeed = 120
    -- walkSpeed = 70
}

local prodGameConfig = {
    transparency = true,
    walkSpeed = 30
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
    startPlaceId = startPlaceId,
    validRods = {},
    validRodAttachments = {},
    playAmbient = playAmbient,
    enabledItems = {
        cardSwap = true,
        petBox = true,
        hexGear = true,
        strayLetterBlocks = true,
        junction4 = true,
        statueGate = true,
        grabbers = true,
        letterGrabber = true,
        theater = true,
        entrance = true
    }
}

if isDev then
    module.enabledItems = enabledItems
end

local islandLength = 36
local bridgeBaseLength = 63
local bridgeOverlap = 2
local bridgeLength = bridgeBaseLength - 2 * bridgeOverlap

module.islandLength = islandLength
module.bridgeLength = bridgeLength
module.totalIslandLength = islandLength + bridgeLength
-- module.totalIslandLength = 128

module.buttonLabels = {PrevPage = 'Prev Page', NextPage = 'Next Page'}
return module

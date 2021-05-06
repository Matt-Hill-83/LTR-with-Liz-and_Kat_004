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
    cardSwap = true,
    petBox = true,
    hexGear = true,
    strayLetterBlocks = true,
    junction4 = true,
    statueGate = true,
    grabbers = true,
    letterGrabber = true,
    -- theater = true,
    entrance = true
}

local getTargetWordsInit = function()
    return {
        {
            {word = 'RAT', target = 1, found = 0},
            {word = 'CAT', target = 1, found = 0},
            {word = 'BAT', target = 1, found = 0},
            {word = 'HAT', target = 1, found = 0},
            {word = 'MAT', target = 1, found = 0},
            {word = 'SAT', target = 1, found = 0},
            {word = 'PAT', target = 1, found = 0}
        }
    }
end

-- over ride isDev setting for when I forget to switch it when I deploy
if not RunService:IsStudio() then
    isDev = false
end

if isDev then
    activeSpawn = 'Spawn_Snowflake_4'
    activeSpawn = 'Spawn_05'
else
    activeSpawn = 'Spawn_Snowflake_4'
    activeSpawn = 'Spawn_05'
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
    portals = {},
    testAreaId = '6508386322',
    gameConfig = gameConfig,
    packageIds = packageIds,
    walkSpeed = gameConfig.walkSpeed,
    gameData = {letterGrabbers = {}},
    startPlaceId = startPlaceId,
    getTargetWordsInit = getTargetWordsInit,
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

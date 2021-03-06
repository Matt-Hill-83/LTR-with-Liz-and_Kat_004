local Sss = game:GetService('ServerScriptService')
local DSS = game:GetService('DataStoreService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Constants = require(Sss.Source.Constants.Constants)
local soundConstants = require(Sss.Source.Constants.Const_05_Audio)
local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)
local ConfigRemoteEvents = require(Sss.Source.AddRemoteObjects.ConfigRemoteEvents)

local BeltJoint = require(Sss.Source.BeltJoint.BeltJoint)
local BlockDash = require(Sss.Source.BlockDash.BlockDash)
local CardSwap = require(Sss.Source.CardSwap.CardSwap)
local VendingMachine = require(Sss.Source.VendingMachine.VendingMachine)
local ConfigGame = require(Sss.Source.AddRemoteObjects.ConfigGame)
local Door = require(Sss.Source.Door.Door)
local Entrance = require(Sss.Source.BlockDash.Entrance)
local HexWall = require(Sss.Source.HexWall.HexWall)
local ClearHex = require(Sss.Source.ClearHex.ClearHex)
local Junction = require(Sss.Source.Junction.Junction)
local Key = require(Sss.Source.Key.Key)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local SkiSlope = require(Sss.Source.SkiSlope.SkiSlope)
local StatueGate = require(Sss.Source.StatueGate.StatueGate)
local Terrain = require(Sss.Source.Terrain.Terrain)
local UniIsland = require(Sss.Source.UniIsland.UniIsland)

local module = {}

function module.initAnimalSounds()
    local unicorns = Utils.getDescendantsByName(workspace, 'Horse_001')

    for uniIndex, uni in ipairs(unicorns) do
        local sound = Utils.getFirstDescendantByName(uni, 'Sound')

        if sound then
            local soundId = soundConstants.animalSounds.unicorn001.soundId
            sound.SoundId = 'rbxassetid://' .. soundId
            sound.Volume = 1
            local timePosition = 10 % uniIndex

            sound.TimePosition = timePosition
            sound.Playing = true
        end
    end
end

function module.initAnimalSounds2()
    local unicorns = Utils.getDescendantsByName(workspace, 'Troll_001')

    for uniIndex, uni in ipairs(unicorns) do
        local sound = Utils.getFirstDescendantByName(uni, 'Sound')

        if sound then
            local soundId = soundConstants.animalSounds.trollNeedGold.soundId
            sound.SoundId = 'rbxassetid://' .. soundId
            sound.Volume = 1
            local timePosition = 10 % uniIndex

            sound.TimePosition = timePosition
            sound.Playing = true
            sound.Looped = true
            sound.RollOffMode = 'Linear'
            sound.RollOffMaxDistance = 64
        end
    end
end

function module.addConveyors(level, sectorConfigs)
    local islandTemplate = Utils.getFromTemplates('IslandTemplate')

    module.initAnimalSounds()
    module.initAnimalSounds2()

    local islandPositioners = Utils.getByTagInParent({parent = level, tag = 'IslandPositioner'})
    Utils.sortListByObjectKey(islandPositioners, 'Name')
    local myPositioners = Constants.gameConfig.singleIsland and {islandPositioners[1]} or islandPositioners

    for islandIndex, islandPositioner in ipairs(myPositioners) do
        -- if islandIndex == 3 then break end
        local newIsland = islandTemplate:Clone()

        local anchoredParts = {}
        for _, child in pairs(newIsland:GetDescendants()) do
            if child:IsA('BasePart') then
                if child.Anchored then
                    child.Anchored = false
                    table.insert(anchoredParts, child)
                end
            end
        end

        newIsland.Parent = level
        newIsland.Name = 'Sector-' .. islandPositioner.Name
        if sectorConfigs then
            local sectorConfig = sectorConfigs[(islandIndex % #sectorConfigs) + 1]
            sectorConfig.sectorFolder = newIsland
            sectorConfig.islandPositioner = islandPositioner

            for _, child in pairs(anchoredParts) do
                child.Anchored = true
            end
            BlockDash.addBlockDash(sectorConfig)
        end
    end
end

--
local function addRemoteObjects()
    PlayerStatManager.init()
    local placeId = game.PlaceId

    local levelDefs = LevelConfigs.levelDefs or {}

    local isStartPlace = Utils.isStartPlace()
    -- This place loads the map list for the other places
    -- Other places have a TP that sends them to the next place in the TP list
    local startPlaceId = Constants.startPlaceId
    local experienceStore = DSS:GetDataStore('MapList')

    if tonumber(placeId) == tonumber(startPlaceId) then
        experienceStore:SetAsync('LevelDefs', levelDefs)
    else
        levelDefs = experienceStore:GetAsync('LevelDefs', levelDefs) or {}
    end

    local levelOrderIndex = -99
    for levelDefIndex, levelDef in ipairs(levelDefs) do
        if tonumber(levelDef.id) == tonumber(placeId) then
            levelOrderIndex = levelDefIndex
        end
    end

    local nextlLevelOrderIndex = levelOrderIndex + 1
    if nextlLevelOrderIndex > #levelDefs then
        nextlLevelOrderIndex = 1
    end

    local nextLevelId = nil

    if isStartPlace then
        -- mainLevelConfig  - xxxx
    else
        if LevelConfigs.levelDefs and LevelConfigs.levelDefs[nextlLevelOrderIndex] then
            nextLevelId = LevelConfigs.levelDefs[nextlLevelOrderIndex]['id']
        end
    end

    if not nextLevelId then
        nextLevelId = startPlaceId
    end

    local myStuff = workspace:FindFirstChild('MyStuff')

    local blockDash = Utils.getFirstDescendantByName(myStuff, 'BlockDash')
    local levelsFolder = Utils.getFirstDescendantByName(blockDash, 'Levels')
    local level = levelsFolder:GetChildren()[1]
    -- Utils.sortListByObjectKey(levels, 'Name')

    -- local level = levels[1]
    local levelName = level.Name
    local levelIndex = tonumber(levelName)

    local islandTemplate = Utils.getFromTemplates('IslandTemplate')
    local levelConfig = nil
    if isStartPlace then
        levelConfig = LevelConfigs.mainLevelConfig
    else
        levelConfig = LevelConfigs.levelConfigs[levelIndex]
    end
    levelConfig.levelIndex = levelIndex
    local hexIslandConfigs = levelConfig.hexIslandConfigs
    --
    --
    --
    ConfigGame.preRunConfig({levelConfig = levelConfig})
    ConfigRemoteEvents.configRemoteEvents()

    ClearHex.initClearHexes({parentFolder = level})
    UniIsland.initUniIslands({parentFolder = level})
    StatueGate.initStatueGates({parentFolder = level, configs = hexIslandConfigs})
    Door.initDoors({parentFolder = level})
    Key.initKeys({parentFolder = level})

    BeltJoint.initBeltJoints({parentFolder = level})
    HexWall.initHexWalls({parentFolder = level})
    Junction.initJunctions({parentFolder = level})
    Junction.initJunctions2({parentFolder = level, levelConfig = levelConfig})
    SkiSlope.initSlopes({parentFolder = level})
    Entrance.initRunFasts(level)
    --
    --
    --
    VendingMachine.initVendingMachine({parentFolder = level, levelConfig = levelConfig, nextLevelId = nextLevelId})
    CardSwap.initCardSwaps({parentFolder = level, levelConfig = levelConfig})

    if true then
        local sectorConfigs = levelConfig.sectorConfigs
        module.addConveyors(level, sectorConfigs)
    end
    islandTemplate:Destroy()

    Terrain.initTerrain({parentFolder = workspace})

    -- PlayerStatManager.init()
    ConfigRemoteEvents.initRemoteEvents()

    -- Do this last after everything has been created/deleted
    ConfigGame.configGame({levelConfig = levelConfig})
    -- ConfigGame.configGame({level = levelIndex})
end

module.addRemoteObjects = addRemoteObjects
return module

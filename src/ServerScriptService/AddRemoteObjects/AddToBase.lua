local Sss = game:GetService('ServerScriptService')
local DSS = game:GetService('DataStoreService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Constants = require(Sss.Source.Constants.Constants)
local soundConstants = require(Sss.Source.Constants.Const_05_Audio)
local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)
local ConfigRemoteEvents = require(Sss.Source.AddRemoteObjects.ConfigRemoteEvents)

local BlockDash = require(Sss.Source.BlockDash.BlockDash)
local ConfigGame = require(Sss.Source.AddRemoteObjects.ConfigGame)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)

local Terrain = require(Sss.Source.Terrain.Terrain)
local TestArea = require(Sss.Source.TestArea.TestArea)
local Theater = require(Sss.Source.Theater.Theater)
local UnicornStore = require(Sss.Source.UnicornStore.UnicornStore)
local UniIsland = require(Sss.Source.UniIsland.UniIsland)
local VendingMachine2 = require(Sss.Source.VendingMachine.VendingMachine_002)
local InitRegion = require(Sss.Source.AddRemoteObjects.InitRegion)
local WordScoreDB = require(Sss.Source.AddRemoteObjects.WordScoreDB)
local Words = require(Sss.Source.Constants.Const_07_Words)

local module = {}

function module.initSheepSounds()
    local unicorns = Utils.getDescendantsByName(workspace, 'Sheep-001-black')

    for uniIndex, uni in ipairs(unicorns) do
        local sound = Utils.getFirstDescendantByName(uni, 'Sound')

        if sound then
            local soundId = soundConstants.animalSounds.baaBaaBlackSheep.soundId
            sound.SoundId = 'rbxassetid://' .. soundId
            sound.Volume = 1
            local timePosition = 10 % uniIndex

            sound.TimePosition = timePosition
            sound.Playing = true
        end
    end
end

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
    local ambient = Utils.getFirstDescendantByName(workspace, 'Ambient')

    if Constants.gameConfig.isDev then
        ambient.Playing = Constants.playAmbient
    else
        ambient.Playing = true
    end

    for uniIndex, uni in ipairs(unicorns) do
        local sound = Utils.getFirstDescendantByName(uni, 'Sound')

        if sound then
            local soundId = soundConstants.animalSounds.trollNeedGold.soundId
            sound.SoundId = 'rbxassetid://' .. soundId
            sound.Volume = 0.5
            local timePosition = 5 % uniIndex

            sound.TimePosition = timePosition
            sound.Playing = true
            sound.Looped = true
            sound.RollOffMode = 'Linear'
            sound.RollOffMaxDistance = 150
            sound.RollOffMinDistance = 80
        end
    end
end

local function resetMyStores(word)
    local player = {UserId = '304010153'}
    WordScoreDB.updateWordStore({player = player, word = word, adder = 1, value = 1})
    --
end

-- me
-- Player_304010153

local function addRemoteObjects()
    local placeId = game.PlaceId
    local levelDefs = LevelConfigs.levelDefs or {}
    local isStartPlace = Utils.isStartPlace()

    local myStuff = workspace.MyStuff

    local blockDash = Utils.getFirstDescendantByName(myStuff, 'BlockDash')
    local levelsFolder = Utils.getFirstDescendantByName(blockDash, 'Levels')
    local level = levelsFolder:GetChildren()[1]

    local levelName = level.Name
    local levelIndex = tonumber(levelName)

    local levelConfig = nil
    if isStartPlace then
        levelConfig = LevelConfigs.levelConfigs[levelIndex]
        levelConfig.levelIndex = levelIndex
    else
        levelConfig = LevelConfigs.levelConfigs[levelIndex]
        levelConfig.levelIndex = levelIndex
    end
    ConfigGame.preRunConfig({levelConfig = levelConfig})
    PlayerStatManager.init()

    module.initAnimalSounds()
    module.initAnimalSounds2()

    -- This place loads the map list for the other places
    -- Other places have a TP that sends them to the next place in the TP list
    local startPlaceId = Constants.startPlaceId
    local experienceStore = DSS:GetDataStore('MapList')

    if isStartPlace and experienceStore then
        -- experienceStore:SetAsync('LevelDefs', levelDefs)
    else
        local success, message =
            pcall(
            function()
                levelDefs = experienceStore:GetAsync('LevelDefs', levelDefs) or {}
            end
        )
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
        if levelDefs and levelDefs[nextlLevelOrderIndex] then
            nextLevelId = levelDefs[nextlLevelOrderIndex]['id']
        end
    else
        if levelDefs and levelDefs[nextlLevelOrderIndex] then
            nextLevelId = levelDefs[nextlLevelOrderIndex]['id']
        end
    end

    if not nextLevelId then
        nextLevelId = startPlaceId
    end

    -- Do this after preconfig to avoid a race
    if isStartPlace then
        experienceStore:SetAsync('LevelDefs', levelDefs)
    end
    ConfigRemoteEvents.configRemoteEvents()

    if isStartPlace then
        UniIsland.initUniIslands({parentFolder = level})
    end

    local regionsFolder = Utils.getFirstDescendantByName(level, 'Regions')

    local regions = regionsFolder:GetChildren()
    Utils.sortListByObjectKey(regions, 'Name')

    local enabledItems = Constants.enabledItems
    local theater = enabledItems.theater

    for regionIndex, region in ipairs(regions) do
        local regionConfig = levelConfig.regions[region.Name] or levelConfig.regions['r001']
        InitRegion.initRegion(region, regionConfig, regionIndex)
    end

    for _, region in ipairs(regions) do
        local regionConfig = levelConfig.regions[region.Name]
        VendingMachine2.initVendingMachine_002(
            {
                positionerName = 'VendingMachinePositioner_001',
                parentFolder = region,
                regionConfig = regionConfig
            }
        )
    end

    for _, region in ipairs(regions) do
        local regionConfig = levelConfig.regions[region.Name]
        BlockDash.addConveyors({regionConfig = regionConfig, parentFolder = region})
        Terrain.initTerrain({parentFolder = region, prefix = 'T-'})
        Terrain.initTerrain({parentFolder = region, prefix = 'T2-'})
        Terrain.initTerrain({parentFolder = region, prefix = 'T9-'})
    end

    Terrain.initTerrain({parentFolder = workspace, prefix = 'T-'})
    Terrain.initTerrain({parentFolder = workspace, prefix = 'T2-'})
    Terrain.initTerrain({parentFolder = workspace, prefix = 'T9-'})

    if theater then
        Theater.initTheaters({parentFolder = level})
    end

    ConfigRemoteEvents.initRemoteEvents()

    local islandTemplate = Utils.getFromTemplates('IslandTemplate')
    islandTemplate:Destroy()
    UnicornStore.initUnicornStore({parentFolder = blockDash})

    ConfigGame.configGame({levelConfig = levelConfig})

    TestArea.configTestArea({parentFolder = level})

    local words = Words.allWords
    -- for _, word in ipairs(words) do
    --     print('word' .. ' - start')
    --     print(word)
    --     wait(2)
    --     resetMyStores(word)
    -- end
end

module.addRemoteObjects = addRemoteObjects
return module

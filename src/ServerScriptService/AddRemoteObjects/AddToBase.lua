local Sss = game:GetService('ServerScriptService')
local DSS = game:GetService('DataStoreService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Constants = require(Sss.Source.Constants.Constants)
local soundConstants = require(Sss.Source.Constants.Const_05_Audio)
local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)
local ConfigRemoteEvents = require(Sss.Source.AddRemoteObjects.ConfigRemoteEvents)

-- local Door = require(Sss.Source.Door.Door)
-- local Key = require(Sss.Source.Key.Key)
local BlockDash = require(Sss.Source.BlockDash.BlockDash)
local CardSwap = require(Sss.Source.CardSwap.CardSwap)
local ConfigGame = require(Sss.Source.AddRemoteObjects.ConfigGame)
local Entrance = require(Sss.Source.BlockDash.Entrance)
local Grabbers = require(Sss.Source.Grabbers.Grabbers)
local Junction4 = require(Sss.Source.Junction.Junction4)
local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)
local PetBox = require(Sss.Source.PetBox.PetBox)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local SingleStrays = require(Sss.Source.SingleStrays.SingleStrays)
local StatueGate = require(Sss.Source.StatueGate.StatueGate)
local StrayLetterBlocks = require(Sss.Source.StrayLetterBlocks.StrayLetterBlocks)
local Terrain = require(Sss.Source.Terrain.Terrain)
local TestArea = require(Sss.Source.TestArea.TestArea)
local Theater = require(Sss.Source.Theater.Theater)
local UnicornStore = require(Sss.Source.UnicornStore.UnicornStore)
local UniIsland = require(Sss.Source.UniIsland.UniIsland)
local VendingMachine2 = require(Sss.Source.VendingMachine.VendingMachine_002)

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

local function addRemoteObjects()
    local placeId = game.PlaceId

    local levelDefs = LevelConfigs.levelDefs or {}

    local isStartPlace = Utils.isStartPlace()

    module.initAnimalSounds()
    module.initAnimalSounds2()

    local myStuff = workspace.MyStuff

    local blockDash = Utils.getFirstDescendantByName(myStuff, 'BlockDash')
    local levelsFolder = Utils.getFirstDescendantByName(blockDash, 'Levels')
    local ramps = Utils.getFirstDescendantByName(blockDash, 'Ramps')

    SingleStrays.initSingleStrays({parentFolder = ramps})

    local level = levelsFolder:GetChildren()[1]

    local levelName = level.Name
    local levelIndex = tonumber(levelName)
    print('levelIndex' .. ' - start')
    print(levelIndex)

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

    -- This place loads the map list for the other places
    -- Other places have a TP that sends them to the next place in the TP list
    local startPlaceId = Constants.startPlaceId
    local experienceStore = DSS:GetDataStore('MapList')

    if isStartPlace and experienceStore then
        -- experienceStore:SetAsync('LevelDefs', levelDefs)
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

    -- Door.initDoors({parentFolder = level})
    -- Key.initKeys({parentFolder = level})

    local regionsFolder = Utils.getFirstDescendantByName(level, 'Regions')
    local regions = regionsFolder:GetChildren()
    Utils.sortListByObjectKey(regions, 'Name')

    for regionIndex, region in ipairs(regions) do
        local config = levelConfig.regions[regionIndex]

        CardSwap.initCardSwaps({parentFolder = region, levelConfig = config, regionIndex = regionIndex})

        PetBox.initPetBox({parentFolder = region, levelConfig = config})

        StrayLetterBlocks.initStraysInRegions({parentFolder = region, regionIndex = regionIndex, levelConfig = config})
        Junction4.initJunctions(
            {
                parentFolder = region,
                levelConfig = config,
                hexTemplate = 'Hex_32_32_v1',
                positionerName = 'Hex_32_32_pos_v2',
                regionIndex = regionIndex
            }
        )
        Junction4.initJunctions(
            {
                parentFolder = region,
                levelConfig = config,
                hexTemplate = 'Hex_128_32_v2',
                positionerName = 'Hex_128_32_pos_v2',
                regionIndex = regionIndex
            }
        )
        StatueGate.initStatueGates({parentFolder = region, levelConfig = config})
        Grabbers.initGrabbers2({levelConfig = config, parentFolder = region})
        LetterGrabber.initGrabberSwaps({levelConfig = config, parentFolder = region})
        Entrance.initRunFasts(region)
    end

    TestArea.configTestArea({parentFolder = level})
    Grabbers.initGrabbers({parentFolder = level})

    Terrain.initTerrain({parentFolder = workspace})

    ConfigRemoteEvents.initRemoteEvents()
    -- Theater.initTheaters({parentFolder = level})

    for regionIndex, region in ipairs(regions) do
        local config = levelConfig.regions[regionIndex]

        VendingMachine2.initVendingMachine_002(
            {tag = 'M-VendingMachine-003', parentFolder = region, levelConfig = config}
        )
    end

    for regionIndex, region in ipairs(regions) do
        local config = levelConfig.regions[regionIndex]
        BlockDash.addConveyors({levelConfig = config, parentFolder = region})
    end

    -- Do this last after everything has been created/deleted
    ConfigGame.configGame({levelConfig = levelConfig})

    local islandTemplate = Utils.getFromTemplates('IslandTemplate')
    islandTemplate:Destroy()
    local unicornStore = UnicornStore.initUnicornStore({parentFolder = blockDash})
end

module.addRemoteObjects = addRemoteObjects
return module

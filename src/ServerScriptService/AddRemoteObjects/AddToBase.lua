local Sss = game:GetService('ServerScriptService')
local DSS = game:GetService('DataStoreService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Constants = require(Sss.Source.Constants.Constants)
local soundConstants = require(Sss.Source.Constants.Const_05_Audio)
local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)
local ConfigRemoteEvents = require(Sss.Source.AddRemoteObjects.ConfigRemoteEvents)

local BlockDash = require(Sss.Source.BlockDash.BlockDash)
local CardSwap = require(Sss.Source.CardSwap.CardSwap)
local ConfigGame = require(Sss.Source.AddRemoteObjects.ConfigGame)
-- local Door = require(Sss.Source.Door.Door)
local Entrance = require(Sss.Source.BlockDash.Entrance)
local Junction4 = require(Sss.Source.Junction.Junction4)
-- local Key = require(Sss.Source.Key.Key)
local Theater = require(Sss.Source.Theater.Theater)
local PetBox = require(Sss.Source.PetBox.PetBox)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local StrayLetterBlocks = require(Sss.Source.StrayLetterBlocks.StrayLetterBlocks)
local SingleStrays = require(Sss.Source.SingleStrays.SingleStrays)
local StatueGate = require(Sss.Source.StatueGate.StatueGate)
local Terrain = require(Sss.Source.Terrain.Terrain)
local TestArea = require(Sss.Source.TestArea.TestArea)
local UniIsland = require(Sss.Source.UniIsland.UniIsland)
local VendingMachine = require(Sss.Source.VendingMachine.VendingMachine)
local VendingMachine2 = require(Sss.Source.VendingMachine.VendingMachine_002)
local Grabbers = require(Sss.Source.Grabbers.Grabbers)

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
            print('timePosition' .. ' - start')
            print(timePosition)

            sound.TimePosition = timePosition
            sound.Playing = true
            sound.Looped = true
            sound.RollOffMode = 'Linear'
            sound.RollOffMaxDistance = 150
            sound.RollOffMinDistance = 80
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
    local placeId = game.PlaceId
    print('placeId' .. ' - start')
    print(placeId)

    local levelDefs = LevelConfigs.levelDefs or {}

    local isStartPlace = Utils.isStartPlace()

    --
    --
    --
    local myStuff = workspace:FindFirstChild('MyStuff')

    local blockDash = Utils.getFirstDescendantByName(myStuff, 'BlockDash')
    local levelsFolder = Utils.getFirstDescendantByName(blockDash, 'Levels')
    local ramps = Utils.getFirstDescendantByName(blockDash, 'Ramps')

    SingleStrays.initSingleStrays({parentFolder = ramps})

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

    -- This place loads the map list for the other places
    -- Other places have a TP that sends them to the next place in the TP list
    local startPlaceId = Constants.startPlaceId
    print('startPlaceId' .. ' - start')
    print(startPlaceId)
    local experienceStore = DSS:GetDataStore('MapList')

    print('levelDefs' .. ' - start')
    print(levelDefs)

    if isStartPlace and experienceStore then
        -- experienceStore:SetAsync('LevelDefs', levelDefs)
    else
        levelDefs = experienceStore:GetAsync('LevelDefs', levelDefs) or {}
    end

    print('levelDefs' .. ' - start')
    print(levelDefs)

    local levelOrderIndex = -99
    for levelDefIndex, levelDef in ipairs(levelDefs) do
        if tonumber(levelDef.id) == tonumber(placeId) then
            levelOrderIndex = levelDefIndex
        end
    end
    print('levelOrderIndex' .. ' - start')
    print(levelOrderIndex)
    local nextlLevelOrderIndex = levelOrderIndex + 1
    if nextlLevelOrderIndex > #levelDefs then
        nextlLevelOrderIndex = 1
    end
    print('nextlLevelOrderIndex' .. ' - start')
    print(nextlLevelOrderIndex)
    local nextLevelId = nil
    print('isStartPlace' .. ' - start')
    print(isStartPlace)
    if isStartPlace then
        -- mainLevelConfig  - xxxx
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

    print('nextLevelId' .. ' - start')
    print(nextLevelId)
    print('levelConfig' .. ' - start--------------------------------->>>>')
    print(levelConfig)

    local hexIslandConfigs = levelConfig.hexIslandConfigs

    -- Do this after preconfig to avoid a race
    if isStartPlace then
        experienceStore:SetAsync('LevelDefs', levelDefs)
    end
    ConfigRemoteEvents.configRemoteEvents()

    if isStartPlace then
        UniIsland.initUniIslands({parentFolder = level})
    end

    StatueGate.initStatueGates({parentFolder = level, configs = hexIslandConfigs})
    -- Door.initDoors({parentFolder = level})
    -- Key.initKeys({parentFolder = level})
    -- PetBox.initPetBox({parentFolder = level, levelConfig = levelConfig})

    print('levelConfig.hexSize' .. ' - start')
    print(levelConfig.hexSize)

    -- if levelConfig.hexSize == 'small-001' then

    -- end
    print('teat')
    print('teat')
    print('teat')
    print('teat')
    print('teat')
    local regionsFolder = Utils.getFirstDescendantByName(level, 'Regions')
    local regions = regionsFolder:GetChildren()
    Utils.sortListByObjectKey(regions, 'Name')

    print('regions' .. ' - start')
    print('regions' .. ' - start')
    print('regions' .. ' - start')
    print('regions' .. ' - start')
    print(regions)

    for regionIndex, region in ipairs(regions) do
        local config = levelConfig.regions[regionIndex]

        CardSwap.initCardSwaps({parentFolder = region, levelConfig = config, regionIndex = regionIndex})
        -- VendingMachine.initVendingMachine(
        --     {tag = 'M-VendingMachine', parentFolder = level, levelConfig = config, nextLevelId = nextLevelId}
        -- )
        VendingMachine2.initVendingMachine_002(
            {tag = 'M-VendingMachine-003', parentFolder = region, levelConfig = config}
        )
        PetBox.initPetBox({parentFolder = region, levelConfig = config})

        StrayLetterBlocks.initStraysInRegions({parentFolder = region, regionIndex = regionIndex})
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

        Junction4.initJunctions(
            {
                parentFolder = region,
                levelConfig = config,
                hexTemplate = 'Hex_128_32_v3',
                positionerName = 'Hex_128_32_pos_v2',
                regionIndex = regionIndex
            }
        )
    end

    TestArea.configTestArea({parentFolder = level})
    Entrance.initRunFasts(level)
    --
    --
    --

    local sectorConfigs = levelConfig.sectorConfigs
    module.addConveyors(level, sectorConfigs)

    Grabbers.initGrabbers({levelConfig = levelConfig, parentFolder = level})

    local islandTemplate = Utils.getFromTemplates('IslandTemplate')
    islandTemplate:Destroy()

    Terrain.initTerrain({parentFolder = workspace})

    ConfigRemoteEvents.initRemoteEvents()
    Theater.initTheaters({parentFolder = level})

    -- Do this last after everything has been created/deleted
    ConfigGame.configGame({levelConfig = levelConfig})
end

module.addRemoteObjects = addRemoteObjects
return module

local Sss = game:GetService('ServerScriptService')
local DSS = game:GetService('DataStoreService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Constants = require(Sss.Source.Constants.Constants)
local soundConstants = require(Sss.Source.Constants.Const_05_Audio)
local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)
local ConfigRemoteEvents = require(Sss.Source.AddRemoteObjects.ConfigRemoteEvents)

local AccessoryGiver = require(Sss.Source.AccessoryGiver.AccessoryGiver)
local BlockDash = require(Sss.Source.BlockDash.BlockDash)
local CardSwap = require(Sss.Source.CardSwap.CardSwap)
local ConfigGame = require(Sss.Source.AddRemoteObjects.ConfigGame)
local Entrance = require(Sss.Source.BlockDash.Entrance)
local Grabbers = require(Sss.Source.Grabbers.Grabbers)
local HexGear = require(Sss.Source.HexGear.HexGear)
local Junction4 = require(Sss.Source.Junction.Junction4)
local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)
local LetterOrbiter = require(Sss.Source.LetterOrbiter.LetterOrbiter)

local PetBox = require(Sss.Source.PetBox.PetBox)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
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

    local cardSwap = enabledItems.cardSwap
    local petBox = enabledItems.petBox
    local hexGear = enabledItems.hexGear
    local strayLetterBlocks = enabledItems.strayLetterBlocks
    local junction4 = enabledItems.junction4
    local statueGate = enabledItems.statueGate
    local grabbers = enabledItems.grabbers
    local letterGrabber = enabledItems.letterGrabber
    local entrance = enabledItems.entrance
    local theater = enabledItems.theater

    -- for regionIndex, region in ipairs({}) do
    for regionIndex, region in ipairs(regions) do
        local config = levelConfig.regions[region.Name]

        if cardSwap then
            CardSwap.initCardSwaps({parentFolder = region, levelConfig = config, regionIndex = regionIndex})
        end

        if petBox then
            PetBox.initPetBox({parentFolder = region, levelConfig = config})
        end

        if strayLetterBlocks then
            StrayLetterBlocks.initStraysInRegions({parentFolder = region, levelConfig = config})
        end

        if junction4 then
            Junction4.initJunctions(
                {
                    parentFolder = region,
                    levelConfig = config,
                    hexTemplate = 'Hex_32_32_v1',
                    positionerName = 'Hex_32_32_pos_v2',
                    regionIndex = regionIndex
                }
            )

            -- Do this after Junctions
            if hexGear then
                HexGear.initHexGears(
                    {
                        parentFolder = region,
                        levelConfig = config,
                        templateName = 'LevelPortal-003',
                        positionerTag = 'Hex_32'
                    }
                )
            end
        end

        if statueGate then
            StatueGate.initStatueGates({parentFolder = region, levelConfig = config})
        end
        if grabbers then
            Grabbers.initGrabbers2({levelConfig = config, parentFolder = region})
        end
        if letterGrabber then
            LetterGrabber.initGrabberSwaps({levelConfig = config, parentFolder = region})
        end
        if entrance then
            Entrance.initRunFasts(region)
        end
        LetterOrbiter.initLetterOrbiter({parentFolder = region, levelConfig = config})
        AccessoryGiver.initAccessoryGivers({parentFolder = region, levelConfig = config})
    end

    TestArea.configTestArea({parentFolder = level})

    Grabbers.initGrabbers3(
        {parentFolder = level, tag = 'LetterGrabberPositioner3', templateName = 'GrabberReplicatorTemplate_003'}
    )
    Grabbers.initGrabbers3(
        {parentFolder = level, tag = 'LetterGrabberPositioner', templateName = 'GrabberReplicatorTemplate_001'}
    )

    Terrain.initTerrain({parentFolder = workspace})

    ConfigRemoteEvents.initRemoteEvents()
    if theater then
        Theater.initTheaters({parentFolder = level})
    end
    for _, region in ipairs(regions) do
        local config = levelConfig.regions[region.Name]

        VendingMachine2.initVendingMachine_002(
            {tag = 'M-VendingMachine-003', parentFolder = region, levelConfig = config}
        )
    end

    for _, region in ipairs(regions) do
        local config = levelConfig.regions[region.Name]
        BlockDash.addConveyors({levelConfig = config, parentFolder = region})
    end

    -- Do this last after everything has been created/deleted
    ConfigGame.configGame({levelConfig = levelConfig})

    local islandTemplate = Utils.getFromTemplates('IslandTemplate')
    islandTemplate:Destroy()
    UnicornStore.initUnicornStore({parentFolder = blockDash})
end

module.addRemoteObjects = addRemoteObjects
return module

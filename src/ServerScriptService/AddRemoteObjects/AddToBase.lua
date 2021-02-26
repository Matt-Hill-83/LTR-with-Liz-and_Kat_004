local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Constants = require(Sss.Source.Constants.Constants)
local soundConstants = require(Sss.Source.Constants.Const_05_Audio)
local LevelConfigs = require(Sss.Source.LevelConfigs.LevelConfigs)
local ConfigRemoteEvents = require(Sss.Source.AddRemoteObjects.ConfigRemoteEvents)

local BeltJoint = require(Sss.Source.BeltJoint.BeltJoint)
local BlockDash = require(Sss.Source.BlockDash.BlockDash)
local VendingMachine = require(Sss.Source.VendingMachine.VendingMachine)
local ConfigGame = require(Sss.Source.AddRemoteObjects.ConfigGame)
local Door = require(Sss.Source.Door.Door)
local Entrance = require(Sss.Source.BlockDash.Entrance)
local HexWall = require(Sss.Source.HexWall.HexWall)
local Junction = require(Sss.Source.Junction.Junction)
local Key = require(Sss.Source.Key.Key)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local SkiSlope = require(Sss.Source.SkiSlope.SkiSlope)
local StatueGate = require(Sss.Source.StatueGate.StatueGate)
local Terrain = require(Sss.Source.Terrain.Terrain)

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

function module.addConveyors(level, sectorConfigs)
    local islandTemplate = Utils.getFromTemplates('IslandTemplate')

    module.initAnimalSounds()

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

local function addRemoteObjects()
    ConfigRemoteEvents.configRemoteEvents()

    local myStuff = workspace:FindFirstChild('MyStuff')

    local blockDash = Utils.getFirstDescendantByName(myStuff, 'BlockDash')
    local levelsFolder = Utils.getFirstDescendantByName(blockDash, 'Levels')
    local levels = levelsFolder:GetChildren()
    Utils.sortListByObjectKey(levels, 'Name')

    local islandTemplate = Utils.getFromTemplates('IslandTemplate')

    for levelIndex, level in ipairs(levels) do
        print('levelIndex' .. ' - start=================================>>>')
        print(levelIndex)
        -- if levelIndex == 2 then break end

        local levelConfig = LevelConfigs.levelConfigs[levelIndex]
        local hexIslandConfigs = levelConfig.hexIslandConfigs

        StatueGate.initStatueGates({parentFolder = level, configs = hexIslandConfigs})
        Door.initDoors({parentFolder = level})
        Key.initKeys({parentFolder = level})

        BeltJoint.initBeltJoints({parentFolder = level})
        HexWall.initHexWalls({parentFolder = level})
        Junction.initJunctions({parentFolder = level})
        Junction.initJunctions2({parentFolder = level})
        -- HexJunction.convertJunctionsToTerrain({parentFolder = level})
        SkiSlope.initSlopes({parentFolder = level})
        Entrance.initRunFasts(level)
        VendingMachine.initVendingMachine({parentFolder = level})

        if true then
            local sectorConfigs = levelConfig.sectorConfigs
            module.addConveyors(level, sectorConfigs)
        end
    end
    islandTemplate:Destroy()

    Terrain.initTerrain({parentFolder = workspace})

    PlayerStatManager.init()
    ConfigRemoteEvents.initRemoteEvents()

    -- Do this last after everything has been created/deleted
    ConfigGame.configGame()
end

module.addRemoteObjects = addRemoteObjects
return module

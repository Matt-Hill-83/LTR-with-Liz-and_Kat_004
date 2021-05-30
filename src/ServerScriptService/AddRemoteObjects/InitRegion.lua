local Sss = game:GetService('ServerScriptService')
local Constants = require(Sss.Source.Constants.Constants)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local AccessoryGiver = require(Sss.Source.AccessoryGiver.AccessoryGiver)
local CardSwap = require(Sss.Source.CardSwap.CardSwap)
local Entrance = require(Sss.Source.BlockDash.Entrance)
local Grabbers = require(Sss.Source.Grabbers.Grabbers)
local HexGear = require(Sss.Source.HexGear.HexGear)
local Junction4 = require(Sss.Source.Junction.Junction4)
local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)
local LetterOrbiter = require(Sss.Source.LetterOrbiter.LetterOrbiter)
local LocalTeleporter = require(Sss.Source.LocalTeleporter.LocalTeleporter)
local MiniGame = require(Sss.Source.MiniGame.MiniGame)

local PetBox = require(Sss.Source.PetBox.PetBox)

local StatueGate = require(Sss.Source.StatueGate.StatueGate)
local StrayLetterBlocks = require(Sss.Source.StrayLetterBlocks.StrayLetterBlocks)
local SingleStrays = require(Sss.Source.SingleStrays.SingleStrays)
local SwapForPackages = require(Sss.Source.SwapForPackages.SwapForPackages)

local module = {}

function module.initRegion(region, regionConfig, regionIndex)
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

    local letterFallPositioners = Utils.getDescendantsByName(region, 'LetterFallPositioner')

    for _, letterFallPositioner in ipairs(letterFallPositioners) do
        local miniGame =
            MiniGame.addMiniGame(
            {
                parent = letterFallPositioner,
                words = {
                    'CAT',
                    'ZZZ',
                    'XXX'
                },
                sceneIndex = 1,
                questIndex = 1,
                questTitle = 'test'
            }
        )
        miniGame.PrimaryPart.Anchored = true
    end

    SwapForPackages.initSwapForPackages({parentFolder = region, regionConfig = regionConfig})

    if cardSwap then
        CardSwap.initCardSwaps({parentFolder = region, regionConfig = regionConfig, regionIndex = regionIndex})
    end

    LocalTeleporter.initLocalTeleporter({parentFolder = region, regionConfig = regionConfig})

    if petBox then
        PetBox.initPetBox({parentFolder = region, regionConfig = regionConfig})
    end

    -- if false then
    if strayLetterBlocks then
        local function func(region, regionConfig)
            return function()
                StrayLetterBlocks.initStraysInRegions({parentFolder = region, regionConfig = regionConfig})
            end
        end

        delay(15, func(region, regionConfig))
        local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
        local blockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_flat')

        SingleStrays.initSingleStrays(
            {
                parentFolder = region,
                blockTemplate = blockTemplate,
                char = nil
            }
        )
    end

    if junction4 then
        Junction4.initJunctions(
            {
                parentFolder = region,
                regionConfig = regionConfig,
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
                    regionConfig = regionConfig,
                    -- templateName = 'LevelPortal-004',
                    templateName = 'LevelPortal-003',
                    positionerTag = 'Hex_32',
                    hexGearTag = 'HexGear_001',
                    offsetAngle = CFrame.Angles(0, math.rad(-30), 0)
                }
            )
            HexGear.initHexGears(
                {
                    parentFolder = region,
                    regionConfig = regionConfig,
                    -- templateName = 'LevelPortal-004',
                    templateName = 'LevelPortal-003',
                    positionerTag = 'Hex_32',
                    hexGearTag = 'HexGear_003',
                    offsetAngle = CFrame.Angles(0, math.rad(-90), 0)
                }
            )
        -- HexGear.initHexGears(
        --     {
        --         parentFolder = region,
        --         regionConfig = regionConfig,
        --         templateName = 'LevelPortal-004',
        --         positionerTag = 'Positioner-Trophy-001'
        --     }
        -- )
        end
    end

    if statueGate then
        StatueGate.initStatueGates({parentFolder = region, regionConfig = regionConfig})
    end
    if grabbers then
        Grabbers.initGrabbers2({regionConfig = regionConfig, parentFolder = region})
    end
    if letterGrabber then
        LetterGrabber.initGrabberSwaps({regionConfig = regionConfig, parentFolder = region})
    end
    if entrance then
        Entrance.initRunFasts(region)
    end
    LetterOrbiter.initLetterOrbiter({parentFolder = region, regionConfig = regionConfig})
    AccessoryGiver.initAccessoryGivers({parentFolder = region, regionConfig = regionConfig})

    -- TestArea.configTestArea({parentFolder = level})

    Grabbers.initGrabbers3(
        {
            regionConfig = regionConfig,
            parentFolder = region,
            tag = 'LetterGrabberPositioner3',
            templateName = 'GrabberReplicatorTemplate_003'
        }
    )
    Grabbers.initGrabbers3(
        {
            regionConfig = regionConfig,
            parentFolder = region,
            tag = 'LetterGrabberPositioner',
            templateName = 'GrabberReplicatorTemplate_001'
        }
    )
end

return module

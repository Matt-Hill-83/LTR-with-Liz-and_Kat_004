local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local Bridge = require(Sss.Source.Bridge.Bridge)
local LetterOrbiter = require(Sss.Source.LetterOrbiter.LetterOrbiter)
local InvisiWall = require(Sss.Source.InvisiWall.InvisiWall2)
local StrayLetterBlocks = require(Sss.Source.StrayLetterBlocks.StrayLetterBlocks)
local SingleStrays = require(Sss.Source.SingleStrays.SingleStrays)

local module = {}

function module.initStrays(props)
    local parentFolder = props.parentFolder

    StrayLetterBlocks.initStraysInRegions({parentFolder = workspace})

    local slope = parentFolder

    -- populate specific letter gems
    local strayPositioners = Utils.getByTagInParent({parent = slope, tag = 'StrayPositioner'})
    for _, positioner in ipairs(strayPositioners) do
        local char = positioner.Name
        local newLetterBlock = StrayLetterBlocks.createStray(char, parentFolder)

        newLetterBlock.CFrame =
            Utils3.setCFrameFromDesiredEdgeOffset(
            {
                parent = positioner,
                child = newLetterBlock,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = nil
                }
            }
        )

        newLetterBlock.Anchored = true
        newLetterBlock.CanCollide = false
    end

    local positioners =
        Utils.getByTagInParent(
        {
            parent = slope,
            tag = 'LetterGrabberPositioner'
        }
    )

    for _, positioner in ipairs(positioners) do
        local grabbersConfig = {
            word = positioner.Name,
            parentFolder = slope,
            positioner = positioner
        }

        LetterGrabber.initLetterGrabber(grabbersConfig)
    end
end

function module.initJunctions(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig
    local positionerName = props.positionerName
    local hexTemplate = props.hexTemplate
    local hexConfigs = levelConfig.hexIslandConfigs

    local template = Utils.getFromTemplates(hexTemplate)
    if not hexConfigs then
        return
    end

    local hexIslandFolderBox = Utils.getFirstDescendantByName(parentFolder, 'HexIslands')
    local hexIslandFolders = hexIslandFolderBox:getChildren()
    Utils.sortListByObjectKey(hexIslandFolders, 'Name')

    --
    --
    local signTargetWords = levelConfig.getTargetWords()[1]
    print('signTargetWords' .. ' - start')
    print(signTargetWords)
    local words = {}
    for _, word in ipairs(signTargetWords) do
        table.insert(words, word.word)
    end

    print('words' .. ' - start')
    print('words' .. ' - start')
    print('words' .. ' - start')
    print('words' .. ' - start')
    print(words)

    local letterMatrix = LetterUtils.createRandomLetterMatrix({words = words, numBlocks = #hexIslandFolders})
    print('letterMatrix' .. ' - start')
    print(letterMatrix)
    --
    --
    --
    for hexIndex, hexIslandFolder in ipairs(hexIslandFolders) do
        local hexConfig = hexConfigs[hexIndex] or {}
        local bridgeConfigs = hexConfig.bridgeConfigs or {}
        local orbiterConfigs = hexConfig.orbiterConfigs or nil

        -- if the 1st letter starts with c
        local fistLetterOfFolder = string.sub(hexIslandFolder.Name, 1, 1)

        local bridgeTemplate = fistLetterOfFolder == 'c' and 'Bridge2' or 'Bridge_32'
        Bridge.initBridges_64(
            {
                parentFolder = hexIslandFolder,
                bridgeConfigs = bridgeConfigs,
                templateName = bridgeTemplate
            }
        )

        LetterOrbiter.initLetterOrbiter({parentFolder = hexIslandFolder, orbiterConfigs = orbiterConfigs})

        local positioners = Utils.getDescendantsByName(hexIslandFolder, positionerName)
        for posIndex, positioner in ipairs(positioners) do
            local newHex = template:Clone()
            newHex.Parent = positioner.Parent
            local newHexPart = newHex.PrimaryPart

            local freeParts = Utils.freeAnchoredParts({item = newHex})

            local positionerPart = positioner.PrimaryPart
            newHexPart.CFrame =
                Utils3.setCFrameFromDesiredEdgeOffset(
                {
                    parent = positionerPart,
                    child = newHexPart,
                    offsetConfig = {
                        useParentNearEdge = Vector3.new(0, -1, 0),
                        useChildNearEdge = Vector3.new(0, -1, 0),
                        offsetAdder = Vector3.new(0, 0, 0)
                    }
                }
            )
            local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
            -- local blockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_8_troll')
            local blockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_flat')

            SingleStrays.initSingleStrays(
                {
                    parentFolder = newHex,
                    blockTemplate = blockTemplate,
                    char = letterMatrix[hexIndex] or letterMatrix[1] or '?'
                }
            )

            local function getWallProps(wall)
                local invisiWallProps = {
                    thickness = 1,
                    height = 1,
                    wallProps = {
                        Transparency = 0.8,
                        BrickColor = BrickColor.new('Alder'),
                        Material = Enum.Material.Concrete,
                        CanCollide = false
                    },
                    shortHeight = 0,
                    shortWallProps = {
                        -- Transparency = 1,
                        Transparency = 0,
                        BrickColor = BrickColor.new('Alder'),
                        Material = Enum.Material.Cobblestone,
                        CanCollide = true
                    },
                    part = wall
                }
                return invisiWallProps
            end

            local rightWalls = Utils.getByTagInParent({parent = newHex, tag = 'InvisiWallRight_Short'})
            for _, wall in ipairs(rightWalls) do
                InvisiWall.setInvisiWallRight(getWallProps(wall))
            end

            local leftWalls = Utils.getByTagInParent({parent = newHex, tag = 'InvisiWallLeft_Short'})
            for _, wall in ipairs(leftWalls) do
                InvisiWall.setInvisiWallLeft(getWallProps(wall))
            end
            positioner:Destroy()

            Utils.anchorFreedParts(freeParts)
            -- local material = hexConfig.material or Enum.Material.Grass
            -- Utils.convertItemAndChildrenToTerrain({parent = newHex, material = material, ignoreKids = false})
        end
    end
end

return module

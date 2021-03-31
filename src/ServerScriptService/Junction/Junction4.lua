local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local Bridge = require(Sss.Source.Bridge.Bridge)
local LetterOrbiter = require(Sss.Source.LetterOrbiter.LetterOrbiter)
local InvisiWall = require(Sss.Source.InvisiWall.InvisiWall2)
local SingleStrays = require(Sss.Source.SingleStrays.SingleStrays)

local Constants = require(Sss.Source.Constants.Constants)

local module = {}

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
    local words = {}
    for _, word in ipairs(signTargetWords) do
        table.insert(words, word.word)
    end

    local letterMatrix = LetterUtils.createRandomLetterMatrix({words = words, numBlocks = #hexIslandFolders})
    --
    --
    --
    print('hexIslandFolders' .. ' - start')
    print(hexIslandFolders)
    for hexIndex, hexIslandFolder in ipairs(hexIslandFolders) do
        local hexConfig = hexConfigs[hexIndex] or {}
        local bridgeConfigs = hexConfig.bridgeConfigs or {}
        -- local orbiterConfigs = hexConfig.orbiterConfigs or nil

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
    end

    for hexIndex, hexIslandFolder in ipairs(hexIslandFolders) do
        local hexConfig = hexConfigs[hexIndex] or {}
        -- local bridgeConfigs = hexConfig.bridgeConfigs or {}
        local orbiterConfigs = hexConfig.orbiterConfigs or nil

        -- if the 1st letter starts with c
        -- local fistLetterOfFolder = string.sub(hexIslandFolder.Name, 1, 1)

        -- local bridgeTemplate = fistLetterOfFolder == 'c' and 'Bridge2' or 'Bridge_32'
        -- Bridge.initBridges_64(
        --     {
        --         parentFolder = hexIslandFolder,
        --         bridgeConfigs = bridgeConfigs,
        --         templateName = bridgeTemplate
        --     }
        -- )

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
            -- use mod to cycle thru configs when there are more positioners than configs
            local mod = (#letterMatrix + hexIndex - 1) % #letterMatrix
            local char = letterMatrix[mod + 1]

            SingleStrays.initSingleStrays(
                {
                    parentFolder = newHex,
                    blockTemplate = blockTemplate,
                    char = char or '?'
                }
            )

            local wallPositioners = Utils.getDescendantsByName(newHex, 'WallPositioner')

            local facesWithWalls = {}

            for _, wallPositioner in ipairs(wallPositioners) do
                local faceHasBridge = false
                for _, point in ipairs(Constants.validRodAttachments) do
                    local intersects =
                        Utils.partIntersectsPoint(wallPositioner, point.WorldPosition, Enum.PartType.Block)

                    if intersects then
                        faceHasBridge = true
                    end
                end
                if not faceHasBridge then
                    table.insert(facesWithWalls, wallPositioner)
                end
            end

            local function getWallProps(wall)
                local invisiWallProps = {
                    thickness = 1,
                    height = 10,
                    wallProps = {
                        Transparency = 1,
                        BrickColor = BrickColor.new('Alder'),
                        Material = Enum.Material.Concrete,
                        CanCollide = true
                    },
                    shortHeight = 1,
                    shortWallProps = {
                        -- Transparency = 1,
                        Transparency = 0,
                        BrickColor = BrickColor.new('Plum'),
                        Material = Enum.Material.Cobblestone,
                        CanCollide = true
                    },
                    part = wall
                }
                return invisiWallProps
            end

            local rightWalls = facesWithWalls
            for _, wall in ipairs(rightWalls) do
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

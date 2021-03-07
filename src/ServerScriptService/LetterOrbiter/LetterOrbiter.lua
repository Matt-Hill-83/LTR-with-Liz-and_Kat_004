local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local RenderWordGrid = require(Sss.Source.Utils.RenderWordGrid_S)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local ReplicatorFactory = require(Sss.Source.ReplicatorFactory.ReplicatorFactory)
local AddModelFromPositioner = require(Sss.Source.AddModelFromPositioner.AddModelFromPositioner)

local module = {}

function module.initLetterOrbiter(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig

    local letterOrbiterPositioners = Utils.getDescendantsByName(parentFolder, 'LetterOrbiterPositioner')

    -- local packageId = '6367502314'
    -- local f = Instance.new('Folder', workspace)
    -- f.Name = packageId
    -- for _, id in pairs(game:GetService('AssetService'):GetAssetIdsForPackage(packageId)) do
    --     local m = game:GetService('InsertService'):LoadAsset(id)
    --     m.Name = id
    --     m.Parent = f
    -- end

    for _, letterOrbiterPositioner in ipairs(letterOrbiterPositioners) do
        print('letterOrbiterPositioner++++++++++++' .. ' - start')
        print(letterOrbiterPositioner)
        local newOrbiter =
            AddModelFromPositioner.addModel(
            {
                parentFolder = parentFolder,
                templateName = 'Orbiter_003',
                positionerModel = letterOrbiterPositioner,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = Vector3.new(0, 0, 0)
                }
            }
        )

        local orbiterDisc = newOrbiter.Disc

        local A = 0
        local R = orbiterDisc.Size.Z
        local P = Vector3.new(0, 0, 0)
        local x = R * math.cos(A)
        local y = R * math.sin(A)
        local X = P + Vector3.new(0, y, z) / 2

        local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
        local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_4_blank')
        --
        --
        --

        -- local newLetter = Instance.new('Part', workspace)
        local newLetter = letterBlockTemplate:Clone()
        -- newLetter.Name = 'orbiterLetter-' .. 'letterNameStub'
        newLetter.Size = Vector3.new(8, 8, 8)
        newLetter.Parent = newOrbiter

        -- CS:AddTag(newLetter, LetterUtils.tagNames.WordLetter)

        local char = 'Z'

        print('newLetter' .. ' - start')
        print(newLetter)
        -- LetterUtils.initLetterBlock(
        --     {
        --         letterBlock = newLetter,
        --         char = char,
        --         templateName = 'Stray_available',
        --         letterBlockType = 'WordRackLetter'
        --     }
        -- )

        newLetter.Anchored = false
        -- newLetter.Position = X
        newLetter.Name = 'zzz'

        newLetter.CFrame =
            Utils3.setCFrameFromDesiredEdgeOffset(
            {
                parent = orbiterDisc,
                child = newLetter,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(1, 0, 0),
                    useChildNearEdge = Vector3.new(1, 0, 0),
                    -- offsetAdder = Vector3.new(0, 0, 0)
                    offsetAdder = X
                }
            }
        )

        Utils.weld2Parts(orbiterDisc, newLetter)
    end

    -- (CFrame.new(P) * CFrame.Angles(0, A, 0) + CFrame.new(0, 0, -R)).Position
end

return module

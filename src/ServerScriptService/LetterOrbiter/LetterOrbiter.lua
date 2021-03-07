local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

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

    -- local letters = {'A', 'B', 'C'}
    local words = {'CAT'}

    local letters = LetterUtils.getLetterSet({words = words, numBlocks = 10})
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

        for letterIndex, char in ipairs(letters) do
            local angle = 360 / #letters

            local A = angle * (letterIndex - 1) * 3.141596 / 180
            local R = 64
            local x = R * math.cos(A)
            local y = R * math.sin(A)
            local blockPosition = Vector3.new(0, y, x) / 2

            local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
            local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_4_blank')
            --
            --
            --

            local newLetter = letterBlockTemplate:Clone()
            newLetter.Name = 'orbiterLetter-' .. char
            newLetter.Size = Vector3.new(8, 8, 8)
            newLetter.Parent = newOrbiter
            newLetter.CanCollide = false
            newLetter.Anchored = false

            CS:AddTag(newLetter, LetterUtils.tagNames.WordLetter)

            LetterUtils.initLetterBlock(
                {
                    letterBlock = newLetter,
                    char = char,
                    templateName = 'Stray_available',
                    letterBlockType = 'WordRackLetter'
                }
            )

            newLetter.CFrame =
                Utils3.setCFrameFromDesiredEdgeOffset(
                {
                    parent = orbiterDisc,
                    child = newLetter,
                    offsetConfig = {
                        useParentNearEdge = Vector3.new(1, 0, 0),
                        useChildNearEdge = Vector3.new(-1, 0, 0),
                        offsetAdder = blockPosition
                    }
                }
            )
            -- Point letter at center
            newLetter.CFrame =
                CFrame.new(
                newLetter.Position,
                Vector3.new(orbiterDisc.Position.X, newLetter.Position.Y, orbiterDisc.Position.Z)
            )

            Utils.weld2Parts(orbiterDisc, newLetter)
        end
    end
end
return module

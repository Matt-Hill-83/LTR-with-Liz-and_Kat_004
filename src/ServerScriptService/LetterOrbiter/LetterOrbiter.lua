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

    -- local letters = {'A', 'B', 'C'}
    local words = {'HOG'}

    local letters = LetterUtils.getLetterSet({words = words, numBlocks = 10})

    for index, letterOrbiterPositioner in ipairs(letterOrbiterPositioners) do
        local newOrbiter =
            AddModelFromPositioner.addModel(
            {
                parentFolder = parentFolder,
                templateName = 'Orbiter_003',
                positionerModel = letterOrbiterPositioner,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, 0, 0),
                    useChildNearEdge = Vector3.new(0, 0, 0),
                    offsetAdder = Vector3.new(0, 0, 0)
                }
            }
        )

        local orbiterDisc = newOrbiter.Disc

        local blockSize = 8
        for letterIndex, char in ipairs(letters) do
            local angle = 360 / #letters

            local angleRadians = angle * (letterIndex - 1) * 3.141596 / 180
            local radius = 40
            local x = radius * math.cos(angleRadians)
            local y = radius * math.sin(angleRadians)
            local blockPosition = Vector3.new(0, y, x) / 2

            local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
            local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_4_blank')

            local newLetter = letterBlockTemplate:Clone()
            newLetter.Name = 'orbiterLetter-' .. char
            newLetter.Size = Vector3.new(blockSize, blockSize, blockSize)
            newLetter.Parent = newOrbiter
            -- newLetter.CanCollide = false
            newLetter.Anchored = false

            orbiterDisc.Size = Vector3.new(blockSize, radius + blockSize, radius + blockSize)

            CS:AddTag(newLetter, LetterUtils.tagNames.WordLetter)

            LetterUtils.initLetterBlock(
                {
                    letterBlock = newLetter,
                    char = char,
                    templateName = 'Stray_available',
                    letterBlockType = 'WordRackLetter',
                    isTextLetter = true
                }
            )

            newLetter.CFrame =
                Utils3.setCFrameFromDesiredEdgeOffset(
                {
                    parent = orbiterDisc,
                    child = newLetter,
                    offsetConfig = {
                        useParentNearEdge = Vector3.new(0, 0, 0),
                        useChildNearEdge = Vector3.new(0, 0, 0),
                        offsetAdder = blockPosition
                    }
                }
            )
            -- Point letter at center
            newLetter.CFrame =
                CFrame.new(
                newLetter.Position,
                Vector3.new(orbiterDisc.Position.X, orbiterDisc.Position.Y, orbiterDisc.Position.Z)
            )

            Utils.weld2Parts(orbiterDisc, newLetter)
        end
        letterOrbiterPositioner:Destroy()
    end
end
return module

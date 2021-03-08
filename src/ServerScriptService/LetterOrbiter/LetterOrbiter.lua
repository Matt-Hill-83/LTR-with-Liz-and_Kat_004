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
    local orbiterConfigs = levelConfig.orbiterConfigs

    local positionerFolder = Utils.getFirstDescendantByName(parentFolder, 'LetterOrbiterPositioners')
    local letterOrbiterPositioners = positionerFolder:getChildren()
    Utils.sortListByObjectKey(letterOrbiterPositioners, 'Name')

    print('letterOrbiterPositioners' .. ' - start')
    print(letterOrbiterPositioners)
    -- local start = #orbiterConfigs
    local test2 = #orbiterConfigs

    for positionerIndex, letterOrbiterPositioner in ipairs(letterOrbiterPositioners) do
        local mod = (#orbiterConfigs + positionerIndex - 1) % #orbiterConfigs
        print('mod-------------' .. ' - start')
        print(mod)

        local orbiterConfig = orbiterConfigs[mod + 1]

        local words = orbiterConfig.words
        local numBlocks = orbiterConfig.numBlocks
        local angularVelocity = orbiterConfig.angularVelocity or 0.66
        local diameter = orbiterConfig.diameter
        local showDisc = orbiterConfig.showDisc
        local collideDisc = orbiterConfig.collideDisc

        local letters = LetterUtils.getLetterSet({words = words, numBlocks = numBlocks})

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
        orbiterDisc.Transparency = showDisc and 0 or 1
        orbiterDisc.CanCollide = collideDisc

        local sun = newOrbiter.Sun
        local discAngularVelocity = orbiterDisc.AngularVelocity
        discAngularVelocity.AngularVelocity = Vector3.new(angularVelocity, 0, 0)

        local blockSize = 8
        for letterIndex, char in ipairs(letters) do
            local angle = 360 / #letters

            local angleRadians = angle * (letterIndex - 1) * 3.141596 / 180

            local posSize = letterOrbiterPositioner.Positioner.Size
            local positionerDiameter = math.min(posSize.Y, posSize.Z)
            local newDiameter = diameter or positionerDiameter
            local radius = newDiameter / 2
            local x = radius * math.cos(angleRadians)
            local y = radius * math.sin(angleRadians)
            local blockPosition = Vector3.new(0, y, x)

            local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
            local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_4_blank')

            local newLetter = letterBlockTemplate:Clone()
            newLetter.Name = 'orbiterLetter-' .. char
            newLetter.Size = Vector3.new(blockSize, blockSize, blockSize)
            newLetter.Parent = newOrbiter
            -- newLetter.CanCollide = false
            newLetter.Anchored = false

            orbiterDisc.Size = Vector3.new(blockSize, newDiameter + blockSize / 1, newDiameter + blockSize / 1)

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

        --
        -- Orient to positioner disc position
        sun.CFrame = sun.CFrame * CFrame.Angles(0, 0, math.rad(90))
        orbiterDisc.CanCollide = true
        letterOrbiterPositioner:Destroy()
    end
end
return module

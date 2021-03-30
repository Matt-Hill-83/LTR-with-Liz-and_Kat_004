local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local AddModelFromPositioner = require(Sss.Source.AddModelFromPositioner.AddModelFromPositioner)

local module = {}

function module.initLetterOrbiter(props)
    local parentFolder = props.parentFolder
    local orbiterConfigs = props.orbiterConfigs

    if not orbiterConfigs then
        return
    end

    local positionerFolder = Utils.getFirstDescendantByName(parentFolder, 'LetterOrbiterPositioners')
    if not positionerFolder then
        return
    end

    local letterOrbiterPositioners = positionerFolder:getChildren()
    Utils.sortListByObjectKey(letterOrbiterPositioners, 'Name')

    for positionerIndex, letterOrbiterPositioner in ipairs(letterOrbiterPositioners) do
        -- use mod to cycle thru configs when there are more positioners than configs
        local mod = (#orbiterConfigs + positionerIndex - 1) % #orbiterConfigs
        local orbiterConfig = orbiterConfigs[mod + 1]
        if not orbiterConfig then
            return
        end

        local words = orbiterConfig.words
        local numBlocks = orbiterConfig.numBlocks
        local angularVelocity = orbiterConfig.angularVelocity or 0.66
        local diameter = orbiterConfig.diameter
        local collideDisc = orbiterConfig.collideDisc
        local collideBlock = orbiterConfig.collideBlock
        local discTransparency = orbiterConfig.discTransparency
        local singleWord = orbiterConfig.singleWord
        local discHeight = orbiterConfig.discHeight

        local letters
        if singleWord then
            letters = LetterUtils.getLetterSetJustWords({words = {singleWord}, numBlocks = numBlocks})
        else
            letters = LetterUtils.getLetterSet({words = words, numBlocks = numBlocks})
        end

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

        if not newOrbiter then
            return
        end
        local orbiterDisc = newOrbiter.Disc
        orbiterDisc.Transparency = discTransparency or 1
        orbiterDisc.CanCollide = collideDisc
        orbiterDisc.Massless = true

        local sun = newOrbiter.Sun
        local discAngularVelocity = orbiterDisc.AngularVelocity
        discAngularVelocity.AngularVelocity = Vector3.new(angularVelocity, 0, 0)
        discAngularVelocity.MaxTorque = 100000000000

        local sizingDisc = letterOrbiterPositioner.Positioner

        local blockSize = 12
        for letterIndex, char in ipairs(letters) do
            if char ~= '?' then
                local angle = 360 / #letters

                local angleRadians = angle * (letterIndex - 1) * 3.141596 / 180

                local posSize = sizingDisc.Size
                local positionerDiameter = math.min(posSize.Y, posSize.Z)
                local newDiameter = diameter or positionerDiameter
                local radius = newDiameter / 2
                local x = radius * math.cos(angleRadians)
                local y = radius * math.sin(angleRadians)
                local blockPosition = Vector3.new(0, y, x)

                local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
                local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_8_blank')
                if char == '~' then
                    letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_8_troll')
                end

                local newLetter = letterBlockTemplate:Clone()
                newLetter.Name = 'orbiterLetter-' .. char
                newLetter.Size = Vector3.new(blockSize, blockSize, blockSize)
                newLetter.Parent = newOrbiter
                newLetter.CanCollide = collideBlock
                newLetter.Anchored = false

                discHeight = discHeight or blockSize - 2

                orbiterDisc.Size = Vector3.new(discHeight, newDiameter + blockSize, newDiameter + blockSize)

                CS:AddTag(newLetter, LetterUtils.tagNames.WordLetter)

                LetterUtils.initLetterBlock(
                    {
                        letterBlock = newLetter,
                        char = char,
                        templateName = 'Stray_available',
                        letterBlockType = LetterUtils.letterBlockTypes.StrayLetter,
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

                newLetter:SetAttribute('BlockGroup', 'Orbiter')
                Utils.weld2Parts(orbiterDisc, newLetter)
            end
        end

        --
        -- Orient to positioner disc position
        sun.CFrame = sun.CFrame * CFrame.Angles(0, 0, math.rad(90))
        sizingDisc.Transparency = 1
        sizingDisc.CanCollide = false

        letterOrbiterPositioner:Destroy()
    end
end
return module

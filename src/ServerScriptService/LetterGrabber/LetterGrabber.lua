local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)
local Utils5 = require(Sss.Source.Utils.U005LetterGrabberUtils)

local Const4 = require(Sss.Source.Constants.Const_04_Characters)

local AccessoryReplicator = require(Sss.Source.BlockDash.AccessoryReplicator)

local module = {}

local function configWordLetters(props)
    local newWord = props.part
    local word = props.word
    local wordNameStub = props.wordNameStub

    local letterPositioner = Utils.getFirstDescendantByName(newWord, 'LetterPositioner')

    local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')
    local letterBlockTemplate = Utils.getFirstDescendantByName(letterBlockFolder, 'LB_2_blank')

    local wordBench = Utils.getFirstDescendantByName(newWord, 'WordBench')

    local spacingFactorX = 0.05
    local letterGapX = letterBlockTemplate.Size.X * spacingFactorX
    local spacingIncrementX = letterGapX + letterBlockTemplate.Size.X

    local template = Utils.getFromTemplates('Grabber_normal')

    local lettersInWord = {}
    for letterIndex = 1, #word do
        local letterNameStub = wordNameStub .. '-L' .. letterIndex
        local char = string.sub(word, letterIndex, letterIndex)
        local newLetter = letterBlockTemplate:Clone()

        LetterUtils.applyStyleFromTemplate(
            {targetLetterBlock = newLetter, templateName = 'Grabber_normal', template = template}
        )

        newLetter.Name = 'wordLetter-' .. letterNameStub .. '-qqq-' .. letterIndex .. '-ch-' .. char
        newLetter.Anchored = false
        newLetter.CanCollide = false
        newLetter.Massless = true

        LetterUtils.createPropOnLetterBlock(
            {
                letterBlock = newLetter,
                propName = 'IsActive',
                initialValue = false,
                propType = 'BoolValue'
            }
        )

        LetterUtils.createPropOnLetterBlock(
            {
                letterBlock = newLetter,
                propName = 'IsFound',
                initialValue = false,
                propType = 'BoolValue'
            }
        )

        LetterUtils.createPropOnLetterBlock(
            {
                letterBlock = newLetter,
                propName = LetterUtils.letterBlockPropNames.CurrentStyle,
                initialValue = 'zzz',
                propType = 'StringValue'
            }
        )

        LetterUtils.createPropOnLetterBlock(
            {
                letterBlock = newLetter,
                propName = LetterUtils.letterBlockPropNames.Character,
                initialValue = 'zzz',
                propType = 'StringValue'
            }
        )

        LetterUtils.createPropOnLetterBlock(
            {
                letterBlock = newLetter,
                propName = 'LetterIndex',
                initialValue = letterIndex,
                propType = 'IntValue'
            }
        )

        local letterPositionX = (letterIndex - 1) * spacingIncrementX - 2 * letterGapX

        CS:AddTag(newLetter, 'WordGrabberLetter')
        LetterUtils.applyLetterText({letterBlock = newLetter, char = char})
        newLetter.Character.Value = char
        newLetter.CFrame =
            Utils3.setCFrameFromDesiredEdgeOffset(
            {
                parent = letterPositioner,
                child = newLetter,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, -1),
                    useChildNearEdge = Vector3.new(0, -1, -1),
                    offsetAdder = Vector3.new(0, 0, letterPositionX)
                }
            }
        )

        local weld = Instance.new('WeldConstraint')
        weld.Name = 'WeldConstraint' .. letterNameStub
        weld.Parent = wordBench
        weld.Part0 = wordBench
        weld.Part1 = newLetter

        -- Do this last to avoid tweening
        newLetter.Parent = newWord

        table.insert(lettersInWord, {char = char, found = false, instance = newLetter})
    end

    local wordBenchSizeX = (#word * letterBlockTemplate.Size.X) + (#word - 1) * letterGapX

    wordBench.Size = Vector3.new(wordBenchSizeX, wordBench.Size.Y, wordBench.Size.Z)

    local newWordObj = {
        word = newWord,
        letters = lettersInWord,
        wordChars = word
    }

    letterPositioner.Name = 'sssss'
    letterPositioner:Destroy()
    letterPositioner.Transparency = 1
    letterPositioner.Size = Vector3.new(0, 0, 0)
    -- letterPositioner.Parent = nil
    return newWordObj
end

local function applyDecalsToCharacterFromWord(props)
    local part = props.part
    local word = props.word

    if Const4.wordConfigs[word] then
        local imageId = Const4.wordConfigs[word]['imageId'] or ''
        local decalUri = 'rbxassetid://' .. imageId
        local decals = Utils.getDescendantsByName(part, 'ImageLabel')

        for _, decal in ipairs(decals) do
            if imageId then
                decal.Image = decalUri
            end
        end
    end
end

local function onTouch2(grabber, player)
    local db = {value = false}

    local function closure(otherPart)
        if not otherPart:FindFirstChild('Type') then
            return
        end
        if otherPart.Type.Value ~= 'StrayLetter' then
            return
        end
        if db.value == true then
            return
        end

        db.value = true
        Utils5.partTouched2(otherPart, player, grabber)
        db.value = false
    end
    return closure
end

function module.afterReplication2(grabber, player)
    local touchRegion = Utils.getFirstDescendantByName(grabber, 'TouchRegion')
    touchRegion.Touched:Connect(onTouch2(grabber, player))
end

function module.initLetterGrabber(props)
    local parentFolder = props.parentFolder
    local positioner = props.positioner
    local templateName = props.templateName
    local word = props.word

    -- templateName = templateName or 'GrabberReplicatorTemplate_001'
    local template = Utils.getFromTemplates(templateName)

    if not template then
        return
    end
    local newReplicator = template:Clone()
    local letterGrabber = Utils.getFirstDescendantByName(newReplicator, 'LetterGrabber')

    if parentFolder then
        newReplicator.Parent = parentFolder
    end

    -- local newReplicatorPart = newReplicator.PrimaryPart

    letterGrabber.Name = letterGrabber.Name .. '-' .. word

    applyDecalsToCharacterFromWord({part = letterGrabber, word = word})
    configWordLetters({part = letterGrabber, word = word, wordNameStub = ''})

    local wordModel = letterGrabber.Word

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = wordModel,
            propName = 'TargetWord',
            initialValue = word,
            propType = 'StringValue'
        }
    )

    if positioner then
        Utils3.setCFrameFromDesiredEdgeOffset2(
            {
                parent = positioner,
                childModel = newReplicator,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = Vector3.new(0, 0, 0)
                }
            }
        )
    end

    AccessoryReplicator.initAccessoryReplicator(newReplicator)
    local hitBox = Utils.getFirstDescendantByName(newReplicator, 'HitBox')
    hitBox.Name = word

    local hitBoxVolume = hitBox.Size.X * hitBox.Size.Y * hitBox.Size.Z
    local positionerVolume = positioner.Size.X * positioner.Size.Y * positioner.Size.Z

    if positionerVolume > hitBoxVolume then
        hitBox.Size = positioner.Size
    end
    module.initGrabberSwap({hitBox = hitBox})
    return newReplicator
end

function module.initLetterGrabberSimple(props)
    local word = props.word
    local player = props.player
    local letterGrabber = props.letterGrabber

    letterGrabber.Name = letterGrabber.Name .. '-' .. word

    applyDecalsToCharacterFromWord({part = letterGrabber, word = word})
    configWordLetters({part = letterGrabber, word = word, wordNameStub = ''})

    local wordModel = letterGrabber.Word

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = wordModel,
            propName = 'TargetWord',
            initialValue = word,
            propType = 'StringValue'
        }
    )

    module.afterReplication2(letterGrabber, player)
    return letterGrabber
end

function module.touchGrabberSwap(touchedPart, player)
    module.donGrabberAccessory(player, {grabberTemplateName = 'LetterGrabberAcc', word = touchedPart.Name})
end

function module.donGrabberAccessory(player, grabberConfig)
    local tagName = 'GrabberAccessory'

    grabberConfig = grabberConfig or {}
    local word = grabberConfig.word or 'ZZZ'

    if not player then
        return
    end

    local character = player.Character or player.CharacterAdded:Wait()
    local kids = character:GetChildren()

    for _, kid in ipairs(kids) do
        local tagValue = kid:GetAttribute(tagName)
        if tagValue then
            -- if character already has grabber, return
            if tagValue == word then
                return
            else
                -- if character has other grabber, delete it
                kid:Destroy()
            end
        end
    end

    -- add new grabber
    local grabberTemplateName = grabberConfig.grabberTemplateName or 'LetterGrabberAcc'

    local humanoid = character:WaitForChild('Humanoid')
    local template = Utils.getFromTemplates(grabberTemplateName)

    local acc = template:Clone()
    CS:AddTag(acc, tagName)
    acc:SetAttribute(tagName, word)

    local letterGrabber = Utils.getFirstDescendantByName(acc, 'LetterGrabber')
    local grabbersConfig = {
        word = word,
        letterGrabber = letterGrabber,
        player = player
    }

    module.initLetterGrabberSimple(grabbersConfig)
    humanoid:AddAccessory(acc)
end

function module.initGrabberSwaps(props)
    local parentFolder = props.parentFolder

    local grabberSwaps = Utils.getByTagInParent({parent = parentFolder, tag = 'GrabberSwap'})
    Utils.sortListByObjectKey(grabberSwaps, 'Name')

    for _, swap in ipairs(grabberSwaps) do
        swap.Touched:Connect(Utils.onTouchHuman(swap, module.touchGrabberSwap))
    end
end

function module.initGrabberSwap(props)
    local hitBox = props.hitBox
    hitBox.Touched:Connect(Utils.onTouchHuman(hitBox, module.touchGrabberSwap))
end

return module

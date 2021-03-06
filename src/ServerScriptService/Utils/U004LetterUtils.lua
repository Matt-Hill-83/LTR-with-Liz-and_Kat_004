local CS = game:GetService('CollectionService')
local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Const3 = require(Sss.Source.Constants.Const_03_Letters)
local Const4 = require(Sss.Source.Constants.Const_04_Characters)

local module = {
    tagNames = {
        WordLetter = 'WordLetter',
        LetterBlock = 'LetterBlock',
        RackLetter = 'RackLetter',
        DeadLetter = 'DeadLetter',
        AvailLetter = 'AvailLetter',
        Found = 'Found',
        NotDeadLetter = 'NotDeadLetter'
    }
}

function module.createRandomLetterMatrix(props)
    local words = props.words
    -- local numBlocks = props.numBlocks

    -- populate matrix with letters
    local letterMatrix = {}
    -- local lettersNotInWords = module.getLettersNotInWords(words)

    for _, word in ipairs(words) do
        for letterIndex = 1, #word do
            local letter = string.sub(word, letterIndex, letterIndex)
            table.insert(letterMatrix, letter)
        end
    end
    return letterMatrix
end

-- module.letterBlockStyleNames = {
--     LBPurpleOrange = 'LBPurpleOrange',
--     LBPurpleLight = 'LBPurpleLight',
--     LBPurpleLight2 = 'LBPurpleLight2',
--     LBDarkPurple = 'LBDarkPurple',
--     LBDeadLetter = 'LBDeadLetter'
-- }

module.letterBlockPropNames = {
    Character = 'Character',
    CurrentStyle = 'CurrentStyle',
    IsHidden = 'IsHidden',
    IsLifted = 'IsLifted',
    IsFound = 'IsFound',
    Type = 'Type',
    Uuid = 'Uuid'
}
module.letterBlockTypes = {
    StrayLetter = 'StrayLetter',
    TargetLetter = 'TargetLetter'
}

-- module.letterBlockStyleDefs = {
--     rack = {
--         Available = module.letterBlockStyleNames.LBPurpleLight2,
--         NotAvailable = module.letterBlockStyleNames.LBPurpleLight,
--         Found = module.letterBlockStyleNames.LBPurpleOrange,
--         DeadLetter = module.letterBlockStyleNames.LBDeadLetter
--     },
--     word = {
--         Placeholder = module.letterBlockStyleNames.LBPurpleLight,
--         Found = module.letterBlockStyleNames.LBPurpleOrange
--     }
-- }

function module.getLetterSet(props)
    local numBlocks = props.numBlocks
    local words = props.words
    local density = props.density or 1

    local letterMatrix = {}
    local lettersNotInWords = module.getLettersNotInWords(words)

    for _ = 1, numBlocks do
        table.insert(letterMatrix, module.getRandomLetter(lettersNotInWords))
    end

    for _, word in ipairs(words) do
        for letterIndex = 1, #word do
            local letter = string.sub(word, letterIndex, letterIndex)
            table.insert(letterMatrix, letter)
        end
    end

    return letterMatrix
end

function module.getLetterSetJustWords(props)
    local numBlocks = props.numBlocks
    local words = props.words

    local letterMatrix = {}
    local wordLetters = {}

    for _ = 1, numBlocks do
        for _, word in ipairs(words) do
            for letterIndex = 1, #word do
                local letter = string.sub(word, letterIndex, letterIndex)
                table.insert(wordLetters, letter)
            end
        end
        table.insert(letterMatrix, module.getRandomLetter(wordLetters))
    end
    return letterMatrix
end

local function playWordSound(word)
    local closure = function()
        if Const4.wordConfigs[word] then
            local soundId = Const4.wordConfigs[word]['soundId']

            if (soundId) then
                local sound = Instance.new('Sound', workspace)
                sound.SoundId = 'rbxassetid://' .. soundId
                sound.Looped = false
                if not sound.IsPlaying then
                    sound:Play()
                end
            end
        end
    end
    return closure
end

function module.getUniqueLettersFromWords(words)
    local dict = {}

    for _, word in ipairs(words) do
        for letterIndex = 1, #word do
            local letter = string.sub(word, letterIndex, letterIndex)
            dict[letter] = true
        end
    end

    local uniqueLettersFromWords = {}
    for k, v in pairs(dict) do
        if dict[k] == true then
            table.insert(uniqueLettersFromWords, k)
        end
    end

    return uniqueLettersFromWords
end

local function getLettersNotInWords(words)
    local allLetters = Const3.allLetters

    local uniqueLettersFromWords = {}

    for _, word in ipairs(words) do
        for letterIndex = 1, #word do
            local letter = string.sub(word, letterIndex, letterIndex)
            uniqueLettersFromWords[letter] = true
        end
    end

    local filteredLetters = {}
    for _, letter in ipairs(allLetters) do
        if not uniqueLettersFromWords[letter] then
            table.insert(filteredLetters, letter)
        end
    end

    return filteredLetters
end

local function getRandomLetter(letters)
    local defaultLetters = Const3.allLetters

    if not letters then
        letters = defaultLetters
    end
    local rand = Utils.genRandom(1, #letters)
    return letters[rand]
end

local function getAvailWords(miniGameState)
    local availWords = {}
    local activeWord = miniGameState.activeWord

    if activeWord then
        availWords = {activeWord.wordChars}
    else
        for _, wordObj in ipairs(miniGameState.renderedWords) do
            if wordObj.completed == false then
                table.insert(availWords, wordObj)
            end
        end
    end
    return availWords
end

local function createPropOnLetterBlock(props)
    local letterBlock = props.letterBlock
    local propName = props.propName
    local initialValue = props.initialValue
    local propType = props.propType

    local propChar = Instance.new(propType, letterBlock)
    propChar.Name = propName
    propChar.Value = initialValue
end

function module.initLetterBlock(props)
    local letterBlock = props.letterBlock
    local char = props.char
    local templateName = props.templateName
    local template = props.template
    local letterBlockType = props.letterBlockType
    local isTextLetter = props.isTextLetter

    CS:AddTag(letterBlock, 'BlockDash')

    if isTextLetter then
        module.applyLetterText({letterBlock = letterBlock, char = char})
    else
        module.applyLetterImage(letterBlock, char)
    end

    createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = module.letterBlockPropNames.Character,
            initialValue = char,
            propType = 'StringValue'
        }
    )

    createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = module.letterBlockPropNames.CurrentStyle,
            initialValue = 'zzz',
            propType = 'StringValue'
        }
    )

    createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = module.letterBlockPropNames.Uuid,
            initialValue = Utils.getUuid(),
            propType = 'StringValue'
        }
    )

    createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = module.letterBlockPropNames.Type,
            initialValue = letterBlockType,
            propType = 'StringValue'
        }
    )

    createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = module.letterBlockPropNames.IsHidden,
            initialValue = false,
            propType = 'BoolValue'
        }
    )

    -- This seems redundant.
    -- I assume we do this after everything is created.
    if templateName or template then
        if isTextLetter then
            module.applyStyleFromTemplate(
                {targetLetterBlock = letterBlock, templateName = templateName, template = template}
            )
        else
            module.applyStyleFromTemplateBD(
                {targetLetterBlock = letterBlock, templateName = templateName, template = template}
            )
        end
    end
end

local function applyLetterImage(letterBlock, char)
    if not Const3.alphabet[char] then
        return
    end
    local imageId = Const3.alphabet[char]['decalId']
    local imageUri = 'rbxassetid://' .. imageId

    local labels = Utils.getDescendantsByName(letterBlock, 'ImageLabel')
    for _, label in ipairs(labels) do
        label.Image = imageUri
    end
end

local function liftLetter(letterBlock, liftUp)
    letterBlock.WeldConstraintRackBlock.Enabled = false

    local liftDistance = 1.25
    if liftUp == true then
        if letterBlock.IsLifted.Value == false then
            letterBlock.CFrame = letterBlock.CFrame * CFrame.new(0, letterBlock.Size.Y * liftDistance, 0)
            letterBlock.IsLifted.Value = true
            letterBlock.CanCollide = false
        -- letterBlock.Sparkles.Enabled = true
        end
    else
        if letterBlock.IsLifted.Value == true then
            letterBlock.CFrame = letterBlock.CFrame * CFrame.new(0, -letterBlock.Size.Y * liftDistance, 0)
            letterBlock.IsLifted.Value = false
            letterBlock.CanCollide = true
        -- letterBlock.Sparkles.Enabled = false
        end
    end
    letterBlock.WeldConstraintRackBlock.Enabled = true
end

local function revertRackLetterBlocksToInit(miniGameState)
    local allLetters = module.getAllLettersInRack2(miniGameState)

    -- revert Letter Rack styles
    for _, letterBlock in ipairs(allLetters) do
        liftLetter(letterBlock, false)
        letterBlock.CurrentStyle.Value = 'none'
        letterBlock.IsHidden.Value = false
        letterBlock.IsFound.Value = false
        Utils.hideItemAndChildren({item = letterBlock, hide = false})
    end

    -- revert word styles
    for _, wordObj in ipairs(miniGameState.renderedWords) do
        wordObj.completed = false
        for _, letterObj in ipairs(wordObj.letters) do
            local letterBlock = letterObj.instance
            module.applyStyleFromTemplateBD(
                {
                    targetLetterBlock = letterBlock,
                    templateName = 'BD_word_normal'
                }
            )
            local firePositioners = Utils.getDescendantsByName(letterBlock, 'FirePositioner')
            for _, firePositioner in ipairs(firePositioners) do
                local fire = firePositioner:FindFirstChild('Fire')
                if fire then
                    fire:Destroy()
                end
            end

            Utils.hideItemAndChildren({item = letterBlock, hide = false})
        end
    end
end

local function styleGemFromTemplate(props)
    local targetLetterBlock = props.targetLetterBlock
    local templateName = props.templateName
    local blockProps = props.blockProps or {}

    local gem1 = Utils.getFirstDescendantByName(targetLetterBlock.Parent, 'Gem1')
    local gem2 = Utils.getFirstDescendantByName(targetLetterBlock.Parent, 'Gem2')

    local gemParts = {gem1, gem2}

    for _, part in ipairs(gemParts) do
        local template = Utils.getFromTemplates(templateName)
        local templatePart = template.Gem1

        part.Material = templatePart.Material
        part.Color = templatePart.Color
        Utils.mergeTables(part, blockProps)
    end
end

local function applyStyleFromTemplateBD(props)
    local targetLetterBlock = props.targetLetterBlock
    local templateName = props.templateName
    local template = props.template

    if not template then
        local letterBlockTemplateFolder = Utils.getFromTemplates('LetterBlockTemplates')

        template = Utils.getFirstDescendantByName(letterBlockTemplateFolder, templateName)
    end
    targetLetterBlock.Color = template.Color
end

function module.applyStyleFromTemplate(props)
    local targetLetterBlock = props.targetLetterBlock
    local templateName = props.templateName
    local template = props.template
    local blockProps = props.blockProps or {}
    local labelProps = props.labelProps or {}

    local currentStyleProp = Utils.getFirstDescendantByName(targetLetterBlock, 'CurrentStyle')
    if not currentStyleProp then
        createPropOnLetterBlock(
            {
                letterBlock = targetLetterBlock,
                propName = module.letterBlockPropNames.CurrentStyle,
                initialValue = 'none',
                propType = 'StringValue'
            }
        )
    end

    local currentStyle = targetLetterBlock.CurrentStyle.Value

    if currentStyle then
        if currentStyle == templateName then
            -- Do not apply a style that already exists
            return
        else
            targetLetterBlock.CurrentStyle.Value = templateName
        end
    end

    if not template then
        local letterBlockTemplateFolder = Utils.getFromTemplates('LetterBlockTemplates')
        template = Utils.getFirstDescendantByName(letterBlockTemplateFolder, templateName)
    end
    Utils.mergeTables(targetLetterBlock, blockProps)

    local label = Utils.getFirstDescendantByName(template, 'BlockChar')

    local baseLabelProps = {
        TextColor3 = label.TextColor3,
        TextStrokeColor3 = label.TextStrokeColor3,
        BorderColor3 = label.BorderColor3,
        BackgroundColor3 = label.BackgroundColor3,
        TextStrokeTransparency = label.TextStrokeTransparency
    }

    Utils.mergeTables(baseLabelProps, labelProps)
    module.styleLetterBlock(targetLetterBlock, baseLabelProps)
end

local function applyLetterText(props)
    local char = props.char
    local letterBlock = props.letterBlock

    -- if not char then return end
    local textLabels = Utils.getDescendantsByName(letterBlock, 'BlockChar')
    if textLabels then
        for i, label in ipairs(textLabels) do
            label.Text = char
        end
    end
end

local function filterItemsByTag(props)
    local items = props.items
    local tag = props.tag
    local include = props.include

    local output = {}
    for i, item in ipairs(items) do
        if include then
            if CS:HasTag(item, tag) then
                table.insert(output, item)
            end
        end

        if not include then
            if not CS:HasTag(item, tag) then
                table.insert(output, item)
            end
        end
    end
    return output
end

function module.styleLetterBlock(letterBlock, labelProps)
    local textLabels = Utils.getDescendantsByName(letterBlock, 'BlockChar')
    for _, label in ipairs(textLabels) do
        Utils.mergeTables(label, labelProps)
    end
end

local function styleImageLabelsInBlock(letterBlock, labelProps)
    local labels = Utils.getDescendantsByName(letterBlock, 'ImageLabel')
    for i, label in ipairs(labels) do
        Utils.mergeTables(label, labelProps)
    end
end

function module.styleLetterBlocksBD(props)
    local miniGameState = props.miniGameState
    local currentLetterIndex = miniGameState.currentLetterIndex

    local activeWord = miniGameState.activeWord
    local availWords = {}

    if activeWord then
        availWords = {activeWord.wordChars}
    else
        for _, wordObj in ipairs(miniGameState.renderedWords) do
            if wordObj.completed == false then
                table.insert(availWords, wordObj.wordChars)
            end
        end
    end

    local availLetters =
        module.getAvailLettersDict(
        {
            words = availWords,
            currentLetterIndex = currentLetterIndex
        }
    )

    local allLetters = module.getAllLettersInRack2(miniGameState)
    local letterBlockTemplateFolder = Utils.getFromTemplates('LetterBlockTemplates')
    local template1 = Utils.getFirstDescendantByName(letterBlockTemplateFolder, miniGameState.activeStyle)
    local template2 = Utils.getFirstDescendantByName(letterBlockTemplateFolder, miniGameState.inActiveStyle)

    for _, letterBlock in ipairs(allLetters) do
        local char = module.getCharFromLetterBlock2(letterBlock)
        local templateName = nil
        local template = nil

        if availLetters[char] then
            templateName = miniGameState.activeStyle
            module.liftLetter(letterBlock, true)
            template = template1
        else
            module.liftLetter(letterBlock, false)
            templateName = miniGameState.inActiveStyle
            template = template2
        end

        module.applyStyleFromTemplate(
            {
                targetLetterBlock = letterBlock,
                templateName = templateName,
                template = template
            }
        )
    end
end

local function colorLetterText(props)
    local color = props.color
    local letterBlock = props.letterBlock

    local textLabels = Utils.getDescendantsByName(letterBlock, 'BlockChar')
    for i, label in ipairs(textLabels) do
        label.TextColor3 = color
    end
end

local function colorLetterBorder(props)
    local color = props.color
    local letterBlock = props.letterBlock

    local textLabels = Utils.getDescendantsByName(letterBlock, 'BlockChar')
    for i, label in ipairs(textLabels) do
        label.BorderColor3 = color or Color3.new(255, 0, 191)
    end
end

local function getCharFromLetterBlock2(letterBlock)
    if not letterBlock then
        return
    end
    local char = letterBlock.Character.Value
    return char
end

local function isDesiredLetter(letter, clickedLetter)
    local textLabel = Utils.getFirstDescendantByName(clickedLetter, 'BlockChar').Text
    return letter.found ~= true and letter.char == textLabel
end

local function isWordComplete(wordLetters)
    for i, word in ipairs(wordLetters) do
        if not word.found then
            return false
        end
    end
    return true
end

local function getAvailLettersDict2(miniGameState)
    local availableWords = {}
    for _, wordObj in ipairs(miniGameState.renderedWords) do
        if wordObj.completed == false then
            table.insert(availableWords, wordObj)
        end
    end

    local availLettersDict = {}
    for i, word in ipairs(availableWords) do
        local letter = string.sub(word.wordChars, 1, 1)
        availLettersDict[letter] = true
    end
    return availLettersDict
end

local function getAvailLettersDict(props)
    local words = props.words
    local currentLetterIndex = props.currentLetterIndex

    local availLettersDict = {}
    for i, word in ipairs(words) do
        local letter = string.sub(word, currentLetterIndex, currentLetterIndex)
        availLettersDict[letter] = true
    end
    return availLettersDict
end

local function getAllLettersInRack2(miniGameState)
    local letterBlocks = {}
    for _, obj in ipairs(miniGameState.rackLetterBlockObjs) do
        table.insert(letterBlocks, obj.part)
    end
    return letterBlocks
end

module.applyLetterText = applyLetterText
module.colorLetterText = colorLetterText
module.isDesiredLetter = isDesiredLetter
module.isWordComplete = isWordComplete
module.getAvailLettersDict = getAvailLettersDict
module.colorLetterBorder = colorLetterBorder
module.filterItemsByTag = filterItemsByTag
module.applyStyleFromTemplateBD = applyStyleFromTemplateBD
module.applyLetterImage = applyLetterImage
module.getAvailLettersDict2 = getAvailLettersDict2
module.getAvailWords = getAvailWords
module.getRandomLetter = getRandomLetter
module.getCharFromLetterBlock2 = getCharFromLetterBlock2
module.getLettersNotInWords = getLettersNotInWords
module.styleImageLabelsInBlock = styleImageLabelsInBlock
module.playWordSound = playWordSound
module.liftLetter = liftLetter
module.revertRackLetterBlocksToInit = revertRackLetterBlocksToInit
module.getAllLettersInRack2 = getAllLettersInRack2
module.styleGemFromTemplate = styleGemFromTemplate
module.createPropOnLetterBlock = createPropOnLetterBlock
return module

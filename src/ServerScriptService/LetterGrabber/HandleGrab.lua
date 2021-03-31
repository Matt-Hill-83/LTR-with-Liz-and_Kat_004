local Sss = game:GetService('ServerScriptService')
local RS = game:GetService('ReplicatedStorage')
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local Const4 = require(Sss.Source.Constants.Const_04_Characters)

local module = {processing = false, initComplete = false}

local function isDesiredLetter(availLetters, clickedLetter)
    local char = LetterUtils.getCharFromLetterBlock2(clickedLetter)
    return availLetters[char]
end

local function findFirstMatchingLetterBlock(foundChar, wordMenuState)
    local matchingLetter = nil
    local availWords = LetterUtils.getAvailWords(wordMenuState)

    for _, word in ipairs(availWords) do
        local letter = word.letters[wordMenuState.currentLetterIndex]
        if foundChar == letter.char then
            wordMenuState.activeWord = word
            matchingLetter = letter.instance
            break
        end
    end
    return matchingLetter
end

function module.onGrabLetter(clickedLetter, wordMenuState, player)
    print('onGrabLetter' .. ' - start')
    print('wordMenuState' .. ' - start')
    print(wordMenuState)

    local gameState = PlayerStatManager.getGameState(player)
    if not gameState.wordMenuState then
        gameState.wordMenuState = {}
    end

    if true then
        return
    end

    if module.processing == true then
        return
    end
    module.processing = true

    local activeWord = wordMenuState.activeWord
    local currentLetterIndex = wordMenuState.currentLetterIndex
    local words = wordMenuState.words

    local foundChar = LetterUtils.getCharFromLetterBlock2(clickedLetter)

    local targetLetterBlock = nil

    if activeWord then
        local nextLetterInWord = activeWord.letters[currentLetterIndex]

        -- I'm not sure why I get this condition
        if not nextLetterInWord then
            module.processing = false
            return
        end
        local nextCharInWord = nextLetterInWord.char
        local found = foundChar == nextCharInWord
        if found then
            targetLetterBlock = activeWord.letters[currentLetterIndex].instance
        end
    else
        local availLetters = LetterUtils.getAvailLettersDict2(wordMenuState)
        if isDesiredLetter(availLetters, clickedLetter) then
            targetLetterBlock = findFirstMatchingLetterBlock(foundChar, wordMenuState)
        end
    end

    if targetLetterBlock then
        local clickedBlockClone = clickedLetter:Clone()
        clickedBlockClone.Parent = clickedLetter.Parent
        clickedBlockClone.CanCollide = false
        -- local fire = Instance.new('Fire', clickedBlockClone)
        -- fire.Size = 20

        -- Utils.enableChildWelds({part = clickedBlockClone, enabled = false})

        -- Utils.hideItemAndChildren({item = clickedLetter, hide = true})
        clickedLetter.IsHidden.Value = true
        clickedLetter.IsFound.Value = true

        clickedBlockClone.CFrame = targetLetterBlock.CFrame
        -- LetterUtils.applyStyleFromTemplateBD(
        --     {
        --         targetLetterBlock = targetLetterBlock,
        --         templateName = 'LBPurpleLight'
        --     }
        -- )

        local clickedChar = LetterUtils.getCharFromLetterBlock2(clickedLetter)

        if clickedChar then
            table.insert(wordMenuState.foundLetters, LetterUtils.getCharFromLetterBlock2(clickedLetter))
        end

        clickedBlockClone:Destroy()

        local currentWord = table.concat(wordMenuState.foundLetters, '')
        local wordComplete = table.find(words, currentWord)
        local fireSound = '5207654419'

        wordMenuState.currentLetterIndex = wordMenuState.currentLetterIndex + 1

        if (wordComplete) then
            local currentWord2 = Const4.wordConfigs[currentWord]
            if currentWord2 then
                local soundId = currentWord2.soundId or fireSound
                Utils.playSound(soundId)
            else
                -- Utils.playSound(fireSound)
            end

            wordMenuState.activeWord = nil
            wordMenuState.foundLetters = {}
            wordMenuState.currentLetterIndex = 1

            activeWord.completed = true
        end

        local numAvailableWords = #LetterUtils.getAvailWords(wordMenuState)

        local function callBack(wordMenuState2)
            local function closure()
                wordMenuState2.onWordLettersGone(wordMenuState2)
            end

            local function wrapperForDelay()
                delay(10, closure)
            end
            return wrapperForDelay()
        end

        if numAvailableWords == 0 then
            for _, wordObj in ipairs(wordMenuState.renderedWords) do
                callBack(wordMenuState)
            end
        end
    end
    module.processing = false
end

return module

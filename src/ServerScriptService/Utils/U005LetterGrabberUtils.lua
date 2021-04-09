local Sss = game:GetService('ServerScriptService')
local RS = game:GetService('ReplicatedStorage')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Const_Client = require(RS.Source.Constants.Constants_Client)
local Const4 = require(Sss.Source.Constants.Const_04_Characters)

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local Leaderboard = require(Sss.Source.AddRemoteObjects.Leaderboard)
-- local HandleGrab = require(Sss.Source.LetterGrabber.HandleGrab)

local module = {}

local function getSortedBlocks(tool2)
    local letterBlocks = Utils.getByTagInParent({parent = tool2, tag = 'WordGrabberLetter'})
    Utils.sortListByObjectKey(letterBlocks, 'Name')
    return letterBlocks
end

local function getActiveLetterGrabberBlock(tool)
    local letterBlocks = getSortedBlocks(tool)
    local activeBlock = nil

    for _, block in ipairs(letterBlocks) do
        block.IsActive.Value = false
    end

    for _, block in ipairs(letterBlocks) do
        if block.IsFound.Value == false then
            activeBlock = block
            block.IsActive.Value = true
            break
        end
    end
    return activeBlock
end

local function setActiveLetterGrabberBlock(tool)
    local letterBlocks = getSortedBlocks(tool)

    for _, block in ipairs(letterBlocks) do
        block.IsActive.Value = false
    end

    for _, block in ipairs(letterBlocks) do
        if block.IsFound.Value == false then
            block.IsActive.Value = true
            break
        end
    end
end

local function resetBlocks(tool)
    local letterBlocks = getSortedBlocks(tool)

    for _, block in ipairs(letterBlocks) do
        block.IsActive.Value = false
        block.IsFound.Value = false
    end
end

local function styleLetterGrabberBlocks(tool)
    local letterBlocks = getSortedBlocks(tool)

    for _, block in ipairs(letterBlocks) do
        LetterUtils.applyStyleFromTemplate({targetLetterBlock = block, templateName = 'Grabber_normal'})
    end

    for _, block in ipairs(letterBlocks) do
        if block.IsFound.Value == true then
            LetterUtils.applyStyleFromTemplate({targetLetterBlock = block, templateName = 'Grabber_found'})
        end
    end
end

local function wordFound(tool, player)
    local wordModel = tool.Word
    local targetWord = wordModel.TargetWord.Value

    module.resetBlocks(tool)
    module.setActiveLetterGrabberBlock(tool)
    module.styleLetterGrabberBlocks(tool)

    local gameState = PlayerStatManager.getGameState(player)
    local targetWords = gameState.targetWords
    print('targetWords' .. ' - start')
    print(targetWords)
    if not targetWords then
        return
    end

    local targetWordObj = Utils.getListItemByPropValue(targetWords, 'word', targetWord)

    local fireSound = '5207654419'
    local currentWord2 = Const4.wordConfigs[targetWord]
    if currentWord2 then
        local soundId = currentWord2.soundId or fireSound
        Utils.playSound(soundId)
    end

    if targetWordObj then
        targetWordObj.found = targetWordObj.found + 1
        local updateWordGuiRE = RS:WaitForChild(Const_Client.RemoteEvents.UpdateWordGuiRE)
        updateWordGuiRE:FireClient(player)

        local function destroyParts()
            tool:Destroy()

            if player:FindFirstChild('leaderstats') then
                local wins = player.leaderstats.Wins
                wins.Value = wins.Value + 1
            end

            PlayerStatManager:ChangeStat(player, 'Gems', 1)
            Leaderboard.updateLB()

            local explosionSound = '515938718'
            Utils.playSound(explosionSound, 0.5)
        end

        -- don't give gem
        if false then
            -- if targetWordObj.found == targetWordObj.target then
            delay(1, destroyParts)

            local keyTemplate = Utils.getFromTemplates('HexLetterGemTool')
            local newKey = keyTemplate:Clone()

            local newTool = Utils.getFirstDescendantByType(newKey, 'Tool')
            newTool.Name = targetWord

            local keyPart = newKey.PrimaryPart

            LetterUtils.applyLetterText({letterBlock = newKey, char = targetWord})

            LetterUtils.createPropOnLetterBlock(
                {
                    letterBlock = keyPart,
                    propName = 'KeyName',
                    initialValue = targetWord,
                    propType = 'StringValue'
                }
            )

            newTool.Parent = player.Character
            keyPart.Anchored = false
        end
    end
end

function module.partTouched(touchedBlock, player)
    local tool = Utils.getActiveTool(player, 'LetterGrabber')
    if not tool then
        return
    end

    -- HandleGrab.onGrabLetter({letterBlock = touchedBlock})

    local activeBlock = module.getActiveLetterGrabberBlock(tool)
    print('activeBlock' .. ' - start')
    print(activeBlock)
    if activeBlock then
        local strayLetterChar = touchedBlock.Character.Value
        local activeLetterChar = activeBlock.Character.Value

        if strayLetterChar == activeLetterChar then
            -- letter found
            local gameState = PlayerStatManager.getGameState(player)

            if not gameState.gemPoints then
                gameState.gemPoints = 0
            end
            gameState.gemPoints = gameState.gemPoints + 1
            local updateWordGuiRE = RS:WaitForChild(Const_Client.RemoteEvents.UpdateWordGuiRE)
            updateWordGuiRE:FireClient(player)

            activeBlock.IsFound.Value = true
            activeBlock.IsActive.Value = false

            module.styleLetterGrabberBlocks(tool)

            local newActiveBlock = module.getActiveLetterGrabberBlock(tool)
            if not newActiveBlock then
                wordFound(tool, player)
            end

            local prevCanCollideValue = touchedBlock.CanCollide
            print('prevCanCollideValue' .. ' - start')
            print(prevCanCollideValue)

            local blockGroup = touchedBlock:GetAttribute('BlockGroup')
            print('blockGroup' .. ' - start')
            print(blockGroup)
            if blockGroup then
                local hiddenParts = Utils.hideItemAndChildren2({item = touchedBlock, hide = true})
                touchedBlock.CanCollide = false

                local function showLetter()
                    touchedBlock.CanCollide = prevCanCollideValue
                    Utils.unhideHideItems2({items = hiddenParts})
                end
                delay(2, showLetter)
            else
                local hiddenParts = Utils.hideItemAndChildren2({item = touchedBlock, hide = true})
                -- local prevCanCollideValue = touchedBlock.CanCollide
                touchedBlock.CanCollide = false

                local function showLetter()
                    -- touchedBlock.Anchored = prevAnchoredValue
                    Utils.unhideHideItems({items = hiddenParts})
                    print('prevCanCollideValue' .. ' - start')
                    print(prevCanCollideValue)
                    touchedBlock.CanCollide = prevCanCollideValue
                end
                delay(2, showLetter)
            end
        end
    end
end

module.getActiveLetterGrabberBlock = getActiveLetterGrabberBlock
module.resetBlocks = resetBlocks
module.setActiveLetterGrabberBlock = setActiveLetterGrabberBlock
module.styleLetterGrabberBlocks = styleLetterGrabberBlocks
module.wordFound = wordFound
return module

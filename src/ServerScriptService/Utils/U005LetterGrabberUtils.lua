local Sss = game:GetService('ServerScriptService')
local RS = game:GetService('ReplicatedStorage')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Const_Client = require(RS.Source.Constants.Constants_Client)

local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local Leaderboard = require(Sss.Source.AddRemoteObjects.Leaderboard)

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
    if not targetWords then
        return
    end

    local targetWordObj = Utils.getListItemByPropValue(targetWords, 'word', targetWord)

    Utils.playWordSound2(targetWord)

    if targetWordObj then
        targetWordObj.found = targetWordObj.found + 1
        local updateWordGuiRE = RS:WaitForChild(Const_Client.RemoteEvents.UpdateWordGuiRE)
        updateWordGuiRE:FireClient(player)

        local function destroyParts()
            -- tool:Destroy()

            if player:FindFirstChild('leaderstats') then
                local wins = player.leaderstats.Wins
                wins.Value = wins.Value + 1
            end

            -- PlayerStatManager:ChangeStat(player, 'Gems', 1)
            Leaderboard.updateLB()

            -- local explosionSound = '515938718'
            -- Utils.playSound(explosionSound, 0.5)
        end

        --  give gem
        if true then
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

            newTool.Parent = workspace
            keyPart.Anchored = false
            local pp = player.Character.PrimaryPart

            keyPart.CFrame =
                CFrame.new(pp.CFrame.Position + (20 * pp.CFrame.LookVector), pp.Position) *
                CFrame.Angles(0, math.rad(180), 0)
        end
    end
end

function module.partTouched(touchedBlock, player)
    local tool = Utils.getActiveTool(player, 'LetterGrabber')
    if not tool then
        return
    end

    local activeBlock = module.getActiveLetterGrabberBlock(tool)
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

            local blockGroup = touchedBlock:GetAttribute('BlockGroup')
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
                    touchedBlock.CanCollide = prevCanCollideValue
                end
                delay(2, showLetter)
            end
        end
    end
end

function module.partTouched2(touchedBlock, player, grabber)
    local tool = grabber
    if not tool then
        return
    end

    local activeBlock = module.getActiveLetterGrabberBlock(tool)
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

            local blockGroup = touchedBlock:GetAttribute('BlockGroup')
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

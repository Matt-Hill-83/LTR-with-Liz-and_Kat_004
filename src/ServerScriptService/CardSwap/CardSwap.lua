local Sss = game:GetService('ServerScriptService')
local RS = game:GetService('ReplicatedStorage')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local Const_Client = require(RS.Source.Constants.Constants_Client)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)

local module = {}

function module.serializeTargetWords(targetWords)
    local store = {}
    for _, set in ipairs(targetWords) do
        store[set.word] = set.target
    end
    return store
end

function module.initCardSwaps(props)
    local parentFolder = props.parentFolder
    local regionConfig = props.regionConfig

    local db = false

    local function onTouchWrapper(itemNum)
        local function onTouch(otherPart)
            if db == false then
                local humanoid = otherPart.Parent:FindFirstChildWhichIsA('Humanoid')
                if humanoid then
                    db = true
                    local player = Utils.getPlayerFromHumanoid(humanoid)
                    local targetWords = regionConfig.getTargetWords()[itemNum] or regionConfig.getTargetWords()[1]

                    -- check to see if they already have that card
                    local gameState = PlayerStatManager.getGameState(player)
                    if not gameState then
                        return
                    end

                    local serial1 = module.serializeTargetWords(targetWords)
                    local serial2 = module.serializeTargetWords(gameState.targetWords)

                    local tablesMatch = Utils.deepCompare(serial1, serial2)
                    if not tablesMatch then
                        gameState.targetWords = targetWords
                        local updateWordGuiRE = RS:WaitForChild(Const_Client.RemoteEvents.UpdateWordGuiRE)
                        updateWordGuiRE:FireClient(player)
                    end
                    db = false
                end
            end
        end

        return onTouch
    end

    local items = Utils.getByTagInParent({parent = parentFolder, tag = 'CardSwap'})
    Utils.sortListByObjectKey(items, 'Name')

    for itemNum, item in ipairs(items) do
        item.Touched:Connect(onTouchWrapper(itemNum))
    end
end

return module

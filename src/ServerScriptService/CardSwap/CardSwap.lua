local Sss = game:GetService('ServerScriptService')
local RS = game:GetService('ReplicatedStorage')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local Const_Client = require(RS.Source.Constants.Constants_Client)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)

local module = {}

function module.initCardSwaps(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig

    local db = false

    local function onTouchWrapper(item, targetWords)
        local function onTouch(otherPart)
            local humanoid = otherPart.Parent:FindFirstChildWhichIsA('Humanoid')
            if db == false then
                if humanoid then
                    db = true
                    local player = Utils.getPlayerFromHumanoid(humanoid)

                    local gameState = PlayerStatManager.getGameState(player)
                    gameState.targetWords = targetWords
                    local updateWordGuiRE = RS:WaitForChild(Const_Client.RemoteEvents.UpdateWordGuiRE)
                    updateWordGuiRE:FireClient(player)
                    db = false
                end
            end
        end

        return onTouch
    end

    local items = Utils.getByTagInParent({parent = parentFolder, tag = 'CardSwap'})
    Utils.sortListByObjectKey(items, 'Name')

    for itemNum, item in ipairs(items) do
        local targetWords = levelConfig.getTargetWords()[itemNum]
        item.Touched:Connect(onTouchWrapper(item, targetWords))
    end
end

return module

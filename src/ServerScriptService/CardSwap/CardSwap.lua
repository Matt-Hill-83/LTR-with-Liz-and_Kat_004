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

    local function onTouchWrapper(itemNum)
        print('onTouchWrapper')
        print('onTouchWrapper')
        print('onTouchWrapper')
        print('onTouchWrapper')
        local function onTouch(otherPart)
            print('onTouch' .. ' - start')
            print('onTouch' .. ' - start')
            print('onTouch' .. ' - start')
            print('onTouch' .. ' - start')

            print('db' .. ' - start')
            print(db)
            if db == false then
                local humanoid = otherPart.Parent:FindFirstChildWhichIsA('Humanoid')
                if humanoid then
                    db = true
                    local player = Utils.getPlayerFromHumanoid(humanoid)
                    local targetWords = levelConfig.getTargetWords()[itemNum] or levelConfig.getTargetWords()[1]

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
    print('parentFolder' .. ' - start')
    print(parentFolder)
    print('items' .. ' - start')
    print(items)
    print('---------------------')

    for itemNum, item in ipairs(items) do
        item.Touched:Connect(onTouchWrapper(itemNum))
    end
end

return module

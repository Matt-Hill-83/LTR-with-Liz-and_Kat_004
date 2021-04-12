local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

local function initReplicator(replicator, callBack, authFunction)
    local hitBox = Utils.getFirstDescendantByName(replicator, 'HitBox')

    local reward
    if #replicator.Reward:GetChildren() > 0 then
        local originalReward = replicator.Reward:GetChildren()[1]
        reward = originalReward:Clone()
        -- Take everything out of the Tool and put it in a model that looks like the tool, for display
        -- But it can't be picked up.  Keep this is the replicator for display, and Anchor it.
        local newModel = Instance.new('Model', replicator.Reward)
        for _, child in pairs(originalReward:GetChildren()) do
            if not (child:IsA('Script') or child:IsA('LocalScript') or child:IsA('PackageLink')) then
                if child:IsA('BasePart') then
                    child.Anchored = true
                end
                child.Parent = newModel
            else
                child:Destroy()
            end
        end
    end

    local function onItemTouched(obj)
        local player = game.Players:GetPlayerFromCharacter(obj.Parent)

        if not player then
            return
        end

        local isAuth = true
        if authFunction then
            isAuth = authFunction(player)
        end

        if not isAuth then
            return
        end

        print('reward.Name' .. ' - start')
        print(reward.Name)
        -- If it's not in the backpack and if you are not holding it, clone it.
        local inBackpack = player.Backpack:FindFirstChild(reward.Name)
        print('inBackpack' .. ' - start')
        print(inBackpack)

        if player.Character then
            local humanoid = player.Character:FindFirstChildOfClass('Humanoid')
            humanoid:EquipTool(inBackpack)
        end

        local inHand = player.Character:FindFirstChild(reward.Name)

        if not inBackpack and player.Character and not inHand then
            -- Clone the tool, unanchor it, so it can be taken
            local toGive = reward:Clone()
            for _, child in pairs(toGive:GetChildren()) do
                if child:IsA('BasePart') then
                    child.Anchored = false
                end
            end

            -- Player may have touched the clone or the original, so unequip all.
            -- Then put the correct one in the backpack and equip it, so the other is not grabbed.
            player.Character.Humanoid:UnequipTools()
            toGive.Parent = player.Backpack
            player.Character.Humanoid:EquipTool(toGive)
            if callBack then
                callBack(toGive)
            end
        end
    end

    hitBox.Touched:connect(onItemTouched)
end

module.initReplicator = initReplicator
return module

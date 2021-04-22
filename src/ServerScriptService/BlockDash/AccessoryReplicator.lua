local Sss = game:GetService('ServerScriptService')
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

function module.initAccessoryReplicator(replicator, callBack, authFunction)
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

    return replicator
end

return module

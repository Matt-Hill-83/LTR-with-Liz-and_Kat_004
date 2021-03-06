local Sss = game:GetService('ServerScriptService')
local RS = game:GetService('ReplicatedStorage')
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

function module.initRunFasts(parent)
    local function onTouchRun30(otherPart)
        local humanoid = otherPart.Parent:FindFirstChildWhichIsA('Humanoid')
        if humanoid then
            if humanoid.WalkSpeed == 30 then
                return
            end
            humanoid.WalkSpeed = 30
        end
    end

    local run30s = Utils.getDescendantsByName(parent, 'Run30')
    for _, item in ipairs(run30s) do
        item.Touched:Connect(onTouchRun30)
    end

    local function onTouchRun50(otherPart)
        local humanoid = otherPart.Parent:FindFirstChildWhichIsA('Humanoid')
        if humanoid then
            if humanoid.WalkSpeed == 50 then
                return
            end
            humanoid.WalkSpeed = 50
        end
    end

    local run50s = Utils.getDescendantsByName(parent, 'Run50')
    for _, item in ipairs(run50s) do
        item.Touched:Connect(onTouchRun50)
    end

    local function onTouchRun70(otherPart)
        local humanoid = otherPart.Parent:FindFirstChildWhichIsA('Humanoid')
        if humanoid then
            if humanoid.WalkSpeed == 70 then
                return
            end
            -- humanoid.WalkSpeed = 200
            humanoid.WalkSpeed = 70
        end
    end

    local run70s = Utils.getDescendantsByName(parent, 'Run70')
    for _, item in ipairs(run70s) do
        item.Touched:Connect(onTouchRun70)
    end

    local function onTouchRun90(otherPart)
        local humanoid = otherPart.Parent:FindFirstChildWhichIsA('Humanoid')
        if humanoid then
            if humanoid.WalkSpeed == 90 then
                return
            end
            humanoid.WalkSpeed = 90
        end
    end

    local run90s = Utils.getDescendantsByName(parent, 'Run90')
    for _, item in ipairs(run90s) do
        item.Touched:Connect(onTouchRun90)
    end
end

return module

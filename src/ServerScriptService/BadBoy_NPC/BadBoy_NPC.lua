local badBoy = script.Parent
local badBoyName = badBoy.Name
local BBhumanoindRootPart = badBoy.HumanoidRootPart
local waitInterval = 1 + math.random()
local b = 1 + math.random()
local loopWaitInterval = .6

-- set something related to walk speed
if true then
    wait(waitInterval)
    local a = nil
    local children = badBoy:GetChildren()

    -- this does nothing
    for index = 1, #children do
        local subChild = children[index]
        if (subChild.className == 'Humanoid') then
            a = subChild.Name
        end
    end
    waitInterval = math.floor(b * 100)
    loopWaitInterval = 7 / badBoy.Humanoid.WalkSpeed
end

local h = 100
local n = BBhumanoindRootPart
local BBPosition = BBhumanoindRootPart.Position
local l = n.Position
local d = BBPosition * 2
local j = CFrame.new(BBPosition)
local i = 0
local b = 100
local c = 0
local distq = 100
local o = 0
local g = false

function findNearestTorso(b)
    local children = game.Workspace:GetChildren()
    local distance = 600
    local childHrp = nil
    local childf = nil
    local child = nil

    local torso = nil

    for a = 1, #children do
        child = children[a]
        if child.className == 'Model' then
            childHrp = child:findFirstChild('HumanoidRootPart')
            if childHrp ~= nil then
                childf = child:findFirstChild('Humanoid')
                if childf ~= nil and (childf.Health > 0) and (child.Name ~= badBoyName) then
                    if (childHrp.Position - b).magnitude < distance then
                        torso = childHrp
                        distance = (childHrp.Position - b).magnitude
                    end
                end
            end
        end
    end
    return torso
end

function DrawRay(c, a)
    local newRay = Ray.new(c, (a).Unit * 7)
    local vara, varb = game.Workspace:FindPartOnRay(newRay, badBoy)
    if true then
        local partd = Instance.new('Part', badBoy)
        if vara then
            partd.BrickColor = BrickColor.new('Bright red')
        else
            partd.BrickColor = BrickColor.new('New Yeller')
        end
        partd.Transparency = 0.1
        partd.Anchored = true
        partd.CanCollide = false
        partd.FormFactor = Enum.FormFactor.Custom

        local testa = (varb - c).Magnitude
        partd.Size = Vector3.new(0.6, 0.6, testa)
        partd.CFrame = CFrame.new(varb, c) * CFrame.new(0, 0, -testa / 2)
        game.Debris:AddItem(partd, .9)
    end
    return vara
end

function FireRayToward()
    g = false
    local c = j * Vector3.new(1, 0, 0) - Vector3.new(0, .5, 0)
    local a = j * Vector3.new(1, 0, 0) - j * Vector3.new(-1, 0, 0)
    local vectorb = j.LookVector * 7
    local a = vectorb - a + Vector3.new(0, 2, 0)
    local rayd = DrawRay(c, a)
    if rayd then
        if n.Parent == rayd.Parent then
            if rayd.Name ~= 'HumanoidRootPart' and rayd.Name ~= 'Head' then
                rayd:BreakJoints()
                rayd.CanCollide = true
            else
                rayd.Parent.Humanoid:TakeDamage(15)
            end
        elseif rayd.Parent.Name == badBoyName then
            if distq > 0 then
                d = nil
            elseif distq == 0 then
                d = BBhumanoindRootPart
            end
        end
    end
    if rayd ~= BBhumanoindRootPart then
        if rayd then
            if (rayd.Name == 'Truss' and n.Position.y > BBPosition.y - 3) or n.Parent == rayd.Parent then
                rayd = nil
                g = true
            else
                if rayd.Name == 'Terrain' then
                    rayd = nil
                else
                    rayd = DrawRay(c + Vector3.new(0, 4.5, 0), a)
                    if rayd == nil then
                        badBoy.Humanoid.Jump = true
                    end
                end
            end
        else
            local a = BBPosition.y
            if n then
                a = n.Position.y
            else
                i = 0
            end
            if BBPosition.y - 3 < a then
                rayd = DrawRay(BBPosition + vectorb * .85, Vector3.new(0, -7, 0))
                if rayd == nil then
                    rayd = true
                else
                    rayd = nil
                end
            end
        end
    end
    return rayd
end

function FireAtPlayer()
    j = CFrame.new(BBPosition, Vector3.new(l.x, BBPosition.y, l.z))
    local a = FireRayToward()
    return a
end
function FireRay()
    j = CFrame.new(BBPosition, BBPosition + Vector3.new(q, 0, o))
    local a = FireRayToward()
    return a
end
function TurnRight()
    if distq == 0 then
        distq = -o
        o = 0
    else
        o = distq
        distq = 0
    end
end
function TurnLeft()
    if distq == 0 then
        distq = o
        o = 0
    else
        o = -q
        distq = 0
    end
end

while BBhumanoindRootPart do
    BBPosition = BBhumanoindRootPart.Position
    local a = workspace.Terrain
    local e = (BBPosition - d).magnitude
    if n == nil then
        i = 0
    end
    if i == 0 then
        n = findNearestTorso(BBPosition)
        if n ~= nil then
            a = n
            l = n.Position
            if FireAtPlayer() or e < 1 then
                distq = (l.x - BBPosition.x)
                o = (l.z - BBPosition.z)
                if math.abs(q) > math.abs(o) then
                    if distq < 0 then
                        distq = -h
                    else
                        distq = h
                        -- Xdag = distq
                        if o < 0 then
                            -- Zdag = -h
                        else
                            -- Zdag = h
                        end
                    end
                    o = 0
                else
                    if o < 0 then
                        o = -h
                    else
                        o = h
                    end
                    distq = 0
                end
                b = distq
                c = o
                i = 1
            end
        else
            BBPosition = BBPosition * 2
        end
    else
        if g == false or n.Position.y < BBPosition.y + 3 then
            if e >= 1 then
                TurnRight()
            end
        end
    end
    if e < 1 then
        TurnLeft()
    end
    if i == 1 then
        if FireRay() then
            TurnLeft()
            if FireRay() then
                TurnLeft()
                if FireRay() then
                    TurnLeft()
                    if FireRay() then
                        badBoy.Humanoid.Jump = true
                    end
                end
            end
        else
            if distq == b and c == o then
                i = 0
            end
        end
        l = BBPosition + Vector3.new(q, 0, o)
    end
    script.Parent.Humanoid:MoveTo(l, a)
    d = BBPosition
    wait(loopWaitInterval)
end

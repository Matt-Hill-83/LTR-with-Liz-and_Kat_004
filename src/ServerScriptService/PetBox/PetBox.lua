local Sss = game:GetService('ServerScriptService')
local ServerStorage = game:GetService('ServerStorage')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

function module.initPetBox(props)
    local hexConfigs = props.configs or {}
    local parentFolder = props.parentFolder

    local petBox = Utils.getFirstDescendantByName(parentFolder, 'PetBox')
    if not petBox then
        return
    end

    local pet = Utils.getFirstDescendantByName(petBox, 'Pet')
    local petModel = Utils.getFirstDescendantByName(petBox, 'PetModel')
    local box = Utils.getFirstDescendantByName(petBox, 'Box')
    local touchBox = Utils.getFirstDescendantByName(petBox, 'TouchBox')
    local boxWalls = box:getChildren()
    print('boxWalls' .. ' - start')
    print(boxWalls)
    print('pet' .. ' - start')
    print(pet)

    print('touchBox' .. ' - start')
    print(touchBox)

    -- local pet = script.Parent

    function givePet(touchedBlock, player)
        if player then
            local character = player.Character
            if character then
                local humRootPart = character.HumanoidRootPart
                local newPet = petModel:Clone()

                newPet.Parent = character
                local petPart = newPet.PrimaryPart
                -- petPart.CFrame = touchBox.CFrame

                local bodyPos = Instance.new('BodyPosition', petPart)
                bodyPos.MaxForce = Vector3.new(10000, 10000, 10000)
                -- bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

                local bodyGyro = Instance.new('BodyGyro', petPart)
                bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

                while wait() do
                    bodyPos.Position = humRootPart.Position + Vector3.new(8, 8, 8)
                    bodyGyro.CFrame = humRootPart.CFrame
                end
            end
        end
    end

    -- game.Players.PlayerAdded:Connect(
    --     function(player)
    --         player.CharacterAdded:Connect(
    --             function(char)
    --                 givePet(player)
    --             end
    --         )
    --     end
    -- )
    touchBox.Touched:Connect(Utils.onTouchHuman(touchBox, givePet))
end

return module

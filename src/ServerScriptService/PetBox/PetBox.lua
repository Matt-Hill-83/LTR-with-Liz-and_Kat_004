local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local VendingMachine = require(Sss.Source.VendingMachine.VendingMachine)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)

local module = {}

function module.initPetBox(props)
    local levelConfig = props.levelConfig or {}
    local parentFolder = props.parentFolder

    local petBox = Utils.getFirstDescendantByName(parentFolder, 'PetBox')
    if not petBox then
        return
    end

    local pet = Utils.getFirstDescendantByName(petBox, 'Pet')
    local petModel = Utils.getFirstDescendantByName(petBox, 'PetModel')
    local touchBox = Utils.getFirstDescendantByName(petBox, 'TouchBox')
    print('pet' .. ' - start')
    print(pet)

    print('touchBox' .. ' - start')
    print(touchBox)

    -- local pet = script.Parent
    local newPet2 = {pet = nil}

    local function givePet(touchedBlock, player)
        if player then
            local gameState = PlayerStatManager.getGameState(player)
            local character = player.Character
            if character then
                local humRootPart = character.HumanoidRootPart
                local newPet = petModel:Clone()
                newPet2.pet = newPet
                newPet.Parent = character
                local petPart = newPet.PrimaryPart
                -- petPart.CFrame = touchBox.CFrame

                local bodyPos = Instance.new('BodyPosition', petPart)
                bodyPos.MaxForce = Vector3.new(100000, 100000, 100000)

                local bodyGyro = Instance.new('BodyGyro', petPart)
                bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

                while wait() do
                    bodyPos.Position = humRootPart.Position
                    petPart.CFrame = CFrame.new(petPart.Position, humRootPart.Position)
                    -- bodyPos.Position =
                    --     humRootPart.Position + humRootPart.CFrame.lookVector * -1 + humRootPart.CFrame.upVector * 2 +
                    --     humRootPart.CFrame.rightVector * 3
                    -- bodyGyro.CFrame = humRootPart.CFrame
                    -- bodyGyro.CFrame = humRootPart.CFrame * CFrame.new(3, 0, -3)
                end
            end
        end
    end

    touchBox.Touched:Connect(Utils.onTouchHuman(touchBox, givePet))

    local function onComplete()
        print('newPet2' .. ' - start')
        print(newPet2.pet)
        print('complete')
        print('complete')
        print('complete')
        print('complete-------------')
    end

    VendingMachine.initVendingMachine(
        {tag = 'M-VendingMachine_002', parentFolder = petBox, levelConfig = levelConfig, onComplete = onComplete}
    )
end

return module

local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local VendingMachine = require(Sss.Source.VendingMachine.VendingMachine)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local PetService = require(Sss.Source.PetService.PetService)

local module = {}

function module.initPetBox(props)
    local levelConfig = props.levelConfig or {}
    local parentFolder = props.parentFolder

    local petBox = Utils.getFirstDescendantByName(parentFolder, 'PetBox')
    if not petBox then
        return
    end

    -- local pet = Utils.getFirstDescendantByName(petBox, 'Pet')
    local petModel = Utils.getFirstDescendantByName(petBox, 'PetModel')
    local touchBox = Utils.getFirstDescendantByName(petBox, 'TouchBox')

    local petService = nil
    local function givePet(touchedBlock, player)
        print('givePet' .. ' - start')
        print(givePet)

        local gameState = PlayerStatManager.getGameState(player)
        print('gameState' .. ' - start')
        print(gameState)
        if gameState.pet then
            return
        end

        if player then
            petService = PetService:PlayerAdded(player)
            print('petService' .. ' - start')
            print('petService' .. ' - start')
            print('petService' .. ' - start')
            print('petService' .. ' - start')
            print(petService)
        end

        if false then
            local character = player.Character
            if character then
                local humRootPart = character.HumanoidRootPart
                local newPet = petModel:Clone()
                local gameState = PlayerStatManager.getGameState(player)
                gameState.pet = newPet
                newPet.Parent = petBox
                local petPart = newPet.PrimaryPart

                local bodyPos = Instance.new('BodyPosition', petPart)
                bodyPos.MaxForce = Vector3.new(100000, 100000, 100000)

                while true do
                    game:GetService('RunService').Heartbeat:Wait()
                    bodyPos.Position = humRootPart.Position
                    petPart.CFrame = CFrame.new(petPart.Position, humRootPart.Position)
                end
            end
        end
    end

    touchBox.Touched:Connect(Utils.onTouchHuman(touchBox, givePet))
    local function onComplete(player)
        print('onComplete' .. ' - start')
        print('onComplete' .. ' - start')
        print('onComplete' .. ' - start')

        if player then
            local gameState3 = PlayerStatManager.getGameState(player)
            if gameState3.hasPet then
                return
            end
            local character = player.Character
            if character then
                -- local humRootPart = character.HumanoidRootPart
                local myPet
                local gameState = PlayerStatManager.getGameState(player)
                myPet = gameState.pet
                if not myPet then
                    petService = PetService:PlayerAdded(player)
                    myPet = gameState.pet
                end
                myPet.Parent = character
                local petPart = myPet.PrimaryPart

                -- the sphere is there to help steer the dog when it is in the cage
                local sphere = Utils.getFirstDescendantByName(myPet, 'Sphere')
                print('sphere' .. ' - start')
                print('sphere' .. ' - start')
                print('sphere' .. ' - start')
                print('sphere' .. ' - start')
                print(sphere)
                sphere.CanCollide = false
                sphere:Destroy()
                -- petPart.CFrame = touchBox.CFrame

                local bodyPos = petPart.BodyPosition

                print('complete')
                print('complete')
                print('complete')

                gameState.hasPet = true
                bodyPos:Destroy()

                local alignOrientation = Utils.getFirstDescendantByType(myPet, 'AlignOrientation')
                alignOrientation.Enabled = true
                local alignPosition = Utils.getFirstDescendantByType(myPet, 'AlignPosition')
                alignPosition.Enabled = true

                print('complete-------------')
            end
        end
    end

    VendingMachine.initVendingMachine(
        {tag = 'M-VendingMachine_002', parentFolder = petBox, levelConfig = levelConfig, onComplete = onComplete}
    )
end

return module

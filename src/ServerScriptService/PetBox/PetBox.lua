local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local VendingMachine = require(Sss.Source.VendingMachine.VendingMachine_002)
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

    local touchBox = Utils.getFirstDescendantByName(petBox, 'TouchBox')
    local center = Utils.getFirstDescendantByName(petBox, 'Center')

    local function givePet(touchedBlock, player)
        local gameState = PlayerStatManager.getGameState(player)
        if gameState.pet then
            return
        end

        if player then
            local test = PetService:PlayerAdded(player)
        end
        gameState.pet.PrimaryPart.CFrame = center.CFrame
    end

    touchBox.Touched:Connect(Utils.onTouchHuman(touchBox, givePet))

    local function onComplete(player)
        if player then
            local gameState3 = PlayerStatManager.getGameState(player)
            if gameState3.hasPet then
                return
            end
            local character = player.Character
            if character then
                local myPet
                local gameState = PlayerStatManager.getGameState(player)
                myPet = gameState.pet
                if not myPet then
                    PetService:PlayerAdded(player)
                    myPet = gameState.pet
                end
                myPet.Parent = character
                local petPart = myPet.PrimaryPart

                -- the sphere is there to help steer the dog when it is in the cage
                local sphere = Utils.getFirstDescendantByName(myPet, 'Sphere')
                sphere.CanCollide = false
                sphere:Destroy()
                petPart.CFrame = center.CFrame
                local sound = Utils.getFirstDescendantByName(myPet, 'Sound')
                sound.Playing = false

                local bodyPos = petPart.BodyPosition

                gameState.hasPet = true
                bodyPos:Destroy()

                local alignOrientation = Utils.getFirstDescendantByType(myPet, 'AlignOrientation')
                alignOrientation.Enabled = true
                local alignPosition = Utils.getFirstDescendantByType(myPet, 'AlignPosition')
                alignPosition.Enabled = true
            end
        end
    end

    VendingMachine.initVendingMachine_002(
        {tag = 'M-VendingMachine_002', parentFolder = petBox, levelConfig = levelConfig, onComplete = onComplete}
    )
end

return module

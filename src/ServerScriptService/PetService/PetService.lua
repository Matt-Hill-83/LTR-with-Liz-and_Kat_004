local Sss = game:GetService('ServerScriptService')
local Players = game:GetService('Players')
local CS = game:GetService('CollectionService')
local RS = game:GetService('RunService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)

local uni_001 = Utils.getFromTemplates('unicorn_baby_001')
local corgi_001 = Utils.getFromTemplates('Corgi_002')
local petInfos = {
    Corgi_001 = {
        Model = corgi_001,
        PosOffset = Vector3.new(3, -3, 6), -- the attachment offset
        AlignPosMaxForce = 200000,
        AlignPosResponsiveness = 15,
        AlignOriResponsiveness = 20
    },
    Uni_001 = {
        Model = uni_001,
        PosOffset = Vector3.new(6, 0, 6), -- the attachment offset
        AlignPosMaxForce = 200000,
        AlignPosResponsiveness = 15,
        AlignOriResponsiveness = 20
    }
}

local PetService = {Pets = {}, PetInfos = petInfos}

-- returns a CS tag for a player, for tagging and deleting pets
local function getPetTag(player)
    return player.Name .. 'Pet'
end

-- creates a new pet model, and sets up the constraints
local function createPet(player, character, petInfo)
    print('createPet')
    print('createPet')
    print('createPet')
    print('createPet')
    local petTag = getPetTag(player)

    local pet = petInfo.Model:Clone()
    print('pet' .. ' - start')
    print('pet' .. ' - start')
    print('pet' .. ' - start')
    print('pet' .. ' - start')
    print(pet)

    local petPrimary = pet.PrimaryPart
    print('petPrimary' .. ' - start')
    print('petPrimary' .. ' - start')
    print('petPrimary' .. ' - start')
    print('petPrimary' .. ' - start')
    print(petPrimary)
    local characterPrimary = character.PrimaryPart

    local alignPosAttachment0 = Instance.new('Attachment', petPrimary)
    alignPosAttachment0.Name = 'att-position'
    local alignPosAttachment1 = Instance.new('Attachment', characterPrimary)
    alignPosAttachment1.Name = 'att-position-char-ppp'
    alignPosAttachment1.Position = petInfo.PosOffset

    local alignOriAttachment0 = Instance.new('Attachment', petPrimary)
    local alignOriAttachment1 = Instance.new('Attachment', characterPrimary)
    alignOriAttachment0.Name = 'att-orientation'

    local alignPosition = Instance.new('AlignPosition')
    alignPosition.Attachment0 = alignPosAttachment0
    alignPosition.Attachment1 = alignPosAttachment1
    alignPosition.MaxForce = petInfo.AlignPosMaxForce
    alignPosition.Responsiveness = petInfo.AlignPosResponsiveness
    alignPosition.ApplyAtCenterOfMass = true
    alignPosition.RigidityEnabled = true
    alignPosition.Parent = petPrimary

    local alignOrientation = Instance.new('AlignOrientation')
    alignOrientation.Responsiveness = petInfo.AlignOriResponsiveness
    alignOrientation.Attachment0 = alignOriAttachment0
    alignOrientation.Attachment1 = alignOriAttachment1
    alignOrientation.Parent = petPrimary

    CS:AddTag(pet, petTag) -- to delete the pet when needed using :GetTagged()
    -- if not petPrimary then
    --     return
    -- end
    petPrimary.CanCollide = false
    -- petPrimary.CFrame = characterPrimary.CFrame -- moves the pet to the player initially so it doesnt have to fly across the map
    pet.Parent = workspace
    -- petPrimary:SetNetworkOwner(player) -- gives client control

    local humRootPart = character.HumanoidRootPart

    alignOrientation.Enabled = false
    alignPosition.Enabled = false

    local gameState = PlayerStatManager.getGameState(player)
    print('gameState' .. ' - start')
    print('gameState' .. ' - start')
    print('gameState' .. ' - start')
    print('gameState' .. ' - start')
    print('gameState' .. ' - start')
    print(gameState)

    gameState.pet = pet

    local gameState2 = PlayerStatManager.getGameState(player)
    print('gameState2' .. ' - start')
    print('gameState2' .. ' - start')
    print('gameState2' .. ' - start')
    print('gameState2' .. ' - start')
    print(gameState2)

    local bodyPos = Instance.new('BodyPosition', petPrimary)
    bodyPos.MaxForce = Vector3.new(100000, 100000, 100000)

    local function timerLoop()
        bodyPos.Position = humRootPart.Position
        petPrimary.CFrame = CFrame.new(petPrimary.Position, humRootPart.Position)

        if not gameState.hasPet then
            delay(0.01, timerLoop)
        end
    end
    timerLoop()
end

-- deletes a player's pet model, using CS to retrieve any existing tagged pet
local function deletePet(player)
    local petTag = getPetTag(player)
    for _, pet in ipairs(CS:GetTagged(petTag)) do
        pet:Destroy()
    end
end

-- sets a player's pet, calls createPet() if they have a character
function PetService:SetPet(player, petInfo)
    if self.Pets[player] then
        PetService:UnsetPet(player)
    end

    self.Pets[player] = petInfo
    local character = player.Character

    if character then
        local humanoid = character:FindFirstChild('Humanoid')
        if humanoid and humanoid.Health > 0 then -- creates pet model if player has an alive character
            createPet(player, character, petInfo)
        end
    end
end

function PetService:UnsetPet(player)
    if self.Pets[player] then
        deletePet(player)
        self.Pets[player] = nil
    end
end

function PetService:PlayerAdded(player)
    local petTag = getPetTag(player)

    -- PetService:SetPet(player, PetService.PetInfos.Pet1) -- set their pet, can be used outside of module, this is just here for testing
    local rand = Utils.genRandom(1, 2)
    print('rand' .. ' - start')
    print(rand)
    local pet = true and 'Corgi_001' or 'Uni_001'
    -- local pet = false and 'Corgi_001' or 'Uni_001'
    -- local pet = rand == 1 and 'Corgi_001' or 'Uni_001'
    print('pet' .. ' - start')
    print(pet)

    -- PetService:SetPet(player, PetService.PetInfos.Corgi_001) -- set their pet, can be used outside of module, this is just here for testing
    PetService:SetPet(player, PetService.PetInfos[pet]) -- set their pet, can be used outside of module, this is just here for testing

    local function characterAdded(character)
        local pet = PetService.Pets[player]

        if pet and #CS:GetTagged(petTag) == 0 then -- if a pet is set and  no existing pet model exists, create one
            createPet(player, character, pet)
        end

        character.Humanoid.Died:Connect(
            function()
                -- player died, delete their pet
                deletePet(player)
            end
        )
    end
    characterAdded(player.Character or player.CharacterAdded:Wait()) -- gets the first character, either by getting it directly if it exists, or waiting for it
    player.CharacterAdded:Connect(characterAdded) -- connects the CharacterAdded event for any future characters
end

local function playerRemoving(player)
    PetService:UnsetPet(player)
end

-- calls the playerAdded() function for all players that exist before we set up the PlayerAdded event
for _, player in ipairs(Players:GetPlayers()) do
    -- playerAdded(player)
end

-- Players.PlayerAdded:Connect(playerAdded)
Players.PlayerRemoving:Connect(playerRemoving)

-- local module = {initPet = playerAdded}

-- return module
return PetService

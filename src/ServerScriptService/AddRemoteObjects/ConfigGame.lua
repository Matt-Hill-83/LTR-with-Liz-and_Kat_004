local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')
local RS = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')

local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)
local Const_Client = require(RS.Source.Constants.Constants_Client)

local MarketplaceService = game:GetService('MarketplaceService')
local Players = game:GetService('Players')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Constants = require(Sss.Source.Constants.Constants)
local PlayerStatManager = require(Sss.Source.AddRemoteObjects.PlayerStatManager)
local InvisiWall = require(Sss.Source.InvisiWall.InvisiWall)

local module = {}

function module.addMeetCreatorBadge()
    local badgeService = game:GetService('BadgeService')
    local creatorBadgeId = 2124704156

    local makerId = 304010153
    local makerInGame = false -- This will go to true while the maker is in-game

    game:GetService('Players').PlayerAdded:Connect(
        function(plr)
            if plr.UserId == makerId then
                makerInGame = true -- Maker in game
                local plrs = game:GetService('Players'):GetPlayers() -- Moved inside the event to get the up-to-date list
                for i, v in pairs(plrs) do
                    if not badgeService:UserHasBadgeAsync(v.UserId, creatorBadgeId) then
                        badgeService:AwardBadge(v.UserId, creatorBadgeId) -- Added userId argument
                    end
                end
            elseif makerInGame then -- If the new player isn't the maker, but the maker is in the game
                if not badgeService:UserHasBadgeAsync(plr.UserId, creatorBadgeId) then
                    badgeService:AwardBadge(plr.UserId, creatorBadgeId)
                end
            end
        end
    )

    game:GetService('Players').PlayerRemoving:Connect(
        function(plr)
            if plr.UserId == makerId then
                makerInGame = false -- Maker has left the building
            end
        end
    )
end

function module.addMeetLizBadge()
    local badgeService = game:GetService('BadgeService')
    local creatorBadgeId = 2124704159

    local makerId = 1994483837
    local makerInGame = false -- This will go to true while the maker is in-game

    game:GetService('Players').PlayerAdded:Connect(
        function(plr)
            if plr.UserId == makerId then
                makerInGame = true -- Maker in game
                local plrs = game:GetService('Players'):GetPlayers() -- Moved inside the event to get the up-to-date list
                for i, v in pairs(plrs) do
                    if not badgeService:UserHasBadgeAsync(v.UserId, creatorBadgeId) then
                        badgeService:AwardBadge(v.UserId, creatorBadgeId) -- Added userId argument
                    end
                end
            elseif makerInGame then -- If the new player isn't the maker, but the maker is in the game
                if not badgeService:UserHasBadgeAsync(plr.UserId, creatorBadgeId) then
                    badgeService:AwardBadge(plr.UserId, creatorBadgeId)
                end
            end
        end
    )

    game:GetService('Players').PlayerRemoving:Connect(
        function(plr)
            if plr.UserId == makerId then
                makerInGame = false -- Maker has left the building
            end
        end
    )
end

--
--
--

function module.configPlayers(props)
    print('configPlayers---------------------------------------')
    local levelConfig = props.levelConfig
    Players.RespawnTime = 0

    module.addMeetCreatorBadge()
    module.addMeetLizBadge()

    local function onCharacterAdded(character)
        print('onCharacterAdded+++++++++++++++++++++++++++++++++')
        character:WaitForChild('Humanoid').WalkSpeed = Constants.gameConfig.walkSpeed

        local player = Players:GetPlayerFromCharacter(character)

        local updateWordGuiRE2 = RS:WaitForChild(Const_Client.RemoteEvents.UpdateWordGuiRE)

        local gameState = PlayerStatManager.getGameState(player)
        local targetWords

        -- Wait so that gui can exist
        if gameState.initComplete == true then
            wait(2)
            targetWords = gameState.targetWords
        else
            local humanoid = character:WaitForChild('Humanoid')

            local acc = Utils.getFirstDescendantByName(workspace, 'LetterGrabberAcc')
            humanoid:AddAccessory(acc)
            local letterGrabber = Utils.getFirstDescendantByName(acc, 'LetterGrabber')
            local grabbersConfig = {
                word = 'RAT',
                letterGrabber = letterGrabber,
                player = player
                -- parentFolder = parentFolder,
                -- positioner = positioner
            }

            LetterGrabber.initLetterGrabberSimple(grabbersConfig)
            --
            --

            targetWords = levelConfig.regions[1].getTargetWords()[1]
            print('targetWords------------------------>>>' .. ' - start')
            print(targetWords)
            gameState.targetWords = targetWords
        end

        updateWordGuiRE2:FireClient(player)
        gameState.initComplete = true
    end

    local function onPlayerAdded(player)
        player.CharacterAdded:Connect(onCharacterAdded)

        -- newPlayerEvent:FireAllClients()
    end

    Players.PlayerAdded:Connect(onPlayerAdded)
    Players.PlayerRemoving:Connect(
        function(player)
        end
    )
end

local function configGamePass1()
    local gamePassID = 14078170
    local function onPlayerAdded(player)
        local hasPass = false

        -- Check if the player already owns the game pass
        local success, message =
            pcall(
            function()
                hasPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePassID)
            end
        )

        -- If there's an error, issue a warning and exit the function
        if not success then
            warn('Error while checking if player has pass: ' .. tostring(message))
            return
        end

        if hasPass == true then
            -- Assign this player the ability or bonus related to the game pass
            local function onCharacterAdded(character)
                local humanoid = character:WaitForChild('Humanoid')
                humanoid.WalkSpeed = 80
                -- local Hair = game.ServerStorage.Hair
                -- humanoid:AddAccessory(Hair:Clone())
                local function transport()
                    -- player.RespawnLocation = game.Workspace.Start
                    -- character.HumanoidRootPart.CFrame =
                    --     CFrame.new(Vector3.new(-245, 211, 1340))
                end

                delay(1, transport)
            end
            player.CharacterAdded:Connect(onCharacterAdded)
        end
    end
    Players.PlayerAdded:Connect(onPlayerAdded)
end

local function configGamePass2()
    print('configGamePass2' .. ' - start')
    -- local MarketplaceService = game:GetService('MarketplaceService')
    -- local Players = game:GetService('Players')

    local gamePassID = 16013032 -- Change this to your game pass ID

    local function onPlayerAdded(player)
        local hasPass = false

        -- Check if the player already owns the game pass
        local success, message =
            pcall(
            function()
                hasPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePassID)
            end
        )

        -- If there's an error, issue a warning and exit the function
        if not success then
            warn('Error while checking if player has pass: ' .. tostring(message))
            return
        end

        if hasPass == true then
            -- Assign this player the ability or bonus related to the game pass
            local function onCharacterAdded(character)
                local humanoid = character:WaitForChild('Humanoid')
                humanoid.WalkSpeed = 80
                -- local Hair = game.ServerStorage.Hair
                -- humanoid:AddAccessory(Hair:Clone())
                local function transport()
                    -- player.RespawnLocation = game.Workspace.Spawn_VIP
                    -- character.HumanoidRootPart.CFrame = Spawn_VIP.CFrame
                end

                delay(1, transport)
            end
            player.CharacterAdded:Connect(onCharacterAdded)
        end
    end

    -- Connect "PlayerAdded" events to the "onPlayerAdded()" function
    Players.PlayerAdded:Connect(onPlayerAdded)
end

local function configBadges()
    game:GetService('Players').PlayerAdded:Connect(
        function(player)
            player.CharacterAdded:Connect(
                function(character)
                    character:WaitForChild('Humanoid').Died:Connect(
                        function()
                        end
                    )
                end
            )
        end
    )
end

local function setVisibility()
    local taggedPartsDestroy = CS:GetTagged('Destroy')
    for _, item in ipairs(taggedPartsDestroy) do
        item:Destroy()
    end

    local disabled = CS:GetTagged('Disable')
    for _, item in ipairs(disabled) do
        item.Enabled = false
    end

    if Constants.gameConfig.transparency then
        local taggedPartsTransparent = CS:GetTagged('Transparent')
        for _, item in ipairs(taggedPartsTransparent) do
            if item:IsA('BasePart') then
                item.Transparency = 1
            end
        end
    end

    local canCollideOff = CS:GetTagged('CanCollideOff')
    for _, item in ipairs(canCollideOff) do
        if item:IsA('BasePart') then
            item.CanCollide = false
        end
    end

    if not Constants.gameConfig.isDev then
        local tagBaseWallTransparent = CS:GetTagged('BaseWallTransparent')
    -- for _, wall in ipairs(tagBaseWallTransparent) do
    --     Utils.setItemHeight({item = wall, height = 20})
    --     local newWallHeight = 1
    --     -- wall.Transparency = 1
    --     wall.Transparency = 0.8
    --     wall.CanCollide = true
    --     wall.Anchored = true

    --     local newWall = wall:Clone()

    --     newWall.Parent = wall.Parent
    --     newWall.Size = newWall.Size + Vector3.new(0, newWallHeight - newWall.Size.Y, 0)
    --     newWall.Position = newWall.Position + Vector3.new(0, -(wall.Size.Y - newWall.Size.Y) / 2, 0)
    --     newWall.Transparency = 0
    --     CS:RemoveTag(newWall, 'BaseWallTransparent')
    -- end
    end

    if not Constants.gameConfig.isDev then
        local tagBaseWallTransparent = CS:GetTagged('ConveyorWallTransparent')

        local realWallHeight = 24
        local invisiWallHeight = 12

        for _, wall in ipairs(tagBaseWallTransparent) do
            Utils.setItemHeight({item = wall, height = realWallHeight})
            local newWallHeight = invisiWallHeight
            -- wall.Transparency = 1
            wall.Transparency = 0.8
            wall.CanCollide = true
            wall.Anchored = true

            local newWall = wall:Clone()

            newWall.Parent = wall.Parent
            newWall.Size = newWall.Size + Vector3.new(0, newWallHeight - newWall.Size.Y, 0)
            newWall.Position = newWall.Position + Vector3.new(0, -(wall.Size.Y - newWall.Size.Y) / 2, 0)
            -- newWall.Transparency = 0
            -- CS:RemoveTag(newWall, "ConveyorWallTransparent")
        end
    end
end

function module.configGame(props)
    setVisibility()
    configBadges()

    --
    InvisiWall.setAllInvisiWalls(
        {
            parentFolder = workspace,
            thickness = 1,
            -- height = 6,
            height = 18,
            shortHeight = 2,
            -- shortHeight = 6,
            shortWallProps = {
                Transparency = 0,
                -- Transparency = 0.8,
                BrickColor = BrickColor.new('Maroon'),
                Material = Enum.Material.Cobblestone
            },
            wallProps = {Transparency = 1}
            -- wallProps = {Transparency = 0.5}
        }
    )

    Utils.hideFrontLabels(workspace)
    local allSpawnLocations = Utils.getDescendantsByType(workspace, 'SpawnLocation')

    for _, item in ipairs(allSpawnLocations) do
        if item.Name == Constants.gameConfig.activeSpawn then
            item.Enabled = true
        else
            item.Enabled = false
        end
    end
end

function module.preRunConfig(props)
    configGamePass1()
    configGamePass2()
    module.configPlayers(props)
    if RunService:IsRunMode() then
    end

    if RunService:IsClient() then
    else
    end

    if RunService:IsServer() then
    else
    end

    if RunService:IsRunning() then
    else
    end
end

return module

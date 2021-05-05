local Sss = game:GetService('ServerScriptService')
local DataStore = game:GetService('DataStoreService')
local Players = game:GetService('Players')

local Utils_2 = require(Sss.Source.Utils.U002InstanceUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local module = {}
local delayBase = 30

function module.setHumanoid(userId, statue)
    local success, errorMsg =
        pcall(
        function()
            local desc = Players:GetHumanoidDescriptionFromUserId(userId)

            local test = statue.Humanoid:ApplyDescription(desc)
        end
    )

    -- "rbxassetid://6648691264"
    pcall(
        function()
            local Track = statue.Humanoid:LoadAnimation(statue.Idle)
            Track:Play()
        end
    )
end

function module.initDataStore(props)
    local word = props.word
    local portal = props.portal

    local dataStore = DataStore:GetOrderedDataStore(word)

    local statue = Utils.getFirstDescendantByName(portal, 'Statue')
    local scoreSign = Utils.getFirstDescendantByName(portal, 'ScoreSign')
    local top = Utils.getFirstDescendantByName(scoreSign, 'Top')
    local list = Utils.getFirstDescendantByName(scoreSign, 'List')

    local delaySec = math.random() + math.random(delayBase, delayBase * 1.5)

    local function closure(word)
        function test()
            module.updateSign(word)
        end
        return test
    end

    function module.updateSign(word)
        for i, leaderboardRank in pairs(list:GetChildren()) do
            if leaderboardRank.ClassName == 'Frame' then
                leaderboardRank:Destroy()
            end
        end

        local success, errorMsg =
            pcall(
            function()
                local data = dataStore:GetSortedAsync(false, 10)
                local StatsPage = data:GetCurrentPage()

                for rankInLB, dataStored in ipairs(StatsPage) do
                    local id = tonumber(dataStored.key)

                    local name = Utils_2.getUsernameFromUserId(id)
                    local statsname = dataStored.value
                    wait(0.1)

                    local Gui = top:Clone()
                    Gui.PlrName.Text = name
                    Gui.Rank.Text = '#' .. rankInLB
                    Gui.Amount.Text = statsname
                    Gui.Parent = list

                    if Gui.Rank.Text == '#1' then
                        -- Gui.Color.Value = Color3.fromRGB(206, 206, 172)
                        -- statue.Configuration.userId.Value = id
                        statue.Tags.Container.pName.Text = name
                        module.setHumanoid(id, statue)
                    end
                end
            end
        )

        --

        --
        -- randomize the interval, so all signs don't update on the same tick
        delay(delaySec, closure(word))
        -- delay(delaySec, module.updateSign)
    end
    module.updateSign(word)
end

function module.initLevelPortal(props)
    local parentFolder = props.parentFolder
    -- local tag = props.tag
    local templateName = props.templateName
    local positioner = props.positioner
    local word = props.word

    local grabbersConfig = {
        word = positioner.Name,
        parentFolder = parentFolder,
        positioner = positioner,
        templateName = templateName
    }

    local portal = LetterGrabber.initLetterGrabber(grabbersConfig)
    module.initDataStore({portal = portal, word = word})
    return portal
end

return module

local Sss = game:GetService('ServerScriptService')
local DataStore = game:GetService('DataStoreService')
local Players = game:GetService('Players')

local Utils_2 = require(Sss.Source.Utils.U002InstanceUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local module = {}

function module.setHumanoid(userId, statue)
    local success, errorMsg =
        pcall(
        function()
            local desc = Players:GetHumanoidDescriptionFromUserId(userId)
            statue.Humanoid:ApplyDescription(desc)
        end
    )

    -- pcall(
    --     function()
    --         local Track = statue.Humanoid:LoadAnimation(statue.Idle)
    --         Track:Play()
    --     end
    -- )
end

function module.initDataStore(props)
    local word = props.word
    local portal = props.portal

    local dataStore = DataStore:GetOrderedDataStore(word)

    local statue = Utils.getFirstDescendantByName(portal, 'Statue')
    local scoreSign = Utils.getFirstDescendantByName(portal, 'ScoreSign')
    local top = Utils.getFirstDescendantByName(scoreSign, 'Top')
    local list = Utils.getFirstDescendantByName(scoreSign, 'List')

    -- local function closure(word, dataStore)
    --     function test()
    --         module.updateSign(word, dataStore)
    --     end
    --     return test
    -- end

    local delayBase = 2000
    local delaySec = math.random() + math.random(delayBase, delayBase * 1.5)
    local startBase = 2
    local startSec = math.random() + math.random(startBase, startBase * 1.5)
    local ResetTime = delaySec
    -- function module.updateSign(word, dataStore)
    local Time = startSec
    while wait(1) do
        Time = Time - 1
        -- print('Time' .. ' - start')
        -- print(Time)
        --script.Parent.Parent.ResetTime.TextLabel.Text = "Resetting in " .. Time .. " seconds..."
        function refreshBoard()
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
                        print('dataStored' .. ' - start')
                        print(dataStored)
                        local name = Utils_2.getUsernameFromUserId(id)
                        local statsname = dataStored.value
                        -- wait()
                        -- wait(0.05)
                        -- wait(0.1)

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
        end
        if Time <= 0 then
            Time = ResetTime
            print('word' .. ' - start============>>>')
            print(word)
            -- function refreshBoard()
            --     for i, leaderboardRank in pairs(list:GetChildren()) do
            --         if leaderboardRank.ClassName == 'Frame' then
            --             leaderboardRank:Destroy()
            --         end
            --     end

            --     local success, errorMsg =
            --         pcall(
            --         function()
            --             local data = dataStore:GetSortedAsync(false, 10)
            --             local StatsPage = data:GetCurrentPage()

            --             for rankInLB, dataStored in ipairs(StatsPage) do
            --                 local id = tonumber(dataStored.key)
            --                 print('dataStored' .. ' - start')
            --                 print(dataStored)
            --                 local name = Utils_2.getUsernameFromUserId(id)
            --                 local statsname = dataStored.value
            --                 -- wait()
            --                 -- wait(0.05)
            --                 -- wait(0.1)

            --                 local Gui = top:Clone()
            --                 Gui.PlrName.Text = name
            --                 Gui.Rank.Text = '#' .. rankInLB
            --                 Gui.Amount.Text = statsname
            --                 Gui.Parent = list

            --                 if Gui.Rank.Text == '#1' then
            --                     -- Gui.Color.Value = Color3.fromRGB(206, 206, 172)
            --                     -- statue.Configuration.userId.Value = id
            --                     statue.Tags.Container.pName.Text = name
            --                     module.setHumanoid(id, statue)
            --                 end
            --             end
            --         end
            --     )
            -- end

            refreshBoard()
        end

        --

        --
        -- randomize the interval, so all signs don't update on the same tick
        -- delay(delaySec, closure(word, dataStore))
        -- delay(delaySec, module.updateSign)
    end
end

-- local delaySec2 = math.random() + math.random(5, 7)
-- delay(delaySec2, closure(word, dataStore))
-- module.updateSign(word)
-- end

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

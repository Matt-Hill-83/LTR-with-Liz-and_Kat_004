local Sss = game:GetService('ServerScriptService')
local DataStore = game:GetService('DataStoreService')
local Players = game:GetService('Players')

local Constants = require(Sss.Source.Constants.Constants)
local Utils_2 = require(Sss.Source.Utils.U002InstanceUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local module = {portals = {}}

function module.getPortal(name)
    return module.portals[name] or 'not found'
end

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

function module.refreshBoard(dataStore, portal, delaySec)
    local statue = Utils.getFirstDescendantByName(portal, 'Statue')
    local scoreSign = Utils.getFirstDescendantByName(portal, 'ScoreSign')

    local winnerScoreSign = Utils.getFirstDescendantByName(portal, 'WinnerScore')
    local winnerScoreTextLabel = {}

    if winnerScoreSign then
        winnerScoreTextLabel = Utils.getFirstDescendantByName(winnerScoreSign, 'TextLabel')
    else
        if delaySec then
            delay(delaySec, module.refreshBoardClosure(dataStore, portal, delaySec))
        end
        return
    end

    local winnerNameSign = Utils.getFirstDescendantByName(portal, 'WinnerName')
    local winnerNameTextLabel = {}
    if winnerNameSign then
        winnerNameTextLabel = Utils.getFirstDescendantByName(winnerNameSign, 'TextLabel')
    end

    local top = Utils.getFirstDescendantByName(scoreSign, 'Top')
    local list = Utils.getFirstDescendantByName(scoreSign, 'List')

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

                local Gui = top:Clone()
                Gui.PlrName.Text = name
                Gui.Rank.Text = '#' .. rankInLB
                Gui.Amount.Text = statsname
                Gui.Parent = list

                if Gui.Rank.Text == '#1' then
                    Gui.Color.Value = Color3.fromRGB(206, 206, 172)
                    -- statue.Configuration.userId.Value = id
                    -- statue.Tags.Container.pName.Text = name
                    module.setHumanoid(id, statue)
                    winnerNameTextLabel.Text = name
                    winnerScoreTextLabel.Text = statsname
                end
            end
        end
    )

    if delaySec then
        delay(delaySec, module.refreshBoardClosure(dataStore, portal, delaySec))
    end
    return success
end

function module.refreshBoardClosure(dataStore, portal, delaySec)
    local function closure()
        module.refreshBoard(dataStore, portal, delaySec)
    end
    return closure
end

function module.initDataStore(props)
    local word = props.word
    local portal = props.portal

    local dataStore = DataStore:GetOrderedDataStore(word)

    -- Only set this delay if you want the updating to loop.
    -- updating is also done when upDateWordStore is called.
    local delayBase = 1000
    local delaySec = math.random(delayBase, math.floor(delayBase * 1.5))
    -- local delaySec = math.random() + math.random(delayBase, math.floor(delayBase * 1.5))
    local startBase = 10
    local startSec = math.random() + math.random(startBase, startBase * 1.5)
    -- local startSec = math.random() + math.random(startBase, startBase * 1.5)

    -- delay(startSec, module.refreshBoardClosure(dataStore, portal, 5))
    delay(startSec, module.refreshBoardClosure(dataStore, portal, delaySec))
end

function module.refreshBoardCurried(portal)
    local function test(dataStore)
        module.refreshBoard(dataStore, portal)
    end
    return test
end

function module.initLevelPortal(props)
    local parentFolder = props.parentFolder
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

    local dataStoreProps = {portal = portal, word = word}
    module.initDataStore(dataStoreProps)

    -- pass a curried function to the data update module, so it can refresh boards.
    -- super hacky
    -- events would be much better
    -- or pass a callback into grabber
    Constants.portals[word] = {portal = portal, refreshFunc = module.refreshBoardCurried(portal)}

    return portal
end

return module

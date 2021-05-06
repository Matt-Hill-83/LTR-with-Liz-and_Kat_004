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

    pcall(
        function()
            local Track = statue.Humanoid:LoadAnimation(statue.Idle)
            Track:Play()
        end
    )
end

function module.refreshBoard(dataStore, portal, delaySec)
    print('refreshing!!!!')
    local statue = Utils.getFirstDescendantByName(portal, 'Statue')
    local scoreSign = Utils.getFirstDescendantByName(portal, 'ScoreSign')
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
                    -- Gui.Color.Value = Color3.fromRGB(206, 206, 172)
                    -- statue.Configuration.userId.Value = id
                    statue.Tags.Container.pName.Text = name
                    module.setHumanoid(id, statue)
                end
            end
        end
    )
    if delaySec then
        delay(delaySec, module.closure(dataStore, portal, delaySec))
    end
    return success
end

function module.closure(dataStore, portal, delaySec)
    print('closure')
    local function test()
        print('test')
        module.refreshBoard(dataStore, portal, delaySec)
    end
    return test
end

function module.initDataStore(props)
    print('initDataStore-==================================>>>>')
    local word = props.word
    print(word)
    local portal = props.portal

    local dataStore = DataStore:GetOrderedDataStore(word)

    local delayBase = 1000
    local delaySec = math.random() + math.random(delayBase, delayBase * 1.5)
    local startBase = 2
    local startSec = math.random() + math.random(startBase, startBase * 1.5)
    -- local ResetTime = delaySec
    -- local Time = startSec

    -- local function closure(dataStore, portal)
    --     print('closure')
    --     local function test()
    --         print('test')
    --         module.refreshBoard(dataStore, portal)
    --     end
    --     return test
    -- end

    -- delay(2, closure(dataStore, portal))

    -- Time = ResetTime
    delay(startSec, module.closure(dataStore, portal, delaySec))
    -- module.refreshBoard(dataStore, portal)

    -- while wait(1) do
    --     Time = Time - 1
    --     if Time <= 0 then
    --         Time = ResetTime
    --         module.refreshBoard(dataStore, portal)
    --     end
    -- end
end

function module.refreshBoardCurried(portal)
    local function test(dataStore)
        module.refreshBoard(dataStore, portal)
    end
    return test
end

function module.initLevelPortal(props)
    print('initLevelPortal' .. ' - start')
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
    -- coroutine.wrap(
    --     function()
    module.initDataStore(dataStoreProps)
    -- end
    -- )(dataStoreProps)

    print('Constants.portals' .. ' - start')
    print(Constants.portals)
    Constants.portals[word] = {portal = portal, refreshFunc = module.refreshBoardCurried(portal)}
    print('Constants.portals' .. ' - start')
    print(Constants.portals)

    return portal
end

return module

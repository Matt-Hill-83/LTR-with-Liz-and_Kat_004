local Sss = game:GetService('ServerScriptService')
local DataStore = game:GetService('DataStoreService')
local Players = game:GetService('Players')

local Utils_2 = require(Sss.Source.Utils.U002InstanceUtils)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local module = {}
local delayBase = 5
local userIdMemo = {}

function module.initDataStore(props)
    local word = props.word
    local portal = props.portal

    local dataStore = DataStore:GetOrderedDataStore(word)

    local scoreSign = Utils.getFirstDescendantByName(portal, 'ScoreSign')
    local top = Utils.getFirstDescendantByName(scoreSign, 'Top')
    local list = Utils.getFirstDescendantByName(scoreSign, 'List')
    local statue = Utils.getFirstDescendantByName(scoreSign, 'Statue')

    local function setHumanoid(userId)
        statue.Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(userId))
        local Track = statue.Humanoid:LoadAnimation(statue.Idle)
        Track:Play()
    end

    local delaySec = math.random() + math.random(delayBase, delayBase * 1.5)
    print('delaySec' .. ' - start')
    print(delaySec)
    function module.updateSign()
        print('updateSign++++++++++++++++++++++=======>>>' .. word)
        local success, errorMsg =
            pcall(
            function()
                local data = dataStore:GetSortedAsync(false, 10)
                local StatsPage = data:GetCurrentPage()

                print('word' .. ' - start------------------------->>')
                print(word)
                if true then
                    -- if word == 'CAT' then
                    print('StatsPage' .. ' - start')
                    print(StatsPage)
                end

                for rankInLB, dataStored in ipairs(StatsPage) do
                    print('dataStored' .. ' - start')
                    print(dataStored)
                    local id = dataStored.key

                    local name = Utils_2.getUsernameFromUserId(id)
                    -- local name = Players:GetNameFromUserIdAsync(dataStored.key)
                    print('name' .. ' - start')
                    print('name' .. ' - start')
                    print('name' .. ' - start')
                    print('name' .. ' - start')
                    print(name)

                    local statsname = dataStored.value
                    wait(0.1)

                    local Gui = top:Clone()
                    Gui.PlrName.Text = name
                    Gui.Rank.Text = '#' .. rankInLB
                    Gui.Amount.Text = statsname
                    Gui.Parent = list

                    if Gui.Rank.Text == '#1' then
                        Gui.Color.Value = Color3.fromRGB(206, 206, 172)
                        statue.Configuration.userId.Value = id
                        statue.Tags.Container.pName.Text = name
                    -- setHumanoid(id)
                    end
                end
            end
        )

        -- randomize the interval, so all signs don't update on the same tick
        delay(delaySec, module.updateSign)
    end
    module.updateSign()
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
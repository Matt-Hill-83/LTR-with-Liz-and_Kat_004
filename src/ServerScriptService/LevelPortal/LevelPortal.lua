local Sss = game:GetService('ServerScriptService')
local DataStore = game:GetService('DataStoreService')
local Players = game:GetService('Players'):GetPlayers()

local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local module = {}
local delayBase = 30
local userIdMemo = {}

function module.initDataStore(props)
    local word = props.word
    local portal = props.portal

    local dataStore = DataStore:GetOrderedDataStore(word)

    -- local scoreSign = Utils.getFirstDescendantByName(portal, 'ScoreSign')
    local top = Utils.getFirstDescendantByName(portal, 'Top')
    local list = Utils.getFirstDescendantByName(portal, 'List')
    local statue = Utils.getFirstDescendantByName(portal, 'Statue')

    local function setHumanoid(userId)
        statue.Humanoid:ApplyDescription(game.Players:GetHumanoidDescriptionFromUserId(userId))
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
                if word == 'CAT' then
                    print('StatsPage' .. ' - start')
                    print(StatsPage)
                end

                for rankInLB, dataStored in ipairs(StatsPage) do
                    -- memoize name table to reduce num fetches
                    local id = tonumber(dataStored.key)
                    local name
                    if userIdMemo[id] then
                        name = userIdMemo[id]
                    else
                        name = Players:GetNameFromUserIdAsync(id)
                        userIdMemo[id] = name
                    end

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
                        setHumanoid(id)
                    end
                end
            end
        )

        -- randomize the interval, so all signs don't update on the same tick
        delay(delaySec, module.updateSign)
    end
    module.updateSign()
end

function module.initGrabbers3(props)
    local parentFolder = props.parentFolder
    local tag = props.tag
    local templateName = props.templateName
    local positioners = props.positioners

    local grabbers = {}

    if not positioners then
        if not tag then
            tag = 'LetterGrabberPositioner'
        end

        positioners =
            Utils.getByTagInParent(
            {
                parent = parentFolder,
                tag = tag
            }
        )
    end

    for _, positioner in ipairs(positioners) do
        local grabbersConfig = {
            word = positioner.Name,
            parentFolder = parentFolder,
            positioner = positioner,
            templateName = templateName
        }

        local newGrabber = LetterGrabber.initLetterGrabber(grabbersConfig)
        table.insert(grabbers, newGrabber)
    end
    return grabbers
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

function module.getLetterMatrix(props)
    local levelConfig = props.levelConfig
    local numRods = props.numRods

    local signTargetWords = levelConfig.getTargetWords()[1]
    local words = {}
    for _, word in ipairs(signTargetWords) do
        table.insert(words, word.word)
    end

    local letterMatrix = LetterUtils.createRandomLetterMatrix({words = words, numBlocks = numRods})
    return letterMatrix
end

return module

local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local Scenes = require(Sss.Source.Scenes.Scenes)
local SceneConfig = require(Sss.Source.QuestConfigs.ScenesConfig)

local module = {}

function module.initTheaters(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig

    if not levelConfig then
        return
    end

    local positionerFolder = Utils.getFirstDescendantByName(parentFolder, 'TheaterPositioners')
    if not positionerFolder then
        return
    end

    local theaterPositioners = positionerFolder:getChildren()
    Utils.sortListByObjectKey(theaterPositioners, 'Name')

    print('theaterPositioners' .. ' - start')
    print(theaterPositioners)
    local sceneTemplateModel = Utils.getFirstDescendantByName(workspace, 'SceneTemplate')
    for positionerIndex, theaterPositioner in ipairs(theaterPositioners) do
        -- use mod to cycle thru configs when there are more positioners than configs

        local questConfigs = SceneConfig.getScenesConfig()
        local questConfig = questConfigs[1]
        local addScenesProps = {
            -- gridPadding = 10,
            theaterPositioner = theaterPositioner,
            questConfig = questConfig,
            questFolder = parentFolder,
            questIndex = positionerIndex,
            sceneConfigs = questConfig.sceneConfigs
        }

        Scenes.addScenes(addScenesProps)

        -- theaterPositioner:Destroy()
    end
    sceneTemplateModel:Destroy()
end
return module

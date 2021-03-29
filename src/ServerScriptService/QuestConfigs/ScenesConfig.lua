local Sss = game:GetService("ServerScriptService")
local MissyMeow = require(Sss.Source.QuestConfigs.MissyMeow)

local QuestConfigs = require(Sss.Source.QuestConfigs.QuestConfigs)
local QuestConfigs1 = require(Sss.Source.QuestConfigs.QuestConfigs1)
local QuestConfigs2 = require(Sss.Source.QuestConfigs.QuestConfigs2)
local module = {}

function module.getScenesConfig()

    -- local missyMeow = MissyMeow.quest
    -- return {missyMeow}

    return QuestConfigs.questConfigs
    -- return {QuestConfigs1.questConfigs, QuestConfigs2.questConfigs}

end

return module

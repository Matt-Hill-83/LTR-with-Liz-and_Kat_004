local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local AddModelFromPositioner = require(Sss.Source.AddModelFromPositioner.AddModelFromPositioner)
local Replicator = require(Sss.Source.BlockDash.Replicator)
local module = {}

function module.createReplicator(props)
    print('createReplicator')
    print('props' .. ' - start')
    print(props)
    local rewardTemplate = props.rewardTemplate
    local positionerModel = props.positionerModel
    local parentFolder = props.parentFolder

    local newReplicator =
        AddModelFromPositioner.addModel(
        {
            parentFolder = parentFolder,
            templateName = 'LetterKeyReplicatorTemplate',
            positionerModel = positionerModel,
            offsetConfig = {
                useParentNearEdge = Vector3.new(0, -1, 0),
                useChildNearEdge = Vector3.new(0, -1, 0),
                offsetAdder = Vector3.new(0, 0, 0)
            }
        }
    )

    -- TODO: finish this
    -- TODO: finish this
    -- TODO: finish this
    -- TODO: finish this
    -- TODO: finish this
    -- biuld a replicator that takes permissionFunction
    -- biuld a replicator that takes permissionFunction
    -- biuld a replicator that takes permissionFunction
    newReplicator.Name = 'uuu'
    print('newReplicator' .. ' - start')
    print(newReplicator)
    local newReplicatorPart = newReplicator.PrimaryPart

    local rewardFolder = newReplicator.Reward
    local rewards = rewardFolder:getChildren()
    for _, reward in ipairs(rewards) do
        reward:Destroy()
    end
    local newReward = rewardTemplate:Clone()

    --  find the Tool and pass that in, instead of the model
    local newRewardTool = Utils.getFirstDescendantByType(newReward, 'Tool')
    print('newRewardTool' .. ' - start')
    print(newRewardTool)

    newRewardTool.Parent = rewardFolder
    local newRewardPart = newRewardTool.Handle
    print('newRewardPart' .. ' - start')
    print(newRewardPart)

    newRewardPart.CFrame =
        Utils3.setCFrameFromDesiredEdgeOffset(
        {
            parent = newReplicatorPart,
            child = newRewardPart,
            offsetConfig = {
                useParentNearEdge = Vector3.new(1, -1, 1),
                useChildNearEdge = Vector3.new(1, -1, 1)
            }
        }
    )

    local keyPart = Utils.getFirstDescendantByName(newReplicator, 'Handle')
    local keyName = positionerModel.name

    LetterUtils.applyLetterText(
        {
            letterBlock = newReplicator,
            char = keyName
        }
    )

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = keyPart,
            propName = 'KeyName',
            initialValue = keyName,
            propType = 'StringValue'
        }
    )

    LetterUtils.styleGemFromTemplate(
        {
            targetLetterBlock = keyPart,
            templateName = 'Gem_yellow'
            -- templateName = 'Gem_pink2'
        }
    )

    local tool = Utils.getFirstDescendantByType(newReplicator, 'Tool')
    print('tool' .. ' - start')
    print(tool)
    if tool then
        tool.Name = keyName
    end
    return newReplicator
end

function module.initReplicators(props)
    local parentFolder = props.parentFolder
    local tagName = props.tagName or 'KeyPositioner'
    -- local keyPositioners = Utils.getByTagInParent({parent = parentFolder, tag = tagName})

    local keys = {}
    -- for _, positionerModel in ipairs(keyPositioners) do
    -- local replicatorProps = {
    --     rewardTemplate = Utils.getFromTemplates('HexLetterGemTool'),
    --     positionerModel = positionerModel,
    --     parentFolder = parentFolder
    -- }

    local newReplicator = module.createReplicator(props)

    Replicator.initReplicator(newReplicator)
    table.insert(keys, newReplicator)
    -- end
    return keys
end

return module

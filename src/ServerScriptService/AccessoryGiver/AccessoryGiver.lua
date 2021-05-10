local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local AddModelFromPositioner = require(Sss.Source.AddModelFromPositioner.AddModelFromPositioner)

local module = {}

function module.initAccessoryGiver(props)
    local parentFolder = props.parentFolder
    local positionerName = props.positionerName

    local levelConfig = props.levelConfig

    local positionerTag = 'AccessoryGrabberPositioner'
    local templateName = 'AccessoryGrabberTemplate_001'
    local grabberModelName = 'AccessoryGrabber_001'

    local grabberModels = Utils.getDescendantsByName(parentFolder, grabberModelName)
    -- local grabberModel = Utils.getFirstDescendantByName(parentFolder, 'grabberModelName')
    local positioners = Utils.getByTagInParent({parent = parentFolder, tag = positionerTag})
    Utils.sortListByObjectKey(positioners, 'Name')

    for posIndex, grabberModel in ipairs(grabberModels) do
        --     local newGrabber =
        --         AddModelFromPositioner.addModel(
        --         {
        --             parentFolder = parentFolder,
        --             templateName = templateName,
        --             positionerModel = positioner,
        --             offsetConfig = {
        --                 useParentNearEdge = Vector3.new(0, 0, 0),
        --                 useChildNearEdge = Vector3.new(0, 0, 0),
        --                 offsetAdder = Vector3.new(0, 0, 0)
        --             }
        --         }
        --     )

        --     newGrabber.Name = 'dddd'

        -- local hitBox = positioner.PrimaryPart
        local hitBox = Utils.getFirstDescendantByName(grabberModel, 'HitBox')
        module.initGrabberSwap({hitBox = hitBox})
    end
end

function module.touchGrabberSwap(touchedPart, player)
    module.donGrabberAccessory(player, {grabberTemplateName = 'Accessory-Fox', word = touchedPart.Name})
end

function module.initGrabberSwap(props)
    local hitBox = props.hitBox
    hitBox.Touched:Connect(Utils.onTouchHuman(hitBox, module.touchGrabberSwap))
end

function module.donGrabberAccessory(player, grabberConfig)
    local tagName = 'HorseAccessory'

    grabberConfig = grabberConfig or {}
    local word = grabberConfig.grabberTemplateName or 'ZZZ'

    local character = player.Character or player.CharacterAdded:Wait()
    local kids = character:GetChildren()

    local hasThisGrabber = false
    for _, kid in ipairs(kids) do
        local tagValue = kid:GetAttribute(tagName)
        if tagValue then
            -- if character already has grabber, return
            if tagValue == word then
                hasThisGrabber = true
            else
                -- if character has other grabber, delete it
                kid:Destroy()
            end
        end
    end

    if not hasThisGrabber then
        -- add new grabber
        local grabberTemplateName = grabberConfig.grabberTemplateName

        local humanoid = character:WaitForChild('Humanoid')
        local template = Utils.getFromTemplates(grabberTemplateName)

        local acc = template:Clone()
        CS:AddTag(acc, tagName)
        acc:SetAttribute(tagName, word)
        humanoid:AddAccessory(acc)
        acc.Handle.Anchored = false
    end
end

return module

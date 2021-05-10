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

    local positioners = Utils.getByTagInParent({parent = parentFolder, tag = positionerTag})
    Utils.sortListByObjectKey(positioners, 'Name')

    for posIndex, positioner in ipairs(positioners) do
        local newGrabber =
            AddModelFromPositioner.addModel(
            {
                parentFolder = parentFolder,
                templateName = templateName,
                positionerModel = positioner,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, 0, 0),
                    useChildNearEdge = Vector3.new(0, 0, 0),
                    offsetAdder = Vector3.new(0, 0, 0)
                }
            }
        )

        -- local hitBox = positioner.PrimaryPart
        local hitBox = Utils.getFirstDescendantByName(newGrabber, 'HitBox')
        -- hitBox.Anchored = false
        module.initHorseSwap({grabber = newGrabber})
        -- module.initHorseSwap({hitBox = hitBox, grabber = newGrabber})
    end
end

-- function module.touchGrabberSwap(touchedPart, player)
--     module.donGrabberAccessory(player, {grabberTemplateName = 'Accessory-Fox'})
-- end

function module.touchGrabberSwapClosure(grabberProps)
    print('touchGrabberSwapClosure')
    local function closure(props)
        print('props' .. ' - start')
        print(props)
        local player = props.player
        local touchedBlock = props.touchedBlock
        module.donGrabberAccessory(player, grabberProps)
    end
    return closure
end

function module.initHorseSwap(props)
    print('initHorseSwap')
    print('initHorseSwap')
    print('initHorseSwap')
    local grabber = props.grabber
    local hitBox = Utils.getFirstDescendantByName(grabber, 'HitBox')

    print('hitBox' .. ' - start')
    print(hitBox)

    local grabberProps = {grabber = grabber}
    hitBox.Touched:Connect(
        Utils.onTouchHuman2({touchedBlock = hitBox, callBack = module.touchGrabberSwapClosure(grabberProps)})
    )
end

function module.donGrabberAccessory(player, grabberProps)
    print('donGrabberAccessory')
    local tagName = 'HorseAccessory'

    grabberProps = grabberProps or {}
    local accessory = grabberProps.grabber.Reward:GetChildren()[1]
    local word = accessory.Name
    -- local word = grabberProps.grabberTemplateName

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
        local grabberTemplateName = grabberProps.grabberTemplateName

        local humanoid = character:WaitForChild('Humanoid')
        local template = accessory
        -- local template = Utils.getFromTemplates(grabberTemplateName)

        local acc = template:Clone()
        CS:AddTag(acc, tagName)
        acc:SetAttribute(tagName, word)
        humanoid:AddAccessory(acc)
        acc.Handle.Anchored = false
    end
end

return module

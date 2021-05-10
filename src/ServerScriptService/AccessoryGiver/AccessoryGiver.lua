local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local AddModelFromPositioner = require(Sss.Source.AddModelFromPositioner.AddModelFromPositioner)

local module = {}

function module.initAccessoryGiver(props)
    local parentFolder = props.parentFolder
    local positionerTag = props.positionerTag or 'AccessoryGrabberPositioner'
    local templateName = props.templateName or 'AccessoryGrabberTemplate_001'

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
        module.initHorseSwap({grabber = newGrabber})
    end
end

function module.touchGrabberSwap(props)
    local player = props.player
    local grabberProps = props.enclosedProps
    module.donGrabberAccessory(player, grabberProps)
end

function module.initHorseSwap(props)
    local grabber = props.grabber
    local hitBox = Utils.getFirstDescendantByName(grabber, 'HitBox')

    local grabberProps = {grabber = grabber}
    hitBox.Touched:Connect(
        Utils.onTouchHuman2(
            {
                touchedBlock = hitBox,
                callBack = module.touchGrabberSwap,
                enclosedProps = grabberProps
            }
        )
    )
end

function module.donGrabberAccessory(player, grabberProps)
    print('donGrabberAccessory')
    local tagName = 'HorseAccessory'

    grabberProps = grabberProps or {}
    local accessory = grabberProps.grabber.Reward:GetChildren()[1]
    local word = accessory.Name

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
        local humanoid = character:WaitForChild('Humanoid')
        local template = accessory

        local acc = template:Clone()
        CS:AddTag(acc, tagName)
        acc:SetAttribute(tagName, word)
        humanoid:AddAccessory(acc)
        acc.Handle.Anchored = false
    end
end

return module

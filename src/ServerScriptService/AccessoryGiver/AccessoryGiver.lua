local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local AddModelFromPositioner = require(Sss.Source.AddModelFromPositioner.AddModelFromPositioner)

local module = {}

function module.initAccessoryGivers(props)
    local configs = {
        {
            positionerTag = 'AccessoryGrabberPositioner',
            templateName = 'AccessoryGrabberTemplate_001'
        }
    }

    for _, config in ipairs(configs) do
        module.initAccessoryGiver(props, config)
    end
end

function module.initAccessoryGiver(props, config)
    local parentFolder = props.parentFolder

    local positionerTag = config.positionerTag
    local templateName = config.templateName

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
    local reward = grabberProps.grabber.Reward
    local accessory = Utils.getFirstDescendantByType(reward, 'Accessory')
    -- local accessory = grabberProps.grabber.Reward:GetChildren()[1]
    local accessoryName = accessory.Name

    local character = player.Character or player.CharacterAdded:Wait()
    local kids = character:GetChildren()

    local hasThisGrabber = false
    for _, kid in ipairs(kids) do
        local tagValue = kid:GetAttribute(tagName)
        if tagValue then
            -- if character already has grabber, return
            if tagValue == accessoryName then
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

        local acc = accessory:Clone()
        CS:AddTag(acc, tagName)
        acc:SetAttribute(tagName, accessoryName)
        humanoid:AddAccessory(acc)

        acc.Handle.Anchored = false

        local breakWeld = Utils.getFirstDescendantByName(acc, 'BreakWeld')

        if breakWeld then
            print('break weld')
            print('break weld')
            print('break weld')
            print('break weld')
            breakWeld:Destroy()
        end
    end
end

return module

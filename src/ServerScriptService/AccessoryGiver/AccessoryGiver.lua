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

        newGrabber.Name = 'dddd'

        -- local hitBox = positioner.PrimaryPart
        local hitBox = Utils.getFirstDescendantByName(newGrabber, 'HitBox')
        print('hitBox' .. ' - start')
        print('hitBox' .. ' - start')
        print('hitBox' .. ' - start')
        print('hitBox' .. ' - start')
        print(hitBox)
        -- hitBox.Name = word
        module.initGrabberSwap({hitBox = hitBox})
    end
end

function module.touchGrabberSwap(touchedPart, player)
    print('touchGrabberSwap' .. ' - start')
    print('touchGrabberSwap' .. ' - start')
    print('touchGrabberSwap' .. ' - start')
    module.donGrabberAccessory(player, {grabberTemplateName = 'Accessory-Fox', word = touchedPart.Name})
end

function module.initGrabberSwap(props)
    local hitBox = props.hitBox
    print('hitBox' .. ' - start')
    print('hitBox' .. ' - start')
    print('hitBox' .. ' - start')
    print('hitBox' .. ' - start')
    print('hitBox' .. ' - start')
    print('hitBox' .. ' - start')
    print(hitBox)
    hitBox.Touched:Connect(Utils.onTouchHuman(hitBox, module.touchGrabberSwap))
end

function module.donGrabberAccessory(player, grabberConfig)
    local tagName = 'HorseAccessory'

    grabberConfig = grabberConfig or {}
    local word = grabberConfig.word or 'ZZZ'

    local character = player.Character or player.CharacterAdded:Wait()
    local kids = character:GetChildren()

    for _, kid in ipairs(kids) do
        local tagValue = kid:GetAttribute(tagName)
        if tagValue then
            -- if character already has grabber, return
            if tagValue == word then
                return
            else
                -- if character has other grabber, delete it
                kid:Destroy()
            end
        end
    end

    -- add new grabber
    local grabberTemplateName = grabberConfig.grabberTemplateName or 'LetterGrabberAcc'

    local humanoid = character:WaitForChild('Humanoid')
    local template = Utils.getFromTemplates(grabberTemplateName)

    local acc = template:Clone()
    CS:AddTag(acc, tagName)
    acc:SetAttribute(tagName, word)

    local letterGrabber = Utils.getFirstDescendantByName(acc, 'LetterGrabber')
    local grabbersConfig = {
        word = word,
        letterGrabber = letterGrabber,
        player = player
    }

    module.initLetterGrabberSimple(grabbersConfig)
    humanoid:AddAccessory(acc)
end

return module

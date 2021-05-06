local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

function module.addModel(props)
    local defaultOffsetConfig = {
        useParentNearEdge = Vector3.new(0, 0, 0),
        useChildNearEdge = Vector3.new(0, 0, 0),
        offsetAdder = Vector3.new(0, 0, 0)
    }

    local parentFolder = props.parentFolder or workspace
    local positionerModel = props.positionerModel
    local templateName = props.templateName
    local offsetConfig = props.offsetConfig or defaultOffsetConfig
    if not positionerModel then
        return
    end
    local dummy = Utils.getFirstDescendantByName(positionerModel, 'Dummy')
    if dummy then
        dummy:Destroy()
    end

    local positioner = Utils.getFirstDescendantByName(positionerModel, 'Positioner')
    if not positioner then
        return
    end
    local cloneProps = {
        parentTo = parentFolder,
        positionToPart = positioner,
        templateName = templateName,
        fromTemplate = true,
        offsetConfig = offsetConfig
    }

    local newItem = Utils.cloneModel(cloneProps)
    return newItem
end

return module

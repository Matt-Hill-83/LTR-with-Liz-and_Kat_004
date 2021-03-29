local Sss = game:GetService("ServerScriptService")
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

function module.addLocation(props)
    local scene = props.scene
    local sceneConfig = props.sceneConfig

    -- Image
    local imageId = Utils.getDecalIdFromName({name = sceneConfig.name})

    local locationImageFront = Utils.getFirstDescendantByName(scene,
                                                              "LocationImageFront")
    local locationImageBack = Utils.getFirstDescendantByName(scene,
                                                             "LocationImageBack")
    locationImageFront.Image = 'rbxassetid://' .. imageId
    locationImageBack.Image = 'rbxassetid://' .. imageId

    -- Label
    local locationLabel =
        Utils.getDisplayNameFromName({name = sceneConfig.name})
    local locationLabelFront = Utils.getFirstDescendantByName(scene,
                                                              "LocationLabelFront")
    local locationLabelBack = Utils.getFirstDescendantByName(scene,
                                                             "LocationLabelBack")

    locationLabelBack.Text = locationLabel
    locationLabelFront.Text = locationLabel

end

return module

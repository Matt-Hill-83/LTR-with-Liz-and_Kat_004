local Sss = game:GetService('ServerScriptService')

local AddModelFromPositioner = require(Sss.Source.AddModelFromPositioner.AddModelFromPositioner)
local module = {}

function module.initBeltJoints(props)
    local offsetConfig = {
        useParentNearEdge = Vector3.new(0, 0, 0),
        useChildNearEdge = Vector3.new(0, 0, 0),
        offsetAdder = Vector3.new(0, 0, 0)
    }

    -- local positioner = Utils.getFirstDescendantByName(myStuff, 'BlockDash')
    AddModelFromPositioner.addModels(
        {
            parentFolder = props.parentFolder,
            templateName = 'BeltJoint-001',
            positionerTag = 'BeltJointPositioner'
            -- offsetConfig = offsetConfig
        }
    )
end

return module

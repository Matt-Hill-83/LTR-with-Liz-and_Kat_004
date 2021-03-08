local Sss = game:GetService('ServerScriptService')

local AddModelFromPositioner = require(Sss.Source.AddModelFromPositioner.AddModelFromPositioner)
local module = {}

function module.initBeltJoints(props)
    AddModelFromPositioner.addModels(
        {
            parentFolder = props.parentFolder,
            templateName = 'BeltJoint-001',
            positionerTag = 'BeltJointPositioner'
        }
    )
end

return module

local Sss = game:GetService('ServerScriptService')
local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

function module.initGrabbers(props)
    local parentFolder = props.parentFolder

    local positioners =
        Utils.getByTagInParent(
        {
            parent = parentFolder,
            tag = 'LetterGrabberPositioner'
        }
    )

    for _, positioner in ipairs(positioners) do
        local grabbersConfig = {
            word = positioner.Name,
            parentFolder = parentFolder,
            positioner = positioner
        }

        LetterGrabber.initLetterGrabber(grabbersConfig)
    end
end

return module

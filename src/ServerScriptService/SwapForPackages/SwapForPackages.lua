local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local Configs = require(Sss.Source.Constants.Const_08_Configs)
local Bridge = require(Sss.Source.Bridge.Bridge)
local InvisiWall = require(Sss.Source.InvisiWall.InvisiWall2)
local Constants = require(Sss.Source.Constants.Constants)

local module = {}

function module.initSwapForPackages(props)
    local parentFolder = props.parentFolder
    local positionerName = props.positionerName

    local regionConfig = props.regionConfig
    if not regionConfig then
        return
    end

    local configs = {
        {name = 'PizzaBox_005', packageName = 'PizzaBox_005'},
        {name = 'PizzaSlice_005', packageName = 'PizzaSlice_005'}
    }

    for _, config in ipairs(configs) do
        local template = Utils.getFromRepStorage(config.packageName)
        local oldParts = Utils.getDescendantsByName(parentFolder, config.name)
        for _, oldPart in ipairs(oldParts) do
            local newPart = template:Clone()
            newPart.Parent = oldPart.Parent
            Utils3.setCFrameFromDesiredEdgeOffset2(
                {
                    parent = oldPart.PrimaryPart,
                    childModel = newPart,
                    offsetConfig = {
                        useParentNearEdge = Vector3.new(0, 0, 0),
                        useChildNearEdge = Vector3.new(0, 0, 0),
                        offsetAdder = Vector3.new(0, 0, 0)
                    }
                }
            )
            oldPart:Destroy()
            newPart.Name = newPart.Name .. 'tttt'
        end
    end
end

return module

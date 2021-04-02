local Sss = game:GetService('ServerScriptService')
local StrayLetterBlocks = require(Sss.Source.StrayLetterBlocks.StrayLetterBlocks)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local module = {}

function module.initSingleStrays(props)
    local parentFolder = props.parentFolder
    local blockTemplate = props.blockTemplate

    -- populate specific letter gems
    local strayPositioners = Utils.getByTagInParent({parent = parentFolder, tag = 'StrayPositioner'})

    for _, positioner in ipairs(strayPositioners) do
        local char2 = nil
        if props.char then
            char2 = props.char
        else
            char2 = positioner.Name
        end

        -- char = char or positioner.Name
        local newLetterBlock = StrayLetterBlocks.createStray(char2, parentFolder, {blockTemplate = blockTemplate})

        newLetterBlock.CFrame =
            Utils3.setCFrameFromDesiredEdgeOffset(
            {
                parent = positioner,
                child = newLetterBlock,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = nil
                }
            }
        )

        newLetterBlock.Anchored = true
        newLetterBlock.CanCollide = false
    end
end

return module

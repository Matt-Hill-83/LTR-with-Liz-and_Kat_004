local Sss = game:GetService('ServerScriptService')
local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)
local StrayLetterBlocks = require(Sss.Source.StrayLetterBlocks.StrayLetterBlocks)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)

local module = {}

function module.initSlopes(props)
    local parentFolder = props.parentFolder

    -- StrayLetterBlocks.initStraysInRegions({parentFolder = workspace})

    local slope = parentFolder

    -- populate specific letter gems
    -- local strayPositioners = Utils.getByTagInParent({parent = slope, tag = 'StrayPositioner'})
    -- for _, positioner in ipairs(strayPositioners) do
    --     local char = positioner.Name
    --     local newLetterBlock = StrayLetterBlocks.createStray(char, parentFolder)

    --     newLetterBlock.CFrame =
    --         Utils3.setCFrameFromDesiredEdgeOffset(
    --         {
    --             parent = positioner,
    --             child = newLetterBlock,
    --             offsetConfig = {
    --                 useParentNearEdge = Vector3.new(0, -1, 0),
    --                 useChildNearEdge = Vector3.new(0, -1, 0),
    --                 offsetAdder = nil
    --             }
    --         }
    --     )

    --     newLetterBlock.Anchored = true
    --     newLetterBlock.CanCollide = false
    -- end

    -- local positioners =
    --     Utils.getByTagInParent(
    --     {
    --         parent = slope,
    --         tag = 'LetterGrabberPositioner'
    --     }
    -- )

    -- for _, positioner in ipairs(positioners) do
    --     local grabbersConfig = {
    --         word = positioner.Name,
    --         parentFolder = slope,
    --         positioner = positioner
    --     }

    --     LetterGrabber.initLetterGrabber(grabbersConfig)
    -- end
end

return module

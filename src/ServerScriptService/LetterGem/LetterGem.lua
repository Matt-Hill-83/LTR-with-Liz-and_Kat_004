local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local module = {}

function module.initLetterGem(props)
    local letterBlock = props.letterBlock
    local char = props.char
    local templateName = props.templateName
    local letterBlockType = props.letterBlockType

    LetterUtils.applyLetterText({letterBlock = letterBlock, char = char})

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = LetterUtils.letterBlockPropNames.Type,
            initialValue = letterBlockType,
            propType = 'StringValue'
        }
    )

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = 'ToolType',
            initialValue = 'LetterGemTool',
            propType = 'StringValue'
        }
    )

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = LetterUtils.letterBlockPropNames.Character,
            initialValue = char,
            propType = 'StringValue'
        }
    )

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = LetterUtils.letterBlockPropNames.CurrentStyle,
            initialValue = 'zzz',
            propType = 'StringValue'
        }
    )

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = LetterUtils.letterBlockPropNames.Uuid,
            initialValue = Utils.getUuid(),
            propType = 'StringValue'
        }
    )

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = letterBlock,
            propName = LetterUtils.letterBlockPropNames.IsFound,
            initialValue = false,
            propType = 'BoolValue'
        }
    )

    if templateName then
        LetterUtils.applyStyleFromTemplate({targetLetterBlock = letterBlock, templateName = templateName})
    end
end

return module

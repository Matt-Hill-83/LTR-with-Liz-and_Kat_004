local Sss = game:GetService('ServerScriptService')
local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local module = {}

-- this seems like a temporary thing to init some grabbers easily
function module.initGrabbers2(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig

    if not levelConfig.strayRegions then
        return
    end
    if not levelConfig.strayRegions[1] then
        return
    end
    if not levelConfig.strayRegions[1]['words'] then
        return
    end

    local word = levelConfig.strayRegions[1]['words'][1]
    local positioners =
        Utils.getByTagInParent(
        {
            parent = parentFolder,
            tag = 'LetterGrabberPositioner2'
        }
    )

    for _, positioner in ipairs(positioners) do
        local grabbersConfig = {
            word = word,
            parentFolder = parentFolder,
            positioner = positioner
        }

        LetterGrabber.initLetterGrabber(grabbersConfig)
    end
end

function module.initGrabbers3(props)
    local parentFolder = props.parentFolder
    local tag = props.tag
    local templateName = props.templateName
    local positioners = props.positioners
    local levelConfig = props.levelConfig
    print('levelConfig' .. ' - start')
    print(levelConfig)

    local grabbers = {}

    if not positioners then
        positioners =
            Utils.getByTagInParent(
            {
                parent = parentFolder,
                tag = tag
            }
        )
    end

    for positionerIndex, positioner in ipairs(positioners) do
        local wordFromConfig = 'ZZZ'

        if levelConfig and levelConfig.wordSet then
            wordFromConfig = levelConfig.wordSet[positionerIndex] or levelConfig.wordSet[1]
        end

        local word = positioner.Name == '???' and wordFromConfig or positioner.Name

        local grabbersConfig = {
            word = word,
            parentFolder = parentFolder,
            positioner = positioner,
            templateName = templateName
        }

        local newGrabber = LetterGrabber.initLetterGrabber(grabbersConfig)
        table.insert(grabbers, newGrabber)
    end
    return grabbers
end

function module.getLetterMatrix(props)
    local levelConfig = props.levelConfig
    local numRods = props.numRods

    if not levelConfig.getTargetWords then
        return {}
    end
    local signTargetWords = levelConfig.getTargetWords()[1]
    local words = {}
    for _, word in ipairs(signTargetWords) do
        table.insert(words, word.word)
    end

    local letterMatrix = LetterUtils.createRandomLetterMatrix({words = words, numBlocks = numRods})
    return letterMatrix
end

return module

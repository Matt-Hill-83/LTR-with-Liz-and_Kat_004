local Sss = game:GetService('ServerScriptService')
local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local module = {}

-- this seems like a temporary thing to init some grabbers easily
function module.initGrabbers2(props)
    local parentFolder = props.parentFolder
    local regionConfig = props.regionConfig

    if not regionConfig.strayRegions then
        return
    end
    if not regionConfig.strayRegions[1] then
        return
    end
    if not regionConfig.strayRegions[1]['words'] then
        return
    end

    local word = regionConfig.strayRegions[1]['words'][1]
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
    local regionConfig = props.regionConfig
    print('regionConfig' .. ' - start')
    print(regionConfig)

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

        if regionConfig and regionConfig.wordSet then
            wordFromConfig = regionConfig.wordSet[positionerIndex] or regionConfig.wordSet[1]
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
    local regionConfig = props.regionConfig
    local numRods = props.numRods

    if not regionConfig.getTargetWords then
        return {}
    end
    local signTargetWords = regionConfig.getTargetWords()[1]
    local words = {}
    for _, word in ipairs(signTargetWords) do
        table.insert(words, word.word)
    end

    local letterMatrix = LetterUtils.createRandomLetterMatrix({words = words, numBlocks = numRods})
    return letterMatrix
end

return module

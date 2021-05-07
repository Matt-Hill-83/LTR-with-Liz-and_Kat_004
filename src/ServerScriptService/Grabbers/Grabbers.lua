local Sss = game:GetService('ServerScriptService')
local LetterGrabber = require(Sss.Source.LetterGrabber.LetterGrabber)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

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
            -- word = positioner.Name,
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

    local grabbers = {}

    if not templateName then
        templateName = 'GrabberReplicatorTemplate_001'
    end

    if not positioners then
        if not tag then
            tag = 'LetterGrabberPositioner'
        end

        positioners =
            Utils.getByTagInParent(
            {
                parent = parentFolder,
                tag = tag
            }
        )
    end

    for _, positioner in ipairs(positioners) do
        local grabbersConfig = {
            word = positioner.Name,
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

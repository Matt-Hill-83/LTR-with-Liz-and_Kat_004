local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
local LetterUtils = require(Sss.Source.Utils.U004LetterUtils)

local module = {}

function module.createStray(char, parentFolder, props)
    local blockTemplate = props and props.blockTemplate
    local letterBlockFolder = Utils.getFromTemplates('LetterBlockTemplates')

    local letterBlockTemplate = blockTemplate or Utils.getFirstDescendantByName(letterBlockFolder, 'BD_6_blank_cupcake')
    local newLetterBlock = letterBlockTemplate:Clone()

    local letterId = 'ID--R'

    local name = 'strayLetter' .. char .. '-' .. letterId
    newLetterBlock.Name = name

    LetterUtils.createPropOnLetterBlock(
        {
            letterBlock = newLetterBlock,
            propName = LetterUtils.letterBlockPropNames.IsFound,
            initialValue = false,
            propType = 'BoolValue'
        }
    )

    newLetterBlock.Parent = parentFolder
    newLetterBlock.Anchored = false
    LetterUtils.initLetterBlock(
        {
            letterBlock = newLetterBlock,
            char = char,
            -- templateName = 'BD_6_blank_cupcake',
            isTextLetter = true,
            letterBlockType = LetterUtils.letterBlockTypes.StrayLetter
        }
    )

    return newLetterBlock
end

function module.initStraysInRegions(props)
    local parentFolder = props.parentFolder
    local levelConfig = props.levelConfig
    local strayRegions = Utils.getByTagInParent({parent = parentFolder, tag = 'StrayRegion'})
    Utils.sortListByObjectKey(strayRegions, 'Name')

    local defaultWords = {
        'RAT',
        'CAT',
        'BAT',
        'HAT',
        'MAT',
        'SAT',
        'PAT'
    }

    for regionIndex, region in ipairs(strayRegions) do
        local words
        local randomLetterMultiplier = 1
        local maxLetters
        local blockTemplate

        local isHoverStray = CS:HasTag(region, 'StrayRegion-Hover')

        if levelConfig.strayRegions and levelConfig.strayRegions[regionIndex] then
            local config = levelConfig.strayRegions[regionIndex]

            blockTemplate = config.blockTemplate

            words = config.words or defaultWords
            local useArea = config.useArea or defaultWords

            if useArea then
                local regionArea = region.Size.X * region.Size.Y
                maxLetters = regionArea / 20
            else
                maxLetters = config.maxLetters or 10
            end

            randomLetterMultiplier = config.randomLetterMultiplier or 1
        else
            words = defaultWords
            maxLetters = 10
        end

        local wordLength = 3
        local requiredLetters = #words * wordLength
        -- Populate random letter gems
        local strays =
            module.initStraysInRegion(
            {
                -- blockTemplate = blockTemplate,
                parentFolder = parentFolder,
                maxLetters = maxLetters,
                numBlocks = 0,
                -- numBlocks = math.floor(requiredLetters * randomLetterMultiplier),
                words = words,
                region = region,
                onTouchBlock = function()
                end
            }
        )

        local hoverPuckTemplate = Utils.getFromTemplates('HoverPuck-003')
        -- local hoverPuckTemplate = Utils.getFromTemplates('HoverPuck-002')

        for _, stray in ipairs(strays) do
            stray.CanCollide = true
            if isHoverStray then
                -- puck's arent' workign right.  somehow the thrustblock is in a different location
                -- puck's arent' workign right.  somehow the thrustblock is in a different location
                -- puck's arent' workign right.  somehow the thrustblock is in a different location
                -- puck's arent' workign right.  somehow the thrustblock is in a different location
                local hoverPuck = hoverPuckTemplate:Clone()
                hoverPuck.Parent = stray
                -- hoverPuck.Parent = stray.Parent
                local hoverPuckPart = hoverPuck.PrimaryPart

                -- hoverPuckPart.Name = 'kkkk'
                hoverPuckPart.Anchored = false

                Utils3.setCFrameFromDesiredEdgeOffset2(
                    {
                        parent = stray,
                        childModel = hoverPuck,
                        offsetConfig = {
                            useParentNearEdge = Vector3.new(0, -1, 0),
                            useChildNearEdge = Vector3.new(0, -1, 0),
                            offsetAdder = nil
                        }
                    }
                )
                -- hoverPuckPart.CFrame =
                --     Utils3.setCFrameFromDesiredEdgeOffset(
                --     {
                --         parent = stray,
                --         child = hoverPuckPart,
                --         offsetConfig = {
                --             useParentNearEdge = Vector3.new(0, -1, 0),
                --             useChildNearEdge = Vector3.new(0, -1, 0),
                --             offsetAdder = nil
                --         }
                --     }
                -- )

                local weld = Instance.new('WeldConstraint')
                weld.Name = 'WeldConstraint-hoverPuck-888'
                weld.Parent = hoverPuckPart
                weld.Part0 = hoverPuckPart
                weld.Part1 = stray

                stray.Massless = true
                stray.Name = stray.Name .. '777'
                hoverPuck.Dummy:Destroy()
            else
                function module.initPuck(puck)
                    local thrust = Instance.new('BodyThrust', puck)
                    thrust.Force = Vector3.new(0, 0, 16000)

                    local angularVelocity = Utils.genRandom(1, 2, true)

                    local av = Instance.new('BodyAngularVelocity', puck)
                    av.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
                    av.AngularVelocity = Vector3.new(0, angularVelocity, 0)
                    av.P = 1250
                end
                module.initPuck(stray)
            end
        end
    end
end

function module.createLetterMatrix(props)
    local words = props.words
    local numBlocks = props.numBlocks

    -- populate matrix with letters
    local letterMatrix = {}
    local lettersNotInWords = LetterUtils.getLettersNotInWords(words)

    for _ = 1, numBlocks do
        table.insert(letterMatrix, LetterUtils.getRandomLetter(lettersNotInWords))
    end

    for _, word in ipairs(words) do
        for letterIndex = 1, #word do
            local letter = string.sub(word, letterIndex, letterIndex)
            table.insert(letterMatrix, letter)
        end
    end
    return letterMatrix
end

function module.initStraysInRegion(props)
    local numBlocks = props.numBlocks
    local words = props.words
    local region = props.region
    local maxLetters = props.maxLetters or 16
    local blockTemplate = props.blockTemplate

    -- populate matrix with letters
    local letterMatrix = {}
    local lettersNotInWords = LetterUtils.getLettersNotInWords(words)

    for _ = 1, numBlocks do
        table.insert(letterMatrix, LetterUtils.getRandomLetter(lettersNotInWords))
    end

    local numLetters = 0
    while numLetters <= maxLetters do
        for _, word in ipairs(words) do
            for letterIndex = 1, #word do
                numLetters = numLetters + 1
                if numLetters <= maxLetters then
                    local letter = string.sub(word, letterIndex, letterIndex)
                    table.insert(letterMatrix, letter)
                end
            end
        end
    end

    local strays = {}
    for _, char in ipairs(letterMatrix) do
        local parentFolder = props.parentFolder

        local strayProps = {
            blockTemplate = blockTemplate
        }

        local newLetterBlock = module.createStray(char, parentFolder, strayProps)

        local offsetX = Utils.genRandom(0, region.Size.X) - region.Size.X / 2
        local offsetZ = Utils.genRandom(0, region.Size.Z) - region.Size.Z / 2

        table.insert(strays, newLetterBlock)
        newLetterBlock.CFrame =
            Utils3.setCFrameFromDesiredEdgeOffset(
            {
                parent = region,
                child = newLetterBlock,
                offsetConfig = {
                    useParentNearEdge = Vector3.new(0, -1, 0),
                    useChildNearEdge = Vector3.new(0, -1, 0),
                    offsetAdder = Vector3.new(offsetX, 0, offsetZ)
                }
            }
        )
    end

    for _, block in ipairs(strays) do
        LetterUtils.createPropOnLetterBlock(
            {
                letterBlock = block,
                propName = 'DestroyOnTouch',
                initialValue = true,
                propType = 'BoolValue'
            }
        )
    end

    return strays
end

return module

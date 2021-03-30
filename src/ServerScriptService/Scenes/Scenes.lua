local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
local Constants = require(Sss.Source.Constants.Constants)

local Characters = require(Sss.Source.Characters.Characters)
local TheaterSeat = require(Sss.Source.TheaterSeat.TheaterSeat)
-- local Teleporters = require(Sss.Source.Teleporters.Teleporters)
local Location = require(Sss.Source.Location.Location)
local Bridges = require(Sss.Source.Bridges.Bridges)

local module = {}

function module.addScenes(props)
    local parent = Instance.new('Part', workspace)
    parent.Position = Vector3.new(0, 180, 0)
    -- local parent = props.parent
    local sceneConfigs = props.sceneConfigs
    local questConfig = props.questConfig
    -- local gridPadding = props.gridPadding
    local theaterPositioner = props.theaterPositioner
    local questFolder = workspace
    -- local questFolder = props.questFolder
    local questIndex = props.questIndex

    local sceneTemplateModel = Utils.getFirstDescendantByName(workspace, 'SceneTemplate')
    local sceneBase = Utils.getFirstDescendantByName(workspace, 'SceneBase')

    for sceneIndex, sceneConfig in ipairs(sceneConfigs) do
        local newSceneOffset =
            getNewSceneOffset(
            {
                coordinates = sceneConfig.coordinates,
                template = sceneBase
            }
        )
        local clonedScene = sceneTemplateModel:Clone()

        local translateCFrameProps = {
            parent = theaterPositioner,
            child = clonedScene.PrimaryPart,
            offsetConfig = {
                useParentNearEdge = Vector3.new(0, -1, 1),
                useChildNearEdge = Vector3.new(0, -1, 1)
                -- offsetAdder = Vector3.new(0, 0, -gridPadding / 2)
            }
        }

        local newCFrame = Utils3.setCFrameFromDesiredEdgeOffset(translateCFrameProps)
        local cFrame = newCFrame * CFrame.new(newSceneOffset)

        clonedScene.Parent = sceneTemplateModel.Parent
        clonedScene.Name = clonedScene.Name .. 'Clone' .. '-Q' .. questIndex .. '-S' .. sceneIndex
        clonedScene:SetPrimaryPartCFrame(cFrame)

        local sceneFolder =
            Utils.getOrCreateFolder(
            {
                name = clonedScene.Name .. sceneIndex,
                parent = questFolder
            }
        )

        clonedScene.Parent = sceneFolder

        function addCharactersToScene(charProps)
            Characters.addCharactersToScene(charProps)
        end

        local seats = Utils.getDescendantsByName(clonedScene, 'CouchSeat')

        for i, seat in ipairs(seats) do
            local addSeatProps = {
                seat = seat,
                clonedScene = clonedScene,
                sceneConfig = sceneConfig,
                addCharactersToScene = addCharactersToScene,
                sceneFolder = sceneFolder
            }

            TheaterSeat.addSeat(addSeatProps)
        end

        Bridges.configBridges(
            {
                sceneConfig = sceneConfig,
                clonedScene = clonedScene
            }
        )

        local charProps = {
            frameConfig = sceneConfig.frames[1],
            clonedScene = clonedScene,
            sceneFolder = sceneFolder
        }

        -- addCharactersToScene(charProps)

        Location.addLocation({scene = clonedScene, sceneConfig = sceneConfig})

        local gameTitleLabel = Utils.getFirstDescendantByName(clonedScene, 'GameTitleLabel')
        gameTitleLabel.Text = 'Quest:   ' .. (questConfig.questTitle or 'Game Title')
    end
    -- sceneTemplateModel:Destroy()
end

getInitialSceneCFrame = function(props)
    local parent = props.parent
    local child = props.child
    -- -- local gridPadding = props.gridPadding

    -- local desiredOffsetFromParentEdge = Vector3.new(0, 0, -gridPadding / 2)

    local translateCFrameProps = {
        parent = parent,
        child = child,
        offsetConfig = {
            useParentNearEdge = Vector3.new(0, -1, 1),
            useChildNearEdge = Vector3.new(0, -1, 1)
            -- offsetAdder = desiredOffsetFromParentEdge
        }
    }

    local output = Utils3.setCFrameFromDesiredEdgeOffset(translateCFrameProps)
    return output
end

function getNewSceneOffset(props)
    local coordinates = props.coordinates
    local gapX = Constants.islandLength + Constants.bridgeLength
    local newX = -(gapX + 0) * coordinates.col
    local newZ = coordinates.row * (Constants.islandLength + Constants.bridgeLength + 0)
    return Vector3.new(newX, 0, -newZ)
end
return module

local Sss = game:GetService('ServerScriptService')
local Players = game:GetService('Players')
local RS = game:GetService('ReplicatedStorage')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Buttons = require(Sss.Source.Buttons.Buttons)
local Constants = require(Sss.Source.Constants.Constants)
local Texts = require(Sss.Source.Texts.NewTexts)

local freezeCameraRE = RS:WaitForChild('FreezeCameraRE')
-- local nextPageButtonClickRE = RS:WaitForChild("NextPageButtonClickRE")
-- local prevPageButtonClickRE = RS:WaitForChild("PrevPageButtonClickRE")

local module = {}

function module.addSeat(props)
    local seat = props.seat
    local clonedScene = props.clonedScene
    local sceneConfig = props.sceneConfig
    local addCharactersToScene = props.addCharactersToScene
    local sceneFolder = props.sceneFolder

    local currentPlayer = nil
    local numPages = #sceneConfig.frames

    -- TODO: numUsersSeated should be happen on a scene level
    local theaterState = {pageNumber = 1, updating = false, numUsersSeated = 0}

    local dialogScreen = Utils.getFirstDescendantByName(clonedScene, 'DialogScreen')
    -- Enable this after an enter event
    -- Enable this after an enter event
    -- Enable this after an enter event
    -- Utils.hideItemAndChildren({item = dialogScreen, hide = true})

    function getFrameConfig(sceneConfig)
        return sceneConfig.frames[theaterState.pageNumber]
    end

    function updateFrameItems(props)
        local newSceneProps = props.newSceneProps
        local frameConfig = props.frameConfig
        local numPages = props.numPages
        local pageNumber = props.pageNumber
        -- local player = props.player

        addCharactersToScene(newSceneProps)

        local dialogScreen = Utils.getFirstDescendantByName(newSceneProps.clonedScene, 'DialogScreen')
        local sgui = Utils.getFirstDescendantByName(dialogScreen, 'SceneDialogGui')

        Buttons.updateButtonActiveStatus({pageNum = pageNumber, numPages = numPages, sgui = sgui})
        Texts.renderTexts({dialogConfigs = frameConfig.dialogs, sgui = sgui})
    end

    function onNextPageClick()
        function closure(currentPlayer)
            -- local sceneConfig = sceneConfig
            -- local frameConfig = sceneConfig.frames[theaterState.pageNumber]
            if theaterState.updating == true then
                return
            end
            theaterState.updating = true
            -- if theaterState.numUsersSeated == 0 then return end

            if theaterState.pageNumber < numPages then
                theaterState.pageNumber = theaterState.pageNumber + 1

                local frameConfig = sceneConfig.frames[theaterState.pageNumber]

                local newSceneProps = {
                    frameConfig = frameConfig,
                    clonedScene = clonedScene,
                    sceneFolder = sceneFolder
                }
                local frameItemProps = {
                    -- player = currentPlayer,
                    newSceneProps = newSceneProps,
                    frameConfig = frameConfig,
                    numPages = numPages,
                    pageNumber = theaterState.pageNumber
                }
                updateFrameItems(frameItemProps)
            end
            theaterState.updating = false
        end
        return closure
    end

    local dialogScreen = Utils.getFirstDescendantByName(clonedScene, 'DialogScreen')
    -- local sgui = Utils.getFirstDescendantByName(newSceneProps.clonedScene,
    --                                             "SceneDialogGui")
    local sgui = Utils.getFirstDescendantByName(dialogScreen, 'SceneDialogGui')
    local nextPageButton = Utils.getFirstDescendantByName(sgui, 'NextPageButton')
    nextPageButton.MouseButton1Click:Connect(onNextPageClick())

    function onPrevPageClick()
        function closure()
            local sceneConfig = sceneConfig
            local frameConfig = sceneConfig.frames[theaterState.pageNumber]
            if theaterState.updating == true then
                return
            end
            theaterState.updating = true

            if theaterState.pageNumber > 1 then
                theaterState.pageNumber = theaterState.pageNumber - 1

                local frameConfig = sceneConfig.frames[theaterState.pageNumber]

                local newSceneProps = {
                    frameConfig = frameConfig,
                    clonedScene = clonedScene,
                    sceneFolder = sceneFolder
                }

                local frameItemProps = {
                    -- player = currentPlayer,
                    newSceneProps = newSceneProps,
                    frameConfig = frameConfig,
                    numPages = numPages,
                    pageNumber = theaterState.pageNumber
                }
                updateFrameItems(frameItemProps)
            end
            theaterState.updating = false
        end
        return closure
    end

    local prevPageButton = Utils.getFirstDescendantByName(sgui, 'PrevPageButton')
    prevPageButton.MouseButton1Click:Connect(onPrevPageClick())

    function openBridgeDoor(props)
        local clonedScene2 = props.clonedScene
        local bridgeDoorRight = Utils.getFirstDescendantByName(clonedScene2, 'BridgeDoorRight')
        local bridgeDoorLeft = Utils.getFirstDescendantByName(clonedScene2, 'BridgeDoorLeft')

        if bridgeDoorRight then
            bridgeDoorRight:Destroy()
        end
        if bridgeDoorLeft then
            bridgeDoorLeft:Destroy()
        end
    end

    seat:GetPropertyChangedSignal('Occupant'):Connect(
        function()
            local cameraPath1 = Utils.getFirstDescendantByName(clonedScene, 'ScreenCameraPath1')
            local cameraPath2 = Utils.getFirstDescendantByName(clonedScene, 'ScreenCameraPath2')

            local humanoid = seat.Occupant
            if humanoid then
                local pageNum = 1

                local player = Utils.getPlayerFromHumanoid(humanoid)

                if player then
                    theaterState.pageNumber = 1
                    theaterState.numUsersSeated = theaterState.numUsersSeated + 1
                    theaterState.updating = false

                    currentPlayer = player

                    local frameConfig = sceneConfig.frames[theaterState.pageNumber]

                    local newSceneProps = {
                        frameConfig = frameConfig,
                        clonedScene = clonedScene,
                        sceneFolder = sceneFolder
                    }

                    local frameItemProps = {
                        newSceneProps = newSceneProps,
                        frameConfig = frameConfig,
                        numPages = numPages,
                        pageNumber = theaterState.pageNumber
                    }
                    updateFrameItems(frameItemProps)

                    freezeCameraRE:FireClient(currentPlayer, cameraPath1, cameraPath2, true)
                    return
                end
            end

            -- player leaves seat
            if currentPlayer then
                theaterState.numUsersSeated = theaterState.numUsersSeated - 1
                currentPlayer.Character:WaitForChild('Humanoid').WalkSpeed = Constants.walkSpeed
                freezeCameraRE:FireClient(currentPlayer, cameraPath1, cameraPath2, false)
                currentPlayer = nil
            end
        end
    )

    local frameConfig = sceneConfig.frames[1]
    local newSceneProps = {
        frameConfig = frameConfig,
        clonedScene = clonedScene,
        sceneFolder = sceneFolder
    }

    local frameItemProps = {
        newSceneProps = newSceneProps,
        frameConfig = frameConfig,
        numPages = numPages,
        pageNumber = 1
    }
    updateFrameItems(frameItemProps)
end

return module

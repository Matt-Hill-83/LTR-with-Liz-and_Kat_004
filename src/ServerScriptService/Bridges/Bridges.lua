local Sss = game:GetService("ServerScriptService")
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

function module.configBridges(props)
    -- all bridges are created in clone.
    -- remove bridges that do not go anywhere
    local sceneConfig = props.sceneConfig
    local clonedScene = props.clonedScene

    local showBottomPath = sceneConfig.showBottomPath
    local showRightPath = sceneConfig.showRightPath
    local showTopPath = sceneConfig.showTopPath
    local showLeftPath = sceneConfig.showLeftPath

    if (showRightPath) then
        local baseWallRight = Utils.getFirstDescendantByName(clonedScene,
                                                             "BaseWallRight")
        if baseWallRight then baseWallRight:Destroy() end
    else

        local bridgeRightModel = Utils.getFirstDescendantByName(clonedScene,
                                                                "BridgeRightModel")
        if bridgeRightModel then bridgeRightModel:Destroy() end
    end

    if (showLeftPath) then
        local baseWallLeft = Utils.getFirstDescendantByName(clonedScene,
                                                            "BaseWallLeft")
        if baseWallLeft then baseWallLeft:Destroy() end
    end

    if (showBottomPath) then
        local baseWallFront = Utils.getFirstDescendantByName(clonedScene,
                                                             "BaseWallFront")
        if baseWallFront then baseWallFront:Destroy() end
    else
        local bridgeFrontModel = Utils.getFirstDescendantByName(clonedScene,
                                                                "BridgeFrontModel")
        bridgeFrontModel:Destroy()
    end

    if (showTopPath) then
        local bridgeWallBack = Utils.getFirstDescendantByName(clonedScene,
                                                              "BaseWallBack")
        bridgeWallBack:Destroy()

    end

end

return module

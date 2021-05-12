local Sss = game:GetService('ServerScriptService')

local Configs = require(Sss.Source.Constants.Const_08_Configs)
local module = {}

local tallWalls = Configs.tallWalls

local r007 = {
    bridgeConfigs = {
        invisiWallProps = tallWalls,
        straysOnBridges = false,
        bridgeTemplateName = Configs.bridges.default
    },
    invisiWallProps = tallWalls
}

local r008 = {
    hexGearConfigs = {
        {
            words = {
                '',
                '',
                '',
                'FOX',
                'FOX',
                'FOX'
            }
        }
    },
    -- invisiWallProps = tallWalls,
    -- hexIslandConfigs = {invisiWallProps = tallWalls},
    bridgeConfigs = {
        invisiWallProps = tallWalls,
        straysOnBridges = false,
        bridgeTemplateName = Configs.bridges.default
    },
    strayRegions = {
        {
            words = {'FOX'},
            -- maxLetters = 6
            useArea = true
        }
    },
    getTargetWords = function()
        return {{{word = 'FOX', target = 1, found = 0}}}
    end
}

local regions = {
    r007 = r007,
    r008 = r008,
    r009 = r008,
    r010 = r008,
    r011 = r008,
    r012 = r008
}

Configs.addDefaults(regions)

module.regions = regions
return module

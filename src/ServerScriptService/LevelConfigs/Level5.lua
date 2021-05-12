local Sss = game:GetService('ServerScriptService')

local Configs = require(Sss.Source.Constants.Const_08_Configs)

local Constants = require(Sss.Source.Constants.Constants)
local module = {}

local tallWalls = Constants.tallWalls

local r001 = {
    bridgeConfigs = {{invisiWallProps = tallWalls, straysOnBridges = false}},
    invisiWallProps = tallWalls,
    getTargetWords = function()
        return {{{word = 'FOX', target = 3, found = 0}}}
    end
}

local r002 = {
    hexGearConfigs = {
        {
            words = {
                'FOX',
                'BOX',
                'LOX'
            }
        }
    },
    invisiWallProps = tallWalls,
    bridgeConfigs = {{invisiWallProps = tallWalls, straysOnBridges = false}},
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
    r001 = r001,
    r002 = r002
}

Configs.addDefaults(regions)

module.regions = regions
return module

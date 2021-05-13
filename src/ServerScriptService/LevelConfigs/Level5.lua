local Sss = game:GetService('ServerScriptService')

local Configs = require(Sss.Source.Constants.Const_08_Configs)
local Words = require(Sss.Source.Constants.Const_07_Words)
local module = {}

local tallWalls = Configs.tallWalls

-- 'words01',
-- 'words02',
-- 'words03',
-- 'words04',
-- 'words05',
-- 'words06',
-- 'words07',
-- 'words08',

local r007 = {
    bridgeConfigs = {
        -- invisiWallProps = tallWalls,
        straysOnBridges = false,
        material = Enum.Material.Grass,
        bridgeTemplateName = Configs.bridges.default
    }
    -- invisiWallProps = tallWalls
}

local r008 = {
    hexGearConfigs = {
        {
            words = {
                'FOX',
                'FOX',
                'FOX'
            }
        }
    },
    bridgeConfigs = {
        -- invisiWallProps = tallWalls,
        straysOnBridges = false,
        material = Enum.Material.Grass,
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

function module.getRegionTemplate(props)
    local hexGearWords = props.hexGearWords
    local strayRegionWords = props.strayRegionWords
    local targetWords = props.targetWords
    local statueConfigs = props.targetWords

    local regionTemplate = {
        hexGearConfigs = hexGearWords,
        bridgeConfigs = {
            invisiWallProps = tallWalls,
            straysOnBridges = false,
            bridgeTemplateName = Configs.bridges.default
        },
        strayRegions = {{words = strayRegionWords}},
        statueConfigs = statueConfigs,
        getTargetWords = function()
            return {targetWords}
        end
    }

    return regionTemplate
end

local statueConfigs = {
    Liz = {
        sentence = {'I', 'SEE', 'A', 'CAT'},
        character = 'lizHappy'
        -- songId = '6342102168',
    },
    Kat = {
        sentence = {'NOT', 'A', 'CAT'},
        character = 'katScared',
        songId = '6342102168'
    },
    Troll = {
        sentence = {'TROLL', 'NEED', 'GOLD'},
        character = 'babyTroll04',
        songId = '6338745550'
    }
}

local numRegions = 50
for i = 10, numRegions do
    local mod = i % #statueConfigs

    print('mod' .. ' - start')
    print(mod)

    local statueConfig = statueConfigs[mod + 1]

    local regionName = 'r0' .. i

    local props = {
        hexGearWords = {{words = {'CAT', 'BAT', 'HAT'}}},
        strayRegionWords = {'MAT'},
        targetWords = {{word = 'HAT', target = 1, found = 0}},
        statueConfigs = {statueConfig}
    }
    local region = module.getRegionTemplate(props)

    regions[regionName] = region
end

print('regions' .. ' - start')
print(regions)
module.regions = regions
Configs.addDefaults(regions)

return module

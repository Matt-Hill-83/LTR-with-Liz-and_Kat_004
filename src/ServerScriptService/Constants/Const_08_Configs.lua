local Sss = game:GetService('ServerScriptService')

local Colors = require(Sss.Source.Constants.Const_02_Colors)
local Words = require(Sss.Source.Constants.Const_07_Words)
local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local conveyor1Config = {
    freezeConveyor = true,
    words = {
        'NAP',
        -- 'TAP',
        'RAP',
        'ZAP',
        'MAP'
        -- 'GAP',
        -- 'LAP'
    }
}
local conveyor2Config = {
    freezeConveyor = true,
    words = {
        'MAT',
        'BAT',
        'PAT',
        'SAT'
    }
}
local conveyor3Config = {
    freezeConveyor = true,
    words = {
        -- 'VAT',
        'TAN',
        'VAN',
        'CAN',
        'PAN'
        -- 'MOM'
    }
}
local conveyor4Config = {
    freezeConveyor = true,
    words = {
        'SAD',
        'MAD',
        'PAD',
        'HAD'
    }
}
local conveyor5Config = {
    freezeConveyor = true,
    words = {
        'CAT',
        'BAT',
        'RAT',
        'HAT'
    }
}

local orbiterConfigs_default = {
    {
        -- words = {'CAT', 'CAT', 'CAT'},
        numBlocks = 12,
        angularVelocity = 0.8,
        -- diameter = 32,
        discTransparency = 1,
        collideDisc = false,
        collideBlock = false,
        singleWord = '~~~',
        discHeight = 1
    }
}

local strayRegions_default = {
    {
        words = {'ABCDEFGHIJKLMNOPQRSTUVWXYZAAAAAAAAATTTTTTT'},
        -- words = {'CAT'},
        randomLetterMultiplier = 1,
        -- maxLetters = 6,
        useArea = true
    }
}

local hexGearConfigs_default = {{words = Words.allWords}}

local getTargetWords_default = function()
    return {{{word = 'HAT', target = 1, found = 0}}}
end

local module = {
    orbiterConfigs_default,
    strayRegions_default,
    hexGearConfigs_default,
    getTargetWords_default
}

local dummy01 = {
    -- invisiWallProps = tallWalls,
    material = Enum.Material.Glacier,
    statueConfigs = {
        Liz = {
            sentence = {'I', 'SEE', 'A', 'CAT'},
            character = 'lizHappy',
            -- songId = '6342102168',
            keyColor = Colors.colors.yellow
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
}

local conveyorConfigs_default = {
    conveyor5Config,
    conveyor2Config,
    conveyor1Config,
    conveyor3Config,
    conveyor4Config
}

function module.addDefaults(regions)
    for _, region in pairs(regions) do
        region.hexIslandConfigs = region.hexIslandConfigs or {dummy01}
        region.conveyorConfigs = region.conveyorConfigs or conveyorConfigs_default
        region.orbiterConfigs = region.orbiterConfigs or orbiterConfigs_default
        region.hexGearConfigs = region.hexGearConfigs or hexGearConfigs_default
        region.strayRegions = region.strayRegions or strayRegions_default
        region.getTargetWords = region.getTargetWords or getTargetWords_default
    end
end
return module

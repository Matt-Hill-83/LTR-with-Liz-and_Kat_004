local Sss = game:GetService('ServerScriptService')
local Colors = require(Sss.Source.Constants.Const_02_Colors)

local module = {}

local hexGearWords01 = {
    words = {
        'CAT',
        'BAT',
        'HAT',
        'MAT',
        'PAT',
        'RAT',
        'SAT',
        'FAT',
        --  break
        --  break
        'CAP',
        'GAP',
        'LAP',
        'MAP',
        'SAP',
        'TAP',
        'RAP',
        'ZAP',
        --  break
        --  break
        'VAN',
        'RAN',
        'CAN',
        'PAN',
        'FAN',
        'TAN',
        'DAN'
    }
}
local hexGearWords02 = {
    words = {
        --  break
        --  break
        'TAG',
        'RAG',
        'SAG',
        'WAG',
        'NAG',
        'ZAG',
        --  break
        --  break
        'BAD',
        'DAD',
        'HAD',
        'MAD',
        'PAD',
        'SAD',
        --  break
        --  break
        'HAM',
        'JAM',
        'PAM',
        'SAM',
        'RAM',
        'BAM',
        --  break
        --  break
        'RAY',
        'BAY',
        'LAY',
        'MAY',
        'PAY'
    }
}
local hexGearWords03 = {
    words = {
        'HAY',
        --  break
        --  break
        'FIG',
        'BIG',
        'DIG',
        'RIG',
        'WIG',
        'JIG',
        'ZIG'
    }
}

local dummy01 = {
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

local region01 = {
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'CAT',
            discHeight = 1
        }
    },
    hexIslandConfigs = {
        dummy01,
        dummy01
    },
    getTargetWords = function()
        return {
            {
                {word = 'CAT', target = 3, found = 0}
            }
        }
    end
}

local dummyRegion = {
    hexGearConfigs = {
        {
            words = {
                'CAT',
                'BAT',
                'HAT'
            }
        }
        -- hexGearWords02,
        -- hexGearWords03
    },
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'ISEEAFOXINABOX',
            discHeight = 1
        }
    },
    hexIslandConfigs = {
        dummy01
    },
    strayRegions = {
        {
            words = {'ABCDEFGHIJKLMNOPQRSTUVWXYZAAAAAAAAATTTTTTT'},
            -- words = {'CAT'},
            randomLetterMultiplier = 1,
            -- maxLetters = 6,
            useArea = true
        }
    },
    getTargetWords = function()
        return {
            {
                {word = 'HAT', target = 1, found = 0}
            }
        }
    end
}

module.regions = {
    region01,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion,
    dummyRegion
}

return module

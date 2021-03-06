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

local conveyorConfigs02 = {
    {
        words = {
            'TAG',
            'RAG',
            'SAG',
            'WAG',
            'NAG',
            'ZAG'
        }
    },
    {
        words = {
            'BAD',
            'DAD',
            'HAD',
            'MAD',
            'PAD',
            'SAD'
        }
    },
    {
        words = {
            'HAM',
            'JAM',
            'PAM',
            'SAM',
            'RAM',
            'BAM'
        }
    },
    {
        words = {
            'RAY',
            'BAY',
            'LAY',
            'MAY',
            'PAY',
            'WAY',
            'HAY'
        }
    }
}

local dummy01 = {
    material = Enum.Material.Glacier,
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = '44444',
            discHeight = 1
        }
    }
}

local region01 = {
    -- conveyorConfigs = conveyorConfigs01,
    hexIslandConfigs = {
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01,
        dummy01
    },
    hexGearConfigs = {hexGearWords01, hexGearWords02, hexGearWords03},
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = '44444',
            discHeight = 1
        }
    },
    getTargetWords = function()
        return {
            {
                {word = 'CAT', target = 1, found = 0}
            }
        }
    end
}

module.regions = {
    region01,
    region01,
    region01,
    region01,
    region01,
    region01,
    region01,
    region01,
    region01
}

return module

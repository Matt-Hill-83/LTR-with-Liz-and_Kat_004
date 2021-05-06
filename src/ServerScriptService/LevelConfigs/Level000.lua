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
    -- local hexGearWords03 = {
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

local conveyorConfigs = {
    conveyor5Config,
    conveyor2Config,
    conveyor1Config,
    conveyor3Config,
    conveyor4Config
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
    conveyorConfigs = conveyorConfigs,
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

local region02 = {
    conveyorConfigs = conveyorConfigs,
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
        dummy01,
        dummy01,
        dummy01
    },
    getTargetWords = function()
        return {
            {
                {word = 'BAT', target = 1, found = 0}
            }
        }
    end
}

local region03 = {
    conveyorConfigs = conveyorConfigs,
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
        dummy01
    },
    getTargetWords = function()
        return {
            {
                {word = 'RAT', target = 1, found = 0}
            },
            {
                {word = 'CAT', target = 1, found = 0}
            }
        }
    end
}

local region04 = {
    conveyorConfigs = conveyorConfigs,
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
        dummy01
    },
    strayRegions = {
        {
            useArea = true,
            words = {
                -- 'RAT',
                -- 'CAT',
                -- 'BAT',
                -- 'HAT',
                'MAT',
                'SAT',
                'PAT'
            }
        },
        {
            useArea = true,
            words = {
                -- 'RAT',
                -- 'CAT',
                -- 'BAT',
                -- 'HAT',
                'MAT',
                'SAT',
                'PAT'
            }
        }
    },
    getTargetWords = function()
        return {
            {
                {word = 'RAT', target = 1, found = 0},
                {word = 'CAT', target = 1, found = 0},
                {word = 'BAT', target = 1, found = 0},
                {word = 'HAT', target = 1, found = 0},
                {word = 'MAT', target = 1, found = 0},
                {word = 'SAT', target = 1, found = 0},
                {word = 'PAT', target = 1, found = 0}
            }
        }
    end
}

local region05 = {
    conveyorConfigs = conveyorConfigs,
    hexIslandConfigs = {dummy01},
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 24,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            -- collideDisc = false,
            -- collideBlock = false,
            -- singleWord = 'ABCDEFGHIJKLMNOPRSTUVWXYZ',
            singleWord = 'CAT',
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

local region08 = {
    conveyorConfigs = conveyorConfigs,
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0,
            collideDisc = false,
            collideBlock = false,
            singleWord = '888',
            discHeight = 1
        }
    },
    hexIslandConfigs = {
        dummy01
    },
    strayRegions = {
        {
            words = {'PAT'},
            -- words = {'CAT', 'BAT', 'RAT'},
            useArea = true
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

local region09 = {
    conveyorConfigs = conveyorConfigs,
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0,
            collideDisc = false,
            collideBlock = false,
            singleWord = '999',
            discHeight = 1
        }
    },
    hexIslandConfigs = {
        dummy01
    },
    strayRegions = {
        {
            words = {'BAT'},
            randomLetterMultiplier = 1,
            -- maxLetters = 6,
            useArea = true
        }
    },
    getTargetWords = function()
        return {{{word = 'BAT', target = 1, found = 0}}}
    end
}

local region10 = {
    hexGearConfigs = {hexGearWords01},
    -- hexGearConfigs = {hexGearWords01, hexGearWords02, hexGearWords03},
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'ten',
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

local region14 = {
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'ft',
            discHeight = 1
        }
    },
    hexIslandConfigs = {dummy01},
    strayRegions = {{words = {'PAT'}}}
}
local region15 = {
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'fvt',
            discHeight = 1
        }
    },
    hexIslandConfigs = {dummy01},
    strayRegions = {{words = {'SAT'}}}
}
local region16 = {
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 0,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'sxt',
            discHeight = 1
        }
    },
    hexIslandConfigs = {dummy01},
    strayRegions = {{words = {'MAT'}}}
}

module.regions = {
    region01,
    region02,
    region03,
    region04,
    region05,
    region08,
    region09,
    region09,
    region09,
    region09,
    region10,
    -- cakes on center

    region14,
    region15,
    region16,
    --
    region10,
    region10,
    region10,
    region10,
    region10,
    region10,
    region10,
    region10,
    region10,
    region10,
    region10,
    region10
}

return module

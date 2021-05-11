local Sss = game:GetService('ServerScriptService')
local Colors = require(Sss.Source.Constants.Const_02_Colors)
local Words = require(Sss.Source.Constants.Const_07_Words)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local test = Utils.concatArrays({{1, 2, 3}, {10, 20, 30}, {100, 200, 300}})
print('test' .. ' - start')
print(test)
local module = {}

local hexGearWords01 = {words = Words.allWords}
-- local hexGearWords01 = {words = Utils.concatArrays({Words.words01, Words.words02, Words.words03})}

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

local conveyorConfigs_default = {
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

local r001 = {
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
    getTargetWords = function()
        return {
            {
                {word = 'CAT', target = 3, found = 0}
            }
        }
    end
}

local r002 = {
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
    getTargetWords = function()
        return {
            {
                {word = 'BAT', target = 1, found = 0}
            }
        }
    end
}

local r003 = {
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

local r004 = {
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

local r005 = {
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

local r008 = {
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
    strayRegions = {
        {
            words = {'PAT'},
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

local r009 = {
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

local orbiterConfigs_default = {
    {
        -- words = {'CAT', 'CAT', 'CAT'},
        numBlocks = 12,
        angularVelocity = 0.8,
        -- diameter = 32,
        discTransparency = 0,
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

local hexGearConfigs_default = {hexGearWords01}

local getTargetWords_default = function()
    return {
        {
            {word = 'HAT', target = 1, found = 0}
        }
    }
end

local regions = {
    r001 = r001,
    r002 = r002,
    r003 = r003,
    r004 = r004,
    r005 = r005,
    r006 = r005,
    r007 = r005,
    r008 = r008,
    r009 = r009
}

for _, region in pairs(regions) do
    region.hexIslandConfigs = region.hexIslandConfigs or {dummy01}
    region.conveyorConfigs = region.conveyorConfigs or conveyorConfigs_default
    region.orbiterConfigs = region.orbiterConfigs or orbiterConfigs_default
    region.hexGearConfigs = region.hexGearConfigs or hexGearConfigs_default
    region.strayRegions = region.strayRegions or strayRegions_default
    region.getTargetWords = region.getTargetWords or getTargetWords_default
end

module.regions = regions
return module

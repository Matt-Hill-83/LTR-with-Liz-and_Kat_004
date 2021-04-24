local Sss = game:GetService('ServerScriptService')
local Colors = require(Sss.Source.Constants.Const_02_Colors)

local module = {}

local conveyor01 = {
    words = {
        'AAA',
        'AAA',
        'AAA',
        'AAA',
        'AAA',
        'AAA',
        'AAA',
        'AAA'
    }
}
local conveyor02 = {
    words = {
        'BBB',
        'BBB',
        'BBB',
        'BBB',
        'BBB',
        'BBB',
        'BBB',
        'BBB'
    }
}
local conveyor03 = {
    words = {
        'CCC',
        'CCC',
        'CCC',
        'CCC',
        'CCC',
        'CCC',
        'CCC',
        'CCC'
    }
}
local conveyor04 = {
    words = {
        'DDD',
        'DDD',
        'DDD',
        'DDD',
        'DDD',
        'DDD',
        'DDD',
        'DDD'
    }
}

local conveyorConfigs01 = {
    {
        words = {
            'CAT',
            'BAT',
            'HAT',
            'MAT',
            'PAT',
            'RAT',
            'SAT',
            'FAT'
        }
    },
    {
        words = {
            'FIG',
            'BIG',
            'DIG',
            'RIG',
            'WIG',
            'JIG',
            'ZIG',
            'PIG'
        }
    },
    {
        words = {
            'CCC',
            'CCC',
            'CCC',
            'CCC',
            'CCC',
            'CCC',
            'CCC',
            'CCC'
        }
    },
    {
        words = {
            'DDD',
            'DDD',
            'DDD',
            'DDD',
            'DDD',
            'DDD',
            'DDD',
            'DDD'
        }
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
            singleWord = 'CATBATRAT',
            discHeight = 1
        }
    }
}

local region01 = {
    conveyorConfigs = conveyorConfigs01,
    hexIslandConfigs = {
        dummy01
    },
    getTargetWords = function()
        return {
            {
                {word = 'CAT', target = 1, found = 0}
            }
        }
    end
}

local region02 = {
    conveyorConfigs = {conveyor01, conveyor02, conveyor03, conveyor04},
    hexIslandConfigs = {
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
    conveyorConfigs = {conveyor01, conveyor02, conveyor03, conveyor04},
    hexIslandConfigs = {
        dummy01
    },
    getTargetWords = function()
        return {
            {
                {word = 'RAT', target = 1, found = 0}
            }
        }
    end
}

local region04 = {
    conveyorConfigs = {conveyor01, conveyor02, conveyor03, conveyor04},
    hexIslandConfigs = {
        dummy01
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
    region02,
    region03,
    region04
}

return module

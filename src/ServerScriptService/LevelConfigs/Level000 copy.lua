local Sss = game:GetService('ServerScriptService')
local Colors = require(Sss.Source.Constants.Const_02_Colors)

local module = {}

local sector1Config = {
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
local sector2Config = {
    freezeConveyor = true,
    words = {
        'MAT',
        'BAT',
        'PAT',
        'SAT'
    }
}
local sector3Config = {
    freezeConveyor = true,
    words = {
        'VAT',
        'VAN',
        'MAN',
        'MOM'
    }
}
local sector4Config = {
    freezeConveyor = true,
    words = {
        -- 'DAD',
        'DOG',
        'HOG',
        'LOG',
        'BOG'
    }
}
local sector5Config = {
    freezeConveyor = true,
    words = {
        'CAT',
        'BAT',
        'RAT',
        'HAT'
    }
}

local conveyorConfigs = {
    sector5Config,
    sector2Config,
    sector1Config,
    sector3Config,
    sector4Config
}
module.conveyorConfigs = conveyorConfigs

local c0r0 = {
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
            character = 'babyTroll04'
            -- songId = '6338745550'
        }
    },
    bridgeConfigs = {},
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 50,
            angularVelocity = 0.2,
            diameter = 780,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = '?????????~',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 50,
            angularVelocity = 0.2,
            diameter = 780,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = '?????????~',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 16,
            angularVelocity = 0.5,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'CATRATBAT',
            discHeight = 1
        }
    }
}

local c1r1 = {
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {},
    orbiterConfigs = {
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'R~H~S~C~B',
            discHeight = 1
        }
    }
}

local c1r2 = {
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {
        {
            item = 'Rink',
            itemConfig = {
                -- grabbers = {'ZZZ'},
                words = {'CAT'}
            },
            material = Enum.Material.LeafyGrass
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {}
            },
            material = Enum.Material.LeafyGrass
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
            singleWord = 'C',
            discHeight = 1
        }
    }
}

local c1r3 = {
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {}
            },
            material = Enum.Material.LeafyGrass
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
            singleWord = 'C',
            -- singleWord = 'CCCCC?',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            -- singleWord = '2',
            singleWord = 'AAAAA?',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            -- singleWord = '3',
            singleWord = 'T?',
            discHeight = 1
        }
    }
}

local c1r4 = {
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {}
            },
            material = Enum.Material.LeafyGrass
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
            singleWord = '4~',
            discHeight = 1
        }
    }
}

local c1r5 = {
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {}
            },
            material = Enum.Material.LeafyGrass
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
            singleWord = '~RA',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = '~A~',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = -0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = '~RB~',
            discHeight = 1
        }
    }
}

local c1r6 = {
    material = Enum.Material.Glacier,
    statueConfigs = {},
    bridgeConfigs = {
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {}
            },
            material = Enum.Material.LeafyGrass
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
            singleWord = '~T',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = -0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = '~RB~',
            discHeight = 1
        }
    }
}

local dummy = {
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
    -- bridgeConfigs = {
    --     {
    --         item = 'Rink',
    --         itemConfig = {
    --             -- grabbers = {'ZZZ'},
    --             words = {'CAT'}
    --         },
    --         material = Enum.Material.LeafyGrass
    --     },
    --     {
    --         item = 'Rink',
    --         itemConfig = {
    --             -- grabbers = {'ZZZ'},
    --             words = {'CAT'}
    --         },
    --         material = Enum.Material.LeafyGrass
    --     },
    --     {
    --         item = 'Rink',
    --         itemConfig = {
    --             -- grabbers = {'ZZZ'},
    --             words = {'CAT'}
    --         },
    --         material = Enum.Material.LeafyGrass
    --     },
    --     {
    --         item = 'Rink',
    --         itemConfig = {
    --             -- grabbers = {'ZZZ'},
    --             words = {'CAT'}
    --         },
    --         material = Enum.Material.LeafyGrass
    --     },
    --     {
    --         item = 'Rink',
    --         itemConfig = {
    --             -- grabbers = {'ZZZ'},
    --             words = {'CAT'}
    --         },
    --         material = Enum.Material.LeafyGrass
    --     },
    --     {
    --         item = 'Rink',
    --         itemConfig = {
    --             -- grabbers = {'ZZZ'},
    --             words = {'CAT'}
    --         },
    --         material = Enum.Material.LeafyGrass
    --     },
    --     {
    --         item = 'Rink',
    --         itemConfig = {
    --             grabbers = {}
    --         },
    --         material = Enum.Material.LeafyGrass
    --     }
    -- },
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

local dummy05 = {
    material = Enum.Material.Glacier,
    orbiterConfigs = {
        {
            -- words = {'CALL', 'CAN', 'CAP', 'CAT', 'DAD'},
            words = {'ALL', 'AT', 'BAD', 'RAT', 'AN'},
            numBlocks = 12,
            angularVelocity = 0,
            -- angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            -- singleWord = 'RRR~',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'AAA~',
            discHeight = 1
        },
        {
            -- words = {'CAT', 'CAT', 'CAT'},
            numBlocks = 12,
            angularVelocity = 0.8,
            -- diameter = 32,
            discTransparency = 1,
            collideDisc = false,
            collideBlock = false,
            singleWord = 'TTT~',
            discHeight = 1
        }
    }
}

local region01 = {
    -- vendingMachines = {{targetWordIndex = 1}, {targetWordIndex = 2}},
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
    -- vendingMachines = {{targetWordIndex = 1}, {targetWordIndex = 2}},
    hexIslandConfigs = {
        dummy,
        dummy,
        dummy,
        dummy
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
    -- vendingMachines = {{targetWordIndex = 1}, {targetWordIndex = 2}},
    hexIslandConfigs = {
        dummy,
        dummy,
        dummy,
        dummy,
        dummy
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
    -- vendingMachines = {{targetWordIndex = 1}, {targetWordIndex = 2}},
    hexIslandConfigs = {
        dummy,
        dummy,
        dummy,
        dummy,
        dummy
    },
    getTargetWords = function()
        return {
            {
                {word = '444', target = 1, found = 0},
                {word = 'CAN', target = 1, found = 0},
                {word = 'CAP', target = 1, found = 0},
                {word = 'CAT', target = 1, found = 0},
                {word = 'DAD', target = 1, found = 0}
            }

            -- {'ALL', 'AT', 'BAD', 'RAT', 'AN',}
        }
    end
}

local region05 = {
    -- vendingMachines = {{targetWordIndex = 1}, {targetWordIndex = 2}},
    hexIslandConfigs = {
        dummy05,
        dummy05,
        dummy05,
        dummy05,
        dummy05
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
            singleWord = 'LNPCATD',
            discHeight = 1
        }
    },
    getTargetWords = function()
        return {
            {
                {word = '555', target = 1, found = 0},
                {word = 'CAN', target = 1, found = 0},
                {word = 'CAP', target = 1, found = 0},
                {word = 'CAT', target = 1, found = 0},
                {word = 'DAD', target = 1, found = 0}
            }
        }
    end
}
local region06 = {
    hexIslandConfigs = {
        dummy05
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
    },
    getTargetWords = function()
        return {
            {
                {word = 'ABCDFGHIJLMNOPRST', target = 1, found = 0}
            }
        }
    end
}

module.regions = {region01, region02, region03, region04, region05, region06}

return module

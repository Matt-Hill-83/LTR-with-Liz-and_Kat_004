local Sss = game:GetService('ServerScriptService')
local Colors = require(Sss.Source.Constants.Const_02_Colors)

local module = {}

local sector1Config = {
    freezeConveyor = true,
    words = {
        'NAP',
        'TAP',
        'RAP',
        'ZAP',
        'MAP',
        'GAP',
        'LAP'
    }
}
local sector2Config = {
    freezeConveyor = true,
    words = {
        'CAT',
        'BAT',
        'RAT',
        'HAT',
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
        'DAD',
        'DOG',
        'HOG',
        'LOG',
        'BOG'
    }
}

local sectorConfigs = {
    sector1Config,
    sector2Config,
    sector3Config,
    sector4Config
}
module.sectorConfigs = sectorConfigs

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
                grabbers = {'ZZZ'},
                words = {'YYY'}
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
        }
    },
    bridgeConfigs = {},
    xxxbridgeConfigs = {
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {'ZZZ'},
                words = {'YYY'}
            },
            material = Enum.Material.LeafyGrass
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {}
            },
            material = Enum.Material.LeafyGrass
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {}
            },
            material = Enum.Material.LeafyGrass
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {}
            },
            material = Enum.Material.LeafyGrass
        },
        {
            item = 'Rink',
            itemConfig = {
                grabbers = {}
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
            singleWord = 'fiona',
            discHeight = 1
        }
    }
}

local hexIslandConfigs = {
    c0r0,
    c0r0,
    c0r0,
    c1r1,
    c1r2,
    c1r3,
    c1r4,
    c1r5,
    c1r6,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy,
    dummy
}

module.vendingMachines = {{targetWordIndex = 1}}
module.hexIslandConfigs = hexIslandConfigs

function module.getTargetWords()
    return {
        {
            {word = 'CAT', target = 1, found = 0}
        }
        -- {
        --     {word = 'RAT', target = 1, found = 0},
        --     {word = 'BAT', target = 1, found = 0},
        --     {word = 'CAT', target = 1, found = 0}
        -- }
    }
end

return module

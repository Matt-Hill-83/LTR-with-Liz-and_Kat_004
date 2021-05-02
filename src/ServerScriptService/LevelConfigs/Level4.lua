local Sss = game:GetService('ServerScriptService')
local Colors = require(Sss.Source.Constants.Const_02_Colors)

local module = {}

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

local region02 = {
    conveyorConfigs = conveyorConfigs02,
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

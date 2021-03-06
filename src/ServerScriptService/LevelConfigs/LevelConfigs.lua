local Sss = game:GetService('ServerScriptService')
local Level000 = require(Sss.Source.LevelConfigs.Level000)
local Level1 = require(Sss.Source.LevelConfigs.Level1)
local Level2 = require(Sss.Source.LevelConfigs.Level2)
local Level3 = require(Sss.Source.LevelConfigs.Level3)
local Level4 = require(Sss.Source.LevelConfigs.Level4)
local Level5 = require(Sss.Source.LevelConfigs.Level5)
local Level6 = require(Sss.Source.LevelConfigs.Level6)
local Level7 = require(Sss.Source.LevelConfigs.Level7)
local Level8 = require(Sss.Source.LevelConfigs.Level8)
local Level009 = require(Sss.Source.LevelConfigs.Level009)
local Level010 = require(Sss.Source.LevelConfigs.Level010)
local Level011 = require(Sss.Source.LevelConfigs.Level011)
local Level012 = require(Sss.Source.LevelConfigs.Level012)
local Level013 = require(Sss.Source.LevelConfigs.Level013)

local module = {}

module.mainLevelConfig = Level000
module.levelConfigs = {
    Level000,
    -- Level1,
    Level2,
    Level3,
    Level4,
    Level5,
    Level6,
    Level7,
    Level8,
    Level009,
    Level010,
    Level011,
    Level012,
    Level013
}
module.levelConfigs2 = {
    [1] = Level000,
    [2] = Level2,
    [3] = Level3,
    [4] = Level4,
    [5] = Level5,
    [6] = Level6,
    [7] = Level7,
    [8] = Level8,
    [9] = Level009,
    [10] = Level010,
    [11] = Level011,
    [12] = Level012,
    [13] = Level013
}

module.levelDefs = {
    -- 8 now has the start place id
    {num = 'LK-LTR-8', name = 'END', id = '6358192824'},
    -- {num = 'LK-LTR-8', name = 'END', id = '6477887663'},
    {num = 'LK-LTR-6', name = 'END', id = '6468893018'},
    {num = 'LK-LTR-7', name = '7', id = '6477631350'},
    {num = 'LK-LTR-5', name = 'END', id = '6468118694'},
    {num = 'LK-LTR-012', name = 'END', id = '6510064848'},
    {num = 'LK-LTR-011', name = 'END', id = '6508386322'},
    {num = 'LK-LTR-Main', name = 'start', id = '6477887663'}
    -- {num = 'LK-LTR-Main', name = 'start', id = '6358192824'}
    -- {num = 'LK-LTR-009', name = 'END', id = '6478277568'},
    -- {num = 'LK-LTR-010', name = 'END', id = '6486874682'},
    -- {num = 'LK-LTR-4', name = 'caveWorld', id = '6467713882'},
    -- {num = 'LK-LTR-013', name = 'END', id = '6512436218'}
}
local unUsed = {}

return module

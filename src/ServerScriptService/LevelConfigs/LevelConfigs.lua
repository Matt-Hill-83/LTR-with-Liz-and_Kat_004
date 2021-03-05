local Sss = game:GetService('ServerScriptService')
local Level1 = require(Sss.Source.LevelConfigs.Level1)
local Level2 = require(Sss.Source.LevelConfigs.Level2)
local Level3 = require(Sss.Source.LevelConfigs.Level3)
local Level4 = require(Sss.Source.LevelConfigs.Level4)
local Level5 = require(Sss.Source.LevelConfigs.Level5)
local Level6 = require(Sss.Source.LevelConfigs.Level6)
local Level7 = require(Sss.Source.LevelConfigs.Level7)
local Level8 = require(Sss.Source.LevelConfigs.Level8)

local module = {}

module.levelConfigs = {
    Level1,
    Level2,
    Level3,
    Level4,
    Level5,
    Level6,
    Level7,
    Level8
}

module.levelDefs = {
    -- {num = 'Liz-and-Kat', name = 'pink planets', id = '6468893018'},
    {num = 'LK-LTR-1', name = 'ramps', id = '6358192824'},
    {num = 'LK-LTR-7', name = '7', id = '6477631350'},
    -- {num = 'LK-LTR-2', name = '2', id = '6460817067'},
    {num = 'LK-LTR-3', name = '3', id = '6461486490'},
    {num = 'LK-LTR-4', name = 'caveWorld', id = '6467713882'},
    {num = 'LK-LTR-5', name = 'END', id = '6468118694'},
    {num = 'LK-LTR-8', name = 'END', id = '6477887663'},
    {num = 'LK-LTR-6', name = 'END', id = '6468893018'}
    -- {num = 'LK-LTR-Main', name = 'Start', id = '6473099511'},
}
local unUsed = {
    -- {num = 'LK-LTR-1', name = 'ramps', id = '6358192824'},
    {num = 'LK-LTR-8', name = '8', id = 'xxx'},
    {num = 'LK-LTR-9', name = '9', id = 'xxx'}
}

return module

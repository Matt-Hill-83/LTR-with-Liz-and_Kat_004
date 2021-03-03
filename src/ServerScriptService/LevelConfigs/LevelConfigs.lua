local Sss = game:GetService('ServerScriptService')
local Level1 = require(Sss.Source.LevelConfigs.Level1)
local Level2 = require(Sss.Source.LevelConfigs.Level2)
local Level3 = require(Sss.Source.LevelConfigs.Level3)
local Level4 = require(Sss.Source.LevelConfigs.Level4)
local Level5 = require(Sss.Source.LevelConfigs.Level5)

local module = {}

module.levelConfigs = {
    Level1, --
    Level2, --
    Level3, --
    Level4, --
    Level5 --
}

module.levelDefs = {
    {num = '1', name = 'ramps', id = '6358192824'},
    {num = '2', name = 'caveWorld', id = '6467713882'},
    {num = '3', name = '2', id = '6460817067'},
    {num = '4', name = '3', id = '6461486490'},
    {num = '5', name = '5', id = '6468118694'},
    {num = '6', name = '6', id = 'xxx'},
    {num = '7', name = '7', id = 'xxx'},
    {num = '8', name = '8', id = 'xxx'},
    {num = '9', name = '9', id = 'xxx'},
    {num = '10', name = '10', id = 'xxx'}
}

return module

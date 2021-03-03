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
    {name = 'ramps', id = '6358192824'},
    {name = 'caveWorld', id = '6467713882'},
    {name = '2', id = '6460817067'},
    {name = '3', id = '6461486490'},
    {name = '5', id = 'xxx'},
    {name = '6', id = 'xxx'},
    {name = '7', id = 'xxx'},
    {name = '8', id = 'xxx'},
    {name = '9', id = 'xxx'},
    {name = '10', id = 'xxx'}
}

return module

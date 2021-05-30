local Sss = game:GetService('ServerScriptService')

local HandleClick = require(Sss.Source.LetterFall.HandleClick)
local LetterFallUtils = require(Sss.Source.LetterFall.LetterFallUtils)

local module = {}

function initGameToggle(miniGameState)
    HandleClick.initClickHandler(miniGameState)
    LetterFallUtils.createBalls(miniGameState)
end

module.initGameToggle = initGameToggle
return module

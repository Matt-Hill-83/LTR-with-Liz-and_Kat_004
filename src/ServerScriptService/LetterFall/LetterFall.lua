local CS = game:GetService('CollectionService')
local Sss = game:GetService('ServerScriptService')
local RS = game:GetService('ReplicatedStorage')

local HandleClick = require(Sss.Source.LetterFall.HandleClick)
local LetterFallUtils = require(Sss.Source.LetterFall.LetterFallUtils)

local module = {}

function initGameToggle(miniGameState)
    HandleClick.initClickHandler(miniGameState)
    LetterFallUtils.createBalls(miniGameState)

    -- if not miniGameState.initCompleted then
    --     miniGameState.initCompleted = true
    -- end
end

module.initGameToggle = initGameToggle
return module

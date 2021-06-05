local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local words01 = {
    'CAT',
    'BAT',
    'HAT',
    'MAT',
    'PAT',
    'RAT',
    'SAT'
    -- 'FAT'
}
local words02 = {
    'CAP',
    'GAP',
    'LAP',
    'MAP',
    'SAP',
    'TAP',
    'RAP',
    'ZAP'
}
local words03 = {
    'VAN',
    'RAN',
    'CAN',
    'PAN',
    'FAN',
    'TAN',
    'DAN'
}
local words04 = {
    'TAG',
    'RAG',
    'SAG',
    'WAG',
    'NAG',
    'ZAG'
}
local words05 = {
    'BAD',
    'DAD',
    'HAD',
    'MAD',
    'PAD',
    'SAD'
}
local words06 = {
    'HAM',
    'JAM',
    'PAM',
    'SAM',
    'RAM',
    'BAM'
}
local words07 = {
    'RAY',
    'BAY',
    'LAY',
    'MAY',
    'PAY',
    'HAY'
}
local words08 = {
    'FIG',
    'BIG',
    'DIG',
    'RIG',
    'WIG',
    'JIG',
    'ZIG'
}

local module = {
    words01 = words01,
    words02 = words02,
    words03 = words03,
    words04 = words04,
    words05 = words05,
    words06 = words06,
    words07 = words07,
    words08 = words08
}

local test = {
    words01,
    words02,
    words03,
    words04,
    words05,
    words06,
    words07,
    words08
}

local allWords = {}
for _, group in ipairs(test) do
    allWords = Utils.concatArray(allWords, group)
end

print('allWords' .. ' - start')
print(allWords)
module.allWords = allWords

return module

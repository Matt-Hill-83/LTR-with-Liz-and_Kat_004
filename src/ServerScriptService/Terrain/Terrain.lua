local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}
local tagName2 = 'AlreadyConverted'

function module.tagConvertedPart(part, tag)
    CS:AddTag(part, tag)
end

function module.shouldConvertPart(part)
    return not CS:HasTag(part, tagName2)
end

function module.initTerrain(props)
    local parentFolder = props.parentFolder
    local prefix = props.prefix
    local materials = Enum.Material:GetEnumItems()

    for _, material in ipairs(materials) do
        local tagName = prefix .. material.Name
        if material.Name ~= 'Air' then
            -- wait()
            local parts = Utils.getByTagInParent({parent = parentFolder, tag = tagName})
            for _, part in ipairs(parts) do
                if module.shouldConvertPart(part) then
                    Utils.convertItemAndChildrenToTerrain({parent = part, material = material, ignoreKids = true})
                    module.tagConvertedPart(part, tagName2)
                end
            end
        end
    end
    wait(0.001)

    -- Do air last, for subtracting terrain
    local airParts = Utils.getByTagInParent({parent = parentFolder, tag = prefix .. 'Air'})
    for _, part in ipairs(airParts) do
        if module.shouldConvertPart(part) then
            -- wait(0.001)
            Utils.convertItemAndChildrenToTerrain({parent = part, material = Enum.Material.Air, ignoreKids = true})
            module.tagConvertedPart(part, tagName2)
        end
    end
end

return module

local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local module = {}

function module.initTerrain(props)
    local parentFolder = props.parentFolder
    local materials = Enum.Material:GetEnumItems()

    for _, material in ipairs(materials) do
        local tagName = 'T-' .. material.Name

        if material.Name ~= 'Air' then
            local parts = Utils.getByTagInParent({parent = parentFolder, tag = tagName})

            for _, part in ipairs(parts) do
                Utils.convertItemAndChildrenToTerrain({parent = part, material = material, ignoreKids = true})
            end
        end
    end
end

function module.initTerrainAfter(props)
    local parentFolder = props.parentFolder
    local materials = Enum.Material:GetEnumItems()

    for _, material in ipairs(materials) do
        local tagName = 'T2-' .. material.Name

        if material.Name ~= 'Air' then
            local parts = Utils.getByTagInParent({parent = parentFolder, tag = tagName})

            for _, part in ipairs(parts) do
                Utils.convertItemAndChildrenToTerrain({parent = part, material = material, ignoreKids = true})
            end
        end
    end
end

function module.initAir(props)
    local parentFolder = props.parentFolder

    -- Do air last, for subtracting terrain
    local airParts = Utils.getByTagInParent({parent = parentFolder, tag = 'T-Air'})
    for _, part in ipairs(airParts) do
        Utils.convertItemAndChildrenToTerrain({parent = part, material = Enum.Material.Air, ignoreKids = true})
    end
end

return module

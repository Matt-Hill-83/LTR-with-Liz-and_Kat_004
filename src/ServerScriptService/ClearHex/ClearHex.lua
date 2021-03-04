local Sss = game:GetService('ServerScriptService')

local Utils = require(Sss.Source.Utils.U001GeneralUtils)

local InvisiWall = require(Sss.Source.InvisiWall.InvisiWall2)

local module = {}

function module.initClearHexes(props)
    local parentFolder = props.parentFolder
    local clearHexes = Utils.getDescendantsByName(parentFolder, 'Hex_128_32_trans_pos')

    Utils.sortListByObjectKey(clearHexes, 'Name')
    for _, hex in ipairs(clearHexes) do
        local stripes = Utils.getDescendantsByName(hex, 'MiniStripe')
        for _, stripe in ipairs(stripes) do
            InvisiWall.setInvisiWallLeft(
                {
                    thickness = 0.5,
                    height = 3,
                    shortHeight = 0,
                    shortWallProps = {
                        Transparency = 0,
                        BrickColor = BrickColor.new('Light yellow'),
                        Material = Enum.Material.Grass
                    },
                    wallProps = {
                        Transparency = 0,
                        BrickColor = BrickColor.new('Alder'),
                        Material = Enum.Material.Granite
                    },
                    part = stripe
                }
            )
            InvisiWall.setInvisiWallRight(
                {
                    thickness = 0.5,
                    height = 3,
                    shortHeight = 0,
                    shortWallProps = {
                        Transparency = 0,
                        BrickColor = BrickColor.new('Light yellow'),
                        Material = Enum.Material.Grass
                    },
                    wallProps = {
                        Transparency = 0,
                        BrickColor = BrickColor.new('Alder'),
                        Material = Enum.Material.Granite
                    },
                    part = stripe
                }
            )
        end

        local bridges = Utils.getDescendantsByName(hex, 'Bridge')
        for _, stripe in ipairs(bridges) do
            InvisiWall.setInvisiWallFront(
                {
                    thickness = 0.5,
                    height = 10,
                    shortHeight = 2,
                    shortWallProps = {
                        Transparency = 0,
                        BrickColor = BrickColor.new('NavyBlue'),
                        Material = Enum.Material.Grass
                    },
                    wallProps = {
                        Transparency = .5,
                        BrickColor = BrickColor.new('NavyBlue'),
                        Material = Enum.Material.Granite
                    },
                    part = stripe
                }
            )
            InvisiWall.setInvisiWallBack(
                {
                    thickness = 0.5,
                    height = 10,
                    shortHeight = 2,
                    shortWallProps = {
                        Transparency = 0,
                        BrickColor = BrickColor.new('NavyBlue'),
                        Material = Enum.Material.Grass
                    },
                    wallProps = {
                        Transparency = .5,
                        BrickColor = BrickColor.new('NavyBlue'),
                        Material = Enum.Material.Granite
                    },
                    part = stripe
                }
            )
        end
    end
end

return module

local Sss = game:GetService('ServerScriptService')
local Statue = require(Sss.Source.Statue.Statue)
local Key = require(Sss.Source.Key.Key)
local Door = require(Sss.Source.Door.Door)

local Utils = require(Sss.Source.Utils.U001GeneralUtils)
local Replicator = require(Sss.Source.BlockDash.Replicator)

local module = {}

function module.initStatueGates(props)
    local levelConfig = props.levelConfig
    local parentFolder = props.parentFolder
    local hexConfigs = levelConfig.hexIslandConfigs

    local hexConfig = hexConfigs and hexConfigs[1] or nil

    if hexConfig then
        local statueConfigs = hexConfig.statueConfigs

        if statueConfigs then
            local statueGates = Utils.getByTagInParent({parent = parentFolder, tag = 'StatueGate'})
            for _, gate in ipairs(statueGates) do
                local statuePositioners = Utils.getByTagInParent({parent = gate, tag = 'StatuePositioner'})
                for _, statuePositioner in ipairs(statuePositioners) do
                    local statueName = statuePositioner.Name
                    local config = statueConfigs[statueName] or {}
                    Statue.initStatue(statuePositioner, config)

                    local keyPositioners = Utils.getByTagInParent({parent = gate, tag = 'KeyPositioner-Key'})
                    local keyPositioner = keyPositioners[1]

                    local doorPositioners = Utils.getByTagInParent({parent = gate, tag = 'BasicDoorPositioner'})
                    if doorPositioners and doorPositioners[1] then
                        local doorPositioner = doorPositioners[1]

                        if doorPositioner then
                            local dummy = Utils.getFirstDescendantByName(doorPositioner, 'Dummy')
                            if dummy then
                                dummy:Destroy()
                            end

                            local replicatorProps = {
                                rewardTemplate = Utils.getFromTemplates('ColorKey'),
                                positionerModel = keyPositioner,
                                parentFolder = parentFolder
                            }

                            local doorProps = {
                                positioner = doorPositioner.Positioner,
                                parentFolder = parentFolder,
                                keyName = 'Yellow',
                                width = 32
                            }

                            local newDoor = Door.initDoor(doorProps)
                            local newReplicator = Key.initKey(replicatorProps)
                            Replicator.initReplicator(newReplicator)
                        end
                    end
                end
            end
        end
    end
end
-- end

return module

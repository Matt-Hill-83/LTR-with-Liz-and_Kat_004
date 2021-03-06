local Sss = game:GetService('ServerScriptService')
local CS = game:GetService('CollectionService')
local RS = game:GetService('ReplicatedStorage')

local Players = game:GetService('Players')
local HttpService = game:GetService('HttpService')

local Utils3 = require(Sss.Source.Utils.U003PartsUtils)
local Constants = require(Sss.Source.Constants.Constants)
local Const4 = require(Sss.Source.Constants.Const_04_Characters)

local module = {}

function module.replaceTerrainInPart(part, materialToReplace, replacementMaterial)
    local function CreateRegion3FromLocAndSize(Position, Size)
        local SizeOffset = Size / 2
        local Point1 = Position - SizeOffset
        local Point2 = Position + SizeOffset
        return Region3.new(Point1, Point2)
    end

    local region = CreateRegion3FromLocAndSize(part.Position, part.Size)

    -- local min = Vector3.new(-20, -20, -20)
    -- local max = Vector3.new(20, 20, 20)
    -- local materialToReplace = Enum.Material.Grass
    -- local replacementMaterial = Enum.Material.Asphalt

    workspace.Terrain:ReplaceMaterial(region, 4, materialToReplace, replacementMaterial)
    -- workspace.Terrain:ReplaceMaterial(Region3.new(min, max), 4, materialToReplace, replacementMaterial)
end

function module.arraySubset(arr, startIndex, endIndex)
    return {table.unpack(arr, startIndex, endIndex)}
end

function module.concatArray(a, b)
    local result = {table.unpack(a)}
    table.move(b, 1, #b, #result + 1, result)
    return result
end

function module.concatArrays(arrays)
    local output = {}
    for _, array in ipairs(arrays) do
        output = module.concatArray(output, array)
    end
    return output
end

function module.doTablesMatch(a, b)
    return table.concat(a) == table.concat(b)
end

function module.deepCompare(t1, t2, ignore_mt)
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then
        return false
    end
    -- non-table types can be directly compared
    if ty1 ~= 'table' and ty2 ~= 'table' then
        return t1 == t2
    end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then
        return t1 == t2
    end
    for k1, v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not module.deepCompare(v1, v2) then
            return false
        end
    end
    for k2, v2 in pairs(t2) do
        local v1 = t1[k2]
        if v1 == nil or not module.deepCompare(v1, v2) then
            return false
        end
    end
    return true
end

function module.playWordSound2(word)
    local currentWord = Const4.wordConfigs[word]
    if currentWord then
        if currentWord.soundConfig then
            local soundConfig = currentWord.soundConfig
            local timePosition = soundConfig.timePosition
            local duration = soundConfig.duration
            local soundId = soundConfig.soundId

            local sound = Instance.new('Sound', game.Workspace)
            sound.SoundId = 'rbxassetid://' .. soundId
            sound.Looped = false

            local function stopSound()
                sound.Playing = false
            end

            sound.TimePosition = timePosition
            sound.Playing = true
            delay(duration, stopSound)
        end
    end
end

function module.partIntersectsPoint(part, point, shape)
    local delta = part.CFrame:pointToObjectSpace(point)
    delta = Vector3.new(math.abs(delta.X), math.abs(delta.Y), math.abs(delta.Z))
    local halfSize = part.Size / 2

    shape = shape or shape == Enum.PartType.Block

    if shape == Enum.PartType.Block then
        local inX = delta.X <= halfSize.X
        local inY = delta.Y <= halfSize.Y
        local inZ = delta.Z <= halfSize.Z

        return inX and inY and inZ
    elseif shape == Enum.PartType.Ball then
        local inR = delta.Magnitude <= halfSize.X

        return inR
    end
end

function module.isInsideBrick(position, brick)
    local v3 = brick.CFrame:PointToObjectSpace(position)
    return (math.abs(v3.X) <= brick.Size.X / 2) and (math.abs(v3.Y) <= brick.Size.Y / 2) and
        (math.abs(v3.Z) <= brick.Size.Z / 2)
end

function module.cloneModel_old(props)
    local model = props.model
    local position = props.position
    local suffix = props.suffix

    local modelClone = model:Clone()
    modelClone.Parent = model.Parent
    modelClone.Name = model.Name .. (suffix or '-Clone')
    if (position) then
        modelClone:SetPrimaryPartCFrame(position)
    --
    end
    return modelClone
end

function module.deleteInstanceByNameStub(props)
    local nameStub = props.nameStub
    local parent = props.parent
    local children = parent:GetChildren()
    for _, item in pairs(children) do
        local match = string.match(item.Name, nameStub)
        if item:IsA('Model') and match then
            item:Destroy()
        end
    end
end

function module.weld2Parts(part1, part2)
    local weld = Instance.new('WeldConstraint')
    weld.Name = 'WeldConstraintRackBlock'
    weld.Parent = part1
    weld.Part0 = part2
    weld.Part1 = part1
end

function module.shallowCopy(tab)
    local retval = {}
    for k, v in pairs(tab) do
        retval[k] = v
    end
    return retval
end

function module.getInstancesByNameStub(props)
    local nameStub = props.nameStub
    local parent = props.parent
    local children = parent:GetDescendants()

    local output = {}
    for _, item in pairs(children) do
        local match = string.match(item.Name, nameStub)

        if match then
            table.insert(output, item)
        --
        end
    end
    return output
end

function module.isStartPlace(props)
    local startPlaceId = Constants.startPlaceId
    local placeId = game.PlaceId

    return tonumber(placeId) == tonumber(startPlaceId)
end

function module.createImageUri(imageId)
    return 'rbxassetid://' .. imageId
end

function module.stringToArray(s, delimiter)
    delimiter = delimiter or ','
    local result = {}
    for match in (s .. delimiter):gmatch('(.-)' .. delimiter) do
        table.insert(result, match)
    end
    return result
end

local function hasProperty(instance, property)
    return (pcall(
        function()
            return instance[property]
            --
        end
    ))
end

function module.cloneModel(props)
    local parentTo = props.parentTo
    local positionToPart = props.positionToPart
    local templateName = props.templateName
    local fromTemplate = props.fromTemplate
    local modelToClone = props.modelToClone
    local offsetConfig =
        props.offsetConfig or
        {
            useParentNearEdge = Vector3.new(1, -1, 1),
            useChildNearEdge = Vector3.new(1, -1, 1),
            offsetAdder = Vector3.new(0, 0, 0)
        }

    if true then
        -- if fromTemplate then
        local childTemplate = module.getFromTemplates(templateName)

        local newChild = childTemplate:Clone()
        newChild.Parent = parentTo
        -- local childPart = newChild.PrimaryPart
        -- local freeParts = module.freeAnchoredParts({item = newChild})

        Utils3.setCFrameFromDesiredEdgeOffset2(
            {
                parent = positionToPart,
                childModel = newChild,
                offsetConfig = offsetConfig
            }
        )
        -- childPart.CFrame =
        --     Utils3.setCFrameFromDesiredEdgeOffset(
        --     {
        --         parent = positionToPart,
        --         child = childPart,
        --         offsetConfig = offsetConfig
        --     }
        -- )
        -- module.anchorFreedParts(freeParts)
        return newChild
    end
end

local function freeAnchoredParts(props)
    local parent = props.item
    local anchoredParts = {}

    local function freeParts(part)
        local hasProp = part:IsA('BasePart')

        if hasProp and part.Anchored == true then
            part.Anchored = false
            table.insert(anchoredParts, part)
        end
    end

    freeParts(parent)
    local children = parent:GetDescendants()
    for _, item in ipairs(children) do
        freeParts(item)
    end
    return anchoredParts
end

local function anchorFreedParts(items)
    for _, item in pairs(items) do
        item.Anchored = true
        --
    end
end

function module.hideItemAndChildren2(props)
    local parent = props.item
    local hiddenParts = {}

    local function hideItem2(part)
        if part:IsA('BasePart') and part.Transparency ~= 1 then
            part.Transparency = 1
            -- part.CanCollide = false
            table.insert(hiddenParts, part)
        end
        if part:IsA('Decal') and part.Transparency ~= 1 then
            part.Transparency = 1
            table.insert(hiddenParts, part)
        end
        if part:IsA('TextLabel') and part.Transparency ~= 1 then
            part.Transparency = 1
            table.insert(hiddenParts, part)
        end
    end

    hideItem2(parent)
    local children = parent:GetDescendants()
    for i, item in ipairs(children) do
        hideItem2(item)
    end
    return hiddenParts
end

function module.convertItemAndChildrenToTerrain(props)
    local parent = props.parent
    local ignoreKids = props.ignoreKids
    local canCollide = props.canCollide or false

    local material = props.material or Enum.Material.Sand
    local function convert(part)
        if part:IsA('BasePart') then
            -- if part:IsA('BasePart') and part.CanCollide == true then
            if part:IsA('WedgePart') then
                game.Workspace.Terrain:FillWedge(part.CFrame, part.Size, material)
            elseif part.Shape == Enum.PartType.Ball then
                game.Workspace.Terrain:FillBall(part.Position, part.Size.X / 2, material)
            elseif part.Shape == Enum.PartType.Cylinder then
                local height = part.Size.X
                local radius = math.min(part.Size.Z, part.Size.Y) / 2
                local newCFrame = part.CFrame * CFrame.Angles(0, 0, math.rad(90))
                game.Workspace.Terrain:FillCylinder(newCFrame, height, radius, material)
            else
                game.Workspace.Terrain:FillBlock(part.CFrame, part.Size, material)
            end
            part.Transparency = 1
            part.CanCollide = false
        -- part.CanCollide = canCollide
        end
    end

    convert(parent)
    if not ignoreKids then
        local children = parent:GetDescendants()
        for i, item in ipairs(children) do
            convert(item)
        end
    end
end

local function hideFrontLabels(parent)
    local hiddenParts = {}

    local function hideItem2(part)
        if part:IsA('TextLabel') and part.Transparency ~= 1 then
            if part.Text == 'Front' or part.Text == 'Label' then
                part.Visible = false
                table.insert(hiddenParts, part)
            end
        end
    end

    hideItem2(parent)
    local children = parent:GetDescendants()
    for i, item in ipairs(children) do
        hideItem2(item)
    end
    return hiddenParts
end

function module.unhideHideItems(props)
    local items = props.items
    for _, part in ipairs(items) do
        if part:IsA('BasePart') then
        -- part.CanCollide = true
        end
        -- if part:FindFirstChild("CanCollide") then part.CanCollide = true end
        part.Transparency = 0
        --
    end
end

local function unhideHideItems2(props)
    local items = props.items
    for _, part in ipairs(items) do
        if part:IsA('BasePart') then
        -- part.CanCollide = true
        end
        -- if part:FindFirstChild("CanCollide") then part.CanCollide = true end
        part.Transparency = 0
        --
    end
end

local function onTouchBlock(touchedBlock, callBack)
    local db = {value = false}

    local function closure(otherPart)
        if not db.value then
            db.value = true

            callBack(touchedBlock, otherPart)
            db.value = false
        end
    end
    return closure
end

local function onTouchHuman(touchedBlock, callBack)
    local db = {value = false}
    local function closure(otherPart)
        if not otherPart.Parent then
            return
        end
        local humanoid = otherPart.Parent:FindFirstChildWhichIsA('Humanoid')
        if not humanoid then
            return
        end

        if not db.value then
            db.value = true
            local player = module.getPlayerFromHumanoid(humanoid)
            callBack(touchedBlock, player)
            db.value = false
        end
    end
    return closure
end

function module.onTouchHuman2(props)
    local touchedBlock = props.touchedBlock
    local callBack = props.callBack
    local enclosedProps = props.enclosedProps

    local db = {value = false}

    -- use a closure to wrap function with additional functionality
    local function closure(otherPart)
        if not otherPart.Parent then
            return
        end
        local humanoid = otherPart.Parent:FindFirstChildWhichIsA('Humanoid')
        if not humanoid then
            return
        end

        if not db.value then
            db.value = true
            local player = module.getPlayerFromHumanoid(humanoid)
            callBack({touchedBlock = touchedBlock, player = player, enclosedProps = enclosedProps})
            db.value = false
        end
    end
    return closure
end

function getUuid()
    return HttpService:GenerateGUID(false)
end

local function destroyTools(player, toolNameStub)
    local children2 = player.Character:GetChildren()
    for _, child in ipairs(children2) do
        local pattern = toolNameStub
        local found = string.match(child.Name, pattern)
        if found and child:IsA('Tool') then
            child:Destroy()
        end
    end

    local children = player.Backpack:GetChildren()
    for _, child in ipairs(children) do
        local pattern = toolNameStub
        local found = string.match(child.Name, pattern)
        if found and child:IsA('Tool') then
            child:Destroy()
        end
    end
end

local function getActiveTool(player, toolNameStub)
    local children2 = player.Character:GetChildren()
    for _, child in ipairs(children2) do
        local pattern = toolNameStub
        local found = string.match(child.Name, pattern)
        if found and child:IsA('Tool') then
            return child
        end
    end
    return false
end

local function getActiveToolByToolType(player, toolType)
    local children2 = player.Character:GetChildren()
    for _, child in ipairs(children2) do
        local isTool = child:IsA('Tool')
        local hasProp = module.getFirstDescendantByName(child, 'ToolType')
        if hasProp and isTool then
            local correctType = child.ToolType.Value == toolType
            if correctType then
                return child
            end
        end
    end
    return false
end

local function listIncludes(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        --
        end
    end

    return false
end

local function playSound(soundId, volume)
    if (soundId) then
        local sound = Instance.new('Sound', workspace)
        sound.SoundId = 'rbxassetid://' .. soundId
        sound.Volume = volume or 0.5
        sound.Looped = false
        if not sound.IsPlaying then
            sound:Play()
        end
    end
end

local function getItemByUuid(items, uuid)
    for _, item in ipairs(items) do
        if item.Uuid == uuid then
            return item
        --
        end
    end
    return nil
end

local function removeListItemByUuid(items, uuid)
    for index, item in ipairs(items) do
        if item.uuid == uuid then
            table.remove(items, index)
        --
        end
        -- if item.Uuid ~= uuid then table.insert(newList, item) end
    end
end

local function getListItemByPropValue(items, propName, value)
    local foundItem = nil
    for _, item in ipairs(items) do
        if item[propName] == value then
            foundItem = item
            break
        end
    end
    return foundItem
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

local function sortListByObjectKey(list, keyName)
    table.sort(
        list,
        function(left, right)
            return left[keyName] < right[keyName]
            --
        end
    )
end

function applyDecalsToCharacterFromWord(props)
    local part = props.part
    local word = props.word

    local found = false

    if Const4.wordConfigs[word] then
        local imageId = Const4.wordConfigs[word]['imageId']
        if imageId then
            local decalUri = 'rbxassetid://' .. imageId
            local decalFront = module.getFirstDescendantByName(part, 'CharacterDecalFront')
            local decalBack = module.getFirstDescendantByName(part, 'CharacterDecalBack')
            decalFront.Image = decalUri
            decalBack.Image = decalUri
            found = true
        end
    end
    return found
end

function applyLabelsToCharacter(props)
    local part = props.part
    local text = props.text or 'no label'

    local charLabelFront = module.getFirstDescendantByName(part, 'CharLabelFront')
    local charLabelBack = module.getFirstDescendantByName(part, 'CharLabelBack')
    charLabelFront.Text = text
    charLabelBack.Text = text
end

function applyDecalsToCharacterFromConfigName(props)
    local part = props.part
    local configName = props.configName

    local imageId = module.getDecalIdFromName({name = configName})

    if imageId then
        local decalUri = 'rbxassetid://' .. imageId
        local decalFront = module.getFirstDescendantByName(part, 'CharacterDecalFront')
        local decalBack = module.getFirstDescendantByName(part, 'CharacterDecalBack')
        decalFront.Image = decalUri
        decalBack.Image = decalUri
    end

    local displayName = module.getDisplayNameFromName({name = configName})
    applyLabelsToCharacter({part = part, text = displayName})
end

local function getPlayerFromHumanoid(humanoid)
    local character = humanoid.Parent
    local player = Players:GetPlayerFromCharacter(character)
    return player
end

local function getKeysFromDict(dict)
    local keyset = {}
    for k, v in pairs(dict) do
        keyset[#keyset + 1] = k
        --
    end
    return keyset
end

local function removeFirstMatchFromArray(array, value)
    for i = #array, 1, -1 do
        if array[i] == value then
            table.remove(array, i)
            break
        end
    end
end

function enableChildWelds(props)
    local part = props.part
    local enabled = props.enabled

    local allWelds = module.getDescendantsByType(part, 'Weld')
    for i, weld in ipairs(allWelds) do
        weld.Enabled = enabled
        --
    end
    local allWelds2 = module.getDescendantsByType(part, 'WeldConstraint')
    for i, weld in ipairs(allWelds2) do
        weld.Enabled = enabled
        --
    end
end

local function disableEnabledWelds(part)
    local welds = {}

    local allWelds = module.getDescendantsByType(part, 'Weld')
    for _, weld in ipairs(allWelds) do
        if weld.Enabled then
            weld.Enabled = false
            table.insert(welds, weld)
        end
    end
    local allWelds2 = module.getDescendantsByType(part, 'WeldConstraint')
    for _, weld in ipairs(allWelds2) do
        if weld.Enabled then
            weld.Enabled = false
            table.insert(welds, weld)
        end
    end
    return welds
end

function genRandom(min, max, float)
    local rand = min + math.random() * (max - min + 1)
    return float and rand or math.floor(rand)
end

function module.clearTable(tbl)
    for key in pairs(tbl) do
        tbl[key] = nil
    end
end

function module.setPropsByTag(props)
    local tag = props.tag
    local theProps = props.props

    local items = CS:GetTagged(tag)
    for i, item in ipairs(items) do
        mergeTables(item, theProps)
        --
    end
end

function module.getByTagInParent(props)
    local tag = props.tag
    local parent = props.parent
    local items = CS:GetTagged(tag)

    local output = {}
    for i, item in ipairs(items) do
        if item:IsDescendantOf(parent) then
            table.insert(output, item)
        end
    end
    return output
end

function module.getFirstDescendantByName(parent, name)
    local model = parent:GetDescendants()
    if #model > 80000 then
    end
    for index, item in ipairs(model) do
        if item.Name == name then
            return item
        end
    end
end

function getDescendantsByName(parent, name)
    local items = parent:GetDescendants()

    local output = {}
    for i, item in ipairs(items) do
        if item.Name == name then
            table.insert(output, item)
        --
        end
    end
    return output
end

function module.getDescendantsByType(parent, type)
    local items = parent:GetDescendants()
    local output = {}

    for i, item in pairs(items) do
        if item:IsA(type) then
            table.insert(output, item)
        --
        end
    end
    return output
end

local function getFirstDescendantByType(parent, type)
    local items = parent:GetDescendants()
    local output

    for i, item in pairs(items) do
        if item:IsA(type) then
            output = item
            break
        end
    end
    return output
end

function hideItem(part, hide)
    local transparency = hide and 1 or 0
    local visible = not hide
    local enabled = not hide

    if part:IsA('BasePart') then
        part.Transparency = transparency
    end
    if part:IsA('Decal') then
        part.Transparency = transparency
    end

    if part:IsA('ScrollingFrame') then
        part.Visible = visible
    end
    if part:IsA('TextLabel') then
        part.Visible = visible
    end
    if part:IsA('TextButton') then
        part.Visible = visible
    end

    if part:IsA('SurfaceGui') then
        part.Enabled = enabled
    end
end

function setChildrenProps(parent, props)
    if parent:IsA('BasePart') then
        mergeTables(parent, props)
    end

    local children = parent:GetDescendants()
    for i, item in ipairs(children) do
        if item:IsA('BasePart') then
            mergeTables(item, props)
        end
    end
end

function hideItemAndChildren(props)
    local parent = props.item
    local hide = props.hide

    hideItem(parent, hide)
    local children = parent:GetDescendants()
    for i, item in ipairs(children) do
        hideItem(item, hide)
    end
end

function sizeWalls(props)
    local parent = props.item
    local height = props.height

    local children = parent:GetDescendants()
    for i, item in ipairs(children) do
        if item:isA('Part') then
            item.CanCollide = false
        end
    end
    for i, item in ipairs(children) do
        if item:isA('Part') then
            local posY = item.Position.Y - item.Size.Y / 2
            local newPosY = posY + (height / 2)
            item.Size = Vector3.new(item.Size.X, height, item.Size.Z)
            item.Position = Vector3.new(item.Position.X, newPosY, item.Position.Z)
        end
    end
    for i, item in ipairs(children) do
        if item:isA('Part') then
            item.CanCollide = true
            item.Anchored = true
        end
    end
end

function setItemHeight(props)
    local item = props.item
    local height = props.height

    if item:isA('Part') then
        local posY = item.Position.Y - item.Size.Y / 2
        local newPosY = posY + (height / 2)
        item.Size = Vector3.new(item.Size.X, height, item.Size.Z)
        item.Position = Vector3.new(item.Position.X, newPosY, item.Position.Z)
    end
end

function sizeWalls2(props)
    local items = props.items
    local height = props.height

    for i, item in ipairs(items) do
        if item:isA('Part') then
            item.CanCollide = false
        end
    end

    for i, item in ipairs(items) do
        if item:isA('Part') then
            local posY = item.Position.Y - item.Size.Y / 2
            local newPosY = posY + (height / 2)
            item.Size = Vector3.new(item.Size.X, height, item.Size.Z)
            item.Position = Vector3.new(item.Position.X, newPosY, item.Position.Z)
        end
    end

    for i, item in ipairs(items) do
        if item:isA('Part') then
            item.CanCollide = true
            item.Anchored = true
        end
    end
end

function module.hideItemAndChildrenByName(props)
    local name = props.name
    local hide = props.hide

    local myStuff = workspace.MyStuff
    local item = module.getFirstDescendantByName(myStuff, name)
    hideItemAndChildren({item = item, hide = hide})
end

function module.setWallHeightByList(props)
    local items = props.items
    local height = props.height

    sizeWalls2({items = items, height = height})
end

function module.setWallHeightbyParentModelName(props)
    local name = props.name
    local height = props.height

    local myStuff = workspace.MyStuff
    local items = getDescendantsByName(myStuff, name)

    for i, item in ipairs(items) do
        sizeWalls({item = item, height = height})
        --
    end
end

function module.setItemAndChildrenPropsByName(myProps)
    local name = myProps.name
    local props = myProps.props

    local myStuff = workspace.MyStuff
    local item = module.getFirstDescendantByName(myStuff, name)
    setChildrenProps(item, props)
end

function module.setItemAndChildrenPropsByInst(myProps)
    local item = myProps.item
    local props = myProps.props

    setChildrenProps(item, props)
end

function module.getOrCreateFolder(props)
    local name = props.name
    local parent = props.parent

    local runtimeQuestsFolder = module.getFirstDescendantByName(parent, name)

    if not runtimeQuestsFolder then
        runtimeQuestsFolder = Instance.new('Folder', parent)
        runtimeQuestsFolder.Name = name
        runtimeQuestsFolder = module.getFirstDescendantByName(parent, name)
    end

    return runtimeQuestsFolder
end

function module.reportPlayerLocation()
    -- local Players = game:GetService("Players")
    Players.PlayerAdded:Connect(
        function(player)
            player.CharacterAdded:Connect(
                function(character)
                    local humanoidRootPart = character:WaitForChild('HumanoidRootPart')
                    while humanoidRootPart do
                        local test2 = workspace.CurrentCamera.CFrame.Position
                        wait(4)
                    end
                end
            )
        end
    )
end

function module.getDecalIdFromName(props)
    local name = props.name
    if (Const4.characters[name] and Const4.characters[name]['decalId']) then
        return Const4.characters[name]['decalId']
    else
        if (name ~= 'blank' and name ~= 'empty' and name ~= '') then
        end
        return '5999465084'
    end
end

function module.getDisplayNameFromName(props)
    local name = props.name
    if (Const4.characters[name] and Const4.characters[name]['displayName']) then
        return Const4.characters[name]['displayName']
    else
        return name
    end
end

function module.deleteChildrenByName(props)
    local parent = props.parent
    local childName = props.childName
    local children = parent:GetDescendants()
    for i, item in pairs(children) do
        if item.Name == childName then
            item:Destroy()
        end
    end
end

function getFromMyStuff(name)
    local myStuff = workspace.MyStuff
    return module.getFirstDescendantByName(myStuff, name)
end

function module.getFromTemplates(name)
    local myStuff = workspace.MyStuff
    local myTemplates = myStuff.MyTemplates
    return module.getFirstDescendantByName(myTemplates, name)
end

function module.getFromRepStorage(name)
    local myTemplates = RS.MyTemplates
    return module.getFirstDescendantByName(myTemplates, name)
end

function module.unAttachAllChildParts(parent)
    local items = parent:GetDescendants()
    local output = {}
    for i = 1, #items do
        if items[i]:IsA('Part') then
            local item = items[i]
            if item.Anchored == true then
                table.insert(output, item)
            end
        end
    end
    return output
end

function module.getDescendantsByNameMatch(parent, name)
    local descendants = parent:GetDescendants()
    local output = {}
    for i = 1, #descendants do
        local child = descendants[i]
        local match = string.match(child.Name, name)
        if match then
            table.insert(output, child)
        end
    end
    return output
end

function addcfv3(a, b)
    local x, y, z, m11, m12, m13, m21, m22, m23, m31, m32, m33 = a:components()
    return CFrame.new(x + b.x, y + b.y, z + b.z, m11, m12, m13, m21, m22, m23, m31, m32, m33)
end

local function getNames(tab, name, res, lev)
    res = res or {[tab] = 'ROOT'}
    local pls = {}
    lev = lev or 0
    for k, v in pairs(tab) do
        if type(v) == 'table' and not res[v] then
            local n = name .. '.' .. tostring(k)
            res[v] = n
            pls[v] = n
        end
    end
    for k, v in pairs(pls) do
        getNames(k, v, res)
        pls[k] = lev
    end
    return res, pls
end

function tableToString(tab, a, b, c, d)
    a, b = a or 0, b or {[tab] = true}
    local name = b[tab]
    local white = ('\t'):rep(a + 1)
    if not c then
        c, d = getNames(tab, 'ROOT')
    end
    local res = {'{'}
    for k, v in pairs(tab) do
        local value
        if type(v) == 'table' then
            if d[v] == a and not b[v] then
                b[v] = true
                value = tableToString(v, a + 1, b, c, d)
            else
                value = c[v]
            end
        elseif type(v) == 'string' then
            value = '"' .. v:gsub('\n', '\\n'):gsub('\t', '\\t') .. '"'
        else
            value = tostring(v)
        end
        table.insert(res, white .. tostring(k) .. ' = ' .. value)
    end
    white = white:sub(2)
    table.insert(res, white .. '}')
    return table.concat(res, '\n')
end

function mergeTables(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
end

local function addPadding(props)
    local parent = props.parent
    local padding = props.padding
    local inPx = props.inPx

    local uIPadding = Instance.new('UIPadding', parent)

    if inPx then
        uIPadding.PaddingBottom = UDim.new(0, padding)
        uIPadding.PaddingTop = UDim.new(0, padding)
        uIPadding.PaddingLeft = UDim.new(0, padding)
        uIPadding.PaddingRight = UDim.new(0, padding)
    else
        uIPadding.PaddingBottom = UDim.new(padding, 0)
        uIPadding.PaddingTop = UDim.new(padding, 0)
        uIPadding.PaddingLeft = UDim.new(padding, 0)
        uIPadding.PaddingRight = UDim.new(padding, 0)
    end
end

module.addcfv3 = addcfv3
module.addPadding = addPadding
module.enableChildWelds = enableChildWelds
module.genRandom = genRandom
module.getDescendantsByName = getDescendantsByName
module.getFromMyStuff = getFromMyStuff
module.getItemByUuid = getItemByUuid
module.getKeysFromDict = getKeysFromDict
module.getPlayerFromHumanoid = getPlayerFromHumanoid
module.getUuid = getUuid
module.hideItem = hideItem
module.disableEnabledWelds = disableEnabledWelds
module.hideItemAndChildren = hideItemAndChildren
module.listIncludes = listIncludes
module.mergeTables = mergeTables
module.playSound = playSound
module.removeFirstMatchFromArray = removeFirstMatchFromArray
module.removeListItemByUuid = removeListItemByUuid
module.setItemHeight = setItemHeight
module.destroyTools = destroyTools
module.sortListByObjectKey = sortListByObjectKey
module.tablelength = tablelength
module.tableToString = tableToString
module.onTouchBlock = onTouchBlock
module.getActiveTool = getActiveTool

module.unhideHideItems2 = unhideHideItems2

module.onTouchHuman = onTouchHuman
module.hasProperty = hasProperty
module.freeAnchoredParts = freeAnchoredParts
module.anchorFreedParts = anchorFreedParts
module.getActiveToolByToolType = getActiveToolByToolType
module.hideFrontLabels = hideFrontLabels
module.getListItemByPropValue = getListItemByPropValue
module.getFirstDescendantByType = getFirstDescendantByType
module.applyDecalsToCharacterFromWord = applyDecalsToCharacterFromWord
module.applyDecalsToCharacterFromConfigName = applyDecalsToCharacterFromConfigName

return module

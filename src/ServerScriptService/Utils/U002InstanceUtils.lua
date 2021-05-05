local Players = game:GetService('Players')

local module = {}

-- Memoization: since these results are rarely (if ever) going to change
-- all we have to do is check a cache table for the UserId.
-- If we find the UserId, then we have no work to do! Just return the name (fast).
-- If we don't find the UserId (cache miss), go look it up (takes time).
local cache = {}
function module.getUsernameFromUserId(userId)
    -- First, check if the cache contains the name
    if cache[userId] then
        return cache[userId]
    end
    -- Second, check if the user is already connected to the server
    local player = Players:GetPlayerByUserId(userId)
    if player then
        cache[userId] = player.Name
        return player.Name
    end
    -- If all else fails, send a request
    local name
    pcall(
        function()
            name = Players:GetNameFromUserIdAsync(userId)
        end
    )
    cache[userId] = name
    return name
end

return module

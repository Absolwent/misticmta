addEvent ("setDraftFactor", true)
addEvent ("requestDraftInit", true)

local draftInterval = tonumber (get ("draftInterval")) or 500
local draftMaxDistance = tonumber (get ("draftMaxDistance")) or 50
local draftDisplayThreshold = tonumber (get ("draftDisplayThreshold")) or 0.6
local draftMultiplier = tonumber (get ("draftMultiplier")) or 0.9

function enableDraftingForPlayer (player, vehicle)
    triggerClientEvent (player, "enableDrafting", player, vehicle, draftInterval, draftMaxDistance, draftDisplayThreshold)
end

function disableDraftingForPlayer (player)
    triggerClientEvent (player, "disableDrafting", player)
end

function setVehicleDraftFactor (vehicle, draftFactor)
    if not isElement (vehicle) then return end
    
    local origHandling = getOriginalHandling (getElementModel (vehicle))
    
    local dragCoeff = origHandling.dragCoeff
    if draftFactor > 0 then 
        dragCoeff = origHandling.dragCoeff - (math.log (origHandling.dragCoeff, 10) * draftFactor * draftMultiplier)
    end
    
    setVehicleHandling (vehicle, "dragCoeff", dragCoeff)
end

addEventHandler ("onPlayerVehicleEnter", root,
    function (vehicle, seat)
        if seat == 0 then
            enableDraftingForPlayer (source, vehicle)
        end
    end
)

addEventHandler ("onPlayerVehicleExit", root,
    function (vehicle, seat)
        disableDraftingForPlayer (source)
    end
)

addEventHandler ("onPlayerQuit", root,
    function ()
        local vehicle = getPedOccupiedVehicle (source)
        if not isElement (vehicle) or getVehicleOccupant (vehicle, 0) ~= source then return end
        
        setVehicleDraftFactor (vehicle, 0.0)
    end
)

addEventHandler ("setDraftFactor", root,
    function (vehicle, draftFactor)
        setVehicleDraftFactor (vehicle, draftFactor)
    end
)

addEventHandler ("requestDraftInit", root,
    function (vehicle)
        enableDraftingForPlayer (source, vehicle)
    end
)

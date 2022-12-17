local playerBlipRoot = createElement("playerBlipRoot", "playerBlipRoot")
local function resourceStart()
	for _, player in ipairs(getElementsByType("player")) do
		if player ~= localPlayer then
			local r, g, b = getPlayerNametagColor(player)
			local blip = createBlipAttachedTo(player, 0, 2, r, g, b, 255, 1)
			setElementParent(blip, playerBlipRoot)
		end
	end
end
addEventHandler("onClientResourceStart", root, resourceStart)

local function playerJoin()
	local r, g, b = getPlayerNametagColor(source)
	local blip = createBlipAttachedTo(source, 0, 2, r, g, b, 255, 1)
	setElementParent(blip, playerBlipRoot)
	setTimer(updateBlipColor, 5000, 1, blip)
end
addEventHandler("onClientPlayerJoin", root, playerJoin)

local function playerQuit()
	for _, blip in ipairs(getElementChildren(playerBlipRoot)) do
		if getElementAttachedTo(blip) == source then
			destroyElement(blip)
		end
	end
end
addEventHandler("onClientPlayerQuit", root, playerQuit)

function updateBlipColor(blip)
	local player = getElementAttachedTo(blip)
	if player then
		local r, g, b = getPlayerNametagColor(player)
		setBlipColor(blip, r, g, b, 255)
	end
end

addEventHandler("onClientRender", getRootElement(), function()
for k,player in ipairs(getElementsByType("player")) do
    if getElementHealth(player) >= 1 then
        local width, height = guiGetScreenSize ()
        local lx, ly, lz = getWorldFromScreenPosition ( width/2, height/2, 10 )
        setPedLookAt(player, lx, ly, lz)
        end 
    end
end)
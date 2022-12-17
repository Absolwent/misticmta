
local sx,sy = guiGetScreenSize()
local s = function(n) return exports["m_ui"]:scale(n) end

local MARKER_ANIMATION_SPEED = 0.002

local MARKER_ICON_SIZE = 1.4
local MARKER_ANIMATION_SIZE = 0.1

local MARKER_TEXT_SIZE = 0.8
local MARKER_TEXT_ANIMATION_SIZE = 0.1
local MARKER_TEXT_OFFSET = Vector3(0, 0, 1.2)

local markersToDraw = {}

local floorTexture
local screenTextFont
local screenTextBottomOffset = s(20)

local currentMarker
local markerKey = "h"

local markerTypes = {
    shop = {
        name = "Магазин Одежды",
        color = {255,255,255},
        radius = 1.5,
        icon = "Files/icons/clothes.png",
        text = "Нажмите на 'F' что-бы войти в магазин одежды",
        restrict = "player",
	},
	carshop = {
		name = "Автосалон",
		color = {255,255,255},
		radius = 1.5,
		icon = "Files/icons/shop.png",
		text = "Нажмите на 'F' что-бы войти в автосалон",
		restrict = "player",
	}
}

function getMarkerProperties(type)
	return markerTypes[type]
end

local function dxDrawShadowTextOld(text, x1, y1, x2, y2, color, scale, font, alignX, alignY)
	dxDrawText(text, x1 - 1, y1, x2 - 1, y2, tocolor(0, 0, 0, 150), scale, font, alignX, alignY)
	dxDrawText(text, x1 + 1, y1, x2 + 1, y2, tocolor(0, 0, 0, 150), scale, font, alignX, alignY)
	dxDrawText(text, x1, y1 - 1, x2, y2 - 1, tocolor(0, 0, 0, 150), scale, font, alignX, alignY)
	dxDrawText(text, x1, y1 + 1, x2, y2 + 1, tocolor(0, 0, 0, 150), scale, font, alignX, alignY)
	dxDrawText(text, x1, y1, x2, y2, color, scale, font, alignX, alignY)
end

local function dxDrawShadowText(text, x1, y1, x2, y2, color, scale, font, alignX, alignY)
	dxDrawText(text, x1 + 2, y1, x2 + 2, y2, tocolor(0, 0, 0, 30), scale, font, alignX, alignY)
	dxDrawText(text, x1 + 2, y1 + 2, x2 + 2, y2 + 2, tocolor(0, 0, 0, 30), scale, font, alignX, alignY)
	dxDrawText(text, x1, y1 + 2, x2, y2 + 2, tocolor(0, 0, 0, 30), scale, font, alignX, alignY)
	dxDrawText(text, x1, y1, x2, y2, color, scale, font, alignX, alignY)
end

local function drawScreenText(text)
	text = string.format(text,string.upper(markerKey))
	dxDrawShadowText(text,0,0,sx,sy-screenTextBottomOffset,white,1,screenTextFont,"center","bottom")	
end

local function drawMarker(marker)
	local markerType = marker:getData("marker:type")
	local markerProperties = markerTypes[markerType]
	if not markerProperties then
		return
	end

	local t = getTickCount()

	local color = {
		markerProperties.color[1], 
		markerProperties.color[2], 
		markerProperties.color[3], 
		200 + math.sin(t * MARKER_ANIMATION_SPEED / 3) * 35
	}

	local restrictElement = markerProperties.restrict
	local canEnter = false
	if restrictElement then
		if restrictElement == "vehicle" and localPlayer.vehicle then
			canEnter = true
		elseif restrictElement == "player" and not localPlayer.vehicle then
			canEnter = true
		end
	else
		canEnter = true
	end
	if (localPlayer:isWithinMarker(marker) or (localPlayer.vehicle and localPlayer.vehicle:isWithinMarker(marker))) and canEnter then
		if not markerProperties.noPaint then
			color = {
				190 + math.sin(t * MARKER_ANIMATION_SPEED) * 23, 
				200 + math.sin(t * MARKER_ANIMATION_SPEED) * 20,
				216 + math.sin(t * MARKER_ANIMATION_SPEED) * 30,
				255
			}
		end
		local markerText = marker:getData("marker:text")
		if not markerText then
			markerText = markerProperties.text
		end
		drawScreenText(markerText)
		if currentMarker ~= marker then
			--triggerEvent("wrp-markers:enter", marker)
			currentMarker = marker
		end
	end	

	local mx,my,mz = getElementPosition(marker)
	if markerProperties.icon then
		local markerIconSize = MARKER_ICON_SIZE
		local animationSize = MARKER_ANIMATION_SIZE
		if markerProperties.radius then
			markerIconSize = markerProperties.radius
			animationSize = markerIconSize / MARKER_ICON_SIZE * MARKER_ANIMATION_SIZE
		end
		local iconSize = markerIconSize - math.sin(t * MARKER_ANIMATION_SPEED) * animationSize		

		local direction = marker:getData("marker:direction")
		local ox = math.cos(direction) * iconSize / 2
		local oy =  math.sin(direction) * iconSize / 2
		dxDrawMaterialLine3D(
			mx + ox,
			my + oy,
			mz,
			mx - ox,
			my - oy,
			mz,
			floorTexture, 
			iconSize,
			tocolor(255, 0, 72, color[4]),
			mx,
			my,
			mz + 1
		)
	end

	if not markerProperties.text then
		return
	end
	local textSize = markerProperties.size or MARKER_TEXT_SIZE
	local textAnimationOffset = math.sin(t * MARKER_ANIMATION_SPEED) * MARKER_TEXT_ANIMATION_SIZE
	dxDrawMaterialLine3D(
		mx, 
		my,
		mz + textSize / 2 + MARKER_TEXT_OFFSET.z + textAnimationOffset,
		mx,
		my,
		mz - textSize / 2 + MARKER_TEXT_OFFSET.z + textAnimationOffset,
		markerProperties.icon,
		textSize,
		white
	)
end

function addMarkerToDraw(marker)
	if isElementStreamedIn(marker) then
		markersToDraw[marker] = true
	end
end

addEventHandler("onClientRender",root,function()
	if localPlayer:getData("user:state") then return end
	for m in pairs(markersToDraw) do
		drawMarker(m)
	end
end)

addEventHandler("onClientElementStreamIn", root, function ()
	if source:getData("marker:type") then
		addMarkerToDraw(source)
	end
end)

addEventHandler("onClientElementStreamOut", root, function ()
	if markersToDraw[source] then
		markersToDraw[source] = nil
	end
end)

addEventHandler("onClientElementDestroy", root, function ()
	if markersToDraw[source] then
		markersToDraw[source] = nil
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function ()
	for name, markerProperties in pairs(markerTypes) do
		if markerProperties.icon then
			markerProperties.icon = dxCreateTexture(markerProperties.icon,"dxt5")
		end
		if markerProperties.text then
			markerProperties.text = tostring(markerProperties.text)
		end
	end

    screenTextFont = exports["m_ui"]:createFont("Roboto-Regular.ttf",s(13))
    floorTexture = dxCreateTexture("Files/floor.png",'argb',true,'clamp')
end)

addEventHandler("onClientKey",root,function(key,state)
	if key == markerKey and state then
		if isMTAWindowActive() then return false end
		if not isElement(currentMarker) then return end
		if localPlayer:getData("user:state") or localPlayer:getData("activeUI") then return end	
		if getElementInterior(localPlayer) ~= getElementInterior(currentMarker) then return end
		if getElementDimension(localPlayer) ~= getElementDimension(currentMarker) then return end
		if localPlayer:isWithinMarker(currentMarker) or (localPlayer.vehicle and localPlayer.vehicle:isWithinMarker(currentMarker)) then
			triggerEvent("wrp-markers:use",currentMarker)
			cancelEvent()
		end		
	end
end)

addEventHandler("onClientMarkerLeave",resourceRoot,function(player)
	if player ~= localPlayer then return end
	if source == currentMarker then currentMarker = nil end
end)
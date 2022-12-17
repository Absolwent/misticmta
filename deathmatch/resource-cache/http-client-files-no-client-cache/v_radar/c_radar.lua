local MAP = {}

-- variables

MAP.fonts = {
	dxCreateFont("assets/fonts/f.ttf", 17/zoom),
}


MAP.pos = {x=25/zoom, y=sh-(235/zoom), w=380/zoom, h=215/zoom}
local Shadowpos = {x=1/zoom, y=sh-(235/zoom), w=430/zoom, h=245/zoom}

MAP.location = {
    pos = {0, 0, 0},

    alpha_1 = 255,
    alpha_2 = 255,

    location_1 = "",
    location_2 = "",

    location_1_a = false,
    location_2_a = false,

    animation_time = 500
}

--

-- load start animation

local x,y,z = getElementPosition(localPlayer)
MAP.location.location_1 = getZoneName(x, y, z, true)
MAP.location.location_2 = getZoneName(x, y, z, false)
setTimer(function()
	animate(MAP.location.alpha_1, 0, "Linear", MAP.location.animation_time, function(a)
		MAP.location.alpha_1 = a
	end)

	animate(MAP.location.alpha_2, 0, "Linear", MAP.location.animation_time, function(a)
		MAP.location.alpha_2 = a
	end)
end, 2500, 1)

--

-- events

MAP.onRender = function()
	if not getElementData(localPlayer, "playing") then return end
	if(getElementDimension(localPlayer) == 0 and getElementInterior(localPlayer) == 0)then
		-- zoomed
		if((getKeyState("=") or getKeyState("num_add")) and not isChatBoxInputActive() and not isConsoleActive() and not isCursorShowing())then
			SETTINGS.minimap_zoom.current = math.max(SETTINGS.minimap_zoom.current-0.05, SETTINGS.minimap_zoom.minimum)
		elseif((getKeyState("-") or getKeyState("num_sub")) and not isChatBoxInputActive() and not isConsoleActive() and not isCursorShowing())then
			SETTINGS.minimap_zoom.current = math.min(SETTINGS.minimap_zoom.current+0.05, SETTINGS.minimap_zoom.maximum)
		end
		--

		-- utilits
		playerX, playerY = getElementPosition(localPlayer)

		local playerRotation = getPedRotation(localPlayer)
		local playerMapX, playerMapY = (3000 + playerX) / 6000 * SETTINGS.map_size, (3000 - playerY) / 6000 * SETTINGS.map_size
		local streamDistance, pRotation = SETTINGS.minimap_size, getRotation()
		local mapRadius = streamDistance / 6000 * SETTINGS.map_size * SETTINGS.minimap_zoom.current
		local mapX, mapY, mapWidth, mapHeight = playerMapX - mapRadius, playerMapY - mapRadius, mapRadius * 2, mapRadius * 2
		--

		-- map target
		dxSetRenderTarget(SETTINGS.map_target, true)
			-- draw map
			dxDrawImageSection(SETTINGS.targetSize_normal / 2, SETTINGS.targetSize_normal / 2, SETTINGS.targetSize_max, SETTINGS.targetSize_max, mapX, mapY, mapWidth, mapHeight, SETTINGS.map_texture, math.deg(-pRotation), 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawRectangle(SETTINGS.targetSize_normal / 2, SETTINGS.targetSize_normal / 2, SETTINGS.targetSize_max, SETTINGS.targetSize_max, tocolor(0, 0, 0, 50))
			--

			-- draw blips
			for i,v in pairs(getElementsByType("blip")) do
				local blipX, blipY, blipZ = getElementPosition(v)

				if (localPlayer ~= getElementAttachedTo(v) and getElementInterior(localPlayer) == getElementInterior(v) and getElementDimension(localPlayer) == getElementDimension(v)) then
					local blipDistance = getDistanceBetweenPoints2D(blipX, blipY, playerX, playerY)
					local blipRotation = math.deg(-getVectorRotation(playerX, playerY, blipX, blipY) - (-pRotation)) - 180
					local blipRadius = math.min((blipDistance / (streamDistance * SETTINGS.minimap_zoom.current)) * SETTINGS.targetSize_normal, SETTINGS.targetSize_normal)
					local distanceX, distanceY = getPointFromDistanceRotation(0, 0, blipRadius, blipRotation)

					local blip_icon = getBlipIcon(v)
					local blip_size = getBlipIcon(v) == 0 and (25/zoom / 2) * getBlipSize(v) or 35/zoom
					local blip_color = getBlipIcon(v) == 0 and {getBlipColor(v)} or {255, 255, 255, 255}
					local current_blip = findBlipTexture(blip_icon)

					if(blip_icon == 5)then
						blip_size=22/zoom
						blip_color={0,255,0}
					end

					local blipX, blipY = SETTINGS.targetSize_normal * 1.5 + (distanceX - ((blip_size) / 2)), SETTINGS.targetSize_normal * 1.5 + (distanceY - ((blip_size) / 2))
					local calculatedX, calculatedY = ((MAP.pos.x + (MAP.pos.w / 2)) - ((blip_size) / 2)) + (blipX - (SETTINGS.targetSize_normal * 1.5) + ((blip_size) / 2)), (((MAP.pos.y + (MAP.pos.h / 2)) - ((30/zoom) / 2)) + (blipY - (SETTINGS.targetSize_normal * 1.5) + ((30/zoom) / 2)))
					
					if(blipDistance <= (getBlipVisibleDistance(v) or 0))then
						blipX = math.max(blipX + (MAP.pos.x - calculatedX), math.min(blipX + (MAP.pos.x + MAP.pos.w - blip_size - calculatedX), blipX))
						blipY = math.max(blipY + (MAP.pos.y - calculatedY), math.min(blipY + (MAP.pos.y + MAP.pos.h - blip_size- calculatedY), blipY))
					end

					dxDrawImage(blipX, blipY, blip_size, blip_size, current_blip, 0, 0, 0, tocolor(unpack(blip_color)), false)
				end
			end
		dxSetRenderTarget()
		--

		-- draw map and player arrow
                dxDrawImage(Shadowpos.x, Shadowpos.y, Shadowpos.w, Shadowpos.h, "assets/images/mapbg.png",0,0,0, tocolor(30,30,30,100))
		dxDrawImageSection(MAP.pos.x, MAP.pos.y, MAP.pos.w, MAP.pos.h, SETTINGS.targetSize_normal / 2 + (SETTINGS.targetSize_max / 2) - (MAP.pos.w / 2), SETTINGS.targetSize_normal / 2 + (SETTINGS.targetSize_max / 2) - (MAP.pos.h / 2), MAP.pos.w, MAP.pos.h, SETTINGS.map_target, 0, -90, 0, tocolor(255, 255, 255, 255))
		dxDrawImage((MAP.pos.x + (MAP.pos.w / 2)) - ((29/zoom)/2), (MAP.pos.y + (MAP.pos.h / 2)) - ((32/zoom)/2), 29/zoom, 32/zoom, SETTINGS.minimap_textures.arrow, math.deg(-pRotation) - playerRotation)
		--

		local x,y,z = getElementPosition(localPlayer)
		if(MAP.location.location_1 ~= getZoneName(x, y, z, true) and not MAP.location.location_1_a)then
			MAP.location.location_1_a = true
			
			animate(MAP.location.alpha_1, 0, "Linear", MAP.location.animation_time, function(a)
				MAP.location.alpha_1 = a
			end, function()
				MAP.location.location_1 = getZoneName(x, y, z, true)

				animate(MAP.location.alpha_1, 255, "Linear", MAP.location.animation_time, function(a)
					MAP.location.location_1_a = false
					MAP.location.alpha_1 = a
				end, function()
					setTimer(function()
						animate(MAP.location.alpha_1, 0, "Linear", MAP.location.animation_time, function(a)
							MAP.location.location_1_a = false
							MAP.location.alpha_1 = a
						end)
					end, 2500, 1)
				end)
			end)
		end

		if(MAP.location.location_2 ~= getZoneName(x, y, z, false) and not MAP.location.location_2_a)then
			MAP.location.location_2_a = true
			
			animate(MAP.location.alpha_2, 0, "Linear", MAP.location.animation_time, function(a)
				MAP.location.alpha_2 = a
			end, function()
				MAP.location.location_2 = getZoneName(x, y, z, false)

				animate(MAP.location.alpha_2, 255, "Linear", MAP.location.animation_time, function(a)
					MAP.location.location_2_a = false
					MAP.location.alpha_2 = a
				end, function()
					setTimer(function()
						animate(MAP.location.alpha_2, 0, "Linear", MAP.location.animation_time, function(a)
							MAP.location.location_2_a = false
							MAP.location.alpha_2 = a
						end)
					end, 2500, 1)
				end)
			end)
		end
	end
end

--

addEventHandler("onClientRender", root, MAP.onRender) -- draw minimap
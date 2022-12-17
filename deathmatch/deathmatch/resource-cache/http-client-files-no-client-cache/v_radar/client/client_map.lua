--[[ 

    author: Asper (© 2019)
    mail: nezymr69@gmail.com
    all rights reserved.

]]

local MAP = {}

local buttons=exports.v_buttons

-- variables

MAP.pos = {x=455/zoom, y=0, w=sw-455/zoom, h=sh}

MAP.playerX, MAP.playerY = 0, 0
MAP.mapOffsetX, MAP.mapOffsetY = 0, 0

MAP.mapIsMoving = false
MAP.mapMoved = false

MAP.showed = false

MAP.alpha = 0
MAP.animate = false

MAP.fonts = {
    dxCreateFont("assets/fonts/Exo2-SemiBold.ttf", 20/zoom),
    dxCreateFont("assets/fonts/Exo2-Regular.ttf", 14/zoom),
    dxCreateFont("assets/fonts/Exo2-Regular.ttf", 11/zoom),
    dxCreateFont("assets/fonts/Exo2-Medium.ttf", 13/zoom),
}

-- useful

MAP.legendBlips={}
 
function isBlipExists(id)
    local value=0
    local exist=false
    for i,v in pairs(getElementsByType("blip")) do
        if(getBlipIcon(v) == tonumber(id))then
            value=value+1
            exist=v
        end
    end
    return exist and {exist,value} or false
end

function getRandomBlipWithID(id)
    local blips={}
    for i,v in pairs(getElementsByType("blip")) do
        if(getBlipIcon(v) == id)then
            blips[#blips+1]=v
        end
    end

    if(#blips > 0)then
        return blips[math.random(1,#blips)]
    end
    return false
end

--

-- events

MAP.btns={}
MAP.row=0
MAP.scroll=false
MAP.onRender = function()
    -- main
    dxDrawRectangle(0, 0, 455/zoom, sh, tocolor(31, 31, 42, MAP.alpha > 230 and 230 or MAP.alpha))
    dxDrawImage((455/2)/zoom-(204/2)/zoom, 58/zoom, 204/zoom, 137/zoom, SETTINGS.minimap_textures.logo, 0, 0, 0, tocolor(255, 255, 255, MAP.alpha))
    dxDrawRectangle(0, 240/zoom, 455/zoom, 1, tocolor(72, 70, 88, MAP.alpha > 100 and 100 or MAP.alpha))

    -- legend
    dxDrawText("LEGENDA", 0, 269/zoom, 455/zoom, sh, tocolor(200, 200, 200, MAP.alpha), 1, MAP.fonts[1], "center", "top", false)
    dxDrawImage((455/2)/zoom-(400/2)/zoom, 310/zoom, 400/zoom, 1, SETTINGS.minimap_textures.line, 0, 0, 0, tocolor(255, 255, 255, MAP.alpha))

    MAP.row=math.floor(exports.v_scroll:dxScrollGetPosition(MAP.scroll)+1)

    local x = 0
    for i = MAP.row, MAP.row+9 do
        local v=MAP.legendBlips[i]
        if(v and v[6])then
            x = x+1

            local sY=(53/zoom)*(x-1)
            dxDrawImage(45/zoom, 331/zoom+sY, 331/zoom, 52/zoom, SETTINGS.minimap_textures.rectangle, 0, 0, 0, tocolor(255, 255, 255, MAP.alpha), false)
            dxDrawRectangle(45/zoom, 331/zoom+sY, 52/zoom, 52/zoom, tocolor(31, 31, 42, MAP.alpha), false)
            if(x ~= 10)then
                dxDrawRectangle(45/zoom, 331/zoom+sY+52/zoom-1, 331/zoom, 1, tocolor(72, 70, 88, MAP.alpha > 100 and 100 or MAP.alpha))
            end

            dxDrawRectangle(45/zoom, 331/zoom+sY, 331/zoom, 52/zoom, tocolor(72, 70, 88, v.alpha))
            -- alpha
            if(isMouseInPosition(45/zoom, 331/zoom+sY, 331/zoom, 52/zoom) and not v.animate)then
                v.animate=true
          
                animate(v.alpha, 50, "Linear", 200, function(a)
                    if(v.animate)then
                        v.alpha = a
                    end
                end)
            elseif(not isMouseInPosition(45/zoom, 331/zoom+sY, 331/zoom, 52/zoom) and v.animate)then
                v.animate = false

                animate(v.alpha, 0, "Linear", 200, function(a)
                  if(not v.animate)then
                    v.alpha = a
                  end
                end)
            end
            --

            dxDrawImage(45/zoom+(52-34)/2/zoom, 331/zoom+sY+(52-34)/2/zoom, 34/zoom, 34/zoom, v[5], 0, 0, 0, tocolor(255, 255, 255, MAP.alpha), false)
            dxDrawText(v[1], 110/zoom, 331/zoom+sY, 331/zoom, 52/zoom+331/zoom+sY, tocolor(200, 200, 200, MAP.alpha), 1, MAP.fonts[2], "left", "center", false)

            dxDrawImage(45/zoom+331/zoom-30/zoom, 331/zoom+sY+(52-18)/2/zoom, 18/zoom, 18/zoom, SETTINGS.minimap_textures.value, 0, 0, 0, tocolor(255, 255, 255, MAP.alpha), false)
            dxDrawText(v[7], 45/zoom+331/zoom-30/zoom, 331/zoom+sY+(52-18)/2/zoom, 18/zoom+45/zoom+331/zoom-30/zoom, 18/zoom+331/zoom+sY+(52-18)/2/zoom, tocolor(200, 200, 200, MAP.alpha), 1, MAP.fonts[3], "center", "center", false)

            onClick(45/zoom, 331/zoom+sY, 331/zoom, 52/zoom, function()
                local randomBlip=getRandomBlipWithID(v[2])
                if(randomBlip)then
                    MAP.mapIsMoving = false
                    MAP.mapMoved = true
                    MAP.clickTick = getTickCount()
                    MAP.clickPos = {getElementPosition(randomBlip)}
                end
            end)
        end
    end

    if(MAP.clickTick)then
        MAP.playerX, MAP.playerY = interpolateBetween(MAP.playerX, MAP.playerY, 0, MAP.clickPos[1], MAP.clickPos[2], 0, (getTickCount()-MAP.clickTick)/500, "Linear")
        if((getTickCount()-MAP.clickTick) > 500)then
            MAP.clickTick = nil
        end
    end

    -- line
    dxDrawRectangle(0, sh-175/zoom, 455/zoom, 1, tocolor(72, 70, 88, MAP.alpha > 100 and 100 or MAP.alpha))

    -- info
    dxDrawText("KLAWISZOLOGIA", 0, sh-150/zoom, 455/zoom, sh, tocolor(200, 200, 200, MAP.alpha), 1, MAP.fonts[1], "center", "top", false)
    dxDrawImage((455/2)/zoom-(400/2)/zoom, sh-110/zoom, 400/zoom, 1, SETTINGS.minimap_textures.line, 0, 0, 0, tocolor(255, 255, 255, MAP.alpha))

    dxDrawText("Scroll - powiększanie/zmniejszanie mapy\nLPM - przeciąganie mapy", 22/zoom, sh-93/zoom, 455/zoom, sh, tocolor(200, 200, 200, MAP.alpha), 1, MAP.fonts[4], "left", "top", false)

    -- moved function
	if(isCursorShowing())then
		local cX, cY = getCursorPosition()
		local mapX, mapY = getWorldFromMapPosition(cX, cY)

        cX, cY = cX*sw, cY*sh

		if(getKeyState("mouse1") and MAP.mapIsMoving and isMouseInPosition(MAP.pos.x, MAP.pos.y, MAP.pos.w, MAP.pos.h))then
			MAP.playerX = -(cX*SETTINGS.bigmap_zoom.current-MAP.mapOffsetX)
			MAP.playerY = cY*SETTINGS.bigmap_zoom.current-MAP.mapOffsetY

			MAP.playerX = math.max(-3000, math.min(3000, MAP.playerX))
			MAP.playerY = math.max(-3000, math.min(3000, MAP.playerY))
		else
			if(not MAP.mapMoved)then
				MAP.playerX, MAP.playerY = getElementPosition(localPlayer)
			end
		end
    end
    --

    -- variables
	local playerRotation = getPedRotation(localPlayer)
	local mapX = (((3000 + MAP.playerX) * SETTINGS.map_unit) - (MAP.pos.w / 2) * SETTINGS.bigmap_zoom.current)
	local mapY = (((3000 - MAP.playerY) * SETTINGS.map_unit) - (MAP.pos.h / 2) * SETTINGS.bigmap_zoom.current)
    local mapWidth, mapHeight = MAP.pos.w * SETTINGS.bigmap_zoom.current, MAP.pos.h * SETTINGS.bigmap_zoom.current
    --

    -- draw map
    dxDrawImageSection(MAP.pos.x, MAP.pos.y, MAP.pos.w, MAP.pos.h, mapX, mapY, mapWidth, mapHeight, SETTINGS.map_texture, 0, 0, 0, tocolor(255, 255, 255, MAP.alpha > 235 and 235 or MAP.alpha), false)
    dxDrawRectangle(MAP.pos.x, MAP.pos.y, MAP.pos.w, MAP.pos.h, tocolor(0, 0, 0, MAP.alpha > 50 and 50 or MAP.alpha))
    --
    
    -- render blips
	for i,v in pairs(getElementsByType("blip")) do
		local blipX, blipY, blipZ = getElementPosition(v)
		local blipDistance = getDistanceBetweenPoints2D(blipX, blipY, MAP.playerX, MAP.playerY)

        if(localPlayer ~= getElementAttachedTo(v))then
            local blip_icon = getBlipIcon(v)
            local blip_size = getBlipIcon(v) == 0 and (20/zoom / 2) * getBlipSize(v) or 35/zoom
            local blip_color = getBlipIcon(v) == 0 and {getBlipColor(v)} or {255, 255, 255, 255}
            local current_blip = findBlipTexture(blip_icon)

			local centerX, centerY = (MAP.pos.x + (MAP.pos.w / 2)), (MAP.pos.y + (MAP.pos.h / 2))
			local leftFrame = (centerX - MAP.pos.w / 2) + (blip_size / 2)
			local rightFrame = (centerX + MAP.pos.w / 2) - (blip_size / 2)
			local topFrame = (centerY - MAP.pos.h / 2) + (blip_size / 2)
			local bottomFrame = (centerY + MAP.pos.h / 2) - (blip_size / 2)
			local blipX, blipY = getMapFromWorldPosition(blipX, blipY)

			centerX = math.max(leftFrame, math.min(rightFrame, blipX))
            centerY = math.max(topFrame, math.min(bottomFrame, blipY))
            
            if(blip_icon == 5)then
                blip_size=22/zoom
                blip_color={0,255,0}
            end

			local currentZoom = SETTINGS.bigmap_zoom.current*3
            if(blipDistance <= (1000*currentZoom))then
				dxDrawImage(centerX - (blip_size / 2), centerY - (blip_size / 2), blip_size, blip_size, current_blip, 0, 0, 0, tocolor(blip_color[1], blip_color[2], blip_color[3], MAP.alpha), false)
			end
		end
    end

    -- arrow player blip
	local x, y, z = getElementPosition(localPlayer)
	local blipX, blipY = getMapFromWorldPosition(x, y, z)
	if((blipX >= MAP.pos.x and blipX <= MAP.pos.x + MAP.pos.w) and (blipY >= MAP.pos.y and blipY <= MAP.pos.y + MAP.pos.h))then
		dxDrawImage(blipX - (29 / 2)/zoom, blipY - (32 / 2)/zoom, 29/zoom, 32/zoom, SETTINGS.minimap_textures.arrow, 360 - playerRotation, 0, 0, tocolor(255, 255, 255, MAP.alpha), false)
    end

    -- shadow
    dxDrawImage(MAP.pos.x, MAP.pos.y, MAP.pos.w, MAP.pos.h, SETTINGS.minimap_textures.outline_2, 0, 0, 0, tocolor(255, 255, 255, MAP.alpha), false)
end

MAP.onClick = function(btn, state, cursorX, cursorY)
	if(btn ~= "state" and state ~= "down")then return end

	if(isMouseInPosition(MAP.pos.x, MAP.pos.y, MAP.pos.w, MAP.pos.h))then
		MAP.mapOffsetX = cursorX * SETTINGS.bigmap_zoom.current + MAP.playerX
        MAP.mapOffsetY = cursorY * SETTINGS.bigmap_zoom.current - MAP.playerY
        
		MAP.mapIsMoving = true
		MAP.mapMoved = true
	end
end

MAP.onKey = function(key, press)
    if(press)then
        if(key == "F11")then
            if(MAP.showed)then
                if(MAP.animate)then return end

                MAP.animate = true
                animate(MAP.alpha, 0, "Linear", 500, function(a)
                    MAP.alpha = a
                    exports.v_scroll:dxScrollSetAlpha(MAP.scroll, a)
                end, function()
                    removeEventHandler("onClientRender", root, MAP.onRender)
                    removeEventHandler("onClientClick", root, MAP.onClick)

                    MAP.showed = false
                    MAP.animate = false

                    exports.v_scroll:dxDestroyScroll(MAP.scroll)

                    for i,v in pairs(MAP.btns) do
                        buttons:destroyButton(v)
                    end
                end)

                showCursor(false)
                showChat(true)

                setElementData(localPlayer, "user:hud_disabled", false, false)
                setElementData(localPlayer, "user:gui_showed", false, false)

                MAP.mapMoved = false
            else
                if(getElementData(localPlayer, "user:gui_showed") or getElementData(localPlayer, "user:hud_disabled"))then return end

                if(MAP.animate)then return end

                -- update legend
                MAP.legendBlips={}
                for i,v in pairs(replaceBlips) do 
                    if(v[2] ~= 5)then
                        local blip = isBlipExists(v[2])
                        if(blip)then
                            v[6]={getElementPosition(blip[1])}
                            v[7]=blip[2]

                            v.animate=false
                            v.alpha=0

                            MAP.legendBlips[#MAP.legendBlips+1]=v
                        else
                            v[6]=false
                        end
                    end
                end

                for i = 1,(#MAP.legendBlips > 10 and 10 or #MAP.legendBlips) do
                    local sY=(53/zoom)*(i-1)
                    MAP.btns[#MAP.btns+1]=buttons:createButton(45/zoom, 331/zoom+sY, 331/zoom, 52/zoom, "", 200, 0, {5,10,20}, false)
                end

                addEventHandler("onClientRender", root, MAP.onRender) 
                addEventHandler("onClientClick", root, MAP.onClick)

                MAP.scroll=exports.v_scroll:dxCreateScroll(80/zoom+331/zoom, 331/zoom, 10/zoom, 18/zoom, 0, 10, MAP.legendBlips, (53*10)/zoom, 0, 1, {0, 0, 455/zoom, sh})

                showCursor(true, false)
                showChat(false)

                MAP.showed = true

                setElementData(localPlayer, "user:hud_disabled", true, false)
                setElementData(localPlayer, "user:gui_showed", resourceRoot, false)

                MAP.animate = true
                animate(MAP.alpha, 255, "Linear", 500, function(a)
                    MAP.alpha = a
                    exports.v_scroll:dxScrollSetAlpha(MAP.scroll, a)
                end, function()
                    MAP.animate = false
                end)
            end
        elseif(MAP.showed and key == "mouse_wheel_up" and isMouseInPosition(MAP.pos.x, MAP.pos.y, MAP.pos.w, MAP.pos.h))then
            SETTINGS.bigmap_zoom.current = math.max(SETTINGS.bigmap_zoom.current-0.15, SETTINGS.bigmap_zoom.minimum)
        elseif(MAP.showed and key == "mouse_wheel_down" and isMouseInPosition(MAP.pos.x, MAP.pos.y, MAP.pos.w, MAP.pos.h))then
            SETTINGS.bigmap_zoom.current = math.min(SETTINGS.bigmap_zoom.current+0.15, SETTINGS.bigmap_zoom.maximum)
        end
    end
end

--

addEventHandler("onClientKey", root, MAP.onKey) -- on key

-- useful

function getWorldFromMapPosition(mapX, mapY)
	local worldX = MAP.playerX + ((mapX * ((MAP.pos.w * SETTINGS.bigmap_zoom.current) * 2)) - (MAP.pos.w * SETTINGS.bigmap_zoom.current))
	local worldY = MAP.playerY + ((mapY * ((MAP.pos.h * SETTINGS.bigmap_zoom.current) * 2)) - (MAP.pos.h * SETTINGS.bigmap_zoom.current)) * -1

	return worldX, worldY
end

function getMapFromWorldPosition(worldX, worldY)
	local centerX, centerY = (MAP.pos.x + (MAP.pos.w / 2)), (MAP.pos.y + (MAP.pos.h / 2))
	local mapLeftFrame = centerX - ((MAP.playerX - worldX) / SETTINGS.bigmap_zoom.current * SETTINGS.map_unit)
	local mapRightFrame = centerX + ((worldX - MAP.playerX) / SETTINGS.bigmap_zoom.current * SETTINGS.map_unit)
	local mapTopFrame = centerY - ((worldY - MAP.playerY) / SETTINGS.bigmap_zoom.current * SETTINGS.map_unit)
	local mapBottomFrame = centerY + ((MAP.playerY - worldY) / SETTINGS.bigmap_zoom.current * SETTINGS.map_unit)

	centerX = math.max(mapLeftFrame, math.min(mapRightFrame, centerX))
	centerY = math.max(mapTopFrame, math.min(mapBottomFrame, centerY))

	return centerX, centerY
end

--

addEventHandler("onClientResourceStop", resourceRoot, function()
    local gui = getElementData(localPlayer, "user:gui_showed")
    if(gui and gui == source)then
        setElementData(localPlayer, "user:gui_showed", false, false)
    end
end)
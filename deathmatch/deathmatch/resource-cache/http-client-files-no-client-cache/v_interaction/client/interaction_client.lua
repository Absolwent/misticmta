--[[ 

    author: Asper & (© 2019)
    mail: nezymr69@gmail.com
    all rights reserved.

]]

sw,sh = guiGetScreenSize()
zoom = 1920/sw

local cX,cY = 0,0
local element = false
local showed = false

-- useful function created by Asper

function isMouseInPosition(x, y, w, h)
	if(not isCursorShowing())then return end

	local cx,cy=getCursorPosition()
	cx,cy=cx*sw,cy*sh
	
    if(isCursorShowing() and (cx >= x and cx <= (x + w)) and (cy >= y and cy <= (y + h)))then
        return true
    end
    return false
end

function getPosition(myX, myY, x, y, w, h)
    if(isCursorShowing() and (myX >= x and myX <= (x + w)) and (myY >= y and myY <= (y + h)))then
        return true
    end
    return false
end

local mouseState=false
local mouseTick=getTickCount()
local mouseClicks=0
local mouseClick=false
function onClick(x, y, w, h, fnc)
	if(not isCursorShowing())then return end

	if((getTickCount()-mouseTick) > 1000 and mouseClicks > 0)then
		mouseClicks=mouseClicks-1
	end

	if(not mouseState and getKeyState("mouse1"))then
		local cursor={getCursorPosition()}
        mouseState=cursor
    elseif(not getKeyState("mouse1") and (mouseClick or mouseState))then
        mouseClick=false
        mouseState=false
    end

    if(mouseState and mouseClicks < 10 and not mouseClick)then
		local cx,cy=unpack(mouseState)
        cx,cy=cx*sw,cy*sh

        if(getPosition(cx, cy, x, y, w, h))then
			fnc()

			mouseClicks=mouseClicks+1
            mouseTick=getTickCount()
            mouseClick=true
        end
	end
end
	
--

local button = dxCreateTexture("assets/images/background.png", "argb", false, "clamp")
local font = dxCreateFont("assets/fonts/Exo2-Regular.ttf", 10/zoom)
local font2 = dxCreateFont("assets/fonts/Exo2-SemiBold.ttf", 10/zoom)
local tick = false
local options=false

function action(id, veh, option)
	local canister=getElementData(localPlayer, "have:canister")
	local fix=getElementData(localPlayer, "have:veh_fix")
	if(option == "Wlej paliwo" and canister)then
		exports.v_progressbar:createProgressbar(sw/2-537/2/zoom, sh-50/zoom, 537/zoom, 33/zoom, "TRWA WLEWANIE PALIWA...", 15/zoom, 20000)

		setPedAnimation(localPlayer, "CAMERA", "camstnd_to_camcrch", -1, false, false)

		exports.v_noti:noti("Rozpoczynasz wlewanie paliwa...")

		triggerServerEvent("interaction.action", resourceRoot, veh, "off")

		setTimer(function()
			exports.v_progressbar:destroyProgressbar()
			setPedAnimation(localPlayer, false)
			triggerServerEvent("interaction.action", resourceRoot, veh, "paliwo", canister)
			exports.v_noti:noti("Pomyślnie dolano "..canister.." litrów paliwa do pojazdu "..getVehicleName(veh)..".")
		end, 5000, 1)
		return
	elseif(option == "Napraw silnik")then
		local x,y,z=getVehicleComponentPosition(veh, "bonnet_dummy", "world")

		local myPos={getElementPosition(localPlayer)}
		local dist=getDistanceBetweenPoints3D(myPos[1],myPos[2],myPos[3],x,y,z)
		if(dist <= 3)then
			exports.v_progressbar:createProgressbar(sw/2-537/2/zoom, sh-50/zoom, 537/zoom, 33/zoom, "TRWA NAPRAWA SILNIKA...", 15/zoom, 20000)

			setPedAnimation(localPlayer, "CAMERA", "camstnd_to_camcrch", -1, false, false)

			exports.v_noti:noti("Rozpoczynasz naprawę silnika...")

			triggerServerEvent("interaction.action", resourceRoot, veh, "take")

			setTimer(function()
				exports.v_progressbar:destroyProgressbar()
				setPedAnimation(localPlayer, false)
				triggerServerEvent("interaction.action", resourceRoot, veh, "napraw")
				exports.v_noti:noti("Pomyślnie naprawiono silnik w pojeździe "..getVehicleName(veh)..".")
			end, 20000, 1)
		else
			exports.v_noti:noti("Aby naprawić silnik, podejdź bliżej maski.")
		end
		return
	elseif(option == "Schowek")then
		exports.v_inventory:toggleSafe(veh)
		return
	end

	local ids=option == "Zamknij" and 1 or option == "Bagażnik" and 4 or option == "Maska" and 3 or option == "Drzwi" and 2 or id
	triggerServerEvent("interaction.action", resourceRoot, veh, ids)
end

function onRender()
	if(tick and (getTickCount()-tick) > 100)then
		tick = false
	end

	for i,v in pairs(options.options) do
		local sY = (-31/zoom)*(i-1)

		local x,y,w,h = cX, cY+sY, 150/zoom, 30/zoom
		dxDrawRectangle(x,y,w,h, tocolor(31, 31, 42, 245), true)
		dxDrawImage(x,y,2,h, button, 0, 0, 0, tocolor(75, 75, 75, 255), true)
		dxDrawImage(x,y,2,h, button, 0, 0, 0, tocolor(5, 143, 59, v.alpha), true)
		dxDrawText(v.name, x,y,w+x,h+y, tocolor(200, 200, 200, 255), 1, font, "center", "center", false, false, true)

		if(not tick)then
			onClick(x,y,w,h, function()
				if(v.close)then
					effectOn = false
					showed = false

					removeEventHandler("onClientRender", root, onRender)
					showCursor(false)

					startWall(false)

					if(alpha)then
						setElementAlpha(localPlayer, 255)
						setElementData(localPlayer, "user:inv", false, false)
						alpha=nil
					end

					options=false
				else
					if(v.name == "Wyślij oferte")then
						exports.v_business_offers:action(i, element)
					elseif(v.name == "Przenieś na lawete" or v.name == "Rozładuj lawete")then
						exports.v_business_transport_vehs:action(v.name, element)
					else
						if(options.scriptName)then
							if(options.type and options.type == "server")then
								triggerServerEvent("action", resourceRoot, options.scriptName, i, element, v.name)
							else
								exports[options.scriptName]:action(i, element)
							end
						else
							action(i, element, v.name)
						end
					end

					effectOn = false
					showed = false

					removeEventHandler("onClientRender", root, onRender)
					showCursor(false)

					startWall(false)

					if(alpha)then
						setElementAlpha(localPlayer, 255)
						setElementData(localPlayer, "user:inv", false, false)
						alpha=nil
					end

					options=false
				end
			end)
		end

		if(isMouseInPosition(x,y,w,h) and not v.animate)then
			v.animate = true
	  
			animate(v.alpha, 255, "InQuad", 200, function(a)
				if(v.animate)then
					v.alpha = a
			  	end
			end)
		elseif(not isMouseInPosition(x,y,w,h) and v.animate)then
			v.animate = false
	  
			animate(v.alpha, 0, "InQuad", 200, function(a)
				if(not buttonAnimate)then
					v.alpha = a
			  	end
			end)
		end
	end
end

bindKey("E", "down", function()
	if(getElementData(localPlayer, "user:furnishing") or not getElementData(localPlayer, "user:uid"))then return end

	if(effectOn == false and not isPedInVehicle(localPlayer))then 
		effectOn = true

		showCursor(true)	

		startWall(true, true)	

		if(not getElementData(localPlayer, "user:inv"))then
			setElementAlpha(localPlayer, 200)
			setElementData(localPlayer, "user:inv", true, false)
			alpha=true
		end
	else
		effectOn = false
		showed = false

		removeEventHandler("onClientRender", root, onRender)

		showCursor(false)
		
		startWall(false)

		if(alpha)then
			setElementAlpha(localPlayer, 255)
			setElementData(localPlayer, "user:inv", false, false)
			alpha=nil
		end
	end
end)

addEventHandler("onClientClick", root, function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
	local x,y,w,h = cX, cY, 150/zoom, 30/zoom
	if(effectOn and clickedWorld and clickedWorld ~= localPlayer and not showed and not isPedInVehicle(localPlayer) and button == "left" and state == "down")then
		local myPos = {getElementPosition(localPlayer)}
		local ePos = {getElementPosition(clickedWorld)}
		local dist = getDistanceBetweenPoints3D(myPos[1], myPos[2], myPos[3], ePos[1], ePos[2], ePos[3])
		local settings=getElementData(localPlayer, "user:faction_settings")

		options = {options={}, scriptName=false}

		if(getElementData(clickedWorld, "interaction"))then
			local distance=getElementData(clickedWorld, "interaction").dist or 5
			if(dist > distance)then 
				exports.v_noti:noti("Musisz się znajdować minimum "..distance.." metrów od elementu.")
				return 
			end

			element = clickedWorld
			cX,cY = absoluteX,absoluteY
			showed = true
			tick = getTickCount()
			options = getElementData(clickedWorld, "interaction")

			if(options.fuel)then
				if(options.lpg)then
					if(getElementData(localPlayer, "user:player_fuel_line"))then
						options.options ={
							{name="Anuluj", alpha=0, animate=false, close=true},
							{name="Odłóż wąż", alpha=0, animate=false},
							{name="Opłać zamówienie", alpha=0, animate=false},
						}
					else
						options.options ={
							{name="Anuluj", alpha=0, animate=false, close=true},
							{name="Weź wąż z LPG", alpha=0, animate=false},
						}
					end
				else
					if(getElementData(localPlayer, "user:player_fuel_line"))then
						options.options ={
							{name="Anuluj", alpha=0, animate=false, close=true},
							{name="Odłóż wąż", alpha=0, animate=false},
							{name="Opłać zamówienie", alpha=0, animate=false},
						}
					else
						options.options ={
							{name="Anuluj", alpha=0, animate=false, close=true},
							{name="Weź wąż z PB-95", alpha=0, animate=false},
							{name="Weź wąż z ON", alpha=0, animate=false}						
						}
					end
				end
			else
				options = getElementData(clickedWorld, "interaction")
			end

			addEventHandler("onClientRender", root, onRender)
		elseif(getElementType(clickedWorld) == "vehicle" and getVehicleName(clickedWorld) ~= "Bike" and getVehicleName(clickedWorld) ~= "BMX" and getVehicleName(clickedWorld) ~= "Mountain Bike")then
			if(dist > 5)then 
				exports.v_noti:noti("Musisz się znajdować minimum 5 metrów od elementu.")
				return 
			end

			local owner=getElementData(clickedWorld, "vehicle:ownerName")
			local kanister=getElementData(localPlayer, "have:canister")
			local fix=getElementData(localPlayer, "have:veh_fix")
			local group=getElementData(clickedWorld, "vehicle:group_name")
			local faction=getElementData(localPlayer, "user:faction")
			local buy=getElementData(clickedWorld, "business:sell")

			if(getElementType(clickedWorld) ~= "vehicle")then return end

			can=false
			-- kanister
			if(kanister)then	
				if(not isEventHandlerAdded("onClientRender", root, onRender))then
					addEventHandler("onClientRender", root, onRender)
				end

				element = clickedWorld
				cX,cY = absoluteX,absoluteY
				showed = true
				tick = getTickCount()
				can=true

				table.insert(options.options, {name="Zamknij", alpha=0, animate=false, close=true})
				table.insert(options.options, {name="Wlej paliwo", alpha=0, animate=false})
			end
			--

			-- naprawka
			if(fix)then	
				if(not isEventHandlerAdded("onClientRender", root, onRender))then
					addEventHandler("onClientRender", root, onRender)
				end

				element = clickedWorld
				cX,cY = absoluteX,absoluteY
				showed = true
				tick = getTickCount()
				can=true

				table.insert(options.options, {name="Zamknij", alpha=0, animate=false, close=true})
				table.insert(options.options, {name="Napraw silnik", alpha=0, animate=false})
			end
			--

			if(owner and owner == getPlayerName(localPlayer))then
				if(not can)then
					if(not isEventHandlerAdded("onClientRender", root, onRender))then
						addEventHandler("onClientRender", root, onRender)
					end

					element = clickedWorld
					cX,cY = absoluteX,absoluteY
					showed = true
					tick = getTickCount()

					table.insert(options.options, {name="Zamknij", alpha=0, animate=false, close=true})
				end

				table.insert(options.options, {name="Schowek", alpha=0, animate=false})
				table.insert(options.options, {name="Drzwi", alpha=0, animate=false})
				table.insert(options.options, {name="Maska", alpha=0, animate=false})
				table.insert(options.options, {name="Bagażnik", alpha=0, animate=false})
			elseif(faction and group and faction == group)then
				if(not isEventHandlerAdded("onClientRender", root, onRender))then
					addEventHandler("onClientRender", root, onRender)
				end

				element = clickedWorld
				cX,cY = absoluteX,absoluteY
				showed = true
				tick = getTickCount()

				table.insert(options.options, {name="Zamknij", alpha=0, animate=false, close=true})

				if(not buy)then
					table.insert(options.options, {name="Schowek", alpha=0, animate=false})
				end

				table.insert(options.options, {name="Drzwi", alpha=0, animate=false})
				table.insert(options.options, {name="Maska", alpha=0, animate=false})
				table.insert(options.options, {name="Bagażnik", alpha=0, animate=false})
			end

			if(settings and settings.business_type and settings.business_type == "warsztat" and getVehicleName(clickedWorld) ~= "DFT-30")then
				if(not isEventHandlerAdded("onClientRender", root, onRender))then
					addEventHandler("onClientRender", root, onRender)
				end

				element = clickedWorld
				cX,cY = absoluteX,absoluteY
				showed = true
				tick = getTickCount()

				table.insert(options.options, {name="Przenieś na lawete", alpha=0, animate=false})
			elseif(settings and settings.business_type and settings.business_type == "warsztat" and getVehicleName(clickedWorld) == "DFT-30")then
				if(not isEventHandlerAdded("onClientRender", root, onRender))then
					addEventHandler("onClientRender", root, onRender)
				end

				element = clickedWorld
				cX,cY = absoluteX,absoluteY
				showed = true
				tick = getTickCount()

				table.insert(options.options, {name="Rozładuj lawete", alpha=0, animate=false})
			end
		elseif(getElementType(clickedWorld) == "player" and not isPedInVehicle(clickedWorld))then
			if(dist > 5)then 
				exports.v_noti:noti("Musisz się znajdować minimum 5 metrów od elementu.")
				return 
			end

			if(not isEventHandlerAdded("onClientRender", root, onRender))then
				addEventHandler("onClientRender", root, onRender)
			end

			element = clickedWorld
			cX,cY = absoluteX,absoluteY
			showed = true
			tick = getTickCount()

			options = {options={}, scriptName="v_inventory"}

			table.insert(options.options, {name="Zamknij", alpha=0, animate=false, close=true})
			table.insert(options.options, {name="Rozpocznij handel", alpha=0, animate=false})

			if(settings and settings.business_type and settings.business_type == "komis")then
				table.insert(options.options, {name="Wyślij oferte", alpha=0, animate=false})
			end
		end
	end
end)


-- useful functions 

local anims = {}
local rendering = false 

local function renderAnimations()
    local now = getTickCount()
    for k,v in pairs(anims) do
        v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing))
        if(now >= v.start+v.duration)then
            table.remove(anims, k)
            if(type(v.onEnd) == "function")then
                v.onEnd()
            end
        end
    end

    if(#anims == 0)then 
        rendering = false
        removeEventHandler("onClientRender", root, renderAnimations)
    end
end

function animate(f, t, easing, duration, onChange, onEnd)
	if(#anims == 0 and not rendering)then 
		addEventHandler("onClientRender", root, renderAnimations)
		rendering = true
	end
	
    assert(type(f) == "number", "Bad argument @ 'animate' [expected number at argument 1, got "..type(f).."]")
    assert(type(t) == "number", "Bad argument @ 'animate' [expected number at argument 2, got "..type(t).."]")
    assert(type(easing) == "string", "Bad argument @ 'animate' [Invalid easing at argument 3]")
    assert(type(duration) == "number", "Bad argument @ 'animate' [expected number at argument 4, got "..type(duration).."]")
    assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
    table.insert(anims, {from = f, to = t, easing = easing, duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd})

    return #anims
end

function destroyAnimation(id)
    if(anims[id])then
        anims[id] = nil
    end
end

-- useful

local shadow = tocolor(0,0,0,50)
function dxDrawTextShadow( text, x, y, w, h, color, fontSize, fontType, alignX, alignY )
	dxDrawText( text, x+1, y+1, w, h, shadow, fontSize, fontType, alignX, alignY )
	dxDrawText( text, x-1, y+1, w, h, shadow, fontSize, fontType, alignX, alignY )
	dxDrawText( text, x-1, y-1, w, h, shadow, fontSize, fontType, alignX, alignY )
 	dxDrawText( text, x+1, y-1, w, h, shadow, fontSize, fontType, alignX, alignY )

 	dxDrawText( text, x, y, w, h, color, fontSize, fontType, alignX, alignY )
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
		 local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		 if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			  for i, v in ipairs( aAttachedFunctions ) do
				   if v == func then
					return true
			   end
		  end
	 end
	end
	return false
end
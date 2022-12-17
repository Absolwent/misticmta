--[[
    Author: AteX<atexprogramming@gmail.com>
	Edit: Bone<bone.pystories@gmail.com>
]]--


local screenW,screenH = guiGetScreenSize()

local rowery = {[509]=true,[481]=true,[510]=true}

function interakcjaGui()
	local v = getPedOccupiedVehicle(localPlayer)
    if getVehicleOverrideLights(v) ~= 2 then
		w1 = "Odpal lampy"
	else
		w1 = "Zgaś lampy"
	end
	
	
    local silnik = getVehicleEngineState(v)
    if silnik == false then
        w2 = "Uruchom silnik"
    else
        w2 = "Zgaś silnik"
    end
	
	
	local drzwi = isVehicleLocked(v)
    if drzwi == true then
		w3 = "Otwórz zamek"
    else
        w3 = "Zamknij zamek"
    end
	
	
    if isElementFrozen(v) then
        w4 = "Spuść hamulec ręczny"
    else
		w4 = "Zaciągnij hamulec ręczny"
    end
	
	
    if getVehicleDoorOpenRatio(v,0) == 0 then
        w5 = "Otwórz maskę"
    else
		w5 = "Zamknij maskę"
    end
	
	
    if getVehicleDoorOpenRatio(v,1) == 0 then
        w6 = "Otwórz bagażnik"
    else
		w6 = "Zamknij bagażnik"
    end

	r1,r2,r3,r4,r5,r6 = 1,1,1,1,1,1
	local wybor = getElementData(localPlayer,"wybor")
	if wybor == 1 then
		r1 = 1.7
	elseif wybor == 2 then
		r2 = 1.7
	elseif wybor == 3 then
		r3 = 1.7
	elseif wybor == 4 then
		r4 = 1.7
	elseif wybor == 5 then
		r5 = 1.7
	elseif wybor == 6 then
		r6 = 1.7
	end
	
        --dxDrawRectangle((screenW - 1450) / 2, (screenH - 1450) / 2, 2050, 2050, tocolor(0, 255, 227, 22), false)
		
		dxDrawText(w1, (screenW * 0.3594) + 1, (screenH * 0.3435) + 1, (screenW * 0.6396) + 1, (screenH * 0.3861) + 1, tocolor(0, 0, 0, 255),r1, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(w1, screenW * 0.3594, screenH * 0.3435, screenW * 0.6396, screenH * 0.3861, tocolor(255, 136, 0), r1, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(w2, (screenW * 0.3599) + 1, (screenH * 0.3954) + 1, (screenW * 0.6401) + 1, (screenH * 0.4380) + 1, tocolor(0, 0, 0, 255), r2, "pricedown", "center", "center", false, false, false, false, false)
		dxDrawText(w2, screenW * 0.3599, screenH * 0.3954, screenW * 0.6401, screenH * 0.4380, tocolor(255, 136, 0), r2, "pricedown", "center", "center", false, false, false, false, false)
    
	local sx,sy,sz = getElementVelocity(v)
	local kmhs = math.ceil(((sx^2+sy^2+sz^2)^(0.5))*155)
    if kmhs < 20 then
		
		setElementData(localPlayer,"maksymalny_wybor",6)
		
        dxDrawText(w3, (screenW * 0.3599) + 1, (screenH * 0.4472) + 1, (screenW * 0.6401) + 1, (screenH * 0.4898) + 1, tocolor(0, 0, 0, 255), r3, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(w3, screenW * 0.3599, screenH * 0.4472, screenW * 0.6401, screenH * 0.4898, tocolor(255, 136, 0), r3, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(w4, (screenW * 0.3599) + 1, (screenH * 0.4991) + 1, (screenW * 0.6401) + 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), r4, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(w4, screenW * 0.3599, screenH * 0.4991, screenW * 0.6401, screenH * 0.5417, tocolor(255, 136, 0), r4, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(w5, (screenW * 0.3599) + 1, (screenH * 0.5509) + 1, (screenW * 0.6401) + 1, (screenH * 0.5935) + 1, tocolor(0, 0, 0, 255), r5, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(w5, screenW * 0.3599, screenH * 0.5509, screenW * 0.6401, screenH * 0.5935, tocolor(255, 136, 0), r5, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(w6, (screenW * 0.3599) + 1, (screenH * 0.6028) + 1, (screenW * 0.6401) + 1, (screenH * 0.6454) + 1, tocolor(0, 0, 0, 255), r6, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(w6, screenW * 0.3599, screenH * 0.6028, screenW * 0.6401, screenH * 0.6454, tocolor(255, 136, 0), r6, "pricedown", "center", "center", false, false, false, false, false)
	else
		setElementData(localPlayer,"maksymalny_wybor",3)
	end
end

function wybor1(key,state)
	if state == "down" then
		if getElementData(localPlayer,"wybor") == 1 then return end
		setElementData(localPlayer,"wybor",getElementData(localPlayer,"wybor")-1)
	end
end
function wybor2(key,state)
	if state == "down" then
		if getElementData(localPlayer,"wybor") == getElementData(localPlayer,"maksymalny_wybor") then return end
		setElementData(localPlayer,"wybor",getElementData(localPlayer,"wybor")+1)
	end
end

function pokazinterakcje(value)
	local v = getPedOccupiedVehicle(localPlayer)
	if v and getVehicleController(v) == localPlayer then
		if rowery[getElementModel(v)] then return end
		if value == true then
			--[[if getElementData(v,"recznySalonData") then
			outputChatBox("* Interakcja, nie działa na pojazd z Salonu / Cygana.")
			return end--]]
			addEventHandler("onClientRender",root,interakcjaGui)
			bindKey("arrow_up","both",wybor1)
			bindKey("arrow_down","both",wybor2)
			bindKey("arrow_u","both",wybor1)
			bindKey("arrow_d","both",wybor2)
			bindKey("arrow_up","both",wybor1)
			bindKey("arrow_down","both",wybor2)
			bindKey("mouse_wheel_up","both",wybor1)
			bindKey("mouse_wheel_down","both",wybor2)
			showPlayerHudComponent("radio", true)
		elseif value == false then
			--[[if getElementData(v,"recznySalonData") then
			outputChatBox("* Interakcja, nie działa na pojazd z Salonu / Cygana.")
			return end--]]
			removeEventHandler("onClientRender",root,interakcjaGui)
			unbindKey("arrow_up","both",wybor1)
			unbindKey("arrow_down","both",wybor2)
			unbindKey("arrow_up","both",wybor1)
			unbindKey("arrow_down","both",wybor2)
			unbindKey("arrow_u","both",wybor1)
			unbindKey("arrow_d","both",wybor2)
			unbindKey("mouse_wheel_up","both",wybor1)
			unbindKey("mouse_wheel_down","both",wybor2)
			showPlayerHudComponent("radio", false)
		end
	end
end

bindKey("lshift", "both", function(key,state)
		if getPedOccupiedVehicle ( localPlayer ) and getPedOccupiedVehicleSeat( localPlayer ) == 0 then 
		if state == "down" then 
		pokazinterakcje(true)
		--showChat(false)
		--setElementData ( localPlayer, "shader", true )
		--setPlayerHudComponentVisible ( "all", false ) 
		setElementData(localPlayer,"wybor",1)
	elseif state == "up" then
		wybierz()
		pokazinterakcje(false)
		--showChat(true)
		--setElementData ( localPlayer, "shader", false )
		--setPlayerHudComponentVisible ( "all", true ) 
      end
   end
end)

function wybierz()
	local wybrano = getElementData(localPlayer,"wybor")
	local v = getPedOccupiedVehicle(localPlayer)
	if not v then return end
	if v and getVehicleController(v) == localPlayer then	
		if wybrano == 1 then
			triggerServerEvent("lampy", localPlayer)
			local odglos=playSound('audio/swiatla.wav')		
		elseif wybrano == 2 then
			triggerServerEvent("silnik", localPlayer)	
		elseif wybrano == 3 then
			triggerServerEvent("drzwi", localPlayer)
			local odglos=playSound('audio/zamykaj.wav')		
		elseif wybrano == 4 then
			triggerServerEvent("handbrake", localPlayer)
			local odglos=playSound('audio/reczny.wav')		
		elseif wybrano == 5 then
			triggerServerEvent("maska", localPlayer)			
		elseif wybrano == 6 then
			triggerServerEvent("bagażnik", localPlayer)
		end
	end
end

function zamknij(plr,seat)
	if plr ~= localPlayer then return end
	if seat ~= 0 then return end
	removeEventHandler("onClientRender",root,interakcjaGui)
	--setElementData ( localPlayer, "shader", false )
	--setPlayerHudComponentVisible ( "all", true ) 
	--showChat(true)
	unbindKey("arrow_up","both",wybor1)
	unbindKey("arrow_down","both",wybor2)
	unbindKey("arrow_up","both",wybor1)
	unbindKey("arrow_down","both",wybor2)
	unbindKey("arrow_u","both",wybor1)
	unbindKey("arrow_d","both",wybor2)
	unbindKey("mouse_wheel_up","both",wybor1)
	unbindKey("mouse_wheel_down","both",wybor2)
	showPlayerHudComponent("radio", false)
end
addEventHandler("onClientVehicleStartExit",root,zamknij)
addEventHandler("onClientVehicleExit",root,zamknij)
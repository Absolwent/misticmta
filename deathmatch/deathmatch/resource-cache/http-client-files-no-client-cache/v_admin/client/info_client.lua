--[[ 

    author: Asper (© 2019)
    mail: nezymr69@gmail.com
    all rights reserved.

]]

-- variables

local UI={}

UI.infos={}

UI.pos={
	sw/2-500/2/zoom,sh/2-20/2/zoom
}

UI.buttons={}

UI.button_click=false

-- renders

UI.onRender=function()
	dxDrawText("Klucz", UI.pos[1]+5/zoom+1, UI.pos[2]+1, 0+1, UI.pos[2]+20/zoom+1, tocolor(0, 0, 0, 255), 1, fonts[7], "left", "center")
	dxDrawText("Klucz", UI.pos[1]+5/zoom, UI.pos[2], 0, UI.pos[2]+20/zoom, tocolor(222, 222, 222, 255), 1, fonts[7], "left", "center")
	dxDrawText("Wartość", UI.pos[1]+5/zoom+1, UI.pos[2]+1, UI.pos[1]-5/zoom+500/zoom+1, UI.pos[2]+20/zoom+1, tocolor(0, 0, 0, 255), 1, fonts[7], "right", "center")
	dxDrawText("Wartość", UI.pos[1]+5/zoom, UI.pos[2], UI.pos[1]-5/zoom+500/zoom, UI.pos[2]+20/zoom, tocolor(222, 222, 222, 255), 1, fonts[7], "right", "center")

	local txt=""
	for i,v in pairs(UI.infos) do
		local sY=(20/zoom)*i
		if(i%2 == 1)then
			dxDrawRectangle(UI.pos[1], UI.pos[2]+sY, 500/zoom, 20/zoom, tocolor(5, 10, 15, 200))
		else
			dxDrawRectangle(UI.pos[1], UI.pos[2]+sY, 500/zoom, 20/zoom, tocolor(15, 20, 25, 200))
		end

		dxDrawText(v[1]..":", UI.pos[1]+5/zoom, UI.pos[2]+sY, 0, UI.pos[2]+sY+20/zoom, tocolor(200, 200, 200, 255), 1, fonts[7], "left", "center")
		dxDrawText(v[2], UI.pos[1]+5/zoom, UI.pos[2]+sY, UI.pos[1]-5/zoom+500/zoom, UI.pos[2]+sY+20/zoom, tocolor(200, 200, 200, 255), 1, fonts[6], "right", "center")

		if(v[2] == "aby wyświetlić skopiuj do konsoli")then
			if(#txt > 0)then
				txt=txt..", "..v[1]..": "..v[3]
			else
				txt=v[1]..": "..v[3]
			end
		else
			if(#txt > 0)then
				txt=txt..", "..v[1]..": "..v[2]
			else
				txt=v[1]..": "..v[2]
			end
		end
	end

	for i,v in pairs(UI.buttons) do
		local sY=(22/zoom)*(i-1)
		dxDrawRectangle(UI.pos[1]+505/zoom, UI.pos[2]+20/zoom+sY, 20/zoom, 20/zoom, tocolor(10,13,20,200))
		dxDrawText(v[1], UI.pos[1]+505/zoom, UI.pos[2]+20/zoom+sY, 20/zoom+UI.pos[1]+505/zoom, 20/zoom+UI.pos[2]+20/zoom+sY, tocolor(200, 200, 200, 255), 1, fonts[6], "center", "center")

		if(getKeyState("mouse1") and isMouseInPosition(UI.pos[1]+505/zoom, UI.pos[2]+20/zoom+sY, 20/zoom, 20/zoom) and not UI.button_click)then
			if(v[2] == "close")then
				removeEventHandler("onClientRender", root, UI.onRender)
				showCursor(false)
				return
			elseif(v[2] == "copy")then
				outputConsole(txt)
			elseif(v[2] == "tp" and v[3] and isElement(v[3]))then
				local x,y,z=getElementPosition(v[3])
				setElementPosition(localPlayer, x,y,z)
			end
			UI.button_click=v[2]
		elseif(not getKeyState("mouse1"))then
			UI.button_click=false
		end
	end

	if(UI.button_click == "change")then
		local cx,cy=getCursorPosition()
		cx,cy=cx*sw,cy*sh
		UI.pos={cx-510/zoom,cy-30/zoom}
	end
end

-- triggers

addEvent("pinfo.open", true)
addEventHandler("pinfo.open", resourceRoot, function(player, v, vehicles, mute, pj, houses)
	addEventHandler("onClientRender", root, UI.onRender)
	showCursor(true,false)

	local licenses=""
	local lic_letter=0
	if(v.prawko_a == 2)then
		licenses="A"
		lic_letter=lic_letter+1
	end
	if(v.prawko_b == 2)then
		licenses=#licenses > 0 and licenses..", B" or "B"
		lic_letter=lic_letter+1
	end
	if(v.prawko_c == 2)then
		licenses=#licenses > 0 and licenses..", C" or "C"
		lic_letter=lic_letter+1
	end
	licenses=#licenses < 1 and "brak" or licenses

	local water_vehs={}
	local parking_vehs={}
	local all_vehs={}
	for i,v in pairs(vehicles) do
		if(v.parking == 1)then
			table.insert(parking_vehs,v.id)
		end

		if(v.water == 1)then
			table.insert(water_vehs,v.id)
		end

		table.insert(all_vehs,v.id)
	end

	local all_houses={}
	for i,v in pairs(houses) do
		table.insert(all_houses,v.id)
	end

	local status=getElementData(player, "user:faction") or getElementData(player, "user:job") or "Swobodna rozgrywka"

	UI.infos={
		{"UID", v.id},
		{"Login", v.login},
		{"Gotówka", getPlayerMoney(player).."$"},
		{"Bankomat", v.bkasa.."$"},
		{"Konto bankowe", v.bank_acc == 1 and "tak" or "nie"},
		{"Rejestracja", v.rejestracja},
		{"Ostatnia wizyta", v.lastlogin},
		{"Serial", getPlayerSerial(player)},
		{"Życie", math.floor(getElementHealth(player)).."%"},
		{"Skin", getElementModel(player)},
		{"Czas gry (łączny)", resulted(getElementData(player, "user:online_time"))},
		{"Czas gry (sesja)", resulted(getElementData(player, "user:sesion_time"))},
		{"Level, exp", getElementData(player, "user:level")..", "..getElementData(player, "user:exp").."XP"},
		{"Premium", getElementData(player, "user:premium") and "tak" or "nie"},
		{"Domki ("..#all_houses..")", #table.concat(all_houses,", ") > 0 and table.concat(all_houses,", ") or "brak"},
		{"Ostrzeżenia", v.warns},
		{"Licencje ("..lic_letter..")", licenses},
		{"Pojazdy ("..#all_vehs..")", #table.concat(all_vehs,", ") > 0 and table.concat(all_vehs,", ") or "brak"},
		{"Pojazdy na parkingu wirtualnym ("..#parking_vehs..")", #table.concat(parking_vehs,", ") > 0 and table.concat(parking_vehs,", ") or "brak"},
		{"Pojazdy w wyławiarce ("..#water_vehs..")", #table.concat(water_vehs,", ") > 0 and table.concat(water_vehs,", ") or "brak"},
		{"Zawieszone prawko", pj and "("..string.sub(pj.first_date,1,#pj.first_date-3).."-"..string.sub(pj.date,1,#pj.date-3)..") - "..pj.admin or "nie"},
		{"Wyciszenie", mute and "("..string.sub(mute.first_date,1,#mute.first_date-3).."-"..string.sub(mute.date,1,#mute.date-3)..") - "..mute.admin or "nie"},
		{"Status", status},
	}

	UI.buttons={
		{"V", "change"},
		{"X", "close"},
		{"T", "tp", player},
		{"C", "copy"}
	}	

	local posY=(20/zoom)*24
	UI.pos={
		sw/2-500/2/zoom,sh/2-posY/2/zoom
	}
end)

addEvent("vinfo.open", true)
addEventHandler("vinfo.open", resourceRoot, function(v)
	addEventHandler("onClientRender", root, UI.onRender)
	showCursor(true,false)

	local NAMES=exports.v_vehicles:getTuningList()

	-- upy
    local ups=fromJSON(v.ups) or {}
    local upy=""
    for i,v in pairs(ups) do
        if(#upy > 0)then
            upy=upy..", UP"..v
        else
            upy="UP"..v
        end
    end
    --

    --upgrades
    local upgrades=""
    for i,v in ipairs(fromJSON(v.tuning)) do
        local slot=NAMES.tuningSlots[getVehicleUpgradeSlotName(v)] or getVehicleUpgradeSlotName(v)
        local upgrade=NAMES.tuningNames[v] or v
        if(upgrade == "Lampa" or slot == "Nitro" or slot == "Hydraulika" or slot == "Stereo")then
            text=slot
        else
            text=slot.." ("..upgrade..")"
        end

        if(#upgrades > 0)then
            upgrades=upgrades..", "..text
        else
            upgrades=text
        end
    end
    
    if(#upy > 0)then
        upgrades=#upgrades > 0 and upgrades..", "..upy or upy
    end

    upgrades=#upgrades > 0 and upgrades or "brak"
    --

	UI.infos={
		{"ID", v.id},
		{"Stworzony jako", v.po_id},
		{"Model", getVehicleNameFromModel(v.model)},
		{"Pierwszy właściciel", v.first_owner},
		{"Właściciel", v.ownerName},
		{"Ostatni kierowca", table.concat(fromJSON(v.lastDrivers), ", ")},
		{"Przebieg", v.distance},
		{"Paliwo", v.fuel.."L/"..v.bak.."L"},
		{"Organizacja", #v.organization > 0 and v.organization or "brak"},
		{"Tuning", upgrades ~= "brak" and "aby wyświetlić skopiuj do konsoli" or upgrades, upgrades},
		{"Lokalizacja", v.parking == 1 and "Parking wirtualny" or v.garage ~= 0 and "Garaż #"..v.garage or "Zrespiony"},
	}

	UI.buttons={
		{"V", "change"},
		{"X", "close"},
		{"C", "copy"}
	}	

	local posY=(20/zoom)*11
	UI.pos={
		sw/2-500/2/zoom,sh/2-posY/2/zoom
	}
end)

-- useful

function isMouseInPosition(x, y, w, h)
	if(not isCursorShowing())then return end

	local cx,cy=getCursorPosition()
	cx,cy=cx*sw,cy*sh
	
    if(isCursorShowing() and (cx >= x and cx <= (x + w)) and (cy >= y and cy <= (y + h)))then
        return true
    end
    return false
end

function resulted(minutes)
	local h = math.floor(minutes/60)
	local m = minutes - (h*60)
	return h.."h "..m.."m"
end
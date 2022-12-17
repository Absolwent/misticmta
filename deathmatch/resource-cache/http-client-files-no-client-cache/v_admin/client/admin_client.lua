--[[ 

    author: Asper (© 2019)
    mail: nezymr69@gmail.com
    all rights reserved.

]]

-- variables

sw,sh = guiGetScreenSize()
zoom = 1920/sw
if(zoom > 1)then
	zoom=zoom/1.3
end

local ucho = {
	logs = {},
	reports = {},
	last_report=false
}

local warn = {
	text = "",
	admin = "",
	tick = getTickCount()
}

fonts = {
	-- logi
	dxCreateFont("assets/fonts/Exo2-SemiBold.ttf", 11/zoom),
	dxCreateFont("assets/fonts/Exo2-Regular.ttf", 11/zoom),

	--warny
	dxCreateFont("assets/fonts/Exo2-SemiBold.ttf", 25/zoom),
	dxCreateFont("assets/fonts/Exo2-Regular.ttf", 15/zoom),
	dxCreateFont("assets/fonts/Exo2-Regular.ttf", 15/zoom),

	--informacje
	dxCreateFont("assets/fonts/Exo2-SemiBold.ttf", 10/zoom),
	dxCreateFont("assets/fonts/Exo2-Regular.ttf", 10/zoom),
}

-- exports

local ranks = {
	[4] = {"#800021", "RCON"},
	[3] = {"#ff0000", "Administrator"},
	[2] = {"#2fc76f", "Community Manager"},
	[1] = {"#3498d6", "Support"},
	[0] = {"#6b3680", "Developer"},
}

function getRanks()
	return ranks
end

-- renders

local admin_info=false
local adminRender=function()
	if(admin_info)then
		local afk=getElementData(localPlayer, "user:afk")

		local hours = math.floor(admin_info.sec / 3600)
		local minutes = math.floor((admin_info.sec / 60) % 60)
		local seconds = math.floor(admin_info.sec % 60)

		local text_1="Służba na randze"
		local text_2=" "..ranks[admin_info.rank][2]
		local time=(hours > 0 and hours.."h " or "")..(hours > 0 and minutes.."m " or (minutes > 0 and minutes.."m " or ""))..seconds.."s"
		local text_3=" - "..time

		local w1=dxGetTextWidth(text_1,1,fonts[2])
		local w2=dxGetTextWidth(text_2,1,fonts[1])
		local w3=dxGetTextWidth(text_3,1,fonts[2])
		local r,g,b=hex2rgb(ranks[admin_info.rank][1])
		dxDrawShadowText(text_1, 300/2/zoom-w3-w2-6, 5, sw-300/2/zoom, 0, tocolor(200, 200, 200, 255), 1, fonts[2], "center", "top", false)
		dxDrawShadowText(text_2, 300/2/zoom-w3+w1, 5, sw-300/2/zoom, 0, tocolor(r,g,b, 255), 1, fonts[1], "center", "top", false)
		dxDrawShadowText(text_3, 300/2/zoom+w2+w1+3, 5, sw-300/2/zoom, 0, tocolor(200, 200, 200, 255), 1, fonts[2], "center", "top", false)

		if(afk)then
			dxDrawShadowText("Status AFK", 0, 30, sw, sh, tocolor(100, 100, 100, 255), 1, fonts[2], "center", "top", false)
		end

		if((getTickCount()-admin_info.tick) > 1000 and not afk)then
			admin_info.tick=getTickCount()
			admin_info.sec=admin_info.sec+1
		end
	end

  	--ucho
	if getElementData(localPlayer, "user:admin") and getElementData(localPlayer, "user:admin_logs") then
		local logi = table.concat(ucho.logs, "\n")
		dxDrawText("Logi serwerowe:", 21/zoom + 1, sh-600/zoom + 1, 274/zoom + 1, 749/zoom + 1, tocolor(0, 0, 0, 255), 1, fonts[1], "left", "top", false, false, false, false, false)
		dxDrawText("Logi serwerowe:", 21/zoom, sh-600/zoom, 274/zoom, 749/zoom, tocolor(11,150,65, 255), 1, fonts[1], "left", "top", false, false, false, false, false)
		dxDrawText("\n"..logi, 21/zoom + 1, sh-600/zoom + 1, 650/zoom + 1, 749/zoom + 1, tocolor(0, 0, 0, 255), 1, fonts[2], "left", "top", false, true, false, false, false)
		dxDrawText("\n"..logi, 21/zoom, sh-600/zoom, 650/zoom, 749/zoom, tocolor(222, 222, 222, 255), 1, fonts[2], "left", "top", false, true, false, false, false)
	end

	if getElementData(localPlayer, "user:admin") and getElementData(localPlayer, "user:admin_reports") then
    	local text = ""
		local newReports = (#ucho.reports - 10)
		local n = "\n"
		local _n = ""

    	dxDrawText("Lista reportów:", 21/zoom + 1, 220/zoom + 1, sw - 21/zoom + 1, 749/zoom + 1, tocolor(0, 0, 0, 255), 1, fonts[1], "right", "top", false, false, false, false, false)
		dxDrawText("Lista reportów:", 21/zoom, 220/zoom, sw - 21/zoom, 749/zoom, tocolor(11,150,65, 255), 1, fonts[1], "right", "top", false, false, false, false, false)

		for i = 1,10 do
			local v = ucho.reports[i]
			if(v)then
				n = n.."\n"
				_n = _n.."\n"

				dxDrawText(_n..v[1], 21/zoom+1, 220/zoom+1, sw - 21/zoom+1, 749/zoom+1, tocolor(0, 0, 0, 255), 1, fonts[2], "right", "top", false, false, false, false, false)
				dxDrawText(_n..v[1], 21/zoom, 220/zoom, sw - 21/zoom, 749/zoom, tocolor(222, 222, 222, 255), 1, fonts[2], "right", "top", false, false, false, false, false)

				if(v[4] and v[5])then
					local sY = 20/zoom*(i-1)
					local w = dxGetTextWidth(v[5], 1, fonts[2])
					dxDrawRectangle(sw-w-21/zoom, 248/zoom+sY, w, 3/zoom, tocolor(255, 0, 0, 255), false)
				end
			end
		end

		dxDrawText("Ostatnio wzięty report:", 21/zoom + 1, 170/zoom + 1, sw - 21/zoom + 1, 749/zoom + 1, tocolor(0, 0, 0, 255), 1, fonts[1], "right", "top", false, false, false, false, false)
		dxDrawText("Ostatnio wzięty report:", 21/zoom, 170/zoom, sw - 21/zoom, 749/zoom, tocolor(11,150,65, 255), 1, fonts[1], "right", "top", false, false, false, false, false)
		if(ucho.last_report)then
			dxDrawText("\n"..ucho.last_report[1], 21/zoom + 1, 170/zoom + 1, sw - 21/zoom + 1, 749/zoom + 1, tocolor(0, 0, 0, 255), 1, fonts[2], "right", "top", false, false, false, false, false)
			dxDrawText("\n"..ucho.last_report[1], 21/zoom, 170/zoom, sw - 21/zoom, 749/zoom, tocolor(222, 222, 222, 255), 1, fonts[2], "right", "top", false, false, false, false, false)
		else
			dxDrawText("\nbrak", 21/zoom + 1, 170/zoom + 1, sw - 21/zoom + 1, 749/zoom + 1, tocolor(0, 0, 0, 255), 1, fonts[2], "right", "top", false, false, false, false, false)
			dxDrawText("\nbrak", 21/zoom, 170/zoom, sw - 21/zoom, 749/zoom, tocolor(222, 222, 222, 255), 1, fonts[2], "right", "top", false, false, false, false, false)
		end

		dxDrawText(n.."razem: "..#ucho.reports, 21/zoom + 1, 220/zoom + 1, sw - 21/zoom + 1, 749/zoom + 1, tocolor(0, 0, 0, 255), 1, fonts[1], "right", "top", false, false, false, false, false)
		dxDrawText(n.."razem: "..#ucho.reports, 21/zoom, 220/zoom, sw - 21/zoom, 749/zoom, tocolor(222, 222, 222, 255), 1, fonts[1], "right", "top", false, false, false, false, false)
		if(newReports > 0)then
			dxDrawText(n.."\ndodatkowo: "..newReports, 21/zoom + 1, 220/zoom + 1, sw - 21/zoom + 1, 749/zoom + 1, tocolor(0, 0, 0, 255), 1, fonts[1], "right", "top", false, false, false, false, false)
			dxDrawText(n.."\ndodatkowo: "..newReports, 21/zoom, 220/zoom, sw - 21/zoom, 749/zoom, tocolor(222, 222, 222, 255), 1, fonts[1], "right", "top", false, false, false, false, false)
		end
	end
end

local warnRender=function()
	if(warn.text ~= "")then
		local r,g,b = interpolateBetween(255, 0, 0, 200, 0, 0, (getTickCount()-warn.tick)/1500, "SineCurve")
		dxDrawRectangle(0, 0, sw, sh, tocolor(r, g, b, 150), true)
		dxDrawText("OTRZYMAŁEŚ OSTRZEŻENIE OD "..string.upper(warn.admin), 610/zoom, 132/zoom, 1311/zoom, 240/zoom, tocolor(200, 200, 200, 255), 1, fonts[3], "center", "center", false, false, true, false, false)
		dxDrawText("Nie stosowanie się do ostrzeżeń może skutkować kickiem lub banem!", 610/zoom, 793/zoom, 1311/zoom, 901/zoom, tocolor(200, 200, 200, 255), 1, fonts[5], "center", "center", false, false, true, false, false)
		dxDrawText("Powód:\n"..warn.text, 610/zoom, 486/zoom, 1311/zoom, 594/zoom, tocolor(200, 200, 200, 255), 1, fonts[4], "center", "center", false, false, true, false, false)
	end
end

-- triggers

addEvent("dutyStatusChanged", true)
addEventHandler("dutyStatusChanged", resourceRoot, function(status)
	if(status)then
		addEventHandler("onClientRender", root, adminRender)
		admin_info={tick=getTickCount(),sec=0,rank=getElementData(localPlayer, "user:admin")}
	else
		removeEventHandler("onClientRender", root, adminRender)

		if(admin_info.sec >= 60)then
			triggerServerEvent("get.payment", resourceRoot, math.floor((admin_info.sec)/60))
		end

		admin_info=false
	end
end)

addEvent("addAdminNotification", true)
addEventHandler("addAdminNotification", resourceRoot, function(text)
	exports.v_informations:noti(text, "admin")
	outputConsole(text)
end)

addEvent("updateLogs", true)
addEventHandler("updateLogs", root, function(logs)
	if getElementData(localPlayer, "user:admin_logs") and getElementData(localPlayer, "user:admin") then
    	ucho.logs = logs
  	end
end)

addEvent("addReport", true)
addEventHandler("addReport", resourceRoot, function(text, player, getPlayer)
	table.insert(ucho.reports, {text, player, getPlayer})
end)

addEvent("removeReport", true)
addEventHandler("removeReport", resourceRoot, function(player, admin, type)
	for i = 1,#ucho["reports"] do
		if(ucho["reports"][i][2] == player)then
			if(admin == localPlayer and type == "cl")then
				ucho.last_report = {ucho["reports"][i][1], ucho["reports"][i][2], ucho["reports"][i][3], i}
			end

			ucho["reports"][i][4] = getPlayerName(admin)
			ucho["reports"][i][5] = ucho["reports"][i][1]
			ucho["reports"][i][1] = getPlayerName(admin).." - "..ucho["reports"][i][1]

			setTimer(function()
				if(ucho["reports"][i][3] and isElement(ucho["reports"][i][3]))then
					setElementData(ucho["reports"][i][3], "user:sendReport", false)
				end

				table.remove(ucho["reports"], i)
			end, 5000, 1)

			if(ucho["reports"][i][3] == localPlayer)then
				if(type == "cl")then
					exports.v_noti:noti("Twój report jest w trakcie rozpatrywania przez "..getPlayerName(admin))
				elseif(type == "xcl")then
					exports.v_noti:noti("Twój report zawierał niedokładne informacje, dlatego został odrzucony przez administratora.")
				end
			end

			break
		end
	end
end)

addEvent("addWarn", true)
addEventHandler("addWarn", resourceRoot, function(text,admin)
	local time_warn = 5000

	warn.text = text
	warn.admin = admin

	setTimer(function()
		playSoundFrontEnd(5)
	end, 300, (time_warn/(300*2)))

	addEventHandler("onClientRender", root, warnRender)

	setTimer(function()
		warn.text = ""
		warn.admin = ""
		removeEventHandler("onClientRender", root, warnRender)
	end, time_warn, 1)
end)

-- get positions

addCommandHandler("gp", function()
	local element = getPedOccupiedVehicle(localPlayer) or localPlayer
	local x,y,z = getElementPosition(element)
	local txt = x..","..y..","..z
	outputChatBox(txt)
	setClipboard(txt)
end)

addCommandHandler("gp2", function()
	local element = getPedOccupiedVehicle(localPlayer) or localPlayer
	local x,y,z = getElementPosition(element)
	local _,_,rz = getElementRotation(element)
	local txt = x..","..y..","..z..","..rz
	outputChatBox(txt)
	setClipboard(txt)
end)

addCommandHandler("gc", function()
	local cx,cy,cz,cx2,cy2,cz2 = getCameraMatrix()
	local txt = cx..","..cy..","..cz..","..cx2..","..cy2..","..cz2
	outputChatBox(txt)
	setClipboard(txt)
end)

-- on start

if(getElementData(localPlayer, "user:admin"))then
	addEventHandler("onClientRender", root, adminRender)
	admin_info={tick=getTickCount(),sec=0,rank=getElementData(localPlayer, "user:admin")}
end

-- useful
function hex2rgb(hex) 
  hex = hex:gsub("#","") 
  return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)) 
end 

function dxDrawShadowText(text, x, y, w, h, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
	local text_gsub=string.gsub(text, "#%x%x%x%x%x%x", "")
	dxDrawText(text_gsub, x+1, y+1, w+1, h+1, tocolor(0, 0, 0), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
	dxDrawText(text, x, y, w, h, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
end

-- quit :)

addEventHandler("onClientPlayerQuit", root, function()
	if(source == localPlayer and admin_info.sec >= 60)then
		triggerServerEvent("get.payment", resourceRoot, math.floor((admin_info.sec)/60))
	end
end)
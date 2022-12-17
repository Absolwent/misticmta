local screenW, screenH = guiGetScreenSize()
local px, py = screenW/1920, screenH/1080

local k = 1
local n10 = 12
local m10 = 12

local tick = getTickCount()

local table_vehicles = {}
local table_selectvehicles = {}
local actualVehTable = {}

animations = {
	alpha255 = 0,
	alpha255_background = 0,
	alpha200 = 0,
	alpha100 = 0,
}

windows = {
	vehicles = false,
	selectcar = false,
}

storeVehs = {

--------------------------------------------------------------------------------------------------------
{
{963.17, -1252.79, 16.98},
setElementData(createMarker(1717.7038574219, -1791.9829101562, 13.539403915405-0.9, "cylinder", 1.5, 255, 255, 0, 55),"store:id",1),
{['Automobile']=true,['Bike']=true,['BMX']=true,['Quad']=true,['Monster Truck']=true,},
"Samochody, motocykle#ffffff",
createColCuboid(970.20, -1268.48, 14.11, 5.33, 10.98, 5.04),{972.72, -1262.08, 15.91, 350.5, 0.2, 181.1}
},
--------------------------------------------------------------------------------------------------------
{
{-2533.88, -28.93, 16.49},
setElementData(createMarker(-2533.88, -28.93, 16.49-0.9, "cylinder", 1.5, 255, 255, 0, 55),"store:id",2),
{['Automobile']=true,['Bike']=true,['BMX']=true,['Quad']=true,['Monster Truck']=true,},
"Samochody, motocykle#ffffff",
createColCuboid(-2538.19, -26.23, 15.43, 8.99, 6.23, 4.56),{-2533.43, -23.13, 16.15, 0.1, 360.0, 90.1},
},
--------------------------------------------------------------------------------------------------------
{
{-2265.08, 452.70, 35.17},
setElementData(createMarker(-2275.77, 443.46, 33.39, "cylinder", 1.5, 255, 255, 0, 55),"store:id",3),
{['Plane']=true,['Helicopter']=true,},
"Samoloty i Helikoptery#ffffff",
createColCuboid(-2268.14, 454.53, 34.99, 0.4, 360.0, 90.7),{-2269.20, 447.55, 35.01, 0.4, 360.0, 89.4}
},
--------------------------------------------------------------------------------------------------------
{
{2940.92, -2051.65, 3.55},
setElementData(createMarker(2940.92, -2051.65, 3.55-0.9, "cylinder", 1.5, 255, 255, 0, 55),"store:id",4),
{['Boat']=true},
"Łodzie#ffffff",
createColCuboid(2934.40, -2047.79, -1.55, 8.46, 5.44, 4.20),{2938.36, -2044.98, -0.47, 2.5, 0.0, 270.2}
},
--------------------------------------------------------------------------------------------------------
{
{161.46, -169.91, 1.58},
setElementData(createMarker(161.46, -169.91, 1.58-1, "cylinder", 1.5, 255, 255, 0, 55),"store:id",5),
{['Automobile']=true,['Bike']=true,['BMX']=true,['Quad']=true,['Monster Truck']=true,},
"Samochody, motocykle#ffffff",
createColCuboid(154.51, -168.19, 0.7, 8, 5, 5.04),{158.14, -165.71, 1.4, 360.0, 0.0, 90}
},
--------------------------------------------------------------------------------------------------------
{
{1908.30, 2121.34, 10.82},
setElementData(createMarker(1908.30, 2121.34, 10.82-1, "cylinder", 1.5, 255, 255, 0, 55),"store:id",6),
{['Automobile']=true,['Bike']=true,['BMX']=true,['Quad']=true,['Monster Truck']=true,},
"Samochody, motocykle#ffffff",
createColCuboid(1898.20, 2120.79, 9.82, 6.01, 5.89, 4.43),{1901.57, 2124.18, 10.55, 0.0, 360.0, 359.6}
},





}

id_stored_entered = nil

for i,c in pairs(storeVehs) do
	local t = createMarker(c[1][1],c[1][2],c[1][3], "cylinder", 4, 255, 255, 0, 0)
	setElementData(t,"marker:text",("Odbiór pojazdów\n%s"):format(c[4]))
end

lib = exports.nrpg_lib

local zoom = 1
if screenW < 1920 then
    zoom = math.min(2, 1920 / screenW)
end

local interface = {

    backgroundRectangle = lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(36, 36, 36, 255)),
	backgroundCarRectangle = lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(91, 91, 91, 255)),
	listRectangle = lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(71, 71, 71, 255)),
	scrollRectangle = lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(6, 181, 255, 255)),
    scrollRectangle2 = lib:dgsCreateRoundRect({{3,false},{3,false},{3,false},{3,false}},tocolor(6, 181, 255, 255)),

}

function window()
		--dxDrawRectangle(420*px, 180*py, 1100*px, 720*py, tocolor(25, 25, 25, 235), false)
	dxDrawImage(420*px, 180*py, 1100*px, 730*py, interface.backgroundRectangle, 0, 0, 0, tocolor(255, 255, 255, 255), false)

	if windows.vehicles == true then
		dxDrawText("PRZECHOWALNIA", -810*px, -620*py, 1920*px, 1080*py, tocolor(220,220,220,255), 1/zoom, exports.nrpg_interface:getGUIFont("money15"), "center", "center", false, false, false, false, false)
		dxDrawText("ODBIÓR POJAZDU", -810*px, -620*py, 1920*px, 1120*py, tocolor(220,220,220,255), 1/zoom, exports.nrpg_interface:getGUIFont("light12"), "center", "center", false, false, false, false, false)
		
		dxDrawText("MODEL", 730*px, -650*py, 1920*px, 1100*py, tocolor(220,220,220,255), 1/zoom, exports.nrpg_interface:getGUIFont("money13"), "left", "center", false, false, false, false, false)
		dxDrawText("ID", 730*px, -650*py, 1465*px, 1100*py, tocolor(220,220,220,255), 1/zoom, exports.nrpg_interface:getGUIFont("money13"), "right", "center", false, false, false, false, false)
		exports['nrpg_buttons']:dxCreateButton("Organizacyjne", 452*px, 330*py, 210*px, 40*py, 1, {55, 200, 55})
		exports['nrpg_buttons']:dxCreateButton("Prywatne", 452*px, 380*py, 210*px, 40*py, 2, {200, 55, 55})
		exports['nrpg_buttons']:dxCreateButton("Zamknij", 452*px, 840*py, 210*px, 40*py, 3, {6, 181, 255})

		x = 0
		for i,v in ipairs(actualVehTable) do
			if i >= k and i <= n10 then 
				x = x + 1
				local additionY = (108*py)*(x-1)
				local additionY2 = (54*py)*(x-1)
				local model = (getVehicleNameFromModel(v["model"]))
				
				
				if isMouseIn(705*px, 241*py + additionY2, 780*px, 50*py) then
					dxDrawImage(705*px, 241*py + additionY2, 780*px, 50*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
				else
					dxDrawImage(705*px, 241*py + additionY2, 780*px, 50*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 25), false)
				end

				dxDrawText(exports["flame_vehicles"]:changeName(model), 730*px, -548*py + additionY, 1920*px, 1080*py, tocolor(220,220,220,255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "left", "center", false, false, false, false, false)
				dxDrawText(v["id"], 730*px, -548*py + additionY, 1465*px, 1080*py, tocolor(220,220,220,255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			end
		end
		drawScrollbar(actualVehTable, 1495*px, 241*py, 645*py, 15*py, m10, k)
	end
	
	if windows.selectcar == true then
		dxDrawText("SZCZEGÓŁOWE INFORMACJE", 0*px, -625*py, 1920*px, 1050*py, tocolor(200,200,200,255), 1/zoom, exports.nrpg_interface:getGUIFont("money15"), "center", "center", false, false, false, false, false)
		dxDrawImage(1110*px, 280*py, 370*px, 190*py, interface.backgroundCarRectangle, 0, 0, 0, tocolor(255, 255, 255, 25), false)
		dxDrawImage(440*px, 250*py, 1055*px, 565*py, interface.backgroundCarRectangle, 0, 0, 0, tocolor(255, 255, 255, 15), false)
		
		dxDrawImage(450*px, 330*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("ID", 460*px,  220*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(450*px, 380*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("MODEL", 460*px,  320*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(450*px, 430*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("PRZEBIEG", 460*px,  420*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(450*px, 480*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("OSTATNI KIEROWCA", 460*px,  520*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)

		dxDrawImage(450*px, 530*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

		dxDrawImage(450*px, 580*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("SID WŁAŚCICIELA", 460*px,  720*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)

		dxDrawImage(450*px, 630*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("STAN", 460*px,  820*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(450*px, 680*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("SILNIK", 460*px,  920*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(450*px, 730*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("TURBOSPRĘŻARKA", 460*px,  1020*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(450*px, 780*py, 610*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("OPONY", 460*px,  1120*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(1110*px, 530*py, 370*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("MK1", 1121*px,  620*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(1110*px, 580*py, 370*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("MK2", 1121*px,  720*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(1110*px, 630*py, 370*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("MK3", 1121*px,  820*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(1110*px, 680*py, 370*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("MK4", 1121*px,  920*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		dxDrawImage(1110*px, 730*py, 370*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("LPG", 1121*px,  1020*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)

		dxDrawImage(1110*px, 780*py, 370*px, -45*py, interface.listRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)
		dxDrawText("RODZAJ", 1121*px,  1120*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
		
		for i,v in ipairs(table_selectvehicles) do
		
			local model = (getVehicleNameFromModel(v["model"]))
			local driver = string.gsub(v["driver"], "#%x%x%x%x%x%x", "") or "Brak"
			
			local us1montage = v["mk1"]
			if us1montage == 1 then us1montage = "Tak" elseif us1montage == 0 then us1montage = "Nie" end
			local us2montage = v["mk2"]
			if us2montage == 1 then us2montage = "Tak" elseif us2montage == 0 then us2montage = "Nie" end
			local us3montage = v["mk3"]
			if us3montage == 1 then us3montage = "Tak" elseif us3montage == 0 then us3montage = "Nie" end
			local us4montage = v["mk4"]
			if us4montage == 1 then us4montage = "Tak" elseif us4montage == 0 then us4montage = "Nie" end
			local turbomontage = v["turbo"]
			if turbomontage == 1 then turbomontage = "Tak" elseif turbomontage == 0 then turbomontage = "Nie" end
			local lpgmontage = v["lpg"]
			if lpgmontage == 1 then lpgmontage = v["fuellpg"].."/100 L" elseif lpgmontage == 0 then lpgmontage = "Brak" end
			local enginemontage = v["engineType"]
			local oponymontage = v["opony"]

			if enginemontage == "Elektryczny" then
				dxDrawText("BATERIA", 460*px,  620*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
			else
				dxDrawText("PALIWO", 460*px,  620*py, 779*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("money14"), "left", "center", false, false, false, false, false)
			end
			if oponymontage == 1 then oponymontage = "Szerokie" elseif oponymontage == 0 then oponymontage = "Standardowe" end
			
			dxDrawText(v["id"], 960*px,  220*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(exports["flame_vehicles"]:changeName(model), 960*px,  320*py, 1050*px, 396*py, tocolor(200, 200, 200,255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(""..v["mileage"].."km", 960*px,  420*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(driver, 960*px,  520*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			
			if enginemontage == "Elektryczny" then
				dxDrawText(""..v["fuel"].."/"..v["bak"].." %", 960*px,  620*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			else
				dxDrawText(""..v["fuel"].."/"..v["bak"].." L", 960*px,  620*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			end
			dxDrawText(v["ownedPlayer"], 960*px,  720*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)		
			dxDrawText(string.format("%.1f", ""..v.health/10).."%", 960*px,  820*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(""..v["silnik"].." dm3", 960*px,  920*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(turbomontage, 960*px,  1020*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(oponymontage, 960*px,  1120*py, 1050*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(us1montage, 1421*px,  620*py, 1470*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(us2montage, 1421*px,  720*py, 1470*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(us3montage, 1421*px,  820*py, 1470*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(us4montage, 1421*px,  920*py, 1470*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(lpgmontage, 1421*px,  1020*py, 1470*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			dxDrawText(enginemontage, 1421*px,  1120*py, 1470*px, 396*py, tocolor(200, 200, 200, 255), 1/zoom, exports.nrpg_interface:getGUIFont("light15"), "right", "center", false, false, false, false, false)
			
			exports['nrpg_buttons']:dxCreateButton("Wróć", 450*px, 830*py, 210*px, 50*py, 1, {6, 181, 255})
			exports['nrpg_buttons']:dxCreateButton("Wyjmij", 1280*px, 830*py, 210*px, 50*py, 2, {55, 155, 55})
		end
	end
end

addEventHandler("onClientClick", root, function(btn, state)
	if btn == "left" and state == "down" then
	
	if windows.vehicles == true then
		local x = 0
		for i, v in ipairs(actualVehTable) do
			if i >= k and i <= n10 then 
				x = x + 1
				local additionY2 = (54*py)*(x-1)
				if isMouseIn(705*px, 241*py + additionY2, 780*px, 50*py) and windows.vehicles == true and storeVehs[id_stored_entered][3][getVehicleType(v["model"])] then
					if v["id"] then
						triggerServerEvent("selectCarParkCar", localPlayer, v["id"])
						windows.selectcar = true
						windows.vehicles = false
						
						local color = split(v.color, ",")
						local x1, y1, z1 = getCameraMatrix()
						vehicle = createVehicle(v["model"], x1, y1, z1, 0)

						for i,tune in ipairs(split(v["tuning"], ",")) do 
							addVehicleUpgrade(vehicle, tune) 
						end

						local var = split(v["wariant"], ",")

						if var[1] and var[2] then
							setVehicleVariant(vehicle, var[1], var[2])
						else
							setVehicleVariant(vehicle, 0, 1)
						end

						setVehicleColor(vehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], color[10], color[11], color[12])
						--addVehicleUpgrade(vehicle, 1025)
						myObject = exports.flame_object_preview:createObjectPreview(vehicle, 0, 0, 0, 10, 0.5, 1, 1, true, true, true)
						guiWindow = guiCreateWindow(1170*px, 190*py, 330*px, 330*py, "", false, false)
						guiSetAlpha(guiWindow, 0)
						guiWindowSetMovable(guiWindow, false)
						guiWindowSetSizable(guiWindow, false) 
						local projPosX, projPosY = guiGetPosition(guiWindow,true)
						local projSizeX, projSizeY = guiGetSize(guiWindow, true)
						exports.flame_object_preview:setProjection(myObject, projPosX, projPosY, projSizeX, projSizeY, true, true)
						exports.flame_object_preview:setRotation(myObject, -3, 0, 140)				
					end
				end
			end
		end
	end


		if isMouseIn(452*px, 330*py, 210*px, 40*py) and windows.vehicles == true then
			if not getElementData(localPlayer,"player:organization") then exports.nrpg_interface:showPlayerNotification('Nie jesteś w organizacji.', 'error') return end
			triggerServerEvent("showVehiclesParkCarOrg", localPlayer)
		elseif isMouseIn(452*px, 380*py, 210*px, 40*py) and windows.vehicles == true then
			triggerServerEvent("showVehiclesParkCar", localPlayer)
		elseif isMouseIn(450*px, 830*py, 210*px, 50*py) and windows.selectcar == true then
			windows.selectcar = false
			windows.vehicles = true

			if isElement(vehicle) then
				destroyElement(vehicle)
				destroyElement(guiWindow)
				vehicle = false
				guiWindow = false
			end
		elseif isMouseIn(1280*px, 830*py, 210*px, 50*py) and windows.selectcar == true then
			for i,v in ipairs(table_selectvehicles) do
				triggerServerEvent("spawnVehicleParkCar", localPlayer, v["id"], localPlayer, storeVehs[id_stored_entered][6])
				
				showCursor(false)
				windows.vehicles = false
				windows.selectcar = false
				removeEventHandler("onClientRender", root, window)
				
				if isElement(vehicle) then
					destroyElement(vehicle)
					destroyElement(guiWindow)
					vehicle = false
					guiWindow = false
				end
			end
		elseif isMouseIn(452*px, 840*py, 210*px, 40*py) and windows.vehicles == true then
			showCursor(false)
			windows.vehicles = false
			windows.selectcar = false
			removeEventHandler("onClientRender", root, window)
		end
	end
end)

addEventHandler("onClientMarkerHit", root, function(plr,md)
	local id = getElementData(source, "store:id")
	if not id then return end
	if plr==localPlayer then
		if isPedInVehicle(plr) then return end
		if windows.vehicles == false then
			showCursor(true)
			windows.vehicles=true
			windows.selectcar=false
			addEventHandler("onClientRender", root, window)
			triggerServerEvent("showVehiclesParkCar", plr)
			id_stored_entered = id
			if isElement(vehicle) then
				destroyElement(vehicle)
				destroyElement(guiWindow)
				vehicle = false
				guiWindow = false
			end
		end
	end
end)

function drawScrollbar(table, x, y, height, barheight, m_, k_)
    dxDrawImage(x, y, 6, height, interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 55), false)

	if #table > m_ then
    	local scrollbarHeight = height/#table

   		if k_ == 1 then 
        	scrollbarPos = y
    	elseif k_ > 1 then 
        	scrollbarPos = ((k_)*scrollbarHeight)+y
    	end

    	if #table <= m_ then 
        	scrollbarHeight = height
    	end
		
		dxDrawImage(x, scrollbarPos, 6, scrollbarHeight*(m_-1), interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 125), false)
    else
        dxDrawImage(x, y, 6, height, interface.scrollRectangle2, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end

addEventHandler("onClientMarkerLeave", root, function(plr,md)
	if plr~= localPlayer then return end
	if isPedInVehicle(plr) then return end
		showCursor(false)
		windows.vehicles=false
		windows.selectcar=false
		removeEventHandler("onClientRender", root, window)
		if isElement(vehicle) then
			destroyElement(vehicle)
			destroyElement(guiWindow)
		end
end)

addEvent("showVehiclesParkCarClient", true)
addEventHandler("showVehiclesParkCarClient", root, function(tablee)
  table_vehicles = tablee
  actualVehTable = {}
  	
 	for i, v in ipairs(table_vehicles) do
		if storeVehs[id_stored_entered][3][getVehicleType(v["model"])] then
			table.insert(actualVehTable, v)
		end
	end
end)

addEvent("selectCarParkCarClient", true)
addEventHandler("selectCarParkCarClient", root, function(table)
  table_selectvehicles = table
  print(table_selectvehicles)
end)

bindKey("mouse_wheel_down", "both", function()
        scrollUp()
end)

bindKey("mouse_wheel_up", "both", function()
        scrollDown()
end)

function scrollDown()
    if n10 == m10 then return end
    k = k-1
    n10 = n10-1
end

function scrollUp()
    if n10 >= #actualVehTable then return end
    k = k+1
    n10 = n10+1
end

function isMouseIn ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end
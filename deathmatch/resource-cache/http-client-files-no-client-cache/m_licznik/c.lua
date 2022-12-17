local sX, sY = guiGetScreenSize()
local px, py = (sX/1920), (sY/1080)

-- Nowe scalowanie zobaczymy jak działa XD
local screenX, screenY = guiGetScreenSize() 
function toposition(x,y) 
  local finalX,finalY = x,y 
  if x > 1 then finalX = x 
  elseif x < -1 then finalX = screenX - x 
  elseif x > 0 then finalX = screenX * x 
  else finalX = screenX - (screenX * x) 
  end 
  -- 
  if y > 1 then finalY = y 
  elseif y < -1 then finalY = screenY - y 
  elseif y > 0 then finalY = screenY * y 
  else finalY = screenY - (screenY * y) 
  end 
  return finalX,finalY 
end



fonts = {
	speed = exports["m_gui"]:getFont("Montserrant_b", 73*px),
	vehicle = exports["m_gui"]:getFont("Montserrant_b", 20*px),
	mileage = exports["m_gui"]:getFont("Montserrant_b", 20*px),
	fuels = exports["m_gui"]:getFont("Montserrant_b", 15*px),
}

image = {
	main = dxCreateTexture("files/image/main.png"),
	prev = dxCreateTexture("files/image/prev.png"),
	speed = dxCreateTexture("files/image/speed.png"),
	vehicle = dxCreateTexture("files/image/vehicle.png"),
	fuel = dxCreateTexture("files/image/fuel.png"),
	right = dxCreateTexture("files/image/right.png"),
	left = dxCreateTexture("files/image/left.png"),
	light = dxCreateTexture("files/image/light.png"),
	engine = dxCreateTexture("files/image/engine.png"),
	door = dxCreateTexture("files/image/door.png"),
}

targetSpeed = dxCreateRenderTarget(286*px, 287*py)
targetFuel = dxCreateRenderTarget(286*px, 287*py)


function getSpeed(element)
	local vx, vy, vz = getElementVelocity(element)
	local speed = ((vx ^ 2 + vy ^ 2 + vz ^ 2) ^ (0.6)) * 180
	return speed
end

function round (n, nn)
	local mult = 10^(nn or 0)
	return math.floor( n * mult ) / mult
end


addEventHandler("onClientRender", root,function()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle then
        local model = getElementModel(vehicle)
        local vName = getVehicleName(vehicle)
        if model == 419 or not model == 410 or not model == 600 or not model == 436 or not model == 439 or not model == 549 or not model == 491 or not model == 604 or not model == 546 or not model == 529 or not model == 542 or not model == 404 or not model == 479 or not model == 442 then return end
    	        if not driveDistance then lastTick = getTickCount() driveDistance = getElementData ( vehicle, "mileage" ) or 0 end
		local neux, neuy, neuz = getElementPosition(vehicle)
			
		local speed = math.floor(getSpeed(vehicle))
		if speed < 10 then
			tspeed = speed
		elseif speed < 100 then
			tspeed = speed
		else
			tspeed = speed
		end
		if speed > 360 then 
			speed = 360 
		end

		local fuel = getElementData(vehicle, "fuel" ) or speed/3
		local fuels = math.floor(fuel)


		dxDrawImage(1590*px, 760*py, 286*px, 287*py, image.main, 0,0,0, tocolor(255,255,255,225))
		dxDrawImage(1380*px, 870*py, 175*px, 175*py, image.prev, 0,0,0, tocolor(255,255,255,225))
		dxDrawText(vName, 1732*px, 825*py, 1732*px, 895*py, tocolor(255,255,255,255), 0.5, 0.5, fonts.vehicle, "center", "center")
		dxDrawText(tspeed, 1732*px, 895*py, 1732*px, 895*py, tocolor(255,255,255,255), 0.5, 0.5, fonts.speed, "center", "center")


		dxSetRenderTarget(targetSpeed, true)
		dxDrawLevelCircle(0*px, 0*py, 286*px, 287*py, tocolor(95,160,160,255), 220, speed*0.75, 360)
		dxSetRenderTarget()
		dxDrawImage(1590*px, 760*py, 286*px, 287*py, maskShader)


		dxDrawText(fuels.."% ⛽", 1205*px, 1015*py, 1732*px, 1020*py, tocolor(255,255,255,255), 0.5, 0.5, fonts.fuels, "center", "center")
		dxDrawText("E", 1310*px, 990*py, 1732*px, 1020*py, tocolor(180,0,0,255), 0.5, 0.5, fonts.fuels, "center", "center")
		dxDrawText("F", 1095*px, 990*py, 1732*px, 1020*py, tocolor(255, 255, 255,255), 0.5, 0.5, fonts.fuels, "center", "center")

		dxSetRenderTarget(targetFuel, true)
                if fuels > 25 then
		    dxDrawLevelCircle(0*px, 0*py, 286*px, 287*py, tocolor(95,160,160,255), 140, fuels*0.8, 360)
                else
		    dxDrawLevelCircle(0*px, 0*py, 286*px, 287*py, tocolor(180,0,0,255), 140, fuels*0.8, 360)
                end
		dxSetRenderTarget()
		dxDrawImage(1377*px, 860*py, 286*px/1.6, 287*py/1.6, maskShader1)

		if driveDistance == 0 then
			driveDistances = "0000000"
		elseif driveDistance <= 10 then
			driveDistances = "000000"..tostring ( math.round(driveDistance),1)..""
		elseif driveDistance <= 100 then
			driveDistances = "00000"..tostring ( math.round(driveDistance),1)..""
		elseif driveDistance <= 1000 then
			driveDistances = "0000"..tostring ( math.round(driveDistance),1)..""
		elseif driveDistance <= 10000 then
			driveDistances = "000"..tostring ( math.round(driveDistance),1)..""
		elseif driveDistance <= 100000 then
			driveDistances = "00"..tostring ( math.round(driveDistance),1)..""
		elseif driveDistance <= 1000000 then
			driveDistances = ""..tostring ( math.round(driveDistance),1)..""
		end
		dxDrawText(driveDistances, 1742*px, 970*py, 1732*px, 965*py, tocolor(171, 171, 171,255), 0.5, 0.5, fonts.mileage, "center", "center")

		dxDrawText("Stan pojazdu", 1200*px, 910*py, 1732*px, 895*py, tocolor(255,255,255,255), 0.5, 0.5, fonts.vehicle, "center", "center")
		local hp = getElementHealth(vehicle)
                if hp < 350 then
			dxDrawImage(1435*px, 925*py, 65*px, 65*py, image.vehicle, 0, 0, 0, tocolor(128, 0, 0,255))
		elseif hp < 400 then
			dxDrawImage(1435*px, 925*py, 65*px, 65*py, image.vehicle, 0, 0, 0, tocolor(128, 32, 0,255))
		elseif hp < 500 then
			dxDrawImage(1435*px, 925*py, 65*px, 65*py, image.vehicle, 0, 0, 0, tocolor(128, 70, 0,255))
		elseif hp < 600 then
			dxDrawImage(1435*px, 925*py, 65*px, 65*py, image.vehicle, 0, 0, 0, tocolor(163, 136, 0,255))
                elseif hp < 700 then
			dxDrawImage(1435*px, 925*py, 65*px, 65*py, image.vehicle, 0, 0, 0, tocolor(201, 195, 0,255))
                elseif hp < 800 then
			dxDrawImage(1435*px, 925*py, 65*px, 65*py, image.vehicle, 0, 0, 0, tocolor(164, 201, 0,255))
                elseif hp < 900 then
			dxDrawImage(1435*px, 925*py, 65*px, 65*py, image.vehicle, 0, 0, 0, tocolor(127, 201, 0,255))
                else
			dxDrawImage(1435*px, 925*py, 65*px, 65*py, image.vehicle, 0, 0, 0, tocolor(0, 153, 5,255))
		end

		state = getVehicleLightState (vehicle, 0)
		if state == 1 then
			dxDrawImage(1700*px, 995+20*py, 17*px, 13*py, image.light, 0, 0, 0, tocolor(95,160,160,255))	
		else
			dxDrawImage(1700*px, 995+20*py, 17*px, 13*py, image.light, 0, 0, 0, tocolor(255,255,255,255))		
		end

		if getVehicleEngineState(vehicle) then
			dxDrawImage(1725*px, 995+20*py, 17*px, 13*py, image.engine, 0, 0, 0, tocolor(95,160,160,255))	
		else
			dxDrawImage(1725*px, 995+20*py, 17*px, 13*py, image.engine, 0, 0, 0, tocolor(255,255,255,255))	
		end


		if isVehicleLocked(vehicle) then
			dxDrawImage(1750*px, 995+20*py, 17*px, 17*py, image.door, 0, 0, 0, tocolor(95,160,160,255))
		else
			dxDrawImage(1750*px, 995+20*py, 17*px, 17*py, image.door, 0, 0, 0, tocolor(255,255,255,255))
		end


		if getElementData(vehicle, "left") then
			if (getTickCount() % 1400 >= 600) then
				dxDrawImage(1675*px, 985+20*py, 16*px, 18*py, image.right, 0, 0, 0, tocolor(95,160,160,255))
			else
				dxDrawImage(1675*px, 985+20*py, 16*px, 18*py, image.right, 0, 0, 0, tocolor(255,255,255,255))
			end
		else
			dxDrawImage(1675*px, 985+20*py, 16*px, 18*py, image.right, 0, 0, 0, tocolor(255,255,255,255))
		end

		
		if getElementData(vehicle, "right")then
			if (getTickCount() % 1400 >= 600) then
				dxDrawImage(1775*px, 985*py+20, 16*px, 18*py, image.left, 0, 0, 0, tocolor(95,160,160,255))
			else
				dxDrawImage(1775*px, 985*py+20, 16*px, 18*py, image.left, 0, 0, 0, tocolor(255,255,255,255))
			end
		else
			dxDrawImage(1775*px, 985*py+20, 16*px, 18*py, image.left, 0, 0, 0, tocolor(255,255,255,255))
		end		

		if not altx or not alty or not altz then
			altx, alty, altz=getElementPosition(vehicle)
		end
		local driveTotal = getDistanceBetweenPoints3D(neux,neuy,neuz,altx,alty,altz)
		driveTotal = driveTotal/1000
		altx,alty,altz=neux,neuy,neuz
		driveDistance = math.round(driveDistance+driveTotal,3)
		if lastTick+5000 < getTickCount() then
			lastTick = getTickCount()
			setElementData ( vehicle, "mileage", driveDistance )    
		end
    end
end)

addEventHandler("onClientPlayerVehicleEnter",getRootElement(),function(vehicle,seat)
	if source == localPlayer then
		altx, alty, altz=getElementPosition(vehicle)
		lastTick = getTickCount()
		driveDistance = getElementData ( vehicle, "driveDistance" )
	end
end)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function StartResource( )
    maskShader = dxCreateShader("fx/mask3d.fx")
	maskTexture = image.speed

	dxSetShaderValue( maskShader, "sPicTexture", targetSpeed )
	dxSetShaderValue( maskShader, "sMaskTexture", maskTexture )

    maskShader1 = dxCreateShader("fx/mask3d.fx")
	maskTexture1 = image.fuel

	dxSetShaderValue( maskShader1, "sPicTexture", targetFuel )
	dxSetShaderValue( maskShader1, "sMaskTexture", maskTexture1 )
end
addEventHandler( "onClientResourceStart", root, StartResource)
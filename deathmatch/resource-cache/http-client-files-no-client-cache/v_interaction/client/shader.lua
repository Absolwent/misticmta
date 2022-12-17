-- 
-- main.lua
--

wallShader = {}
colorizePed = {0/255, 255/255, 17/255, 1}
specularPower = 1.3
effectMaxDistance = 150
isPostAura = true
scx, scy = guiGetScreenSize ()
effectOn = nil
myRT = nil
myShader = nil
isMRTEnabled = false
timer = 110
key = 'e'
objects = {}

function enablePedWall(isMRT)
	if isMRT and isPostAura then 
		myRT = dxCreateRenderTarget(scx, scy, true)
		myShader = dxCreateShader("assets/fx/post_edge.fx")
		if not myRT or not myShader then 
			isMRTEnabled = false
			return
		else
			dxSetShaderValue(myShader, "sTex0", myRT)
			dxSetShaderValue(myShader, "sRes", scx, scy)
			isMRTEnabled = true
		end
	else
		isMRTEnabled = false
	end

	pwEffectEnabled = true
end

function disablePedWall()
	pwEffectEnabled = false
	disablePedWallTimer()
	if isElement(myRT) then
		destroyElement(myRT)
	end
end

function createWallEffectForPlayer(thisPlayer, isMRT)
    if not wallShader[thisPlayer] then
		if isMRT then 
			wallShader[thisPlayer] = dxCreateShader("assets/fx/ped_wall_mrt.fx", 1, 0, true, "all")
		else
			wallShader[thisPlayer] = dxCreateShader("assets/fx/ped_wall.fx", 1, 0, true, "all")
		end

		if not wallShader[thisPlayer] then 
			return false
		else
			if myRT then
				dxSetShaderValue (wallShader[thisPlayer], "secondRT", myRT)
			end

			dxSetShaderValue(wallShader[thisPlayer], "sColorizePed",colorizePed)
			dxSetShaderValue(wallShader[thisPlayer], "sSpecularPower",specularPower)
			engineApplyShaderToWorldTexture ( wallShader[thisPlayer], "*" , thisPlayer )

			if not isMRT then
				if getElementAlpha(thisPlayer) == 255 then setElementAlpha(thisPlayer, 254) end
			end

			return true
			end
    end
end

function destroyShaderForPlayer(thisPlayer)
    if wallShader[thisPlayer] then
		engineRemoveShaderFromWorldTexture(wallShader[thisPlayer], "*" , thisPlayer)
		destroyElement(wallShader[thisPlayer])
		wallShader[thisPlayer] = nil
	end
end

function getObjects()
		-- get all elements
		local objs = {}
		local x, y, z = getElementPosition(localPlayer)
		local faction=getElementData(localPlayer, "user:faction")
		local settings=getElementData(localPlayer, "user:faction_settings")
		local rx,ry,rz = getCameraMatrix()

		for i,v in pairs(getElementsWithinRange(x, y, z, 10, "ped")) do
			local xx,yy,zz = getElementPosition(v)
			if(getElementData(v, "interaction") and isLineOfSightClear(rx, ry, rz, xx, yy, zz, true, true, false, false))then
				objs[#objs+1] = v
			end
		end

		for i,v in pairs(getElementsWithinRange(x, y, z, 10, "vehicle")) do
			local owner = getElementData(v, "vehicle:ownerName")
			local group=getElementData(v, "vehicle:group_name")
			local xx,yy,zz = getElementPosition(v)
			if(getElementData(localPlayer, "have:canister") or getElementData(v, "interaction") or (owner and owner == getPlayerName(localPlayer)) or (faction and group and faction == group) or (settings and settings.business_type and settings.business_type == "warsztat"))then
				if(getVehicleName(v) ~= "Bike" and getVehicleName(v) ~= "BMX" and getVehicleName(v) ~= "Mountain Bike")then
					objs[#objs+1] = v
				end
			end
		end

		for i,v in pairs(getElementsWithinRange(x, y, z, 10, "object")) do
			local xx,yy,zz = getElementPosition(v)
			if(getElementData(v, "interaction") and isLineOfSightClear(rx, ry, rz, xx, yy, zz, true, true, false, false))then
				objs[#objs+1] = v
			end
		end

		for i,v in pairs(getElementsWithinRange(x, y, z, 10, "player")) do
			local xx,yy,zz = getElementPosition(v)
			if(not isPedInVehicle(v) and isLineOfSightClear(rx, ry, rz, xx, yy, zz, true, true, false, false))then
				objs[#objs+1] = v
			end
		end

		objects = objs
		--
		return objs
end

function enablePedWallTimer(isMRT)
	if PWenTimer then 
		return 
	end
	PWenTimer = setTimer(function()
		local x, y, z = getElementPosition(localPlayer)

		local objs = getObjects()
		for index,obj in pairs(objs)  do
			if isElement(obj) then
				createWallEffectForPlayer(obj, isMRT)
			end 
				local hx,hy,hz = getElementPosition(localPlayer)            
				local cx,cy,cz = getCameraMatrix()
				local dist = getDistanceBetweenPoints3D(cx,cy,cz,hx,hy,hz)
				local isItClear = isLineOfSightClear (cx,cy,cz, hx,hy, hz, true, false, false, true, false, true, false, localPlayer)
				if (dist<effectMaxDistance ) and not isItClear and effectOn then 
					createWallEffectForPlayer(localPlayer, isMRT)
				end 
				if (dist>effectMaxDistance ) or  isItClear or not effectOn then 
					destroyShaderForPlayer(localPlayer) 
				end
			end
		end
	,timer,0 )
end

function disablePedWallTimer()
	if PWenTimer then
		killTimer( PWenTimer )
		PWenTimer = nil		
	end
end


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function()
		local isMRT = false
		if dxGetStatus().VideoCardNumRenderTargets > 1 then 
			isMRT = true 
		end

		switchPedWall(true, isMRT)
	end
)

function switchPedWall(pwOn, isMRT)
	if(pwOn)then
		enablePedWall(isMRT)
	else
		disablePedWall()
	end
end

function preRender()
	if(not pwEffectEnabled or not isMRTEnabled or not effectOn)then return end

	dxSetRenderTarget(myRT, true)
	dxSetRenderTarget()
end

function hudRender()
	if(not pwEffectEnabled or not isMRTEnabled or not effectOn)then return end

	dxDrawRectangle(0, 0, sw, sh, tocolor(15, 18, 23, 150), true)
	dxDrawImage(0, 0, scx, scy, myShader, 0, 0, 0, tocolor(255, 255, 255, 255), true)
end

function startWall(pwOn)
	if(pwOn)then
		enablePedWallTimer(true)

		dxSetRenderTarget(myRT, true)
		dxSetRenderTarget()

		addEventHandler("onClientPreRender", root, preRender)
		addEventHandler("onClientHUDRender", root, hudRender)
	else
		disablePedWallTimer()

		removeEventHandler("onClientPreRender", root, preRender)
		removeEventHandler("onClientHUDRender", root, hudRender)

		local objs = getObjects()
		for index,obj in pairs(objects)  do
			destroyShaderForPlayer(obj)
		end
	end
end
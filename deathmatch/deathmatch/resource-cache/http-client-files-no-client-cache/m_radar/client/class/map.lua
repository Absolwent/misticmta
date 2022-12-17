Map = {}
Map.__index = Map
Map.instances = {}
Map.damageEfect = {}
local sx,sy = guiGetScreenSize()
px,py = 1366,768
x,y =  (sx/px), (sy/py)
font = dxCreateFont("gfx/myriadproregular.ttf",20,true)

function math.map(value, low1, high1, low2, high2)
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
end

function kozeliGPSPontokTorlese()
	for i,pont in ipairs(gpsPontok) do
		local x,y = getElementPosition(getLocalPlayer())
		if(getDistanceBetweenPoints2D ( x, y, pont.x, pont.y ) < 10) then
			table.remove(gpsPontok, i)
			for k,kpont in ipairs(gpsPontok) do 
				if kpont.id < pont.id then
					table.remove(gpsPontok, k)
				end
			end
			if(#gpsPontok == 0) then
				if(utiBlip) then
					destroyElement(utiBlip)
					utiBlip = nil
				end
			end
		end
	end
end

function renderRadarAfterSpawn()
    addEventHandler("onClientRender", getRootElement(), Map.render)
    toggleControl("radar", true)
end
addEventHandler("onClientPlayerSpawn", localPlayer, renderRadarAfterSpawn)


function Map.new(X,Y,W,H)
	local self = setmetatable({}, Map)
	self.x = X
	self.y = Y
	self.w = W
	self.h = H
	local pos = {getElementPosition(localPlayer)}
	self.posX = pos[1]
	self.posY = pos[2]
	self.posZ = pos[3]
	self.size = 90
	self.color = {255,255,255,255}	
	self.blipSize = x*17
	self.drawRange = 400
	self.map = dxCreateTexture("gfx/gtasa.png","dxt5")
	self.renderTarget = dxCreateRenderTarget(W, H, true)
	self.blips = {}
	for k=0, 63 do
		self.blips[k] = dxCreateTexture("gfx/icons/"..k..".png","dxt3")
	end
	if(#Map.instances == 0) then
            if getElementData(localPlayer, "playing") then
		addEventHandler("onClientRender", getRootElement(), Map.render)
            end
	end
	
	table.insert(Map.instances, self)
	return self	
end

function Map.render()
	for k,v in pairs(Map.instances) do
		if v.visible then
			if not v.style then
				v:draw()
			elseif v.style == 1 then
				v:draw2()
			end
		end
	end
end

function Map:setVisible(bool)
	self.visible = bool
	if bool == true then
		self:setPosition(getElementPosition(localPlayer))
	end
	return true
end

function Map:isVisible()
	return self.visible
end

function Map:setPosition(x,y,z)
	self.posX = x
	self.posY = y
	self.posZ = z
	return true
end

function Map:getPosition()
	return self.posX, self.posY, self.posZ
end

function Map:setColor(r,g,b,a)
	self.color = {r,g,b,a}
	return true
end

function Map:getColor()
	return self.color
end

function Map:setSize(value)
	self.size = value
	return true
end

function contornoRetangulo(absX, absY, sizeX, sizeY, color, ancho)
	dxDrawRectangle(absX, absY, sizeX, ancho, color)
	dxDrawRectangle(absX, absY + ancho, ancho, sizeY - ancho, color)
	dxDrawRectangle(absX + ancho, absY + sizeY - ancho, sizeX - ancho, ancho, color)
	dxDrawRectangle(absX + sizeX - ancho, absY + ancho, ancho, sizeY - ancho*2, color)
end

function dxDrawEmptyRec(absX,absY,sizeX,sizeY,color,ancho)
    dxDrawRectangle ( absX,absY,sizeX,ancho,color )
	dxDrawRectangle ( absX,absY+ancho,ancho,sizeY-ancho,color )
	dxDrawRectangle ( absX+ancho,absY+sizeY-ancho,sizeX-ancho,ancho,color )
	dxDrawRectangle ( absX+sizeX-ancho,absY+ancho,ancho,sizeY-ancho*2,color )	
end


function Map:draw2()

	dxSetRenderTarget(self.renderTarget, true)
	kozeliGPSPontokTorlese()
	local player = getLocalPlayer()
	local centerX = (self.x) + (self.w/2)
	local centerY = (self.y) + (self.h/2)
	local pr = getPedRotation(player)
	local mapSize = 3000 / (self.drawRange/500)
	local _, _, camRotZ = getElementRotation(getCamera())
	

		self.posX, self.posY, self.posZ = getElementPosition(player)
		local playerX, playerY, playerZ = getElementPosition(player)
		
		local mapPosX, mapPosY = -(math.map(self.posX+3000,0,6000,0,mapSize)-self.w/2), -(math.map(-self.posY + 3000, 0, 6000, 0, mapSize)-self.h/2)
		
		
		local cx,cy,_,tx,ty = getCameraMatrix()
		local north = findRotation(cx,cy,tx,ty)
		dxDrawRectangle(0,0,self.w,self.h,tocolor(269,120,210,0))
		dxDrawImage(mapPosX, mapPosY, mapSize, mapSize, self.map, north, -mapSize/2 - mapPosX +  self.w/2, -mapSize/2 - mapPosY + self.h/2, tocolor(255,255,255,255))
				for k, v in ipairs(gpsPontok) do
					local bx, by = v.x, v.y
					local w, h = 15, 15
					local liX = (3000+bx) / 6000 * mapSize
					local liY = (3000-by) / 6000 * mapSize
					local scaledW = w / 6000*mapSize
					local scaledH = -(h / 6000*mapSize)
					liX = liX + mapPosX
					liY = liY + mapPosY

					dxSetBlendMode("modulate_add")
					dxDrawImage (liX, liY, scaledW, scaledH,self.blips[0], north, -scaledW/2 - liX +  self.w/2, -scaledH/2 - liY + self.h/2,tocolor(124, 197, 118
					))
					dxSetBlendMode("blend")

				end
				for i, area in ipairs (getElementsByType("radararea")) do
					local ex, ey = getElementPosition(area)
					local w, h = getRadarAreaSize(area)
					local areaX = (3000+ex) / 6000 * mapSize
					local areaY = (3000-ey) / 6000 * mapSize
					local scaledW = w / 6000*mapSize
					local scaledH = -(h / 6000*mapSize)
					areaX = areaX + mapPosX
					areaY = areaY + mapPosY
					local rr, gg, bb, alpha = 255,255,255,255
					rr, gg, bb, alpha = getRadarAreaColor(area)

					if (isRadarAreaFlashing(area)) then
						alpha = alpha*math.abs(getTickCount()%1000-500)/500
					end
					dxSetBlendMode("modulate_add")
					dxDrawImage(areaX, areaY, scaledW, scaledH,self.blips[1], north, -scaledW/2 - areaX +  self.w/2, -scaledH/2 - areaY + self.h/2,tocolor(rr,gg,bb,alpha))
					dxSetBlendMode("blend")
				end
				local ux, uy = nil, nil

			for i, b in ipairs (getElementsByType('blip')) do
			if getElementDimension(b) == getElementDimension(player) and getElementInterior(b) == getElementInterior(player) then
				local elementAttached =  getElementAttachedTo ( b )
				if elementAttached ~= player then
					local ex, ey, ez = getElementPosition(b)				
					local blipIcon = getBlipIcon(b)
					local rr,gg,bb,aa = 255,255,255,255
					local blipSize = self.blipSize
					
					local blipX, blipY = getRadarFromWorldPosition(ex,ey,-x*40, -y*40, self.w+x*80, self.h+y*80,mapSize)

		
					if (elementAttached) and (getElementType(elementAttached) == "vehicle") then
						blipSize = blipSize / 2
						aa = 200
					end
					local blipIcon = getBlipIcon(b)
					if blipIcon == 0 then
						rr, gg, bb, aa = getBlipColor(b)
					end
					local img = self.blips[blipIcon]
					if (elementAttached) and (getElementType(elementAttached) == "player") then
						img = self.blips[0]
						blipSize = blipSize / 1.3
					end
					dxDrawImage(blipX-blipSize/2, blipY-blipSize/2, blipSize, blipSize,img, 0,0,0,tocolor(rr,gg,bb,aa))
					
					if (elementAttached) and (getElementType(elementAttached) == "player") and getPedOccupiedVehicle(elementAttached) and getVehicleType(getPedOccupiedVehicle(elementAttached)) == "Helicopter" then	
						dxDrawImage(blipX-x*50/2, blipY-y*50/2, x*50, y*50, "gfx/H.png",north-getPedRotation(elementAttached))
						dxDrawImage(blipX-x*50/2, blipY-y*50/2, x*50, y*50, "gfx/HR.png",getTickCount()%360)
					end

				end
			end
		end
		local b = self.blipSize
		local ex,ey = getElementPosition(player)
		local blipX = (3000+ex) / 6000 * mapSize
		local blipY = (3000-ey) / 6000 * mapSize
		blipX = blipX + mapPosX
		blipY = blipY + mapPosY
		
		if getPedOccupiedVehicle(player) and getVehicleType(getPedOccupiedVehicle(player)) == "Helicopter" then
			dxDrawImage(blipX-x*50/2, blipY-y*50/2, x*50, y*50, "gfx/H.png",north-pr)
			dxDrawImage(blipX-x*50/2, blipY-y*50/2, x*50, y*50, "gfx/HR.png",getTickCount()%360)
		else
			dxDrawImage(blipX-x*23/3, blipY-y*23/3,x*15,y*15, self.blips[2], north-pr,0,0,tocolor(255,255,255,255))	
		end
			
	dxSetRenderTarget()	

	local interior = getElementInterior(getLocalPlayer())
	local dimensao = getElementDimension(getLocalPlayer())
	
	if getElementInterior(player) == 0 then

		for k, v in ipairs({"radar", "area_name", "vehicle_name"}) do
			setPlayerHudComponentVisible(v, false)
		end
		
		dxDrawImage(self.x-x*17, self.y-y*9, self.w+x*33, self.h+y*18, "gfx/mapbg.png",0,0,0,tocolor(0, 0, 0, 130))	
		dxDrawImage(self.x, self.y, self.w, self.h, self.renderTarget,0,0,0,tocolor(unpack(self.color)))
	else
		dxDrawRectangle(self.x-x*0, self.y-y*-0, self.w+x*0, self.h+y*0,tocolor(0,0,0,130))
	end
	for k, v in ipairs(Map.damageEfect) do
		v[3] = v[3] - (getTickCount() - v[1]) / 800 
		if v[3] <= 0 then
			table.remove(Map.damageEfect, k)
		else
			dxDrawImage(self.x, self.y, self.w, self.h, "gfx/mapred.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		end		
	end

end

function findRotation(x1, y1, x2, y2)
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end
  return t
end

function getPointAway(x, y, angle, dist)
        local a = -math.rad(angle)
        dist = dist / 57.295779513082
        return x + (dist * math.deg(math.sin(a))), y + (dist * math.deg(math.cos(a)))
end
 
function getRadarFromWorldPosition(bx, by, x, y, w, h, scaledMapSize)
	local RadarX, RadarY = x + w/2, y + h/2
	local RadarD = getDistanceBetweenPoints2D(RadarX, RadarY, x, y)
	local px, py = getElementPosition(localPlayer)
	local _, _, crz = getElementRotation(getCamera())
	local dist = getDistanceBetweenPoints2D(px, py, bx, by)
	if dist > RadarD * 6000/scaledMapSize then
		dist = RadarD * 6000/scaledMapSize
	end
	local rot = 180 - findRotation(px, py, bx, by) + crz
	local ax, ay = getPointAway(RadarX, RadarY, rot, dist * scaledMapSize/6000)
	return ax, ay
end


function onClientPlayerDamage(attacker, weapon, _, bodypart)
	local part = attacker and getElementType(attacker) == "player" and getPedWeaponSlot(attacker) and getPedWeaponSlot(attacker) or false	
	if attacker and attacker ~= source and not (part == 8 or (part == 7 and weapon ~= 38)) then
		Map.damageEfect[#Map.damageEfect + 1] = {getTickCount(), 0, math.min(25.5 * bodypart, 255)}
	else
		Map.damageEfect[#Map.damageEfect + 1] = {getTickCount(), 0, math.min(20 * bodypart, 255)}
	end
	if #Map.damageEfect > 18 then
		repeat
			table.remove(Map.damageEfect, 1)
		until #Map.damageEfect < 18
	end
end
addEventHandler("onClientPlayerDamage", localPlayer,onClientPlayerDamage)

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end
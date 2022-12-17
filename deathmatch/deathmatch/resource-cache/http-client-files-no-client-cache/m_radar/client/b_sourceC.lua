local s = {guiGetScreenSize()}
local radarS = {s[1]-400, s[2]-200}
local radarP = {s[1]/2-radarS[1]/2, s[2]/2-radarS[2]/2}
local vizSzin = tocolor(110, 158, 204,255)
local nagymap
local radarM = {3072,3072}
local blipMeret = {20,20}
local jatekosMeret = {12,12}
local zoom = 1
local minZoom = 1
local maxZoom = 1
local zoomRadio = 0.05
local mozgatAdat = {0,0}
local honnanMozgat = {0,0}
local chatetRejtett = false
utiBlip = nil

gpsPontok = {}
radarMegjelenitve = false -- Ha ez igaz akkor a minimapot nem rendereli


addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( resource )
		if resource ~= getThisResource() then return end
		-- Régi radar törlése
        toggleControl("radar", true)
		nagymap=dxCreateRenderTarget(radarS[1], radarS[2],false)
		radar=dxCreateRenderTarget(radarS[1], radarS[2],false)
    end
);

addEventHandler("onClientKey", getRootElement(), function(gomb, statusz)
	if(gomb == "F11" and statusz) then
		togRadar()
		cancelEvent()
	end
end)

function togRadar()
	if(radarMegjelenitve) then
		radarMegjelenitve = false
		ujRadarElrejtes()
		showChat(true)
		showCursor(false)
		addEventHandler("onClientRender", root, Map.render)
	else
		radarMegjelenitve = true
		ujRadarMegjelenites()
		showChat(false)
		mozgatAdat = {0,0}
		removeEventHandler("onClientRender", root, Map.render)
		showCursor(true,false)
	end
end

function ujRadarMegjelenites()
	if not radarMegjelenitve then return end
	addEventHandler("onClientRender", getRootElement(), ujRadarRender)
end

addEventHandler( "onClientMouseWheel", getRootElement( ),
    function ( fel_le )
		if not radarMegjelenitve then return end
		
        if(fel_le == 1) then
			if(zoom < maxZoom) then
				zoom = zoom + zoomRadio
			end
		elseif(fel_le == -1) then
			if(zoom > minZoom) then
				zoom = zoom - zoomRadio
			end
		end
    end
)

function utvonalTervezes(x,y,z,hx,hy,hz)
	local utvonal = calculatePathByCoords(x,y,z,hx,hy,hu)
	if not utvonal then
		return
	end
	gpsPontok = {}
	for i,node in ipairs(utvonal) do
		table.insert(gpsPontok, {x = node.x, y = node.y, id=i})
	end
end

function nagyMapKattintas ( gomb, statusz, x, y, ... )
	if(radarMegjelenitve) then
		if(gomb == "right" and statusz == "down" and nagyMapKattintas) then
			if(x > radarP[1] and x < radarP[1]+radarS[1] and y > radarP[2] and y < radarP[2]+radarS[2]) then
				if #gpsPontok == 0 then
					local jx, jy, _ = getElementPosition(localPlayer)
					jx, jy = jx+mozgatAdat[1], jy+mozgatAdat[2]
					local kx = jx+((((x-radarP[1])-(radarS[1]/2))*2)*zoom)
					local ky = jy-((((y-radarP[2])-(radarS[2]/2))*2)*zoom)
					--outputChatBox("X: "..jx.." - Y: "..jy)
					--outputChatBox("CX: "..kx.." - CY: "..ky)
					local ejx, ejy, ejz = getElementPosition(localPlayer)
					local utvonal = calculatePathByCoords(ejx, ejy, ejz,kx,ky, 0)
					if not utvonal then
						return
					end
					gpsPontok = {}
					for i,node in ipairs(utvonal) do
						table.insert(gpsPontok, {x = node.x, y = node.y, id=i})
					end
					utiBlip = createBlip(kx,ky, 0, 41, 2, 255, 255, 255, 255, 0)
				else
					gpsPontok = {}
					if(utiBlip) then
						destroyElement(utiBlip)
						utiBlip = nil
					end
				end
			end
		elseif(gomb == "left") then
			if(statusz == "down") then
				honnanMozgat = {x+mozgatAdat[1],y-mozgatAdat[2]}
			end
			if(statusz == "up") then
				honnanMozgat = {0,0}
			end
		end
	end
end
addEventHandler ( "onClientClick", getRootElement(), nagyMapKattintas )

local blipNeve = "FASZKIVAN "

local blipNames = {
	[41] = "Cel",
	[2] = "Ty",
	[0] = "Ty",
  
}

function ujRadarRender()
	if not nagymap then return end
	--exports["zGPainelBlur"]:dxDrawBluredRectangle(radarP[1], radarP[2], radarS[1], radarS[2], tocolor(255, 255, 255, 255))
	if(honnanMozgat[1] ~= 0 or honnanMozgat[2] ~= 0) then
		local kx, ky = getCursorPosition ( )
		if(kx and ky) then
			kx, ky = kx*s[1], ky*s[2]
			mozgatAdat = {kx-honnanMozgat[1], ky-honnanMozgat[2]}
			mozgatAdat = {math.max(math.min(-mozgatAdat[1],6000),-6000), math.max(math.min(mozgatAdat[2], 6000), -6000)}
		end
	end
	if(getKeyState ( "num_add" )) then
		if(zoom > minZoom) then
			zoom = zoom - zoomRadio
		end
	end
	if(getKeyState ( "num_sub" )) then
		if(zoom < maxZoom) then
			zoom = zoom + zoomRadio
		end
	end
	if(getKeyState ( "num_4" )) then
		mozgatAdat[1] = mozgatAdat[1] - 5
	end
	if(getKeyState ( "num_6" )) then
		mozgatAdat[1] = mozgatAdat[1] + 5
	end
	
	dxSetRenderTarget(nagymap,true)
	dxDrawRectangle ( 0, 0, radarS[1], radarS[2], vizSzin, false )
	local jx, jy, _ = getElementPosition(localPlayer)
	jx, jy = jx+mozgatAdat[1], jy+mozgatAdat[2]
	local e1,e2,e3,e4=(((3000)+jx)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom), ((3000-jy)/(6000)*radarM[2])-((radarS[2]/2)*zoom), radarS[1]*zoom, radarS[2]*zoom
	local xplussz, yplussz = 0, 0
	if(e2+(radarS[2]*zoom) >= radarM[2]) then
		yplussz = radarM[2]-(e2+(radarS[2]*zoom))
	end
	if(e2 <= 0) then
		yplussz = 0-e2
	end
	if(e1+(radarS[1]*zoom) >= radarM[1]) then
		xplussz = radarM[1]-(e1+(radarS[1]*zoom))
	end
	if(e1 <= 0) then
		xplussz = 0-e1
	end
	local axm, aym = 0, 0
	dxDrawImageSection(0+(xplussz/zoom),0+(yplussz/zoom),radarS[1],radarS[2],e1+xplussz,e2+yplussz,e3,e4,"gfx/gtasa.png",0,0,0,tocolor(255, 255, 255, 255),false)
	local ux, uy = nil, nil
	--local alapBeallitasok = exports['ace_rendszer']:getAlapBeallitasok()
	for i,utvonal in ipairs(gpsPontok) do
		--[[local hsl = exports['ace_rendszer']:tabla_masolas(alapBeallitasok["szerverSzin"]["hsl"])
		hsl[2] = -0.5
		local szin = {exports['ace_rendszer']:hsl2rgb(hsl[1], hsl[2], hsl[3])}--]]
		local x,y = utvonal.x, utvonal.y
		local n_x = (((((3000)+x)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom)-e1)+((radarS[1]/2)*zoom))/zoom
		local n_y = ((((3000-y)/(6000)*radarM[2])-((radarS[2]/2)*zoom)-e2)+((radarS[2]/2)*zoom))/zoom
		if(ux and uy) then
			dxDrawLine ( ux, uy, n_x, n_y, tocolor(144, 0, 254, 255), 8 )
			ux, uy = n_x, n_y
		else
			ux, uy = n_x,n_y
		end
	end

	for k,v in ipairs(getElementsByType ("radararea")) do
        local sx, sy = getRadarAreaSize(v)
        local size = 2
        sx = sx / size
        sy = sy / size
        local jbx, jby, _ = getElementPosition(v)
        local jb_x = (((((3000)+jbx)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom)-e1)+((radarS[1]/2)*zoom))/zoom
		local jb_y = ((((3000-jby)/(6000)*radarM[2])-((radarS[2]/2)*zoom)-e2)+((radarS[2]/2)*zoom))/zoom
        local rr, gg, bb, alpha = 255,255,255,255
        rr, gg, bb, alpha = getRadarAreaColor(v)

        if (isRadarAreaFlashing(v)) then
            alpha = alpha*math.abs(getTickCount()%1000-500)/500
        end

        dxDrawRectangle ( jb_x-sx/size + sx/1.8, jb_y-sy/size - sy/1.8, sx, sy, tocolor(rr, gg, bb, alpha) )
    end

	for k,v in ipairs(getElementsByType ("blip")) do
		local bIcon = getBlipIcon(v)
        local x,y = getElementPosition(v)
        local b_x = (((((3000)+x)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom)-e1)+((radarS[1]/2)*zoom))/zoom
		local b_y = ((((3000-y)/(6000)*radarM[2])-((radarS[2]/2)*zoom)-e2)+((radarS[2]/2)*zoom))/zoom
        local blip_icon = getBlipIcon  ( v)
		--outputChatBox("X: "..b_x)
		b_x = math.min(math.max(b_x, blipMeret[1]/2), radarS[1]-blipMeret[2]/2)
		b_y = math.min(math.max(b_y, blipMeret[2]/2), radarS[2]-blipMeret[2]/2)
		
		local bcR, bcG, bcB = 255, 255, 255
		if getBlipIcon(v) == 0 then
			bcR, bcG, bcB = getBlipColor(v)
		end
		if blip_icon == 0 then
			blipNeve = getElementData(v, "blipName")
		end
		
        dxDrawImage ( b_x-blipMeret[1]/2,b_y-blipMeret[2]/2,blipMeret[1],blipMeret[2], "gfx/icons/"..blip_icon..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, 255))
		
		local kx, ky = getCursorPosition()
		if kx and ky then
			kx, ky = kx*s[1]-radarP[1], ky*s[2]-radarP[2]
			if (dobozbaVan(b_x-blipMeret[1]/2,b_y-blipMeret[2]/2,blipMeret[1],blipMeret[2], kx, ky)) then
				if getElementData(v, "blipName") or false then
					blipNeve = getElementData(v, "blipName")
				elseif blipNames[bIcon] then
					blipNeve = blipNames[bIcon]
				else
					blipNeve = "Nome indisponível"
				end
				local szovegHossz =  dxGetTextWidth(blipNeve, 0.7, "default-bold")+40
				formDobozRajzolasa( b_x-szovegHossz/2,b_y+blipMeret[2],szovegHossz,20, tocolor(20, 20, 20, 150), tocolor(0,0,0,200))
				fontSzovegRender(blipNeve,b_x-szovegHossz/2,b_y+blipMeret[2], szovegHossz, 20, tocolor(255,255,255,220), 1, "default-bold", "center", "center", true, true, false, 0, 0, 0)
			end
		end
    end

	local rot = getPedRotation( localPlayer )
	local jbx, jby, _ = getElementPosition(localPlayer)
    local jb_x = (((((3000)+jbx)/(6000)*(radarM[1]))-((radarS[1]/2)*zoom)-e1)+((radarS[1]/2)*zoom))/zoom
	local jb_y = ((((3000-jby)/(6000)*radarM[2])-((radarS[2]/2)*zoom)-e2)+((radarS[2]/2)*zoom))/zoom
	dxDrawImage ( jb_x-blipMeret[1]/2, jb_y-blipMeret[2]/2, blipMeret[1], blipMeret[2], "gfx/icons/2.png", -rot, 0, 0, tocolor(255,255,255,255) )
	dxSetRenderTarget()
	
	dxCreateBorder(radarP[1], radarP[2], radarS[1], radarS[2], tocolor(0, 0, 0, 200)) 
	dxDrawImage ( radarP[1], radarP[2], radarS[1], radarS[2], nagymap, 0, 0, 0, tocolor(255,255,255,200) ) 
	
end



function fontSzovegRender(szoveg, x, y, b, f, szin, meret, font, ax, ay, clip, szotores, postgui, rot, rotx, roty, fszin)
	if not fszin then fszin = false end
	dxDrawText ( szoveg, x, y, x+b, y+f, szin, meret, "default-bold", ax, ay, clip, szotores, postgui, fszin, false, rot, rotx, roty )
end


function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end

function dxCreateBorder(x,y,w,h,color)
	dxDrawRectangle(x-3,y-3,w+6,3,color) -- Fent
	dxDrawRectangle(x-3,y,3,h,color) -- Bal Oldal
	dxDrawRectangle(x-3,y+h,w+6,3,color) -- Lent Oldal
	dxDrawRectangle(x+w,y-3,3,h+3,color) -- Jobb Oldal
end

local dobozB = {15, 3}
local dobozS = {17, 1, 0, 5}

function formDobozRajzolasa(x, y, sz, m, hszin, kszin, elore)
	-- Keret
	dxDrawRectangle ( x, y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255), elore) -- Bal oldal
	dxDrawRectangle ( x+sz-(dobozS[1]-dobozB[1]-1), y+dobozS[4]/2, 1, m-dobozS[4], kszin or tocolor(60,63,63,255), elore) -- Jobb oldal
	dxDrawRectangle ( x+dobozS[4]/2, y, sz-dobozS[4], 1, kszin or tocolor(60,63,63,255), elore) -- Teteje oldal
	dxDrawRectangle ( x+dobozS[4]/2, y+m-(dobozS[1]-dobozB[1]-1), sz-dobozS[4], 1, kszin or tocolor(60,63,63,255), elore) -- Alja oldal
	
	dxDrawRectangle(x+1, y+1, sz-2, m-2, hszin or tocolor(60,63,63,100), elore)
end

function ujRadarElrejtes()
	if radarMegjelenitve then return end
	removeEventHandler("onClientRender", getRootElement(), ujRadarRender)
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
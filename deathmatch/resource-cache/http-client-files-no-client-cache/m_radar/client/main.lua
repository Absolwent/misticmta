Menu = {}
Menu.__index = Menu
Menu.instances = {}

function onClientResourceStart()
--if getElementData(source, "auth:login") or getElementData(localPlayer, "auth:register") then radarMegjelenitve = false end
	
	Pages = {}
	
	Pages.MAPA = {}
	Pages.MAPA.map = Map.new(x*10,y*30,x*1345,y*708)
	Pages.MAPA.map:setColor(255,255,255,200)
	
	Pages.MAPA.radar = Map.new(x*20, y*599, x*280, y*138)
	Pages.MAPA.radar:setColor(255,255,255,190)
	Pages.MAPA.radar.style = 1

	Pages.MAPA.radar:setVisible(true)
	
	
	setPlayerHudComponentVisible("radar",false)
end
addEventHandler("onClientResourceStart",resourceRoot,onClientResourceStart)

function onClientResourceStop()
--if getElementData(source, "auth:login") or getElementData(localPlayer, "auth:register") then radarMegjelenitve = false end
	setPlayerHudComponentVisible("radar",true)
	toggleControl("radar",true)
end
addEventHandler("onClientResourceStop",resourceRoot,onClientResourceStop)

function isKeyBound(key, keyState, handler)
--if getElementData(source, "auth:login") or getElementData(localPlayer, "auth:register") then radarMegjelenitve = false end
	local handlers = getFunctionsBoundToKey(key)
	for k,v in pairs(handlers or {}) do
		if(v == handler) then
			return true
		end
	end
	return false
end


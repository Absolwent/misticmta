--[[
	
	AUTHOR - https://vk.com/ganzes77
	GROUP VK - https://vk.com/ganzes_shop

]]

local sx, sy = guiGetScreenSize()

local function gs(var) return var * sy/1080 end
local w, h = gs(694), gs(410)
local x, y = (sx / 2) - (w / 2), (sy / 2) - (h / 2)

salon.takePlayerVehicles = function(table, cars)
	playerVehicles = table
	limit = cars
end
addEvent('salon.takePlayerVehicles', true)
addEventHandler('salon.takePlayerVehicles', root, salon.takePlayerVehicles)

local eAlpha = false
local alpha = 0

salon.enable = function()
	self.tick = nil
	self.tickOne = nil
	self.vis = false
	self.scrollManager = 0
	self.selectedManager = ''
	self.idVehicle = ''
end
salon.enable()

local vis = false
local r_root = getResourceRootElement(getThisResource())

salon.renderManager = function()
	Blur.render(255, 1)
	if eAlpha then
		if alpha <= 250 then
			alpha = alpha + 11
			self.moveF3= interpolateBetween(200, 0, 0, y, 0, 0, (getTickCount() - self.tick ) / 300, 'InQuad')
		end
	elseif eAlpha == false then
		if alpha >= 5 then
			alpha = alpha - 11
			self.moveF3 = interpolateBetween(y, 0, 0, 200, 0, 0, (getTickCount() - self.tickOne) / 300, 'InQuad')
		end
	end

	dxDrawImage(x, self.moveF3, w, h, 'files/images/f3/bg.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
	dxDrawImage(x + gs(40), self.moveF3 + gs(55), gs(336), gs(316), 'files/images/f3/bg_grid.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
	dxDrawText('Транспорт', x+gs(65), self.moveF3+gs(20), w, h, tocolor(255, 255, 255, alpha), gs(0.9), self.fonts[2])
	dxDrawText('Номер', x+gs(275), self.moveF3+gs(20), w, h, tocolor(255, 255, 255, alpha), gs(0.9), self.fonts[2])
	dxDrawText('Управление транспортом', x+gs(425), self.moveF3+gs(30), w, h, tocolor(255, 255, 255, alpha), gs(0.9), self.fonts[2])

	dxDrawText('Парковочных ячеек занято: #FF0000'..limit, x+gs(100), self.moveF3+gs(382), w, h, tocolor(255, 255, 255, alpha), gs(0.8), self.fonts[2], nil, nil, false, false, false, true)

	dxCreateButton(x + gs(420), self.moveF3 + gs(80), gs(227), gs(47), 'Респавн', 0, 'files/images/f3/btn.png', 'files/images/f3/button.png', self.fonts[2], alpha)
	dxCreateButton(x + gs(420), self.moveF3 + gs(150), gs(227), gs(47), 'Убрать', 1, 'files/images/f3/btn.png', 'files/images/f3/button.png', self.fonts[2], alpha)
	dxCreateButton(x + gs(420), self.moveF3 + gs(220), gs(227), gs(47), 'Сбросить чип', 2, 'files/images/f3/btn.png', 'files/images/f3/button.png', self.fonts[2], alpha)
	dxCreateButton(x + gs(420), self.moveF3 + gs(290), gs(227), gs(47), 'Убрать все', 3, 'files/images/f3/btn.png', 'files/images/f3/button.png', self.fonts[2], alpha)

	dxDrawImage(x+gs(385), self.moveF3 + gs(70), gs(5), gs(275), 'files/images/f3/scroll_bg.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
	if vis then
		if #playerVehicles > 2 then
			local scrolling = ( self.scrollManager / ( #playerVehicles - 2 ) )
			dxDrawImage(x+gs(385), scrolling*self.moveF3+gs(410), gs(5), gs(29), 'files/images/f3/scroll.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
		else
			dxDrawImage(x+gs(385), self.moveF3+gs(80), gs(5), gs(29), 'files/images/f3/scroll.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
		end
	end

	local py = 0
	local maxed = 0
	for i, v in ipairs(playerVehicles) do
		if #playerVehicles == 0 then return false end
		if i >= self.scrollManager then
			if maxed <=6 then
				dxDrawImage(x + gs(40), self.moveF3 + gs(65) + py, gs(336), gs(35), 'files/images/f3/Line.png', 0, 0, 0, tocolor(255, 255, 255, alpha))

				if cs(x + gs(40), self.moveF3 + gs(65) + py, gs(336), gs(35)) then
					dxDrawImage(x + gs(40), self.moveF3 + gs(65) + py, gs(336), gs(35), 'files/images/f3/line_hover.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
					if getKeyState('mouse1') then
						self.selectedManager = i
						self.idVehicle = v['id']
					end
				end

				if self.selectedManager == i then
					dxDrawImage(x + gs(40), self.moveF3 + gs(65) + py, gs(336), gs(35), 'files/images/f3/line_hover.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
				end

				local number = fromJSON(v['number'])
				dxDrawText(v['name'], x+gs(64), self.moveF3 + gs(70) + py, w, h, tocolor(255, 255, 255, alpha), gs(0.9), self.fonts[2])
				dxDrawText(number[2]..' | '..number[1], x+gs(260), self.moveF3 + gs(70) + py, w, h, tocolor(255, 255, 255, alpha), gs(0.9), self.fonts[2], nil, nil, false, false, false, true)
				py = py + gs(43)
				maxed = maxed + 1
			end
		end
	end
	if alpha <= 0 then
		removeEventHandler('onClientRender', root, salon.renderManager)
	end

end


salon.stateManager = function()
	if not isEventHandlerAdded('onClientRender', root, salon.renderManager) then
		eAlpha = true
		self.tick = getTickCount()
		triggerServerEvent('givePlayerVehicles', localPlayer, localPlayer)
		addEventHandler('onClientRender', root, salon.renderManager)
		addEventHandler('onClientKey', root, salon.key)
		addEventHandler('onClientClick', root, salon.managerClick)
		showCursor(true)
		Timer(function ()
			vis = true
		end, 300, 1)
	else
		 eAlpha = false
		self.tickOne = getTickCount()
		showCursor(false)
		removeEventHandler('onClientKey', root, salon.key)
		removeEventHandler('onClientClick', root, salon.managerClick)
	--	Timer(function()
	--		removeEventHandler('onClientRender', root, salon.renderManager)
	--	end, 270, 1)
		vis = false
	end
end
bindKey('f3', 'down', salon.stateManager)
	
addEventHandler('onClientResourceStart', r_root, function()
	triggerServerEvent('givePlayerVehicles', localPlayer, localPlayer)
end)

salon.key = function(key)
	if key == 'mouse_wheel_down' then
		if self.scrollManager+7 <= #playerVehicles then
			self.scrollManager = self.scrollManager + 1
		end
	end
	if key == 'mouse_wheel_up' then
		if self.scrollManager > 0 then
			self.scrollManager = self.scrollManager - 1
		end
	end
end

salon.managerClick = function(b, s)
	if b == 'left' and s == 'down' then
		if cs(x + gs(420), y + gs(80), gs(227), gs(47)) then
			if self.selectedManager == '' or self.selectedManager == 0 then outputChatBox('Выберите автомобиль') return end
			triggerServerEvent('takeMyVehicle', localPlayer, localPlayer, self.idVehicle)
		elseif cs(x + gs(420), self.moveF3 + gs(150), gs(227), gs(47)) then
			if self.selectedManager == '' or self.selectedManager == 0 then outputChatBox('Выберите автомобиль') return end
			triggerServerEvent('deleteMyCar', localPlayer, localPlayer, self.idVehicle)
		end
	end
end

Timer(function()
	outputDebugString('Автор ресурса: https://vk.com/ganzes77\nГруппа ВК: https://vk.com/ganzes_shop')
end, 1000, 0)
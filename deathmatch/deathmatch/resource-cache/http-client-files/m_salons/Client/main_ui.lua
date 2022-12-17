--[[
	
	AUTHOR - https://vk.com/ganzes77
	GROUP VK - https://vk.com/ganzes_shop

]]

salon = {}
self = salon

local sx, sy = guiGetScreenSize()

local function gs(var) return var * sy/1080 end
local isClicked = false
local click = false
local px, py = (sx / 2) - (gs(668) / 2), (sy / 1.05) - (gs(59))

salon.on = function()

	self.w, self.h = gs(453), gs(348)
	self.x, self.y = ( sx / 7 ) - ( self.w / 2 ), ( sy / 3 ) - ( self.h / 2 )
	
	self.selectedCar = 0
	self.selectedCarPrice = 0
	self.selectedSpeed = 0
	self.selectedFuel = 0
	self.selectedFuelLeave = 0
	self.selectedRow = ''
	self.veh = nil
	self.shop = nil
	self.int = nil
	self.tickOpen = nil
	self.tickClose = nil
	self.scroll = 0
	self.id = nil
	self.r = 0
	self.g = 0
	self.b = 0
	self.grid = CONFIG['VEHICLES']
	self.eAlpha = false
	self.alpha = 0
	self.move = nil
	self.selectedColor = ''

	self.images = {
		['character'] = 'files/images/veh_info.png',
		['progress']  = 'files/images/progress.png',
		['money']     = 'files/images/money.png',
		['bg_info']	  = 'files/images/bg_info.png',
	}

	self.fonts = {
		[1] = DxFont('files/fonts/proximanova.ttf', gs(16)),
		[2] = DxFont('files/fonts/manrope_medium.ttf', gs(14))
	}


	self.colors = {-- img, r g b
		{img = 'files/images/colors/dark.png', r = 0, g = 0, b = 0},
		{img = 'files/images/colors/bel.png', r = 255, g = 255, b = 255},
		{img = 'files/images/colors/blue.png', r = 0, g = 5, b = 200},
		{img = 'files/images/colors/g.png', r = 6, g = 187, b = 165},
		{img = 'files/images/colors/green.png',  r = 0, g = 255, b = 0},
		{img = 'files/images/colors/orange.png',  r = 142, g = 163, b = 31},
		{img = 'files/images/colors/purple.png',  r = 193, g = 0, b = 193},
		{img = 'files/images/colors/red.png',  r = 255, g = 0, b = 0},
		{img = 'files/images/colors/ser.png',  r = 150, g = 150, b = 150},
	}

end
salon.on()

salon.render = function()
	if self.eAlpha then
		if self.alpha <= 250 then
			self.alpha = self.alpha + 11
			pyy = interpolateBetween(0, 0, 0, self.y + gs(5), 0, 0, (getTickCount() - self.tickOpen) / 600, 'InQuad')
			self.move = interpolateBetween(1000, 0, 0, py, 0, 0, (getTickCount() - self.tickOpen) / 450, 'InQuad')
		end
	elseif self.eAlpha == false then
		if self.alpha >= 5 then
			self.alpha = self.alpha - 11
			pyy =  interpolateBetween(self.y, 0, 0, 0, 0, 0, (getTickCount() - self.tickClose) / 600, 'InQuad')
			self.move = interpolateBetween(py, 0, 0, 1000, 0, 0, (getTickCount() - self.tickClose) / 450, 'InQuad')
		end
	end

	dxDrawImage(0, 0, sx, gs(100), self.images.bg_info, 0, 0, 0, tocolor(255, 255, 255, self.alpha))
	dxDrawText('Автосалон', self.x, pyy-gs(160), self.w, self.h, tocolor(255, 255, 255, self.alpha), gs(1), self.fonts[1], 'center')

	dxDrawImage(self.x+gs(1250), pyy - gs(160), gs(28), gs(30), self.images.money, 0, 0, 0, tocolor(255, 255, 255, self.alpha))
	dxDrawText(FN(getPlayerMoney(localPlayer)), self.x+gs(1285), pyy-gs(157), self.w ,self.h, tocolor(255, 255, 255, self.alpha), gs(1), self.fonts[2])

	dxDrawImage(self.x + gs(1800), pyy-gs(160), gs(32), gs(32), 'files/images/icon_close.png', 0, 0, 0, tocolor(255 ,255, 255, self.alpha))
	if cs(self.x + gs(1800), pyy-gs(160), gs(32), gs(32)) then
		dxDrawImage(self.x + gs(1800), pyy-gs(160), gs(32), gs(32), 'files/images/icon_close.png', 0, 0, 0, tocolor(255 ,0, 0, 255))
		if getKeyState('mouse1') and not isClicked then
			salon.stateWindow()
		end
	end
	dxDrawImage(self.x+gs(1809), pyy-gs(150), gs(14), gs(11), 'files/images/close.png', 0, 0, 0, tocolor(255 ,255, 255, self.alpha))


	dxDrawImage(self.x, pyy, self.w, self.h, self.images.character, 0, 0, 0, tocolor(255, 255, 255, self.alpha))

	dxDrawText(self.selectedCar, self.x+gs(30), pyy+gs(11), self.w, self.h, tocolor(255, 255, 255, self.alpha), gs(1), self.fonts[1], 'center')

	dxDrawImage(self.x + gs(30), pyy+gs(100), gs(383), gs(21), self.images.progress, 0, 0, 0, tocolor(255, 255, 255, self.alpha))
	dxDrawImage(self.x + gs(30), pyy+gs(100), (self.selectedSpeed/5)/100*gs(301), gs(20), 'files/images/progress_1.png')

	dxDrawImage(self.x + gs(30), pyy+gs(170), gs(383), gs(21), self.images.progress, 0, 0, 0, tocolor(255, 255, 255, self.alpha))
	dxDrawImage(self.x + gs(30), pyy+gs(170), (self.selectedFuel/2)/100*gs(301), gs(20), 'files/images/progress_1.png')

	dxDrawImage(self.x + gs(30), pyy+gs(240), gs(383), gs(21), self.images.progress, 0, 0, 0, tocolor(255, 255, 255, self.alpha))
	dxDrawImage(self.x + gs(30), pyy+gs(240), (self.selectedFuelLeave/1)/100*gs(301), gs(20), 'files/images/progress_1.png')

	-- speed
	dxDrawText('Макс скорость', self.x+gs(50), pyy+gs(70), self.w, self.h, tocolor(255, 255, 255, self.alpha), gs(0.8), self.fonts[2])
	dxDrawText(self.selectedSpeed, self.x+gs(320), pyy+gs(70), self.w, self.h, tocolor(255, 255, 255, self.alpha), gs(0.8), self.fonts[2])

	-- fuel 
	dxDrawText('Бензобак', self.x+gs(50), pyy+gs(140), self.w, self.h, tocolor(255, 255, 255, self.alpha), gs(0.8), self.fonts[2])
	dxDrawText(self.selectedFuel, self.x+gs(320), pyy+gs(140), self.w, self.h, tocolor(255, 255, 255, self.alpha), gs(0.8), self.fonts[2])

	-- fuel leave
	dxDrawText('Расход топлива', self.x+gs(50), pyy+gs(210), self.w, self.h, tocolor(255, 255, 255, self.alpha), gs(0.8), self.fonts[2])
	dxDrawText(self.selectedFuelLeave, self.x+gs(320), pyy+gs(210), self.w, self.h, tocolor(255, 255, 255, self.alpha), gs(0.8), self.fonts[2])

	-- price
	dxDrawImage(self.x + gs(120), pyy+gs(290), gs(28), gs(30), self.images.money, 0, 0, 0, tocolor(255, 255, 255, self.alpha))
	dxDrawText(FN(self.selectedCarPrice), self.x+gs(30), pyy+gs(290), self.w, self.h, tocolor(255, 255, 255, self.alpha), gs(1), self.fonts[1], 'center')


	-- colors
	dxDrawImage(self.x ,pyy+gs(370), gs(452), gs(64), 'files/images/bg_colors.png', 0, 0, 0, tocolor(255, 255, 255, self.alpha))

	-- settings info 
	dxDrawImage(px, self.move, gs(668), gs(59), 'files/images/bg_set.png', 0, 0, 0, tocolor(255, 255, 255, self.alpha))

	btn(px + gs(35), self.move-gs(3), gs(141), gs(64), 'files/images/close_icon.png', nil, nil, 'BACKSPACE', self.fonts[2])
	dxDrawText('- Закрыть', px + gs(175), self.move+gs(17.5), 0, 0, tocolor(255, 255, 255, self.alpha), gs(0.9), self.fonts[2])

	btn(px + gs(270), self.move-gs(3), gs(141), gs(64), 'files/images/buy_icon.png', nil, nil, 'ENTER', self.fonts[2])
	dxDrawText('- Купить', px + gs(400), self.move+gs(17.5), 0, 0, tocolor(255, 255, 255, self.alpha), gs(0.9), self.fonts[2])

	btn(px + gs(470), self.move-gs(3), gs(77), gs(61), 'files/images/test_icon.png', nil, nil, 'Z', self.fonts[2])
	dxDrawText('- Тест-драйв', px + gs(540), self.move+gs(17.5), 0, 0, tocolor(255, 255, 255, self.alpha), gs(0.9), self.fonts[2])

	-- grid list cars 
	local pxGrid = 0
	local maxed = 0
	for k, v in pairs(self.grid[self.shop]) do
		if k >= self.scroll then
			if maxed <= 5 then

				dxDrawImage(self.x+gs(100) + pxGrid, pyy + gs(600), gs(252), gs(152), 'files/images/veh_info.png', 0, 0, 0, tocolor(255 ,255, 255, self.alpha))
				
				if cs(self.x+gs(100) + pxGrid, pyy + gs(600), gs(252), gs(152)) then
					dxDrawImage(self.x+gs(100) + pxGrid, pyy+ gs(600), gs(252), gs(152), 'files/images/item_bg_active.png', 0, 0, 0, tocolor(255 ,255, 255, 255))
				end

				if self.selectedRow == k then
					dxDrawImage(self.x+gs(100) + pxGrid, pyy+ gs(600), gs(252), gs(152), 'files/images/item_bg_active.png', 0, 0, 0, tocolor(255 ,55, 0, 155))
				end

				dxDrawImage(self.x+gs(140) + pxGrid, pyy+gs(630), gs(v[8]), gs(v[9]), v[7], 0, 0, 0, tocolor(255, 255, 255, self.alpha))
				dxDrawText(v[2], self.x+gs(155)+pxGrid, pyy+gs(715), self.w, self.h, tocolor(255 ,255, 255, self.alpha), gs(0.9), self.fonts[2])
				
				if cs(self.x+gs(100) + pxGrid,pyy + gs(600), gs(252), gs(152)) then
					if getKeyState('mouse1') and not isClicked then
						self.selectedCar = v[2]
						self.selectedFuel = v[5]
						self.selectedSpeed = v[4]
						self.selectedFuelLeave = v[6]
						self.selectedCarPrice = v[3]
						self.selectedRow = k
						self.veh.model = v[1]
						self.id = v[1]
					end
				end
				pxGrid = pxGrid + gs(265)
				maxed = maxed + 1
			end
		end
	end
	self.px = 0
	for i, v in pairs(self.colors) do
		local color = tocolor(255, 255, 255, self.alpha)

		if v.img == self.selectedColor then
			color = tocolor(255, 255, 255, 100)
		end
		dxDrawImage(self.x+gs(20) + self.px, pyy+gs(380), gs(40), gs(40), v.img, 0, 0, 0, color)

		if cs(self.x+gs(20) + self.px, pyy+gs(380), gs(40), gs(40)) then
			if getKeyState('mouse1') and not isClicked then
				self.selectedColor = v.img
				if isElement(self.veh) then
					self.r = v.r
					self.g = v.g 
					self.b = v.b
					setVehicleColor(self.veh, v.r, v.g, v.b)
				end
			end
		end
		self.px = self.px + gs(45)
	end
	if self.alpha <= 0 then
		removeEventHandler('onClientRender', root, salon.render)
	end
	if getKeyState('mouse1') then isClicked = true else isClicked = false end
end

salon.stateWindow = function()
	if not isEventHandlerAdded('onClientRender', root, salon.render) then
		self.eAlpha = true
		self.tickOpen = getTickCount()
		self.tickClose = nil
		addEventHandler('onClientRender', root, salon.render)
		addEventHandler('onClientKey', root, salon.scrolled)
		showCursor(true)
		showChat(false)
		localPlayer.frozen = true

	else
		removeEventHandler('onClientKey', root, salon.scrolled)
		self.eAlpha = false
		self.tickClose = getTickCount()
		self.tickOpen = nil
		showCursor(false)
		showChat(true)
		localPlayer.frozen = false
		localPlayer.dimension = 0
		setCameraTarget(getLocalPlayer())
		if isElement(self.veh) then
			self.veh:destroy()
		end
	end
end
addEvent('salon.stateWindow', true)
addEventHandler('salon.stateWindow', root, salon.stateWindow)

for _, v in pairs(CONFIG['ALL_MARKETS']) do
	local marker = Marker(v[1], v[2], v[3]-1, 'cylinder', 1.5, 0, 255, 0)

	marker:setData('s:type', _, false)
	marker.interior = v[4]
	marker.dimension = v[5]
end

addEventHandler('onClientMarkerHit', resourceRoot, function(el, dim)
	if el == getLocalPlayer() and dim then
		if isPedInVehicle(el) then info('info', 'Автосалон', 'Выйдите из транспорта') return end
		local type = source:getData('s:type')
		if type then
			self.shop = type
			fadeCamera(false)
			Timer(function()
				fadeCamera(true)
				local xcar, ycar, zcar, rotation = CONFIG['POS_SPAWN_AUTO'][self.shop][1], CONFIG['POS_SPAWN_AUTO'][self.shop][2],
				 CONFIG['POS_SPAWN_AUTO'][self.shop][3], CONFIG['POS_SPAWN_AUTO'][self.shop][4]
				local xcam ycam, zcam  = CONFIG['POS_SPAWN_AUTO'][self.shop][5], CONFIG['POS_SPAWN_AUTO'][self.shop][6],
				 CONFIG['POS_SPAWN_AUTO'][self.shop][7] 
				 setCameraMatrix(-1957.0451660156, 267.13192749023, 35.86875, 
                    -1945.4359130859, 267.13192749023, 35.86875)
				self.veh = Vehicle(self.grid[self.shop][1][1], xcar, ycar, zcar, 0, 0, rotation)
				el.dimension = math.random(1, 5000)
				self.veh.dimension = el.dimension
				salon.stateWindow()
			end, 1000, 1)
		end
	end
end)

salon.scrolled = function( key, state )
	if state then
	--	if (key == "mouse_wheel_up") or (key == "mouse_wheel_down") then else return end

		if key == "mouse_wheel_down" then
			if self.scroll+6 <= #self.grid[self.shop] then
				self.scroll = self.scroll + 1
			end
		end
		if key == "mouse_wheel_up" then
			if self.scroll > 0 then
				self.scroll = self.scroll - 1
			end
		end
		if key == 'backspace' then
			salon.stateWindow()
		end
		if key == 'enter' then
			if isElement(self.veh) then
				if self.selectedCar == '' or self.selectedCar == 0 then return end
				salon.stateMessage()
			end
		end
		if key == 'arrow_r' then
			if isElement(self.veh) then
				local _, _, z = getElementRotation(self.veh)
				setElementRotation(self.veh, 0, 0, z-7)
			end
		end
		if key == 'arrow_l' then
			if isElement(self.veh) then
				local _, _, z = getElementRotation(self.veh)
				setElementRotation(self.veh, 0, 0, z+7)
			end
		end
		if key == 'z' then
			if isElement(self.veh) then
				if self.selectedCar == '' or self.selectedCar == 0 then return end
				triggerServerEvent('startTestDrive', localPlayer, localPlayer, self.id, self.shop)
			end
		end
	end
end

renderMessage = function()	
	dxDrawImage((sx / 2) - (gs(453) / 2), (sy / 2) - (gs(348) / 2), gs(453), gs(348), 'files/images/veh_info.png', 0, 0, 0, tocolor(255 ,255, 255))
	dxDrawText('Вы уверены что хотите купить\n'..self.selectedCar..' За '..FN(self.selectedCarPrice)..' ? ' ,(sx / 2) - (gs(453) / 2) + gs(720), (sy / 2) - (gs(348) / 2) + gs(100), self.w, self.h, tocolor(255, 255, 255), gs(1), self.fonts[2], 'center')
	dxBtn(gs(800), gs(630), gs(148), gs(63), 'files/images/close_icon.png', nil, tocolor(0, 255, 0, 55), 'Купить', self.fonts[2])
	dxBtn(gs(1000), gs(630), gs(148), gs(63), 'files/images/close_icon.png', nil, tocolor(0, 255, 0, 55), 'Закрыть', self.fonts[2])


	if cs(gs(1000), gs(630), gs(148), gs(63)) then
		if getKeyState('mouse1') and not click then
			salon.stateMessage()
		end
	elseif cs(gs(800), gs(630), gs(148), gs(63)) then
		if getKeyState('mouse1') and not click then
			if isElement(self.veh) then
				if self.selectedCar == '' or self.selectedCar == 0 then return end
				local veh = self.veh.model
				triggerServerEvent('buyNewVehicle', localPlayer, localPlayer, veh, self.selectedCar, self.shop, self.r, self.g, self.b, self.selectedCarPrice)
				salon.stateMessage()
				return
			end
		end
	end
	if getKeyState('mouse1') then click = true else click = false end
end

salon.stateMessage = function()
	if not isEventHandlerAdded('onClientRender', root, renderMessage) then
		addEventHandler('onClientRender', root, renderMessage)
	else
		removeEventHandler('onClientRender', root, renderMessage)
	end
end

function info(type, text, text1)
	exports['vehicle_notify']:showInfo(type, text, text1)
end
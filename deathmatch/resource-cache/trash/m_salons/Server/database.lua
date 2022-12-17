--[[
	
	AUTHOR - https://vk.com/ganzes77
	GROUP VK - https://vk.com/ganzes_shop

]]

local db = Connection('sqlite', 'database.db')
db:exec('CREATE TABLE IF NOT EXISTS Vehicles (id, account, name, x, y, z, color, number, hand)')
db:exec('CREATE TABLE IF NOT EXISTS VehiclesID (ID, account)')

local vehicles = {}

local testVehicles = {}

function info(self, text, text1)
	if self and isElement(self) then
		exports['vehicle_notify']:showInfo(self, 'info', text, text1)
	end
end

-- добавление в бд
function addVehilceDatabase(self, id, name, vehicle, color, x, y, z, number, hand)
	if not isElement(self) or not id or not name then return false end
	local hand = hand or 0
	db:exec('INSERT INTO Vehicles VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', id, self.account.name, name, x, y, z, color, number, hand)
end

-- передаем данные клиенту
addEvent('givePlayerVehicles', true)
addEventHandler('givePlayerVehicles', root, function(self)
	if isElement(self) then
		local t = db:query("SELECT * FROM Vehicles WHERE account = ?", self.account.name):poll(-1)
		local cars = getPlayerVehiclesCount(self).."/"..exports["vehicle_house"]:getCarLimit(self)
		triggerClientEvent(self, 'salon.takePlayerVehicles', self, t, cars)
	end
end)

function getPlayerCars(self)
	if not isElement(self) then return end
	local account = self.account.name
	if account then
		local t = db:query("SELECT * FROM Vehicles"):poll(-1)
		if t['account'] == account then
			return t['id']
		end
	end
end

-- покупка
function buyNewVehicle(self, id, name, shop, r, g, b, price)
	if not isElement(self) or not id then return false end
	if getPlayerVehiclesCount(self) >= exports["vehicle_house"]:getCarLimit(self) then
		info(self, 'Автосалон', 'Недостаточно парковочных мест')
		triggerClientEvent(self, 'salon.stateWindow', self)
		return
	end
	if getPlayerMoney(self) >= price then
		takePlayerMoney(self, price)
		triggerClientEvent(self, 'salon.stateWindow', self)
		local x, y, z = getElementPosition(self)
		vehicles[self] = Vehicle(id, x, y, z)
		self:setData('id', vehicles[self])
		local x1, y1, z1 = getElementPosition(vehicles[self])
		setVehicleColor(vehicles[self], r, g, b)
		local c1,c2,c3,c4,c5,c6 = getVehicleColor(vehicles[self])
		local color = toJSON({c1,c2,c3,c4,c5,c6,c7,c8,c9})
		setElementData(vehicles[self],"numberType","ru")
		local s1 = CONFIG['NUMBER_SYMBOLS'][math.random(1,#CONFIG['NUMBER_SYMBOLS'])]
		local s2 = CONFIG['NUMBER_SYMBOLS'][math.random(1,#CONFIG['NUMBER_SYMBOLS'])]
		local s3 = CONFIG['NUMBER_SYMBOLS'][math.random(1,#CONFIG['NUMBER_SYMBOLS'])]
		local num = math.random(100,999)
		local region =  math.random(10,99)
		setElementData(vehicles[self],"number:plate",s1..s2..num..s3..region)
		local number = toJSON({getElementData(vehicles[self],"numberType"),getElementData(vehicles[self],"number:plate")})
		local hand = toJSON(getVehicleHandling(vehicles[self]))
		addVehilceDatabase(self, id, name, vehicles[self], color, x1, y1, z1, number, hand)

		info(self, 'Автосалон', 'Вы купили '..name..' За '..price..'.\nУправлять: F3')
		setElementPosition(vehicles[self], CONFIG['POS_SPAWN_AUTO'][shop][5], CONFIG['POS_SPAWN_AUTO'][shop][6], CONFIG['POS_SPAWN_AUTO'][shop][7])
		warpPedIntoVehicle(self, vehicles[self])
	else
		info(self, 'Автосалон', 'У вас недостаточно денег.')
		triggerClientEvent(self, 'salon.stateWindow', self)
	end
end
addEvent('buyNewVehicle', true)
addEventHandler('buyNewVehicle', root, buyNewVehicle)

-- респавн
function takeMyVehicle (self, id)
	if not isElement(self) or not id then return end
	local data = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE id = ?", id), -1)[1]

	for k, v in pairs(getElementsByType('vehicle')) do
		if vehicles[self] then
			info(self, 'Автосалон', 'У вас уже есть заспавненный автомобиль.')
			return
		end
	end

	local x, y, z = getElementPosition(self)
	vehicles[self] = Vehicle(data['id'], x + 2, y + 2, z + 1)
	fixVehicle(vehicles[self])

	local color = fromJSON(data['color'])
	setVehicleColor(vehicles[self], color[1], color[2], color[3], color[4])

	local handlings = fromJSON(data["hand"])
	for key,value in pairs(handlings) do
		setVehicleHandling(vehicles[self], key, value)
	end

	info(self, 'Автосалон', data['name']..' Заспавнен.')

	local nomer = fromJSON(data['number'])
	if nomer[1] then
		setElementData(vehicles[self],"numberType",nomer[1])
		setElementData(vehicles[self],"number:plate",nomer[2])
	end
end
addEvent('takeMyVehicle', true)
addEventHandler('takeMyVehicle', root, takeMyVehicle)

-- убрать авто
function deleteMyCar (self, id)
	if vehicles[self] then
		vehicles[self]:destroy()
		vehicles[self] = nil
	else
		info(self, 'Автосалон', 'У вас нет заспавненных авто.')
		return
	end
end
addEvent('deleteMyCar', true)
addEventHandler('deleteMyCar', root, deleteMyCar)

function getPlayerVehiclesCount(ply)
	local account = getAccountName(getPlayerAccount(ply))
	local result = dbPoll(dbQuery(db, "SELECT * FROM Vehicles WHERE account = ?", account), -1)
	local count = 0
	if result and type(result) == "table" then
		count = count + #result
	end
	return count
end


function startTestDrive(self, id, shop)
	if not isElement(self) then return false end
	self:setData('test:active', shop)
	triggerClientEvent(self, 'salon.stateWindow', self)
	testVehicles[self] = Vehicle(id, CONFIG['POS_SPAWN_AUTO'][shop][5], CONFIG['POS_SPAWN_AUTO'][shop][6], CONFIG['POS_SPAWN_AUTO'][shop][7])
	self.dimension = math.random(1, 5000)
	testVehicles[self].dimension = self.dimension
	warpPedIntoVehicle(self, testVehicles[self])
	info(self, 'Автосалон', 'Вы начали тест-драйв.')

	Timer(function()
		self:setData('test:active', false)
		if isElement(testVehicles[self]) then
			info(self, 'Автосалон', 'Тест-драйв окончен.')
			testVehicles[self]:destroy()
		--	triggerClientEvent(self, 'salon.stateWindow', self)
			setElementPosition(self, CONFIG['ALL_MARKETS'][shop][1], CONFIG['ALL_MARKETS'][shop][2], CONFIG['ALL_MARKETS'][shop][3])
			self.interior = CONFIG['ALL_MARKETS'][shop][4]
			self.dimension = CONFIG['ALL_MARKETS'][shop][5]
		end
	end, 10000, 1)
end
addEvent('startTestDrive', true)
addEventHandler('startTestDrive', root, startTestDrive)

addEventHandler('onVehicleExit', resourceRoot, function(p)
	if p:getData('test:active') then
		if isElement(testVehicles[p]) then
			testVehicles[p]:destroy()
			info(p, 'Автосалон', 'Тест-драйв окончен.')
			setElementPosition(p, CONFIG['ALL_MARKETS'][p:getData('test:active')][1], CONFIG['ALL_MARKETS'][p:getData('test:active')][2], CONFIG['ALL_MARKETS'][p:getData('test:active')][3])
			p.interior = CONFIG['ALL_MARKETS'][p:getData('test:active')][4]
			p.dimension = CONFIG['ALL_MARKETS'][p:getData('test:active')][5]
			p:setData('test:active', false)
		end
	end
end)
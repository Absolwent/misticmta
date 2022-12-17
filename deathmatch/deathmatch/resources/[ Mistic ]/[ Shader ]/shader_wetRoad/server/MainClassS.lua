--[[
	Name: WetRoadsReloaded
	Filename: MainClassS.lua
	Authors: Sam@ke
--]]

local Instance = nil

MainClassS = {}


function MainClassS:constructor()
	
	setFPSLimit(60)
	
	self.updateInterVal = 250
	
	self.m_Update = bind(self.update, self)
	self.updateTimer = setTimer(self.m_Update, self.updateInterVal , 0)
end


function MainClassS:update()
	--setWeather(12)
end


function MainClassS:destructor()
	if (self.updateTimer) then
		self.updateTimer:destroy()
		self.updateTimer = nil
	end
end


addEventHandler("onResourceStart", resourceRoot,
function()
	Instance = new(MainClassS)
end)


addEventHandler("onResourceStop", resourceRoot,
function()
	if (Instance) then
		delete(Instance)
		Instance = nil
	end
end)
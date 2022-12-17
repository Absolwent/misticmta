local sw, sh = guiGetScreenSize()
local zoom = sw < 1920 and math.min(2, 1920/sw) or 1


local noti = {}
noti.__index = noti



function noti:create()
	local instance = {}
	setmetatable(instance, noti)
	instance:constructor()
end


function noti:constructor()
	self.func = {}
	self.func.render = function() self:render() end
	self.fonts = {}
	self.fonts[1] = dxCreateFont("assets/font.ttf", 10/zoom)
	self:code()
	self.nots = {}
end

function noti:code()
	self.settings = {
		["error"] = {
			img = dxCreateTexture("assets/error.png"),
			color = {255, 20, 0}
		},
		["success"] = {
			img = dxCreateTexture("assets/success.png"),
			color = {0, 186, 25}
		},
		["info"] = {
			img = dxCreateTexture("assets/info.png"),
			color = {255, 196, 0}
		},
		["punishment"] = {
			img = dxCreateTexture("assets/punishment.png"),
			color = {255, 90, 0}
		}
	}
	addEvent("notiAdd", true)
	addEventHandler("notiAdd", root, function(type, text)
		if #self.nots > 6 then
			table.remove(self.nots, 1)
		end
		table.insert(self.nots, {type=type, text=text, tick=getTickCount()})
		if not self.rendered then
			self.rendered = true
			addEventHandler("onClientRender", root, self.func.render, true, "low")
		end
		outputConsole("["..string.upper(type).."] - "..text)
		playSound("assets/sounds/info.mp3")
	end)
end


function noti:render()
	for i,v in ipairs(self.nots) do
		local add = 63/zoom*(i-1)
		if v.tick + 6000 < getTickCount() then
			anim = interpolateBetween(0, 0, 0, 350/zoom, 0, 0, (getTickCount() - (v.tick + 6000))/700, "OutQuad")
			alpha, alpha200 = interpolateBetween(255, 200, 0, 0, 0, 0, (getTickCount() - (v.tick + 6000))/500, "Linear")
			if v.tick + 6700 < getTickCount() then
				table.remove(self.nots, 1)
			end
			bar = 100
		else
			anim = interpolateBetween(350/zoom, 0, 0, 0, 0, 0, (getTickCount() - v.tick)/700, "OutQuad")
			alpha, alpha200, alpha155 = interpolateBetween(0, 0, 0, 255, 200, 155, (getTickCount() - v.tick)/500, "Linear")
			bar = interpolateBetween(0, 0, 0, 100, 0, 0, (getTickCount() - (v.tick + 500))/5000, "Linear")
		end
		if getElementData(localPlayer, "removeRadar") then
			dxDrawRectangle(10/zoom - anim, sh - 72/zoom - add, 350/zoom, 60/zoom, tocolor(20, 20, 20, alpha200))
			dxDrawText(v.text, 65/zoom - anim, sh - 70/zoom - add*2, 295/zoom + 65/zoom - anim, 60/zoom + sh - 70/zoom, tocolor(255, 255, 255, alpha), 1, self.fonts[1], "left", "center", true, true)
			dxDrawRectangle(10/zoom - anim, sh - 12/zoom - add, 350/zoom, 2, tocolor(10, 10, 10, alpha))
			dxDrawRectangle(10/zoom - anim, sh - 12/zoom - add, 350/zoom/100*bar, 2, tocolor(self.settings[v.type]["color"][1], self.settings[v.type]["color"][2], self.settings[v.type]["color"][3], alpha))
			dxDrawImage(25/zoom - anim, sh - 52.5/zoom - add, 25/zoom, 25/zoom, string.format("assets/%s.png", v.type), 0, 0, 0, tocolor(self.settings[v.type]["color"][1], self.settings[v.type]["color"][2], self.settings[v.type]["color"][3], alpha))
		else			
			dxDrawRectangle(10/zoom - anim, sh - 274/zoom - add, 350/zoom, 60/zoom, tocolor(20, 20, 20, alpha200))
			dxDrawText(v.text, 65/zoom - anim, sh - 272/zoom - add*2, 295/zoom + 65/zoom - anim, 60/zoom + sh - 272/zoom, tocolor(255, 255, 255, alpha), 1, self.fonts[1], "left", "center", true, true)
			dxDrawRectangle(10/zoom - anim, sh - 214/zoom - add, 350/zoom, 2, tocolor(10, 10, 10, alpha))
			dxDrawRectangle(10/zoom - anim, sh - 214/zoom - add, 350/zoom/100*bar, 2, tocolor(self.settings[v.type]["color"][1], self.settings[v.type]["color"][2], self.settings[v.type]["color"][3], alpha))
			dxDrawImage(25/zoom - anim, sh - 255/zoom - add, 25/zoom, 25/zoom, string.format("assets/%s.png", v.type), 0, 0, 0, tocolor(self.settings[v.type]["color"][1], self.settings[v.type]["color"][2], self.settings[v.type]["color"][3], alpha))
		end
	end
end


noti:create()


function dxDrawRoundedRectangle(x, y, width, height, radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+radius, width-(radius*2), height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawCircle(x+radius, y+radius, radius, 180, 270, color, color, 16, 1, postGUI)
    dxDrawCircle(x+radius, (y+height)-radius, radius, 90, 180, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, (y+height)-radius, radius, 0, 90, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, y+radius, radius, 270, 360, color, color, 16, 1, postGUI)
    dxDrawRectangle(x, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+height-radius, width-(radius*2), radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+width-radius, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y, width-(radius*2), radius, color, postGUI, subPixelPositioning)
end


addCommandHandler("notixdall", function()
	triggerEvent("notiAdd", localPlayer, "error", "Przykładowy bląd!")
	triggerEvent("notiAdd", localPlayer, "info", "Przykładowa informacja.")
	triggerEvent("notiAdd", localPlayer, "success", "Przykładowy sukces :D")
end)
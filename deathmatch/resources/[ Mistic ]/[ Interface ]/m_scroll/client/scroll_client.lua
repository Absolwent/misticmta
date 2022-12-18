local scroll = {}

local sw,sh = guiGetScreenSize()
local zoom = 1920/sw

function isMouseInPosition(x, y, w, h)
	if not isCursorShowing() then return end

	local pos = {getCursorPosition()}
	pos[1], pos[2] = (pos[1] * sw), (pos[2] * sh)

	if pos[1] >= x and pos[1] <= (x + w) and pos[2] >= y and pos[2] <= (y + h) then
		return true
	end
	return nil
end

function scroll:load()
    self.render_fnc = function() self:render() end
    self.click_fnc = function(...) self:click(...) end
    self.key_fnc = function(...) self:key(...) end

    self.textures = {}
    self.scrolls = {}
    self.showed = false
    self.resources = {}

    self.circle=false
end

function scroll:create(x, y, w, h, row, showed, tbl, height, alpha, plus, strefa)
    self.scrolls[#self.scrolls] = {"", x, y, w, h, row, showed, tbl, 0, false, height, {}, alpha or 255, plus or 1, strefa or {0,0,sw,sh}}

    if not self.showed then 
        addEventHandler("onClientRender", root, self.render_fnc)
        addEventHandler("onClientClick", root, self.click_fnc)
        addEventHandler("onClientKey", root, self.key_fnc)
    end

    for i,v in pairs(self.scrolls) do
        local max = (v[3] + (v[11] - v[5])) - v[3]
        local row = 0
        for i = v[3], (v[3] + max) do
            local rel = (i - v[3]) /  max
            row = rel * (#v[8] - (v[7]))
            v[12][math.floor(row + 1)] = i
        end
    end

    self.showed = true
    
    if(sourceResource)then
		self.resources[sourceResource] = true
		self.scrolls[#self.scrolls].resource = sourceResource
        addEventHandler("onClientResourceStop", getResourceRootElement(sourceResource), function(resource)
			for i,v in pairs(self.scrolls) do
				if(v.resource == resource)then
					scroll:destroy(i)
				end
            end
            self.resources[resource] = nil
		end)
	end

    return #self.scrolls
end

function scroll:destroy(name)
    for i,v in pairs(self.scrolls) do
        if i == name then
            self.scrolls[i] = nil
            break
        end
    end

    if #self.scrolls < 1 and self.showed then
        removeEventHandler("onClientRender", root, self.render_fnc)
        removeEventHandler("onClientClick", root, self.click_fnc)
        removeEventHandler("onClientKey", root, self.key_fnc)
        
        for i,v in pairs(self.textures) do
            if v and isElement(v) then
                destroyElement(v)
            end
        end

        self.textures = {}
        self.showed = false
        self.resources = {}
    end
end

function scroll:getPosition(name)
    local row = 0
    for i,v in pairs(self.scrolls) do
        if i == name then
            row = math.abs(v[6])
            break
        end
    end
    return row
end

function scroll:updateTable(name, tbl)
    for i,v in pairs(self.scrolls) do
        if i == name then
            v[8] = tbl

            local max = (v[3] + (v[11] - v[5])) - v[3]
            local row = 0
            for i = v[3], (v[3] + max) do
                local rel = (i - v[3]) /  max
                row = rel * (#v[8] - (v[7]))
                v[12][math.floor(row)] = i
            end
            break
        end
    end
end

function scroll:key(key, press)
    if press then
        if key == "mouse_wheel_up" then
            for i,v in pairs(self.scrolls) do
                if(isMouseInPosition(unpack(v[15])) and v[6] > 0)then
                    v[6] = v[6]-v[14]
                    v[9] = v[12][math.floor(v[6])] or v[12][math.floor(v[6]-1)] or 0
                end
            end
        elseif key == "mouse_wheel_down" then
            for i,v in pairs(self.scrolls) do
                if isMouseInPosition(unpack(v[15])) and (v[6] + v[7]) < #v[8] then
                    v[6] = v[6]+v[14]
                    v[9] = v[12][math.floor(v[6])] or v[12][math.floor(v[6]+1)] or v[3]+v[11]-v[5]
                end
            end
        end
    end
end

function scroll:click(button, state)
    if button ~= "left" then return end

    for i,v in pairs(self.scrolls) do
        if isMouseInPosition(v[2], v[3], v[4], v[11]) and state == "down" then
            v[10] = true
        elseif state == "up" then
            v[10] = false
        end
    end
end

function scroll:render()
    for i,v in pairs(self.scrolls) do
        if(isCursorShowing())then
            local cX, cY = getCursorPosition()
            cX, cY = cX * sw, cY * sh
            cY = cY - (v[5] / 2)
            v[9] = v[10] and cY or v[9]
        else
            local cX, cY = 0,0
            cX, cY = cX * sw, cY * sh
            cY = cY - (v[5] / 2)
            v[9] = v[10] and cY or v[9]
        end

        if v[9] > v[3] + (v[11] - v[5]) then
            v[9] = v[3] + v[11] - v[5]
        elseif v[9] < v[3] then
            v[9] = v[3]
        end

        if(v[10] and v[7] < #v[8])then
            local max = (v[3] + (v[11] - v[5])) - v[3]
            local rel = (v[9] - v[3]) /  max
            v[6] = rel * (#v[8] - (v[7]))
        end
    end
end

function dxCreateScroll(...)
    return scroll:create(...)
end

function dxDestroyScroll(id)
    return scroll:destroy(id)
end

function dxScrollGetPosition(id)
    return scroll:getPosition(id)
end

function dxScrollUpdateTable(...)
    return scroll:updateTable(...)
end

function dxScrollSetAlpha(id, alpha)
    for i,v in pairs(scroll.scrolls) do
        if i == id then
            v[13] = alpha
            break
        end
    end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    scroll:load()
end)

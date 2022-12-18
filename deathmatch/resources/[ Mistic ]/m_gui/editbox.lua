local dx = exports.m_dx;

local edit = {}

local sw,sh = guiGetScreenSize()
local zoom = 1
if sw < 1920 then
    zoom = math.min(2, 1920 / sw)
end

local sx,sy = guiGetScreenSize()
local px,py = (sx/1920),(sy/1080)

function isMouseInPosition(x, y, w, h)
	if not isCursorShowing() then return end

	local pos = {getCursorPosition()}
	pos[1], pos[2] = (pos[1] * sw), (pos[2] * sh)

	if pos[1] >= x and pos[1] <= (x + w) and pos[2] >= y and pos[2] <= (y + h) then
		return true
	end
	return nil
end

function edit:load()
    self.render_fnc = function() self:render() end
    self.click_fnc = function(...) self:click(...) end
    self.character_fnc = function(...) self:character(...) end
    self.key_fnc = function(...) self:key(...) end

    self.edits = {}

    self.showed = nil

    self.tick = getTickCount()
    self.tickBack = getTickCount()
    self.backState = 0

    self.pasted = nil

    self.backing = nil

    self.font = dx:getFont("rbt-l", 5);
end

function edit:create(name, localText, opisText, x, y, w, h, masked, fontSize, a, filePath, type)
    self.edits[#self.edits + 1] = {name, localText, opisText, x, y, w, h, masked, false, 0, color or {255, 255, 255}, false, fontSize, a or 255, filePath and dxCreateTexture(filePath, "argb", false, "clamp") or false, type};
    self.font = dx:getFont("rbt-r", (fontSize or 1));

    if not self.showed then
        addEventHandler("onClientRender", root, self.render_fnc)
        addEventHandler("onClientClick", root, self.click_fnc)
        addEventHandler("onClientCharacter", root, self.character_fnc)
        addEventHandler("onClientKey", root, self.key_fnc)

        self.showed = true
    end
end

function edit:destroy(name)
    for i,v in pairs(self.edits) do
        if v[1] == name then
            if v[15] and isElement(v[15]) then
                destroyElement(v[15])
            end

            self.edits[i] = nil
        end
    end

    if #self.edits < 1 then
        removeEventHandler("onClientRender", root, self.render_fnc)
        removeEventHandler("onClientClick", root, self.click_fnc)
        removeEventHandler("onClientCharacter", root, self.character_fnc)
        removeEventHandler("onClientKey", root, self.key_fnc)

        self.showed = nil
    end
end

function edit:render()
    for i,v in pairs(self.edits) do
        local x,w = 0,0;
        local xx = v[6];
        if(v[9])then
            x,w = interpolateBetween(v[6]/2, 0, 0, 0, xx, 0, (getTickCount()-v[10])/200, "Linear");
        else
            x,w = interpolateBetween(0, xx, 0, v[6]/2, 0, 0, (getTickCount()-v[10])/200, "Linear");
        end;

        if(not v[16])then
            dxDrawRectangle(v[4], v[5]+v[7]-5, v[6], 1, tocolor(194,197,200, v[14]), false);
            if(v[15])then
                local ww,hh = 20,20;
                dxDrawImage(v[4]+v[6]-30/zoom, v[5]+(hh/2/zoom), v[7]-ww/zoom, v[7]-hh/zoom, v[15], 0, 0, 0, tocolor(255, 255, 0, v[14]), false);
            end;
            dxDrawRectangle(v[4]+x, v[5]+v[7]-5, w, 1, tocolor(95,160,160,v[14]), false);
        end;


        local newW = v[15] and 40/zoom or 0;
        local w = v[6];
	local w2 = v[4];
        local l = 775*px
        local text = v[8] and string.rep("*", #v[2]) or v[2];
        local width = dxGetTextWidth(text, 1, self.font, false) or 0;
        if v[9] then
            if (getKeyState("lctrl") or getKeyState("rctrl")) and getKeyState("v") then
                v[2] = guiGetText(self.pasted) or ""
            end

            if getKeyState("backspace") then
                self.backState = self.backState - 1
            else
                self.backState = 100
            end

            if getKeyState("backspace") and (getTickCount() - self.tickBack) > self.backState then
                v[2] = string.sub(v[2], 1, #v[2] - 1)
                self.tickBack = getTickCount()
            end

            local carretAlpha = v[14] > 200 and interpolateBetween(50, 0, 0, 200, 0, 0, (getTickCount() - self.tick) / 1000, "SineCurve") or v[14]
            local carretSize = dxGetFontHeight(1, self.font);
            local carretPosX = width > (w-newW) and v[4] + w-newW or v[4] + width
        end

        if(width > (w-newW))then
            dxDrawText(text, v[4]+w+w+w2-w-w-l, v[5], v[4]+w2-newW2, v[7] + v[5], tocolor(v[11][1], v[11][2], v[11][3], v[14]), 1, self.font, "right", "center", true)
        else
            dxDrawText(text, v[4]+w+w+w2-w-w-l, v[5], w, v[7] + v[5], tocolor(v[11][1], v[11][2], v[11][3], v[14]), 1, self.font, "left", "center", false)
        end

        if #v[2] < 1 then
            dxDrawText(v[3], v[4]+w+w+w2-w-w-l, v[5], w, v[7] + v[5], tocolor(145, 144, 144, v[14]), 1, self.font, "left", "center", false)
        end
    end
end

function edit:click(button, state)
    if button ~= "left" or state ~= "down" then return end

    for i,v in pairs(self.edits) do
        if isMouseInPosition(v[4], v[5], v[6], v[7]) then
			if not v[9] then
                if i == 1 then
                    self.backing = nil
                else
                    self.backing = true
                end

                for _,k in pairs(self.edits) do
                    if k[9] then
                        k[9] = false
                        k[10] = getTickCount()
                        break
                    end
				end

				v[9] = true
        v[10] = getTickCount()

        self.pasted = guiCreateEdit(3000, 3000, 200, 200, "", false, false)
        guiBringToFront(self.pasted)
				return
			end
		end

		if v[9] then
			v[9] = false
      v[10] = getTickCount()

      if self.pasted and isElement(self.pasted) then
        destroyElement(self.pasted)
        self.pasted = nil
      end
		end
  end
end

function edit:character(key)
    for i,v in pairs(self.edits) do
        if v[9] then
            v[2] = v[2] .. key
        end
    end
end

function edit:key(key, press)
    if press then
        if key == "tab" then
            for i = 1, #self.edits do
                if self.edits[i][9] == true then
                    if self.edits[i + 1] and not self.backing then
                        if (i + 1) == #self.edits then
                            self.backing = true
                        end

                        self.edits[i][9] = false
                        self.edits[i + 1][9] = true
                        self.edits[i][10] = getTickCount()
                        self.edits[i + 1][10] = getTickCount()
                        break
                    elseif self.edits[i - 1] then
                        if (i - 1) == 1 then
                            self.backing = nil
                        end

                        self.edits[i][9] = false
                        self.edits[i - 1][9] = true
                        self.edits[i][10] = getTickCount()
                        self.edits[i - 1][10] = getTickCount()
                        break
                    end
                end
            end
        elseif (getKeyState("lctrl") or getKeyState("rctrl")) and (getKeyState("c") or getKeyState("a")) then
            cancelEvent()
        end
    end
end

function dxCreateEdit(...)
    edit:create(...)
end

function dxDestroyEdit(...)
    edit:destroy(...)
end

function dxGetEditText(name)
    local text = ""
    for i,v in pairs(edit.edits) do
        if v[1] == name then
            text = v[2]
            break
        end
    end
    return text
end

function dxSetEditText(name, text)
    for i,v in pairs(edit.edits) do
        if v[1] == name then
            v[2] = text
        end
    end
end

function dxSetEditAlpha(name, a)
    for i,v in pairs(edit.edits) do
        if v[1] == name then
            v[14] = a;
        end
    end
end;

function dxSetEditPosition(name, x, y)
    for i,v in pairs(edit.edits) do
        if v[1] == name then
            v[4], v[5] = x,y;
        end
    end
end;

function dxEditGetSelected(name)
    local selected = false;
    for i,v in pairs(edit.edits) do
        if(v[1] == name and v[9])then
            selected = true;
            break;
        end;
    end;
    return selected;
end;

addEventHandler("onClientResourceStart", resourceRoot, function()
    edit:load()
end)

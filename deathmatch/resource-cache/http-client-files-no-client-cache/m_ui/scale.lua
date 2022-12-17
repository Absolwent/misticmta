sx,sy = guiGetScreenSize()
local zoom = sx < 1024 and math.min(3,1024/sx) or 1

function scale(n,f)
	if not f then
		return math.floor(tonumber(n)/zoom)
	else
		return tonumber(n)/zoom
	end
end

s = scale

function cursorPosition(x,y,w,h)
	if not isCursorShowing() then return false end
	local mx,my = getCursorPosition()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
	if cursorx > x and cursorx < x+w and cursory > y and cursory < y+h then
		return true
	else
		return false
	end
end

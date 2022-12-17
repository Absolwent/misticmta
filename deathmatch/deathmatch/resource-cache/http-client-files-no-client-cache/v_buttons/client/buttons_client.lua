--[[ 

    author: Asper (© 2019)
    mail: nezymr69@gmail.com
    all rights reserved.

]]

local BUTTONS = {}

local sw,sh = guiGetScreenSize()
local zoom = 1920/sw

BUTTONS.font = false
BUTTONS.table = {}
BUTTONS.img = {}
BUTTONS.resources = {}

BUTTONS.onRender = function()
	for i,v in pairs(BUTTONS.table) do
		if(not v.onlyEffect)then
			dxDrawImage(v.pos[1], v.pos[2], v.pos[3], v.pos[4], BUTTONS.img[3], 0, 0, 0, tocolor(255, 255, 255, v.mainAlpha), v.postGui)
		end

		if(v.clickTick)then
			if(v.back)then
				v.alpha = interpolateBetween(v.alpha, 0, 0, 0, 0, 0, (getTickCount()-v.clickTick)/300, "Linear")

				if((getTickCount()-v.clickTick) > 300)then
					v.clickTick = nil
				end
			else
				v.size = interpolateBetween(0, 0, 0, (v.pos[3]*2)+v.pos[4], 0, 0, (getTickCount()-v.clickTick)/500, "Linear")
				v.alpha = interpolateBetween(0, 0, 0, 200, 0, 0, (getTickCount()-v.clickTick)/10, "Linear")

				if((getTickCount()-v.clickTick) > 500)then
					v.back = true
					v.clickTick = getTickCount()
				end
			end

			dxSetRenderTarget(v.target, true)
				dxDrawImage(v.posX-v.size/2, v.posY-v.size/2, v.size, v.size, BUTTONS.img[1], 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxSetRenderTarget()

			local color=(v.onlyEffect and v.onlyEffect[1]) and v.onlyEffect or {29, 29, 39}
			dxDrawImage(v.pos[1], v.pos[2], v.pos[3], v.pos[4], v.target, 0, 0, 0, tocolor(color[1], color[2], color[3], v.mainAlpha > v.alpha and v.alpha or v.mainAlpha), v.postGui)
		end

		if(not v.onlyEffect)then
			if(not v.withoutLine)then
				dxDrawImage(v.pos[1], v.pos[2]+v.pos[4]-1, v.pos[3], 1, BUTTONS.img[2], 0, 0, 0, tocolor(75, 75, 75, v.mainAlpha), v.postGui)
				dxDrawImage(v.pos[1], v.pos[2]+v.pos[4]-1, v.pos[3], 1, BUTTONS.img[2], 0, 0, 0, tocolor(5, 143, 59, v.mainAlpha > v.progress and v.progress or v.mainAlpha), v.postGui)
			end

			dxDrawText(string.upper(v.text), v.pos[1], v.pos[2], v.pos[3]+v.pos[1], v.pos[4]+v.pos[2], tocolor(185, 185, 185, v.mainAlpha), 1, BUTTONS.font, "center", "center", false, false, v.postGui)
		end

		if(isMouseInPosition(v.pos[1], v.pos[2], v.pos[3], v.pos[4]))then
			if(not v.onMouse)then
				playSound("assets/sounds/hover.mp3")

				v.onMouse = true

				animate(v.progress, 255, "Linear", 300, function(a)
					if(v.onMouse)then
						v.progress = a
					end
				end)
			end

			onClick(v.pos[1], v.pos[2], v.pos[3], v.pos[4], function()
				playSound("assets/sounds/click.mp3")

				v.clickTick = getTickCount()
				v.back = false

				local cX, cY = getCursorPosition()
				cX,cY = cX*sw,cY*sh
				v.posX, v.posY = cX-v.pos[1], cY-v.pos[2]
			end)
		elseif(not isMouseInPosition(v.pos[1], v.pos[2], v.pos[3], v.pos[4]))then
			if(v.onMouse)then
				v.onMouse = false

				animate(v.progress, 0, "Linear", 300, function(a)
					if(not v.onMouse)then
						v.progress = a
					end
				end)
			end
		end
	end
end

BUTTONS.create = function(x, y, w, h, text, alpha, fontSize, onlyEffect, postGui, withoutLine)
	if(BUTTONS.font and isElement(BUTTONS.font))then
		destroyElement(BUTTONS.font)
	end

	BUTTONS.font = dxCreateFont("assets/fonts/Exo2-SemiBold.ttf", (fontSize or 15)/zoom)

	table.insert(BUTTONS.table, {onlyEffect=onlyEffect, pos={x,y,w,h}, text=text, withoutLine=withoutLine, progress=0, onMouse=false, click=false, target=dxCreateRenderTarget(w, h, true), size=0, posX=0, posY=0, alpha=255, mainAlpha=alpha or 255, clickTick=false, back=false, postGui=postGui})

	if(#BUTTONS.table == 1)then
		addEventHandler("onClientRender", root, BUTTONS.onRender)

		BUTTONS.img[1] = dxCreateTexture("assets/images/circle.png", "argb", false, "clamp")
		BUTTONS.img[2] = dxCreateTexture("assets/images/line.png", "argb", false, "clamp")
		BUTTONS.img[3] = dxCreateTexture("assets/images/background.png", "argb", false, "clamp")
	end

	if(sourceResource)then
		-- if source resource stop then destroy buttons
		BUTTONS.resources[sourceResource] = true
		BUTTONS.table[#BUTTONS.table].resource = sourceResource
		addEventHandler("onClientResourceStop", getResourceRootElement(sourceResource), function(resource)
			for i,v in pairs(BUTTONS.table) do
				if(v.resource == resource)then
					BUTTONS.destroy(i)
				end
			end
			BUTTONS.resources[resource] = nil
		end)
	end

    return #BUTTONS.table
end

BUTTONS.destroy = function(id)
	if(BUTTONS.table[id])then
		if(BUTTONS.table[id].target and isElement(BUTTONS.table[id].target))then
			destroyElement(BUTTONS.table[id].target)
		end

		BUTTONS.table[id] = nil
	end

	if(#BUTTONS.table == 0)then
		removeEventHandler("onClientRender", root, BUTTONS.onRender)

		if(BUTTONS.font and isElement(BUTTONS.font))then
			destroyElement(BUTTONS.font)
		end

		for i,v in pairs(BUTTONS.img) do
			if(v and isElement(v))then
				destroyElement(v)
				BUTTONS.img[i] = nil
			end
		end

		BUTTONS.resources = {}
	end
end

BUTTONS.setPosition = function(id, pos)
	if(BUTTONS.table[id])then
		BUTTONS.table[id].pos[1], BUTTONS.table[id].pos[2] = pos[1], pos[2]
	end
end

BUTTONS.setAlpha = function(id, a)
	if(BUTTONS.table[id])then
		BUTTONS.table[id].mainAlpha = a
	end
end

function createButton(...)
	return BUTTONS.create(...)
end
--createButton(sw/2, sh/5, 200, 50, "XD", 255)
--showCursor(true, false)

function destroyButton(...)
	BUTTONS.destroy(...)
end

function buttonSetAlpha(...)
	BUTTONS.setAlpha(...)
end

function buttonSetPosition(...)
	BUTTONS.setPosition(...)
end

function buttonSetText(id, text)
	if(BUTTONS.table[id])then
		BUTTONS.table[id].text=text
	end
end

-- animation

local anims = {}
local rendering = false 

local function renderAnimations()
    local now = getTickCount()
    for k,v in pairs(anims) do
        v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing))
        if(now >= v.start+v.duration)then
            table.remove(anims, k)
			if(type(v.onEnd) == "function")then
                v.onEnd()
            end
        end
    end

    if(#anims == 0)then 
        rendering = false
        removeEventHandler("onClientRender", root, renderAnimations)
    end
end

function animate(f, t, easing, duration, onChange, onEnd)
	if(#anims == 0 and not rendering)then 
		addEventHandler("onClientRender", root, renderAnimations)
		rendering = true
	end
	
    assert(type(f) == "number", "Bad argument @ 'animate' [expected number at argument 1, got "..type(f).."]")
    assert(type(t) == "number", "Bad argument @ 'animate' [expected number at argument 2, got "..type(t).."]")
    assert(type(easing) == "string", "Bad argument @ 'animate' [Invalid easing at argument 3]")
    assert(type(duration) == "number", "Bad argument @ 'animate' [expected number at argument 4, got "..type(duration).."]")
    assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
    table.insert(anims, {from = f, to = t, easing = easing, duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd})

    return #anims
end

function destroyAnimation(id)
    if(anims[id])then
        anims[id] = nil
    end
end

-- mouse

function isMouseInPosition(x, y, w, h)
	if(not isCursorShowing())then return end

	local cx,cy=getCursorPosition()
	cx,cy=cx*sw,cy*sh
	
    if(isCursorShowing() and (cx >= x and cx <= (x + w)) and (cy >= y and cy <= (y + h)))then
        return true
    end
    return false
end

function getPosition(myX, myY, x, y, w, h)
    if(isCursorShowing() and (myX >= x and myX <= (x + w)) and (myY >= y and myY <= (y + h)))then
        return true
    end
    return false
end

local mouseState=false
local mouseTick=getTickCount()
local mouseClicks=0
local mouseClick=false
function onClick(x, y, w, h, fnc)
	if(not isCursorShowing())then return end

	if((getTickCount()-mouseTick) > 1000 and mouseClicks > 0)then
		mouseClicks=mouseClicks-1
	end

	if(not mouseState and getKeyState("mouse1"))then
		local cursor={getCursorPosition()}
        mouseState=cursor
    elseif(not getKeyState("mouse1") and (mouseClick or mouseState))then
        mouseClick=false
        mouseState=false
    end

    if(mouseState and mouseClicks < 10 and not mouseClick)then
		local cx,cy=unpack(mouseState)
        cx,cy=cx*sw,cy*sh

        if(getPosition(cx, cy, x, y, w, h))then
			fnc()

			mouseClicks=mouseClicks+1
            mouseTick=getTickCount()
            mouseClick=true
        end
	end
end
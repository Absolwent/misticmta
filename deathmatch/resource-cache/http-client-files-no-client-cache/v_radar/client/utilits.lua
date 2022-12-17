--[[ 

    author: Asper (© 2019)
    mail: nezymr69@gmail.com
    all rights reserved.

]]

toggleControl("radar", false)

-- utilits

sw,sh = guiGetScreenSize()
zoom = 1920/sw

SETTINGS = {
	map_texture = dxCreateTexture("assets/images/map.png", "argb", false, "clamp"),
	map_size = 3072,
	map_target = dxCreateRenderTarget(900/zoom, 900/zoom, true),
	targetSize_normal = 300/zoom,
	targetSize_max = 600/zoom,
	map_unit = 3072/6000,

	minimap_textures = {
		arrow = dxCreateTexture("assets/images/blips/arrow.png", "argb", false, "clamp"),
		rectangle = dxCreateTexture("assets/images/rectangle.png", "argb", false, "clamp"),
		outline = dxCreateTexture("assets/images/outline.png", "argb", false, "clamp"),
		outline_2 = dxCreateTexture("assets/images/outline_2.png", "argb", false, "clamp"),
		logo = dxCreateTexture("assets/images/logo.png", "argb", false, "clamp"),
		line = dxCreateTexture("assets/images/line.png", "argb", false, "clamp"),
		value = dxCreateTexture("assets/images/value.png", "argb", false, "clamp"),
	},

	minimap_zoom = {
		current = 1,
		maximum = 2,
		minimum = 1,
	},

	minimap_size = 500,

	bigmap_zoom = {
		current = 1,
		maximum = 4,
		minimum = 0.5,
	},
}

dxSetTextureEdge(SETTINGS.map_texture, "border", tocolor(110, 158, 204, 255)) -- water

--

-- blips

blipsTexture = {}

for i = 0,63 do
	if(fileExists("assets/images/blips/"..i..".png"))then
		blipsTexture[i] = dxCreateTexture("assets/images/blips/"..i..".png", "argb", false, "clamp")
	end
end
blipsTexture[5] = dxCreateTexture("assets/images/blips/46.png", "argb", false, "clamp")

replaceBlips = {
	{"Bankomat", 5, {}},
	{"assets/images/blips/6.png", 6, {}},
	{"assets/images/blips/7.png", 7, {}},
	{"assets/images/blips/8.png", 8, {}},
	{"assets/images/blips/9.png", 9, {}},
	{"assets/images/blips/10.png", 10, {}},
	{"assets/images/blips/11.png", 11, {}},
	{"Checkpoint", 12, {}},
	{"assets/images/blips/13.png", 13, {}},
	{"assets/images/blips/14.png", 14, {}},
	{"assets/images/blips/15.png", 15, {}},
	{"assets/images/blips/16.png", 16, {}},
	{"assets/images/blips/17.png", 17, {}},
	{"assets/images/blips/18.png", 18, {}},
	{"assets/images/blips/19.png", 19, {}},
	{"assets/images/blips/20.png", 20, {}},
	{"assets/images/blips/21.png", 21, {}},
	{"assets/images/blips/22.png", 22, {}},
	{"assets/images/blips/23.png", 23, {}},
	{"assets/images/blips/24.png", 24, {}},
	{"assets/images/blips/25.png", 25, {}},
	{"assets/images/blips/26.png", 26, {}},
	{"Warsztat", 27, {{879.11834716797,-1192.0856933594,17.005250930786}}},
	{"assets/images/blips/28.png", 28, {}},
	{"assets/images/blips/29.png", 29, {}},
	{"assets/images/blips/30.png", 30, {}},
	{"Domek zajęty", 31, {}},
	{"Domek wolny", 32, {}},
	{"assets/images/blips/33.png", 33, {}},
	{"assets/images/blips/34.png", 34, {}},
	{"assets/images/blips/35.png", 35, {}},
	{"Szkoła jazdy", 36, {}},
	{"Handlarz", 37, {{1881.1296386719,-1855.7116699219,13.576112747192}}},
	{"assets/images/blips/38.png", 38, {}},
	{"assets/images/blips/39.png", 39, {}},
	{"Stacja paliw", 40, {}},
	{"assets/images/blips/41.png", 41, {}},
	{"assets/images/blips/42.png", 42, {}},
	{"assets/images/blips/43.png", 43, {}},
	{"assets/images/blips/44.png", 44, {}},
	{"Przebieralnia", 45, {{2273.4345703125,-1717.9304199219,13.6328125}}},
	{"Praca", 46, {}},
	{"assets/images/blips/47.png", 47, {}},
	{"assets/images/blips/48.png", 48, {}},
	{"assets/images/blips/49.png", 49, {}},
	{"assets/images/blips/50.png", 50, {}},
	{"assets/images/blips/51.png", 51, {}},
	{"Spawn point", 52, {}},
	{"Salon pojazdów", 53, {{1494.5432128906,-1272.6245117188,22.7734375},{1720.0844726563,-1651.1593017578,13.546875},{2031.2888183594,-1769.6856689453,13.546875}}},
	{"Złomowisko", 54, {{-63.529251098633,-1582.5297851563,2.6107201576233}}},
	{"Wyławiarka pojazdów", 55, {{2603.7180175781,-2446.2707519531,13.624583244324}}},
	{"Sklep 24/7", 56, {}},
	{"Parking wirtualny", 57, {}},
	{"Szpital", 58, {{1173.5118408203,-1320.1733398438,15.1953125}}},
	{"Bank", 59, {{1310.2093505859,-1376.4127197266,13.654383659363}}},
	{"Budynek straży", 60, {{1748.0212402344,-1104.5511474609,24.079999923706}}},
	{"Komisariat policji", 61, {{1553.2496337891,-1675.8858642578,16.1953125}}},
	{"Urząd główny", 62, {{1480.5467529297,-1769.7736816406,18.795755386353}}},
	{"Giełda pojazdów", 63, {{2444.2822265625,-1554.1243896484,23.999500274658}}},
}

function findBlipTexture(id)
    return blipsTexture[id] or blipsTexture[0]
end

for i,v in pairs(replaceBlips) do
    v[5] = blipsTexture[v[2]] or blipsTexture[0]

    for index,k in pairs(v[3]) do
        v[4] = {}
        v[4][index] = createBlip(k[1], k[2], k[3], v[2])
        setBlipVisibleDistance(v[4][index], 400)
    end
end

--

-- useful

function getRotation()
	local cameraX, cameraY, _, rotateX, rotateY = getCameraMatrix()
	local camRotation = getVectorRotation(cameraX, cameraY, rotateX, rotateY)

	return camRotation
end

function getVectorRotation(X, Y, X2, Y2)
	local rotation = 6.2831853071796 - math.atan2(X2 - X, Y2 - Y) % 6.2831853071796

	return -rotation
end

function getPointFromDistanceRotation(x, y, dist, angle)
	local a = math.rad(90 - angle)
	local dx = math.cos(a) * dist
	local dy = math.sin(a) * dist

	return x + dx, y + dy
end

-- animate

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

-- by asper

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
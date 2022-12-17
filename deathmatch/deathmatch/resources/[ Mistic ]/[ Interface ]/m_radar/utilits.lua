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

dxSetTextureEdge(SETTINGS.map_texture, "border", tocolor(30,30,30,200)) -- water

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
	{"Cel", 41, {}},
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
	{"Urząd Miasta", 62, {{1481.1790771484, -1759.2601318359, 17.53125}}},
	{"assets/images/blips/28.png", 28, {}},
	{"assets/images/blips/29.png", 29, {}},
	{"assets/images/blips/30.png", 30, {}},
	{"Domek zajęty", 31, {}},
	{"Domek wolny", 32, {}},
	{"assets/images/blips/33.png", 33, {}},
	{"assets/images/blips/34.png", 34, {}},
	{"assets/images/blips/35.png", 35, {}},
	{"Szkoła jazdy", 36, {}},
	{"Handlarz", 37, {}},
	{"assets/images/blips/38.png", 38, {}},
	{"assets/images/blips/39.png", 39, {}},
	{"Stacja paliw", 40, {}},
	{"assets/images/blips/41.png", 41, {}},
	{"assets/images/blips/42.png", 42, {}},
	{"assets/images/blips/43.png", 43, {}},
	{"assets/images/blips/44.png", 44, {}},
	{"Przebieralnia", 45, {}},
	{"Praca", 46, {}},
	{"assets/images/blips/47.png", 47, {}},
	{"assets/images/blips/48.png", 48, {}},
	{"assets/images/blips/49.png", 49, {}},
	{"assets/images/blips/50.png", 50, {}},
	{"assets/images/blips/51.png", 51, {}},
	{"Spawn point", 52, {}},
	{"Salon pojazdów", 53, {{-55.6884765625,-1564.6982421875,2.611438035965}}},
	{"Złomowisko", 54, {}},
	{"Wyławiarka pojazdów", 55, {}},
	{"Sklep 24/7", 56, {}},
	{"Parking wirtualny", 57, {{1720.7380371094, -1777.16796875, 13.542719841003}}},
	{"Szpital", 58, {}},
	{"Bank", 59, {}},
	{"Budynek straży", 60, {}},
	{"Komisariat policji", 61, {}},
}

function findBlipTexture(id)
    return blipsTexture[id] or blipsTexture[0]
end

for i,v in pairs(replaceBlips) do
    v[5] = blipsTexture[v[2]] or blipsTexture[0]

    for index,k in pairs(v[3]) do
        v[4] = {}
        v[4][index] = createBlip(k[1], k[2], k[3], v[2])
        setBlipVisibleDistance(v[4][index], 100)
    end
end

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
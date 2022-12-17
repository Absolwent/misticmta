--[[ 

    author: Asper (© 2019)
    mail: nezymr69@gmail.com
    all rights reserved.

]]

local sw,sh = guiGetScreenSize()
local zoom = 1920/sw

local noti = exports.v_noti

BUY = {}

-- main variables

local assets={
    fonts={},
    fonts2={},
    fonts_paths={
        {"assets/fonts/Exo2-SemiBold.ttf", 15/zoom},
        {"assets/fonts/Exo2-Regular.ttf", 13/zoom},
        {"assets/fonts/Exo2-SemiBold.ttf", 13/zoom},
        {"assets/fonts/Exo2-Regular.ttf", 11/zoom},
    },

    textures={},
    textures_paths={
        "assets/images/back.png",
        "assets/images/line.png",
       --[[ "assets/images/header.png",
        "assets/images/line.png",

        "assets/images/checkbox.png",
        "assets/images/checkbox_selected.png",

        "assets/images/circle_90.png",
        "assets/images/circle_180.png",
        "assets/images/circle_270.png",
        "assets/images/circle_360.png",]]
    },
}

assets.create = function()
    for k,t in pairs(assets) do
        if(k=="fonts_paths")then
            for i,v in pairs(t) do
                assets.fonts[i] = dxCreateFont(v[1], v[2]/zoom)
                assets.fonts2[i] = dxCreateFont(v[1], v[2])
            end
        elseif(k=="textures_paths")then
            for i,v in pairs(t) do
                assets.textures[i] = dxCreateTexture(v, "argb", false, "clamp")
            end
        end
    end
end

assets.destroy = function()
    for k,t in pairs(assets) do
        if(k == "textures" or k == "fonts")then
            for i,v in pairs(t) do
                if(v and isElement(v))then
                    destroyElement(v)
                end
            end
            assets.fonts={}
            assets.textures={}
        end
    end
end

--

-- variables

BUY.info = {}
BUY.alpha = 0

--
--[[
-- peds

function action(id, ped)
    if(id == 2 and not BUY.showed)then
        if(getElementData(localPlayer, "user:gui_showed"))then return end
        
        if(getElementData(localPlayer, "user:job") or getElementData(localPlayer, "user:faction"))then
            noti:noti("Najpierw zakończ pracę.")
            return
        end

        local info = getElementData(ped, "info")
        if(info)then
            if(info.vehicle and isElement(info.vehicle))then
                BUY.startTimer(#BUY.prologs[BUY.prolog].ped)

                showCursor(true, false)
                addEventHandler("onClientRender", root, BUY.onRender)

                animate(BUY.alpha, 255, "Linear", 500, function(a)
                    BUY.alpha = a
                end)

                for i,v in pairs(BUY.textures) do
                    BUY.imgs[i] = dxCreateTexture(v, "argb", false, "clamp")
                end

                for i,v in pairs(BUY.fonts) do
                    BUY.fnts[i] = dxCreateFont(v[1], v[2]/zoom)
                end

                BUY.showed = true
                BUY.prolog = 1
                BUY.cost = 0
                BUY.info = info

                BUY.updatePrologs(true)

                moveCameraTo(ped)

                showChat(false)
                setElementData(localPlayer, "user:hud_disabled", true)
                setElementData(localPlayer, "user:gui_showed", resourceRoot, false)

                noti:noti("Aby pominąć dialog naciśnij spacje.")
            else
                noti:noti("Aktualnie nie posiadam żadnego pojazdu na stanie.")
            end
        end
    end
end

--

-- utilits

BUY.startTimer = function(x)
    BUY.letter = 0
    BUY.timer = getTickCount()
end

BUY.updatePrologs = function(without)
    for i,v in pairs(BUY.prologs) do
        if(i == 3)then
            v.ped = "Widzę, że jesteś zainteresowany. Dzisiaj mam na sprzedaż pojazd "..BUY.info.name.."."
        elseif(i == 5)then
            v.ped = "Tak. Ma "..(BUY.info.distance/1000).." tysięcy przebiegu."
        elseif(i == 6)then
            v.ped = "Chciałbym dostać za niego "..convertNumber(BUY.info.max_cost).."$."
            v.player = {
                {text="Biorę.", option="buy", cost=BUY.info.max_cost},
                {text="Chciałbym zaoferować inną cenę.", option="next", update=true},
                {text="Rezygnuję.", option="quit"},
            }
        elseif(i == 7 and not without)then
            v.player={}

            local rnd=math.random(1,4)

            local costs={
                [1]=(BUY.info.max_cost-math.random(10,100)),
                [2]=BUY.info.min_cost,
                [3]=(BUY.info.min_cost-math.random(100,200)),
                [4]=(BUY.info.min_cost-math.random(300,400)),
            }

            local min_cost=costs[rnd] -- losujemy minimalna cene pojazdu
            
            for _,k in pairs(costs) do
                local option="next2"
                local cost=min_cost
                if(k >= min_cost)then
                    option="next"
                    cost=k
                end

                v.player[#v.player+1]={text=convertNumber(k).."$", option=option, cost=cost}
            end

            v.player[#v.player+1]={text="Rezygnuję.", option="quit"}
        elseif(i == 8)then
            v.ped = "Niech będzie to "..convertNumber(BUY.cost).."$. Na pewno chcesz go zabrać?"
            v.player = {
                {text="Tak, na pewno.", option="buy", cost=BUY.cost},
                {text="Rezygnuję.", option="quit"},
            }
        elseif(i == 9)then
            v.ped = "Niestety to zbyt mało. Mogę go sprzedać za "..convertNumber(BUY.cost).."$."
            v.player = {
                {text="Niech będzie, biorę.", option="buy", cost=BUY.cost},
                {text="Rezygnuję.", option="quit"},
            }
        end
    end
end

-- drawing

BUY.onRender = function()
    dxDrawImage(sw-200/zoom, 5/zoom, 300/zoom, 60/zoom, BUY.imgs[2], 0, 0, 0, tocolor(5, 8, 13, BUY.alpha > 200 and 200 or BUY.alpha), false)
    dxDrawText("Pieniądze: "..convertNumber(getPlayerMoney(localPlayer)).."$", 0+1, 22/zoom+1, sw-10/zoom+1, 0+1, tocolor(0, 0, 0, BUY.alpha), 1, BUY.fnts[3], "right", "top", false, true, false, true)
    dxDrawText("#939393Pieniądze: #14a84f"..convertNumber(getPlayerMoney(localPlayer)).."$", 0, 22/zoom, sw-10/zoom, 0, tocolor(175, 175, 175, BUY.alpha), 1, BUY.fnts[3], "right", "top", false, true, false, true)

    local prolog = BUY.prolog

    local w = dxGetTextWidth(BUY.prologs[prolog].ped, 1, BUY.fnts[1])+200/zoom
    dxDrawImage(sw/2-w/2, sh-200/zoom, w, 50/zoom, BUY.imgs[2], 0, 0, 0, tocolor(5, 8, 13, BUY.alpha > 200 and 200 or BUY.alpha), false)

    dxDrawText("HANDLARZ", sw/2-w/2+1, sh-250/zoom+1, w+sw/2-w/2+1, 50/zoom+sh-250/zoom+1, tocolor(0, 0, 0, BUY.alpha), 1, BUY.fnts[2], "center", "center", false, true, false, true)
    dxDrawText("HANDLARZ", sw/2-w/2, sh-250/zoom, w+sw/2-w/2, 50/zoom+sh-250/zoom, tocolor(150, 150, 150, BUY.alpha), 1, BUY.fnts[2], "center", "center", false, true, false, true)
    dxDrawText(string.sub(BUY.prologs[prolog].ped, 1, BUY.letter), sw/2-w/2, sh-200/zoom, w+sw/2-w/2, 50/zoom+sh-200/zoom, tocolor(200, 200, 200, BUY.alpha), 1, BUY.fnts[1], "center", "center", false, true, false, true)

    if(BUY.letter == #BUY.prologs[prolog].ped)then
        for i = 1,#BUY.prologs[prolog].player do
            local sY = (23/zoom)*i

            local text = "» "..BUY.prologs[prolog].player[i].text
            local w = dxGetTextWidth(text, 1, BUY.fnts[1])

            dxDrawText(text, sw/2-474/2/zoom+1, sh-150/zoom+sY+1, 474/zoom+sw/2-474/2/zoom+1, 424/zoom+sY+1, tocolor(0, 0, 0, BUY.alpha), 1, BUY.fnts[1], "center", "top", false)
            if(isMouseInPosition(sw/2-w/2/zoom, sh-150/zoom+sY, w/zoom, 20/zoom))then
                dxDrawText(text, sw/2-474/2/zoom, sh-150/zoom+sY, 474/zoom+sw/2-474/2/zoom, 424/zoom+sY, tocolor(19, 144, 69, BUY.alpha), 1, BUY.fnts[1], "center", "top", false)
            else
                dxDrawText(text, sw/2-474/2/zoom, sh-150/zoom+sY, 474/zoom+sw/2-474/2/zoom, 424/zoom+sY, tocolor(135, 135, 135, BUY.alpha), 1, BUY.fnts[1], "center", "top", false)
            end

            onClick(sw/2-w/2/zoom, sh-150/zoom+sY, w/zoom, 20/zoom, function()
                if(BUY.prologs[prolog].player[i].option == "next")then
                    if(BUY.prologs[prolog].player[i].cost)then
                        BUY.cost = BUY.prologs[prolog].player[i].cost
                        BUY.updatePrologs(true)
                    end

                    BUY.prolog = BUY.prolog+1
                    BUY.startTimer(#BUY.prologs[BUY.prolog].ped)

                    if(BUY.prologs[prolog].player[i].update)then
                        BUY.updatePrologs()
                    end
                elseif(BUY.prologs[prolog].player[i].option == "buy")then
                    showCursor(false)
                    
                    setCameraTarget(localPlayer)
                    showChat(true)
                    setElementData(localPlayer, "user:hud_disabled", false)
                    
                    triggerServerEvent("buy:veh", resourceRoot, BUY.info.name, BUY.info.distance, BUY.prologs[prolog].player[i].cost, BUY.info.vehicle, BUY.info.id, BUY.info)

                    animate(BUY.alpha, 0, "Linear", 200, function(a)
                        BUY.alpha = a
                    end, function()
                        removeEventHandler("onClientRender", root, BUY.onRender)
                        setElementData(localPlayer, "user:gui_showed", false, false)
    
                        for i,v in pairs(BUY.imgs) do
                            destroyElement(v)
                            BUY.imgs[i] = nil
                        end
        
                        for i,v in pairs(BUY.fnts) do
                            destroyElement(v)
                            BUY.fnts[i] = nil
                        end
                    end)

                    BUY.showed = false
                elseif(BUY.prologs[prolog].player[i].option == "next2")then
                    BUY.cost = BUY.prologs[prolog].player[i].cost
                    BUY.updatePrologs(true)

                    BUY.prolog = BUY.prolog+2
                    BUY.startTimer(#BUY.prologs[BUY.prolog].ped)
                elseif(BUY.prologs[prolog].player[i].option == "quit")then
                    setCameraTarget(localPlayer)
                    showChat(true)
                    setElementData(localPlayer, "user:hud_disabled", false)

                    showCursor(false)
                    animate(BUY.alpha, 0, "Linear", 500, function(a)
                        BUY.alpha = a
                    end, function()
                        removeEventHandler("onClientRender", root, BUY.onRender)
                        setElementData(localPlayer, "user:gui_showed", false, false)
    
                        for i,v in pairs(BUY.imgs) do
                            destroyElement(v)
                            BUY.imgs[i] = nil
                        end
        
                        for i,v in pairs(BUY.fnts) do
                            destroyElement(v)
                            BUY.fnts[i] = nil
                        end
                    end)

                    BUY.showed = false
                end
            end)
        end
    else
        if(getKeyState("space"))then
            BUY.letter=#BUY.prologs[prolog].ped
        elseif((getTickCount()-BUY.timer) > 50)then
            BUY.letter = BUY.letter+1
            BUY.timer = getTickCount()
        end
    end
end]]

BUY.tickTime=getTickCount()
BUY.time=0

BUY.onRender=function()
    local times=(getTickCount()-BUY.tickTime)/1000

    local w,h = 560,100
    dxDrawImage(sw/2-w/2/zoom, sh-h-30/zoom, w/zoom, h/zoom, assets.textures[1], 0, 0, 0, tocolor(31,31,42), false)
    dxDrawImage(sw/2-w/2/zoom, sh-h-30/zoom+h/zoom-1, w/zoom, 1, assets.textures[2], 0, 0, 0, tocolor(255, 255, 255), false)

    dxDrawText("Do końca jazdy pozostało:", sw/2-w/2/zoom, sh-h-30/zoom+20/zoom, w/zoom+sw/2-w/2/zoom, h/zoom, tocolor(11, 150, 65, 255), 1, assets.fonts[1], "center", "top", false)
    dxDrawText(math.floor(BUY.time-times).." sekund", sw/2-w/2/zoom, sh-h-30/zoom+50/zoom, w/zoom+sw/2-w/2/zoom, h/zoom, tocolor(200, 200, 200, 255), 1, assets.fonts[2], "center", "top", false, true)

    if(math.floor(BUY.time-times) <= 0)then
        assets.destroy()
        removeEventHandler("onClientRender", root, BUY.onRender)

        triggerServerEvent("stop.testDrive", resourceRoot)

        exports.v_noti:noti("Czas na jazde testową się skończył.")
    end
end

function action(id, vehicle)
    if(id == 3)then
        local info=getElementData(vehicle, "info")
        if(info)then
            triggerServerEvent("buy:veh", resourceRoot, info.info.name, info.info.distance, info.info.max_cost, vehicle, info.info.id, info)
        end
    elseif(id == 2)then
        local info=getElementData(vehicle, "info")
        if(info)then    
            BUY.tickTime=getTickCount()
            BUY.time=120

            addEventHandler("onClientRender", root, BUY.onRender)

            assets.create()

            triggerServerEvent("create.testDrive", resourceRoot, info.info, vehicle)
        end
    end
end

addEvent("stop.testDrive", true)
addEventHandler("stop.testDrive", resourceRoot, function()
    assets.destroy()
    removeEventHandler("onClientRender", root, BUY.onRender)

    triggerServerEvent("stop.testDrive", resourceRoot)
end)

addEvent("buy.openUI", true)
addEventHandler("buy.openUI", resourceRoot, function(info)
    if(info)then
        BUY.info=info
        BUY.alpha=0
    
        showChat(false)
        showCursor(true,false)
    
        assets.create()
        addEventHandler("onClientRender", root, BUY.onRender)
    
        animate(BUY.alpha, 255, "Linear", 500, function(a)
            BUY.alpha=a
        end)
    else        
        BUY.info={}

        animate(BUY.alpha, 0, "Linear", 500, function(a)
            BUY.alpha=a
        end, function()
            assets.destroy()
            removeEventHandler("onClientRender", root, BUY.onRender)
            showChat(true)
            showCursor(false)
        end)
    end
end)

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

function getPointFromDistanceRotation(x, y, dist, angle)

    local a = math.rad(90 - angle);
 
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
 
    return x+dx, y+dy;
 
end

-- camera by asper

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function moveCameraTo(element)
    local x,y,z = getElementPosition(element)
    local x1,y1 = getElementPosition(localPlayer)
    local rot = -findRotation(x, y, x1, y1)
    rot=rot+180
    local cx, cy = getPointFromDistanceRotation(x, y, -3, rot)
    setCameraMatrix(cx, cy, z+2, x, y, z+0.5)
end

--

addEventHandler("onClientResourceStop", resourceRoot, function()
    local gui = getElementData(localPlayer, "user:gui_showed")
    if(gui and gui == source)then
        setElementData(localPlayer, "user:gui_showed", false, false)
    end
end)

-- useful function created by Asper

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

-- useful

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

-- obracanie się pojazdów


addEventHandler("onClientRender", root, function()
    for i,v in pairs(getElementsByType("vehicle", resourceRoot, true)) do
        local data=getElementData(v, "change:rotation")
        if(data)then
            local rx,ry,rz=getElementRotation(v)
            setElementRotation(v, rx,ry,rz+0.1)

            local x,y,z=getElementPosition(v)
            if(x ~= data[1] or y ~= data[2] or z ~= data[3])then
                setElementPosition(v, data[1], data[2], data[3])
            end
        end
    end
end)
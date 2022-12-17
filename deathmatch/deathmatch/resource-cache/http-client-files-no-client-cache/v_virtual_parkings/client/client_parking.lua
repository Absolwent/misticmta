--[[ 

    author: Asper (© 2019)
    mail: nezymr69@gmail.com
    all rights reserved.

]]

-- variables

local sw,sh = guiGetScreenSize()
local zoom = 1920/sw

local assets={
    fonts={},
    fonts_paths={
        {"assets/fonts/Exo2-SemiBold.ttf", 15},
        {"assets/fonts/Exo2-Regular.ttf", 12},
        {"assets/fonts/Exo2-Regular.ttf", 12},
        {"assets/fonts/Exo2-Regular.ttf", 13},
        {"assets/fonts/Exo2-Regular.ttf", 10},
    },

    textures={},
    textures_paths={
        "assets/images/header.png",
        "assets/images/line.png",
        "assets/images/mini_line.png",
        "assets/images/car.png",
        "assets/images/rectangle.png",
        "assets/images/color.png",

        "assets/images/circle_90.png",
        "assets/images/circle_180.png",
        "assets/images/circle_270.png",
        "assets/images/circle_360.png",

        "assets/images/back.png",
    },
}

--

local buttons=exports.v_--buttons

local UI={}

UI.vehs={}

UI.selected_veh=false
UI.click_veh=false

UI.veh=false
UI.preVeh=false

UI.--buttons={}

-- accept functions

UI.onAccept=function()
    local veh=getPedOccupiedVehicle(localPlayer)
    if(not veh)then
        removeEventHandler("onClientRender",root,UI.onAccept)
        showCursor(false)

        assets.destroy()

        --buttons:destroyButton(UI.--buttons[1])
        --buttons:destroyButton(UI.--buttons[2])
        return
    end

    dxDrawRectangle(sw/2-500/2/zoom, sh/2-200/2/zoom, 500/zoom, 200/zoom, tocolor(31, 31, 42, 235), false)
    dxDrawImage(sw/2-500/2/zoom, sh/2-200/2/zoom, 500/zoom, 56/zoom, assets.textures[1], 0, 0, 0, tocolor(255, 255, 255, 222), false)
    dxDrawImage(sw/2-500/2/zoom, sh/2-200/2/zoom+56/zoom-1, 500/zoom, 1, assets.textures[2], 0, 0, 0, tocolor(255, 255, 255, 255), false)

    dxDrawText("PRZECHOWALNIA", sw/2-500/2/zoom, sh/2-200/2/zoom, 500/zoom+sw/2-500/2/zoom, 56/zoom+sh/2-200/2/zoom, tocolor(200, 200, 200, 255), 1, assets.fonts[1], "center", "center", false)
    
    dxDrawText("Czy chcesz oddać pojazd do przechowalni?", sw/2-500/2/zoom, sh/2-200/2/zoom, 500/zoom+sw/2-500/2/zoom, 250/zoom+sh/2-302/2/zoom, tocolor(200, 200, 200, 255), 1, assets.fonts[4], "center", "center", false)

    onClick(sw/2-185/zoom, sh/2+40/zoom, 175/zoom, 40/zoom, function()
        removeEventHandler("onClientRender",root,UI.onAccept)
        showCursor(false)

        assets.destroy()

        --buttons:destroyButton(UI.--buttons[1])
        --buttons:destroyButton(UI.--buttons[2])

        triggerServerEvent("set:parking", resourceRoot, veh)
    end)

    onClick(sw/2+10/zoom, sh/2+40/zoom, 175/zoom, 40/zoom, function()
        removeEventHandler("onClientRender",root,UI.onAccept)
        showCursor(false)

        assets.destroy()

        --buttons:destroyButton(UI.--buttons[1])
        --buttons:destroyButton(UI.--buttons[2])

        setElementFrozen(veh, false)
    end)
end

addEvent("get:parking", true)
addEventHandler("get:parking", resourceRoot, function()
    --buttons=exports.v_--buttons

    assets.create()

    addEventHandler("onClientRender",root,UI.onAccept)
    showCursor(true)

    --UI.--buttons[1] = --buttons:createButton(sw/2-185/zoom, sh/2+40/zoom, 175/zoom, 40/zoom, "ODDAJ", 255, 11)
    ----UI.--buttons[2] = --buttons:createButton(sw/2+10/zoom, sh/2+40/zoom, 175/zoom, 40/zoom, "ANULUJ", 255, 11)
end)

--

--UI.createVehicle=function(v)
    local color=fromJSON(v.color)
    local tune=fromJSON(v.tuning)

    --UI.veh=createVehicle(v.model,0,0,0)
    setElementDimension(--UI.veh,9999)
    setElementCollisionsEnabled(--UI.veh,false)
    setVehicleColor(--UI.veh,color[1],color[2],color[3],color[4],color[5],color[6])

    for i,v in pairs(tune) do
        addVehicleUpgrade(--UI.veh,v)
    end

    --UI.preVeh=exports.object_preview:createObjectPreview(--UI.veh, -5, 0, 150, 890/zoom, 20/zoom, 250/zoom, 250/zoom,false,true)
end

--UI.onRender=function()
    local width=80+#--UI.vehs*50
    dxDrawRectangle(80/zoom, 80/zoom, 420/zoom, width/zoom, tocolor(31, 31, 42, 235))
    dxDrawImage(80/zoom, 80/zoom, 420/zoom, 80/zoom, assets.textures[11], 0, 0, 0, tocolor(255, 255, 255, 222))
    dxDrawTextShadow("PRZECHOWALNIA", 80/zoom, 80/zoom, 420/zoom+80/zoom, 80/zoom+80/zoom, tocolor(200, 200, 200, 255), 1, assets.fonts[1], "center", "center", false)    
    dxDrawImage(80/zoom, 80/zoom+80/zoom-1, 420/zoom, 1, assets.textures[2], 0,0,0,tocolor(255, 255, 255, 255))

    local k=0
    for i,v in pairs(--UI.vehs) do
        if(not v.alpha)then
            v.alpha=0
            v.animate=false
        end

        local sY=(50/zoom)*(i-1)

        dxDrawImage(80/zoom, 160/zoom+sY, 331/zoom, 50/zoom, assets.textures[5], 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(80/zoom, 160/zoom+sY, 50/zoom, 50/zoom, tocolor(31, 31, 42, 255), false)

        dxDrawRectangle(100/zoom-20/zoom, 160/zoom+sY, 420/zoom, 50/zoom, tocolor(72, 70, 88, v.alpha))
        -- alpha
        if(isMouseInPosition(100/zoom-20/zoom, 160/zoom+sY, 420/zoom, 50/zoom) and not v.animate)then
            v.animate=true
          
            animate(v.alpha, 50, "Linear", 200, function(a)
                if(v.animate)then
                    v.alpha = a
                end
            end)
        elseif(not isMouseInPosition(100/zoom-20/zoom, 160/zoom+sY, 420/zoom, 50/zoom) and v.animate)then
            v.animate = false

            animate(v.alpha, 0, "Linear", 200, function(a)
                if(not v.animate)then
                    v.alpha = a
                end
            end)
        end
        --

        local w,h=26,23
        w,h=w/1.1,h/1.1
        dxDrawImage(80/zoom+(50-w)/2/zoom, 160/zoom+sY+(50-h)/2/zoom, w/zoom, h/zoom, assets.textures[4], 0, 0, 0, tocolor(200, 200, 200, 255), false)
        if(--UI.selected_veh == i and --UI.click_veh)then
            dxDrawImage(80/zoom, 160/zoom+sY+50/zoom-1, 420/zoom, 1, assets.textures[2], 0, 0, 0, tocolor(255, 255, 255))
        else
            dxDrawRectangle(80/zoom, 160/zoom+sY+50/zoom-1, 420/zoom, 1, tocolor(72, 70, 88, 100))
        end

        if(isMouseInPosition(100/zoom, 160/zoom+sY, 420/zoom, 50/zoom))then
            onClick(100/zoom, 160/zoom+sY, 420/zoom, 50/zoom, function()
                --UI.click_veh=not --UI.click_veh
                --UI.selected_veh=i
            end)
            
            k=k+1

            if(not --UI.selected_veh or --UI.selected_veh and --UI.selected_veh ~= i)then
                --UI.click_veh=false

                if(not --UI.selected_veh)then
                    --UI.--buttons[1] = --buttons:createButton(890/zoom, 318/zoom, 200/zoom, 35/zoom, "WYCIĄGNIJ", 255, 11/zoom)

                    --UI.createVehicle(v)
                else
                    exports.object_preview:destroyObjectPreview(--UI.preVeh)
                    destroyElement(--UI.veh)

                    --UI.createVehicle(v)
                end

                --UI.selected_veh=i
            end
        end

        dxDrawText("["..v.id.."] "..getVehicleNameFromModel(v.model), 140/zoom, 160/zoom+sY, 420/zoom, 50/zoom+160/zoom+sY, tocolor(200,200,200,255), 1, assets.fonts[2], "left", "center", false, false, false, true)  
    end
    
    if(k == 0 and not --UI.click_veh and --UI.selected_veh)then
        --UI.selected_veh=false

        --buttons:destroyButton(--UI.--buttons[1])

        exports.object_preview:destroyObjectPreview(--UI.preVeh)
        destroyElement(--UI.veh)
    end

    if(--UI.selected_veh)then
        local v=--UI.vehs[--UI.selected_veh]
        if(v)then
            dxDrawRectangle(520/zoom, 80/zoom, 600/zoom, 290/zoom, tocolor(31, 31, 42, 235), false)
            dxDrawText(getVehicleNameFromModel(v.model), 550/zoom, 100/zoom, 600/zoom, 420/zoom, tocolor(150, 150, 150, 255), 1, assets.fonts[1], "left", "top", false)    

            local color=fromJSON(v.color)
            local light=fromJSON(v.lightColor)
            local hand=getOriginalHandling(v.model)
            local driveType=#v.driveType > 0 and v.driveType or hand.driveType

            local info="- #828282ID:#cecece "..v.id.."\n- #828282Paliwo:#cecece "..math.floor(v.fuel).."L\n- #828282Bak:#cecece "..v.bak.."L\n- #828282Typ paliwa:#cecece "..v.type.."\n- #828282Przebieg:#cecece "..v.distance..".0km\n- #828282Napęd: #cecece"..string.upper(driveType)
            dxDrawText(info, 550/zoom, 130/zoom, 600/zoom, 420/zoom, tocolor(200,200,200,255), 1, assets.fonts[3], "left", "top", false, false, false, true)
        
            dxDrawRectangle(520/zoom, 80/zoom+290/zoom-70/zoom, 600/zoom, 1, tocolor(72, 70, 88, 100))

            dxDrawImage(520/zoom+18/zoom, 80/zoom+290/zoom-60/zoom, 35/zoom, 35/zoom, assets.textures[6], 0, 0, 0, tocolor(color[1],color[2],color[3]))
            dxDrawText("Kolor 1", 520/zoom+25/zoom, 80/zoom+290/zoom-50/zoom, 20/zoom+520/zoom+25/zoom, 20/zoom+80/zoom+290/zoom-50/zoom+20/zoom, tocolor(200, 200, 200), 1, assets.fonts[5], "center", "bottom", false, false, false, true)
            dxDrawImage(520/zoom+89/zoom, 80/zoom+290/zoom-60/zoom, 35/zoom, 35/zoom, assets.textures[6], 0, 0, 0, tocolor(color[4],color[5],color[6]))
            dxDrawText("Kolor 2", 520/zoom+97/zoom, 80/zoom+290/zoom-50/zoom, 20/zoom+520/zoom+97/zoom, 20/zoom+80/zoom+290/zoom-50/zoom+20/zoom, tocolor(200, 200, 200), 1, assets.fonts[5], "center", "bottom", false, false, false, true)
            dxDrawImage(520/zoom+162/zoom, 80/zoom+290/zoom-60/zoom, 35/zoom, 35/zoom, assets.textures[6], 0, 0, 0, tocolor(light[1],light[2],light[3]))
            dxDrawText("Światła", 520/zoom+170/zoom, 80/zoom+290/zoom-50/zoom, 20/zoom+520/zoom+170/zoom, 20/zoom+80/zoom+290/zoom-50/zoom+20/zoom, tocolor(200, 200, 200), 1, assets.fonts[5], "center", "bottom", false, false, false, true)

            dxDrawImage(520/zoom+20/zoom+50/zoom, 80/zoom+290/zoom-55/zoom, 1, 40/zoom, assets.textures[3], 0, 0, 0, tocolor(100, 100, 100))
            dxDrawImage(520/zoom+20/zoom+120/zoom, 80/zoom+290/zoom-55/zoom, 1, 40/zoom, assets.textures[3], 0, 0, 0, tocolor(100, 100, 100))

            dxDrawImage(1050/zoom-20/zoom, 250/zoom-20/zoom, 43/zoom, 43/zoom, assets.textures[10], 0, 0, 0, tocolor(150, 150, 150), false)
            if(v.silnik > 0)then
                dxDrawImage(1050/zoom-20/zoom, 250/zoom-20/zoom, 43/zoom, 43/zoom, assets.textures[6+v.silnik], 0, 0, 0, tocolor(11, 150, 65), false)
            end
            dxDrawText("US", 1050/zoom-20/zoom, 250/zoom-20/zoom, 43/zoom+1050/zoom-20/zoom, 43/zoom+250/zoom-20/zoom, tocolor(200, 200, 200), 1, assets.fonts[5], "center", "center", false)
            dxDrawText(v.silnik.."/4", 1050/zoom-20/zoom, 250/zoom-20/zoom, 43/zoom+1050/zoom-20/zoom, 20/zoom+250/zoom+22/zoom, tocolor(200, 200, 200), 1, assets.fonts[5], "center", "bottom", false)

            dxDrawImage(1050/zoom-20/zoom-60/zoom, 250/zoom-20/zoom, 43/zoom, 43/zoom, assets.textures[10], 0, 0, 0, tocolor(150, 150, 150), false)
            if(v.hamulce > 0)then
                dxDrawImage(1050/zoom-20/zoom-60/zoom, 250/zoom-20/zoom, 43/zoom, 43/zoom, assets.textures[6+v.hamulce], 0, 0, 0, tocolor(11, 150, 65), false)
            end
            dxDrawText("UH", 1050/zoom-20/zoom-60/zoom, 250/zoom-20/zoom, 43/zoom+1050/zoom-20/zoom-60/zoom, 43/zoom+250/zoom-20/zoom, tocolor(200, 200, 200), 1, assets.fonts[5], "center", "center", false)
            dxDrawText(v.hamulce.."/4", 1050/zoom-20/zoom-60/zoom, 250/zoom-20/zoom, 43/zoom+1050/zoom-20/zoom-60/zoom, 20/zoom+250/zoom+22/zoom, tocolor(200, 200, 200), 1, assets.fonts[5], "center", "bottom", false)

            dxDrawImage(1050/zoom-20/zoom-120/zoom, 250/zoom-20/zoom, 43/zoom, 43/zoom, assets.textures[10], 0, 0, 0, tocolor(150, 150, 150), false)
            if(v.trakcja > 0)then
                dxDrawImage(1050/zoom-20/zoom-120/zoom, 250/zoom-20/zoom, 43/zoom, 43/zoom, assets.textures[6+v.trakcja], 0, 0, 0, tocolor(11, 150, 65), false)
            end
            dxDrawText("UT", 1050/zoom-20/zoom-120/zoom, 250/zoom-20/zoom, 43/zoom+1050/zoom-20/zoom-120/zoom, 43/zoom+250/zoom-20/zoom, tocolor(200, 200, 200), 1, assets.fonts[5], "center", "center", false)
            dxDrawText(v.trakcja.."/4", 1050/zoom-20/zoom-120/zoom, 250/zoom-20/zoom, 43/zoom+1050/zoom-20/zoom-120/zoom, 20/zoom+250/zoom+22/zoom, tocolor(200, 200, 200), 1, assets.fonts[5], "center", "bottom", false)

            onClick(890/zoom, 318/zoom, 200/zoom, 35/zoom, function()
                triggerServerEvent("get.vehicle", resourceRoot, v.id)

                removeEventHandler("onClientRender",root,--UI.onRender)
                showChat(true)
        
                assets.destroy()
        
                --buttons:destroyButton(--UI.--buttons[1])
        
                showCursor(false)
        
                if(--UI.veh and --UI.preVeh and isElement(--UI.veh) and isElement(--UI.preVeh))then
                    exports.object_preview:destroyObjectPreview(--UI.preVeh)
                    destroyElement(--UI.veh)
                end

                setElementData(localPlayer, "user:gui_showed", false, false)
            end)
        end
    end
end

addEvent("get.vehicles", true)
addEventHandler("get.vehicles", resourceRoot, function(vehs)
    if(vehs)then
        if(getElementData(localPlayer, "user:gui_showed"))then return end

        assets.create()

        addEventHandler("onClientRender",root,--UI.onRender)
        showChat(false)

        showCursor(true,false)

        --UI.vehs=vehs

        --UI.selected_veh=false
        --UI.click_veh=false

        setElementData(localPlayer, "user:gui_showed", resourceRoot, false)
    else
        removeEventHandler("onClientRender",root,--UI.onRender)
        showChat(true)

        assets.destroy()

        --buttons:destroyButton(--UI.--buttons[1])

        showCursor(false)

        if(--UI.veh and --UI.preVeh and isElement(--UI.veh) and isElement(--UI.preVeh))then
            exports.object_preview:destroyObjectPreview(--UI.preVeh)
            destroyElement(--UI.veh)
        end

        setElementData(localPlayer, "user:gui_showed", false, false)
    end
end)

-- by asper

assets.create = function()
    for k,t in pairs(assets) do
        if(k=="fonts_paths")then
            for i,v in pairs(t) do
                assets.fonts[i] = dxCreateFont(v[1], v[2]/zoom)
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

local shadow = tocolor(0,0,0,100)

function dxDrawTextShadow( text, x, y, w, h, color, fontSize, fontType, alignX, alignY )
	dxDrawText( text, x+1, y+1, w, h, shadow, fontSize, fontType, alignX, alignY )
	dxDrawText( text, x-1, y+1, w, h, shadow, fontSize, fontType, alignX, alignY )
	dxDrawText( text, x-1, y-1, w, h, shadow, fontSize, fontType, alignX, alignY )
 	dxDrawText( text, x+1, y-1, w, h, shadow, fontSize, fontType, alignX, alignY )

 	dxDrawText( text, x, y, w, h, color, fontSize, fontType, alignX, alignY )
end

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

function RGBToHex(red, green, blue, alpha)
	
	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end

	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end

end

addEventHandler("onClientResourceStop", resourceRoot, function()
    local gui = getElementData(localPlayer, "user:gui_showed")
    if(gui and gui == source)then
        setElementData(localPlayer, "user:gui_showed", false, false)
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
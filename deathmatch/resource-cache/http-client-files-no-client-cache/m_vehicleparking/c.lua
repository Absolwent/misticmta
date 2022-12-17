local sw,sh = guiGetScreenSize()
local zoom = 1920/sw

local back = dxCreateTexture("textures/back.png", "argb", false, "clamp")
local circle = dxCreateTexture("textures/circle.png", "argb", false, "clamp")

local showed = false

local vehs = {}

local rt = dxCreateRenderTarget(520/zoom, 450/zoom, true)

local screenY = 0

local font = dxCreateFont("fonts/Roboto-Regular.ttf", 10)
local font2 = dxCreateFont("fonts/Roboto-Regular.ttf", 10)

-- useful function created by Asper

function isMouseInPosition(x, y, w, h)
    if not isCursorShowing() then return end
            
    local mouse = {getCursorPosition()}
    local myX, myY = (mouse[1] * sw), (mouse[2] * sh)
    if (myX >= x and myX <= (x + w)) and (myY >= y and myY <= (y + h)) then
        return true
    end
            
    return false
end
        
local click = false
function onClick(x, y, w, h, called)
    if(isMouseInPosition(x, y, w, h) and not click and getKeyState("mouse1"))then
        click = true
        called()
    elseif(not getKeyState("mouse1") and click)then
        click = false
    end
end
        
--

function onRender()
    dxDrawImage(sw/2-569/2/zoom, sh/2-646/2/zoom, 569/zoom, 646/zoom, back)

    dxSetRenderTarget(rt, true)
        for i,v in pairs(vehs) do
            local sY = (55/zoom)*(i-1)

            sY = sY+screenY

            dxDrawRectangle(0, sY, 520/zoom, 50/zoom, tocolor(20, 20, 30, 200))
            dxDrawText(getVehicleNameFromModel(v.model).." ["..v.id.."]", 10/zoom, sY, 520/zoom, 50/zoom+sY, tocolor(200, 200, 200), 1, font, "left", "center")
            dxDrawText("Przebieg: "..v.distance.."km\nPaliwo: "..v.fuel.."L", 150/zoom, sY, 520/zoom, 50/zoom+sY, tocolor(100, 100, 100), 1, font2, "left", "center")

            dxDrawText("ODBIERZ", 150/zoom, sY, 470/zoom, 50/zoom+sY, tocolor(100, 100, 100), 1, font2, "right", "center")
            dxDrawImage(480/zoom, sY+25/2/zoom, 25/zoom, 25/zoom, circle)

            onClick(sw/2-520/2/zoom+480/zoom, sh/2-390/2/zoom+sY+25/2/zoom, 25/zoom, 25/zoom, function()
                triggerServerEvent("get:veh", resourceRoot, v.id)

                removeEventHandler("onClientRender", root, onRender)
                showCursor(false)
        
                showed = false
            end)
        end
    dxSetRenderTarget()    
    dxDrawImage(sw/2-520/2/zoom, sh/2-390/2/zoom, 520/zoom, 450/zoom, rt)
end

addEvent("get:vehicles", true)
addEventHandler("get:vehicles", resourceRoot, function(v)
    if(showed and not v)then
        removeEventHandler("onClientRender", root, onRender)
        showCursor(false)

        showed = false
    else
        if(v)then
            addEventHandler("onClientRender", root, onRender)
            showCursor(true, false)

            showed = true

            vehs = v
        end
    end
end)

bindKey("mouse_wheel_up", "down", function()
    if(not showed)then return end

    screenY = screenY+50
    if(screenY > 0)then
        screenY = 0
    end
end)


bindKey("mouse_wheel_down", "down", function()
    if(not showed)then return end

    screenY = screenY-50
end)
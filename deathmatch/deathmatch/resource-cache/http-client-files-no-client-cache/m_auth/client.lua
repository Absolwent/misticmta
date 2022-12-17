local sx,sy = guiGetScreenSize()
local px,py = (sx/1920),(sy/1080)

local blod = exports["m_gui"]:getFont("regular", 18*px)

function loadAuthRender()
    if getElementData(localPlayer, "playing") then return end
    dxDrawText("Panel logowania jest widoczny", 100*px, 350*py, 300*px, 350*py, tocolor(255, 255, 0), 1, blod)
end
addEvent("loadAuthRender", true)
addEventHandler("onClientRender", root, loadAuthRender)

function showAuthPanel()
    if getElementData(localPlayer, "playing") then return end
    showCursor(true)
    showChat(false)
end
addEventHandler("onClientResourceStart", root, showAuthPanel)
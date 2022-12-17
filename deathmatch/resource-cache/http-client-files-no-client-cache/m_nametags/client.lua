local sw,sh=guiGetScreenSize()

local auta = exports["m_gui"]:getFont("Montserrant_r", 10)
local nametagFont = exports["m_gui"]:getFont("Montserrant_r", 14)
local nametagFontBold = exports["m_gui"]:getFont("Montserrant_b", 14)

local fontHeight=dxGetFontHeight(1, nametagFont)
local nametagScale = 0.7
local nametagAlpha = 255
local nametagColor =
{
    r = 255,
    g = 255,
    b = 255
} 

local icons = {
    [1] = "files/icon_admin.png",
}

local hp_width=math.floor(sw/20)
if hp_width<50 then hp_width=50 end
local hp_height=math.floor(hp_width/10)

local gsize=sw>800 and 32 or 16

local ourlevel=0
local ourfid=""

function renderNametag()
local rootx, rooty, rootz = getCameraMatrix()
local ctrl=getKeyState("lalt") or getKeyState("ralt") or getKeyState("lctrl") or getKeyState("rctrl")
for i, player in ipairs(getElementsByType("player",root,true)) do
    if player ~= localPlayer and (getElementAlpha(player)>50 or ourlevel>1 or getElementDimension(player)==901) then
        local x,y,z = getPedBonePosition(player,8)
        local sx, sy = getScreenFromWorldPosition(x, y, z+0.5)
        if sx then
            local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)
            if getElementAlpha(player) < 1 and not getElementData(localPlayer,"rank") then
            return end
	    local pID = getElementData(player, "id")
            local pName = getPlayerName(player)
            local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)
            local fX = math.floor(sx)
            local fY = math.floor(sy)
            local alpha = 120
            local level = tonumber(getElementData(player, "rank"))
            if (distance<=15 or (player and player==localPlayer)) then	
            if level == 1 then
                dxDrawText(""..pName.." ("..pID..")", fX+1-30, fY+1, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)
                dxDrawText(""..pName.." #00b2bf("..pID..")", fX-30, fY, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)

                dxDrawText("Support", fX+1-30, fY+1+27, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
                dxDrawText("#00b2bfSupport", fX-30, fY+27, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
                --dxDrawImage(fX-27, fY-30, 21,21, icons[1], 0,0,0, tocolor(0, 178, 191,255))

            elseif level == 2 then
                dxDrawText(""..pName.." ("..pID..")", fX+1-30, fY+1, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)
                dxDrawText(""..pName.." #22d658("..pID..")", fX-30, fY, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)

                dxDrawText("Moderator", fX+1-30, fY+1+27, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
                dxDrawText("#22d658Moderator", fX-30, fY+27, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)

            elseif level == 3 then
                dxDrawText(""..pName.." ("..pID..")", fX+1-30, fY+1, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)
                dxDrawText(""..pName.." #ba0000("..pID..")", fX-30, fY, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)

                dxDrawText("Administrator", fX+1-30, fY+1+27, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
                dxDrawText("#ba0000Administrator", fX-30, fY+27, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)

            elseif level == 4 then
                dxDrawText(""..pName.." ("..pID..")", fX+1-30, fY+1, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)
                dxDrawText(""..pName.." #3b46e3("..pID..")", fX-30, fY, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)

                dxDrawText("Guardian", fX+1-30, fY+1+27, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
                dxDrawText("#3b46e3Guardian", fX-30, fY+27, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)

            elseif level == 5 then
                dxDrawText(""..pName.." ("..pID..")", fX+1-30, fY+1, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)
                dxDrawText(""..pName.." #89009e("..pID..")", fX-30, fY, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)

                dxDrawText("Developer", fX+1-30, fY+1+27, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
                dxDrawText("#89009eDeveloper", fX-30, fY+27, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)

            elseif level == 6 then
                dxDrawText(""..pName.." ("..pID..")", fX+1-25, fY+1, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)
                dxDrawText(""..pName.." #6b0020("..pID..")", fX-25, fY, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)

                dxDrawText("CEO", fX+1-25, fY+1+27, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
                dxDrawText("#6b0020CEO", fX-25, fY+27, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
            elseif getElementData(player, "premium") == "1" then
                dxDrawText(""..pName.." ("..pID..")", fX+1-30, fY+1, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)
                dxDrawText(""..pName.." #5fa0a0("..pID..")", fX-30, fY, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)

                dxDrawText("Premium", fX+1-30, fY+1+27, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
                dxDrawText("#5fa0a0Premium", fX-30, fY+27, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
            else
                dxDrawText(""..pName.." ("..pID..")", fX+1-30, fY+1, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)
                dxDrawText(""..pName.." #808080("..pID..")", fX-30, fY, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFontBold, "left", "center",false,false,false,true,true)

                dxDrawText("Gracz", fX+1-30, fY+1+27, fX+1, fY+1, tocolor(0,0,0, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
                dxDrawText("#808080Gracz", fX-30, fY+27, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFont, "left", "center",false,false,false,true,true)
            end
            end
	    end
        end
    end
end
addEventHandler("onClientRender", root, renderNametag)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
    function()
        for k, v in ipairs(getElementsByType("player")) do
            setPlayerNametagShowing ( v, false )
        end
    end
)

addEventHandler("onClientPlayerJoin", root, 
    function()
        setPlayerNametagShowing ( source, false )
    end
)
local colors = {
    [4] = "#5238d6", -- rcon
    [3] = "#b54628", -- admina
    [2] = "#1fad5d", -- mod
    [1] = "#108bde", -- tmod
}

local premiumColor = {
    [true] = "#bda20a",
    [false] = "#37474F",
}

local sw,sh = guiGetScreenSize()
local gsize=sw>800 and 32 or 16


local img = {
    [4] = "img/rcon.png",
    [3] = "img/admin.png",
    [2] = "img/mod.png",
    [1] = "img/kmod.png",
}

local font = dxCreateFont("roboto_light.ttf",13)
local font1 = dxCreateFont(":ys-gui-prace/Poppins_Light.ttf", 14, false, "cleartype_natural");
local font2 = dxCreateFont(":ys-gui-prace/Poppins_Regular.ttf", 16, false, "cleartype_natural");
local font3 = dxCreateFont(":ys-gui-prace/Poppins_Regular.ttf", 13, false, "cleartype_natural");

local id = {}
local premium = {}
local rangaP = {}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        render = dxCreateRenderTarget(100000,100000,true)
        for k, v in ipairs(getElementsByType("player")) do
            setPlayerNametagShowing ( v, false )
        end
    end
)




addEventHandler("onClientMinimize",root,function()
    triggerServerEvent('set:minimize',localPlayer, localPlayer,true)
end)

addEventHandler("onClientRestore",root,function()
    triggerServerEvent('set:minimize',localPlayer,localPlayer,false)
end)


addEventHandler("onClientRestore",root,function()
    render = dxCreateRenderTarget(100000,100000,true)
end)



addEventHandler("onClientPlayerJoin", root, 
--addEventHandler("onClientPlayerSpawn", getRootElement(), 
    function()
        setPlayerNametagShowing ( source, false )
    end
)


addEventHandler("onClientRender", root, function()
    local pX,pY,pZ = getElementPosition(localPlayer)
    local x,y,z = getCameraMatrix()
    for i,v in ipairs(getElementsWithinRange(pX,pY,pZ,300,'player')) do 
            if not id[v] or not premium[v] or not rangaP[v] then 
                id[v] =  getElementData(v,"id") 
                premium[v] = getElementData(v,"player:premium")
                rangaP[v] = getElementData(v,"player:adminlevel")
            end
            if getPlayerName(localPlayer) ~= getPlayerName(v) then 
                local cX, cY, cZ = getPedBonePosition(v,5)
                local distance = getDistanceBetweenPoints3D(x,y,z,cX,cY,cZ)
                if (distance <= 18) then
                    local sx, sy = getScreenFromWorldPosition(cX,cY,cZ+0.6)
                    if sx and sy then
                        local fX = math.floor(sx) 
                        local fY = math.floor(sy)
                        local icons = {}
                        local ranga = rangaP[v]
                        local premium = premium[v]
                        local health = getElementHealth(v)
                        local writing = getElementData(v,"chat_typing")
                        local minimalized = getElementData(v,"player:minimalize")
                        local is_duty = getElementData(v, "player:onduty")
                        if getElementAlpha(v) == 0 then 
                            return
                        end
                        dxSetRenderTarget(render)
                        if writing then 
                            table.insert(icons,{file="img/czat.png", level = 5})
                        end
                        if ranga then
                            dxDrawText(getPlayerName(v).. " ("..id[v]..")",fX,fY+18,fX,fY+18,tocolor(0,0,0),1.025,font2,"center","center",false,false,false,true,false) 
                            dxDrawText("#B0BEC5"..getPlayerName(v).." "..premiumColor[premium].."("..colors[ranga]..""..id[v]..""..premiumColor[premium]..")",fX,fY+18,fX,fY+18,tocolor(255,255,255),1,font2,"center","center",false,false,false,true,true) 
                        else
                            dxDrawText("#B0BEC5"..getPlayerName(v).." "..premiumColor[premium].."(#ffffff"..id[v]..""..premiumColor[premium]..")",fX,fY+18,fX,fY+18,tocolor(255,255,255),1,font2,"center","center",false,false,false,true,true) 
                        end
                        if is_duty then
                            table.insert(icons,{file = img[ranga], level = 100})
                        end
                        if minimalized and minimalized ~= false then
                          dxDrawText("Gracz zminimalizowany od "..(minimalized).." sekund",fX,fY-45,fX,fY-45,tocolor(233,60,0),1.025,font3,"center","center",false,false,false,true,false) 
                        end
                        if health < 20 then 
                            table.insert(icons,{file = "img/hp.png", level = 10})
                        end
                        if premium then 
                            table.insert(icons,{file="img/vip.png", level = 50})
                        end
                        if #icons == 1 then 
                            dxDrawImage(fX-15, fY-30, 32, 32, icons[1].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                        elseif #icons == 2 then 
                            table.sort(icons,function(a,b) return a.level>b.level end )
                            dxDrawImage(fX-40, fY-30, 32, 32, icons[1].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                            dxDrawImage(fX+5, fY-30, 32, 32, icons[2].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                        elseif #icons == 3 then 
                            table.sort(icons,function(a,b) return a.level>b.level end )
                            dxDrawImage(fX-55, fY-30, 32, 32, icons[1].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                            dxDrawImage(fX-15, fY-30, 32, 32, icons[2].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                            dxDrawImage(fX+25, fY-30, 32, 32, icons[3].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                        elseif #icons > 3 then
                            table.sort(icons,function(a,b) return a.level>b.level end )
                            dxDrawImage(fX-75, fY-30, 32, 32, icons[1].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                            dxDrawImage(fX-35, fY-30, 32, 32, icons[2].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                            dxDrawImage(fX+5, fY-30, 32, 32, icons[3].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                            dxDrawImage(fX+45, fY-30, 32, 32, icons[4].file, 0, 0, 0, tocolor(255, 255, 255, 255))
                        end
                        
                        icons = {}
                        dxSetRenderTarget()
                    end
                end
            end
        end
    --end
end)


function checkPlayerChatTyping()
	if isChatBoxInputActive() then
		if getElementData(localPlayer, "chat_typing")==false then
			setElementData(localPlayer, "chat_typing", true)
		end
	else
		if getElementData(localPlayer, "chat_typing")==true then
			setElementData(localPlayer, "chat_typing", false)
		end
	end
end
setTimer(checkPlayerChatTyping, 100, 0)

function checkPlayerOnDuty()
    if getElementData(localPlayer, "player:admin") then
        if getElementData(localPlayer, "player:onduty") == false then
            setElementData(localPlayer, "player:onduty", true)
        end
    else
        if getElementData(localPlayer, "player:onduty") == true then
            setElementData(localPlayer, "player:onduty", false)
        end
    end
end
setTimer(checkPlayerOnDuty, 100, 0)

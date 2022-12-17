local sx, sy = guiGetScreenSize()
local zoom = sx < 1920 and math.min(2, 1920 / sx) or 1



local hud = {}

function format(val)
    local left,num,right = string.match(val,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end





hud.avatarbg = {sx - 160/zoom, 34/zoom, 127/zoom , 127/zoom};
hud.bgbar1 = {hud.avatarbg[1] - 136/zoom, 50/zoom, 166/zoom, 8/zoom};
hud.bgbar2 = {hud.avatarbg[1] - 150/zoom, 65/zoom, 166/zoom, 8/zoom};
hud.bgbar3 = {hud.avatarbg[1] - 164/zoom, 80/zoom, 166/zoom, 8/zoom};
hud.lvlbar = {sx - 348/zoom, 102/zoom, 210/zoom, 31/zoom};
hud.lvlbg = {sx - 347/zoom, 104/zoom, 200/zoom, 19/zoom};
hud.txtlvl = {sx - 209/zoom, hud.lvlbar[2]+5/zoom, 46/zoom, 18/zoom};
hud.txtlevel = {sx - 229/zoom, hud.lvlbar[2]+4/zoom, 46/zoom, 18/zoom};
hud.money = {sx - 372/zoom, 133/zoom, 225/zoom, 22/zoom};

hud.ammo = {sx - 195/zoom, 175/zoom, 48/zoom, 23/zoom};
hud.clip = {sx - 195/zoom, 200/zoom, 48/zoom, 23/zoom};
hud.weapon = {sx - 390/zoom, 165/zoom, 194/zoom, 97/zoom};

hud.avatar = {sx - 144/zoom, 57/zoom, 90/zoom, 90/zoom};

local hp = dxCreateTexture("img/hp-bar.png","argb",false,"clamp");
local armor = dxCreateTexture("img/shield-bar.png","argb",false,"clamp");
local oxygen = dxCreateTexture("img/air-bar.png","argb",false,"clamp");
local lvlbar = dxCreateTexture("img/lvl-bar.png","argb",false,"clamp");
local font = dxCreateFont("font.ttf",10/zoom,false,"antialiased");
local font2 = dxCreateFont("font.ttf",15/zoom,false,"antialiased");
local font3 = dxCreateFont("font.ttf", 17/zoom, false,"antialiased");
local font4 = dxCreateFont("font.ttf", 13/zoom, false,"antialiased");

local render = function()
    dxDrawImage(hud.avatarbg[1],hud.avatarbg[2],hud.avatarbg[3],hud.avatarbg[4],"img/skin-bg.png")
    dxDrawImage(hud.bgbar1[1],hud.bgbar1[2],hud.bgbar1[3],hud.bgbar1[4],"img/bg-bar.png")
    dxDrawImage(hud.bgbar2[1],hud.bgbar2[2],hud.bgbar2[3],hud.bgbar2[4],"img/bg-bar.png")
    dxDrawImage(hud.bgbar3[1],hud.bgbar3[2],hud.bgbar3[3],hud.bgbar3[4],"img/bg-bar.png")

    --HP
    if math.floor(getElementHealth(localPlayer)) < math.floor(info.hp) then
        info.hp = info.hp - 0.8
    elseif math.floor(getElementHealth(localPlayer)) > math.floor(info.hp) then
        info.hp = info.hp + 0.8
    end
    dxDrawImageSection(hud.bgbar1[1],hud.bgbar1[2],hud.bgbar1[3]*(info.hp/100),hud.bgbar1[4], 0, 0, 166*(info.hp/100),8,hp)


    --Shield
    if math.floor(getPedArmor(localPlayer)) < math.floor(info.shield) then
        info.shield = info.shield - 0.8
    elseif math.floor(getPedArmor(localPlayer)) > math.floor(info.shield) then
        info.shield = info.shield + 0.8
    end


    dxDrawImageSection(hud.bgbar2[1],hud.bgbar2[2],hud.bgbar2[3]*(info.shield/100),hud.bgbar2[4], 0, 0, 166*(info.shield/100),8,armor)

    --Air
    dxDrawImageSection(hud.bgbar3[1],hud.bgbar3[2],hud.bgbar3[3]*(getPedOxygenLevel(localPlayer)/1000),hud.bgbar3[4], 0, 0, 166*(getPedOxygenLevel(localPlayer)/1000),8,oxygen)

    --Level
    local data = getElementData(localPlayer,"level:data") or {1,0}
    local need_exp = exps[tonumber(data[1])]
    dxDrawImage(hud.lvlbar[1],hud.lvlbar[2],hud.lvlbar[3],hud.lvlbar[4],"img/lvl-bg.png")
    dxDrawImageSection(hud.lvlbg[1],hud.lvlbg[2],hud.lvlbg[3]*(data[2]/need_exp),hud.lvlbg[4], 0, 0, 200*(data[2]/need_exp), 19, lvlbar, 0, 0, 0, tocolor(255,255,255,255))
    --dxDrawText("21 lvl", hud.lvlbg[1]-15/zoom,hud.lvlbg[2]+1/zoom,hud.lvlbg[3]+hud.lvlbg[1]-15/zoom,hud.lvlbg[4]+hud.lvlbg[2]+1/zoom, tocolor(255, 255, 255, 255), 0.50, font, "right", "center", false, false, false, false, false)
    dxDrawText("LVL", hud.txtlvl[1]+1,hud.txtlvl[2]+1,hud.txtlvl[3]+hud.txtlvl[1]+1,hud.txtlvl[4]+hud.txtlvl[2]+1, tocolor(0, 0, 0, 150), 0.5, font, "right", "center", false, false, false, false, false)
    dxDrawText("LVL", hud.txtlvl[1],hud.txtlvl[2],hud.txtlvl[3]+hud.txtlvl[1],hud.txtlvl[4]+hud.txtlvl[2], tocolor(255, 255, 255, 255), 0.5, font, "right", "center", false, false, false, false, false)
    
    dxDrawText(data[1], hud.txtlevel[1]+1,hud.txtlevel[2]+1,hud.txtlevel[3]+hud.txtlevel[1]+1,hud.txtlevel[4]+hud.txtlevel[2]+1, tocolor(0, 0, 0, 150), 0.5, font2, "right", "center", false, false, false, false, false)
    dxDrawText(data[1], hud.txtlevel[1],hud.txtlevel[2],hud.txtlevel[3]+hud.txtlevel[1],hud.txtlevel[4]+hud.txtlevel[2], tocolor(255, 255, 255, 255), 0.5, font2, "right", "center", false, false, false, false, false)



    --Money
    if tonumber(info.money) ~= tonumber(getPlayerMoney(localPlayer)) then
        local checkMoney = info.money - getPlayerMoney(localPlayer)
        if checkMoney == math.abs(checkMoney) then
            if tonumber(info.money-getPlayerMoney(localPlayer))>1000000 then
                info.money = info.money - 100000
            elseif tonumber(info.money-getPlayerMoney(localPlayer))>100000 then
                info.money = info.money - 10000
            elseif tonumber(info.money-getPlayerMoney(localPlayer))>10000 then
                info.money = info.money - 1000
            elseif tonumber(info.money-getPlayerMoney(localPlayer))>1000 then
                info.money=info.money-100
            elseif tonumber(info.money-getPlayerMoney(localPlayer))>100 then
                info.money=info.money-10
            else
                info.money=info.money-1
            end
        else
            if tonumber(getPlayerMoney(localPlayer)-info.money)>1000000 then
                info.money = info.money + 100000
            elseif tonumber(getPlayerMoney(localPlayer)-info.money)>100000 then
                info.money = info.money + 10000
            elseif tonumber(getPlayerMoney(localPlayer)-info.money)>10000 then
                info.money = info.money + 1000
            elseif tonumber(getPlayerMoney(localPlayer)-info.money)>1000 then
                info.money=info.money+100
            elseif tonumber(getPlayerMoney(localPlayer)-info.money)>100 then
                info.money=info.money+10
            else
                info.money=info.money+1
            end
        end
    end

    dxDrawText("$ "..format(info.money), hud.money[1]+1, hud.money[2]+1, hud.money[3]+hud.money[1]+1, hud.money[4]+hud.money[2]+1, tocolor(0, 0, 0, 150), 0.50, font3, "right", "center", false, false, false, false, false)
    dxDrawText("#46E487$#ffffff "..format(info.money), hud.money[1], hud.money[2], hud.money[3]+hud.money[1], hud.money[4]+hud.money[2], tocolor(255, 255, 255, 255), 0.50, font3, "right", "center", false, false, false, true, false)


    --Weapons
    local wep = getPedWeapon(localPlayer)
    if wep and wep ~= 0 then
        local file = fileExists("img/wep/"..wep..".png")
        if file then
            dxDrawText(getPedAmmoInClip(localPlayer), hud.ammo[1], hud.ammo[2], hud.ammo[3]+hud.ammo[1], hud.ammo[4]+hud.ammo[2], tocolor(255, 255, 255, 255), 0.50, font3, "right", "bottom", false, false, false, false, false)
            dxDrawText(getPedTotalAmmo(localPlayer), hud.clip[1], hud.clip[2], hud.clip[3]+hud.clip[1], hud.clip[4]+hud.clip[2], tocolor(180, 180, 180, 255), 0.50, font4, "right", "top", false, false, false, false, false)
            dxDrawImage(hud.weapon[1],hud.weapon[2],hud.weapon[3],hud.weapon[4],"img/wep/"..wep..".png")
        end
    end

    --Avatar
    
    dxDrawImage(hud.avatar[1],hud.avatar[2],hud.avatar[3],hud.avatar[4], mask, 0, 0, 0, tocolor(255, 255, 255, 255), false)
end




addEventHandler("onClientResourceStart",resourceRoot,function()
    exps = exports["un-exp"]:importLevels()
    info = {
        hp = getElementHealth(localPlayer),
        shield = getPedArmor(localPlayer),
        oxygen = getPedOxygenLevel(localPlayer),
        money = getPlayerMoney(localPlayer),
    }
    new = getElementModel(localPlayer)
    if tonumber(new) < 100 then
        new = "0"..new
    elseif tonumber(new) < 10 then
        new = "00"..new
    end
    skin = dxCreateTexture("img/char/"..new..".png")
    mask = dxCreateShader("tex/mask.fx")
	mask_circle=dxCreateTexture("tex/circle_mask.png")
    dxSetShaderValue( mask, "sPicTexture", skin )
	dxSetShaderValue( mask, "sMaskTexture", mask_circle )
    addEventHandler("onClientRender",root,render)
end)

addEventHandler("onClientElementModelChange",root,function(_,new)
    if source==localPlayer then
        if getElementType(source) == "player" then
            if tonumber(new) < 100 then
                new = "0"..new
            elseif tonumber(new) < 10 then
                new = "00"..new
            end
            skin = dxCreateTexture("img/char/"..new..".png")
            dxSetShaderValue( mask, "sPicTexture", skin )
            dxSetShaderValue( mask, "sMaskTexture", mask_circle )
        end
    end
end)
if getElementData(localPlayer, "playing") then return end

local root = getRootElement()
local resourceRoot = getResourceRootElement(getThisResource())

local sx,sy = guiGetScreenSize()
local px,py = (sx/1920),(sy/1080)

local blod = exports["m_gui"]:getFont("popins_b", 38*px)
local regular = exports["m_gui"]:getFont("popins_r", 38*px)
local Smallregular = exports["m_gui"]:getFont("popins_r", 30*px)

local Mblod = exports["m_gui"]:getFont("Montserrant_b", 32*px)
local Mregular = exports["m_gui"]:getFont("Montserrant_r", 30*px)
local MSmallregular = exports["m_gui"]:getFont("Montserrant_r", 24*px)

local data={ showed=nil, }

local rMusic = math.random(1,3)
local pName = getPlayerName(localPlayer)
local pSerial = getPlayerSerial(localPlayer)

radarMegjelenitve = false

function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

local function wavelengthToRGBA(length) 
    local r, g, b, factor 
    if (length >= 380 and length < 440) then 
        r, g, b = -(length - 440)/(440 - 380), 0, 1 
    elseif (length < 489) then 
        r, g, b = 0, (length - 440)/(490 - 440), 1 
    elseif (length < 510) then 
        r, g, b = 0, 1, -(length - 510)/(510 - 490) 
    elseif (length < 580) then 
        r, g, b = (length - 510)/(580 - 510), 1, 0 
    elseif (length < 645) then 
        r, g, b = 1, -(length - 645)/(645 - 580), 0 
    elseif (length < 780) then 
        r, g, b = 1, 0, 0 
    else 
        r, g, b = 0, 0, 0 
    end 
    if (length >= 380 and length < 420) then 
        factor = 0.3 + 0.7*(length - 380)/(420 - 380) 
    elseif (length < 701) then 
        factor = 1 
    elseif (length < 780) then 
        factor = 0.3 + 0.7*(780 - length)/(780 - 700) 
    else 
        factor = 0 
    end 
    return r55, g55, b55, factor55 
end 

local pPassword = getElementData(localPlayer, "user:pass")
local startTime = getTickCount() 
function renderLoginAuthPanel()
    local progress = math.fmod(getTickCount() - startTime, 3000) / 3000 
    local length = interpolateBetween(400, 0, 0, 700, 0, 0, progress, "Linear") 
    local r, g, b = wavelengthToRGBA(length) 
    dxDrawImage(0, 0, 1920*px, 1080*py, "files/background.png")
    dxDrawImage(725*px, 285*py, 432*px, 588*py, "files/login_bg.png")

    -- Username
    if not isMouseIn(767*px, 425*py, 348*px, 55*py) then
        dxDrawImage(767*px, 425*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,175))
        dxDrawImage(1080*px, 445*py, 20*px, 15*py, "files/i_user.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawText("Nazwa użytkownika", 775*px, 427*py, 565*px, 325*py, tocolor(95,160,160,255), 0.4, MSmallregular, "left", "top", false, false, false, true)
    else 
        dxDrawImage(767*px, 425*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawImage(1080*px, 445*py, 20*px, 15*py, "files/i_user.png", 0,0,0, tocolor(95,160,160,255))
        dxDrawText("Nazwa użytkownika", 775*px, 427*py, 565*px, 325*py, tocolor(95,160,160,175), 0.4, MSmallregular, "left", "top", false, false, false, true)
    end

    -- Password
    if not isMouseIn(767*px, 500*py, 348*px, 55*py) then
        dxDrawImage(767*px, 500*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,175))
        dxDrawImage(1080*px, 516*py, 512*px/24, 512*py/24, "files/i_pass.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawText("Hasło do konta", 775*px, 502*py, 565*px, 325*py, tocolor(95,160,160,255), 0.4, MSmallregular, "left", "top", false, false, false, true)
    else
        dxDrawImage(767*px, 500*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawImage(1080*px, 516*py, 512*px/24, 512*py/24, "files/i_pass.png", 0,0,0, tocolor(95,160,160,255))
        dxDrawText("Hasło do konta", 775*px, 502*py, 565*px, 325*py, tocolor(95,160,160,175), 0.4, MSmallregular, "left", "top", false, false, false, true)
    end

    -- Other
    dxDrawText("Nie posiadasz konta?", 1320*px, 745*py, 565*px, 325*py, white, 0.4, Mregular, "center", "top", false, false, false, true)
    dxDrawText("Stwórz nowe konto", 1320*px, 765*py, 565*px, 325*py, tocolor(95,160,160,255), 0.45, Mblod, "center", "top", false, false, false, true)


    if not isMouseIn(767*px, 660*py, 348*px, 55*py) then
        dxDrawImage(767*px, 660*py, 348*px, 55*py, "files/huge_btn.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawText("Autoryzuj", 1325*px, 674*py, 565*px, 325*py, white, 0.4, Mblod, "center", "top", false, false, false, true)
    else
        dxDrawImage(767*px, 660*py, 348*px, 55*py, "files/huge_btn.png", 0,0,0, tocolor(255,255,255,175))
        dxDrawText("Autoryzuj", 1325*px, 674*py, 565*px, 325*py, tocolor(168, 168, 168,255), 0.4, Mblod, "center", "top", false, false, false, true)
    end

    dxDrawText("Zaloguj się na instniejące konto.", 767*px, 360*py, 565*px, 325*py, white, 0.4, Mregular, "left", "top", false, false, false, true)
    dxDrawText("Logowanie", 767*px, 330*py, 565*px, 325*py, white, 0.6, Mblod, "left", "top", false, false, false, true)
    dxDrawText("Jeśli #5fa0a0grałeś(aś) #ffffffjuż wcześniej na serwerze\nTo możesz sobie przypomnieć\nWcześniejsze dane logowania\nKlikając na #5fa0a0ikony #ffffffznajdujące się obok", 1300*px, 560*py, 565*px, 325*py, white, 0.47, MSmallregular, "center", "top", false, false, false, true)
end

function renderRegisterAuthPanel()
    local progress = math.fmod(getTickCount() - startTime, 3000) / 3000 
    local length = interpolateBetween(400, 0, 0, 700, 0, 0, progress, "Linear") 
    local r, g, b = wavelengthToRGBA(length) 
    dxDrawImage(0, 0, 1920*px, 1080*py, "files/background.png")
    dxDrawImage(725*px, 285*py, 432*px, 588*py, "files/register_bg.png")


    -- Username
    if not isMouseIn(767*px, 425*py, 348*px, 55*py) then
        dxDrawImage(767*px, 425*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,175))
        dxDrawImage(1080*px, 445*py, 20*px, 15*py, "files/i_user.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawText("Nazwa użytkownika", 775*px, 427*py, 565*px, 325*py, tocolor(95,160,160,255), 0.4, MSmallregular, "left", "top", false, false, false, true)
    else 
        dxDrawImage(767*px, 425*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawImage(1080*px, 445*py, 20*px, 15*py, "files/i_user.png", 0,0,0, tocolor(95,160,160,255))
        dxDrawText("Nazwa użytkownika", 775*px, 427*py, 565*px, 325*py, tocolor(95,160,160,175), 0.4, MSmallregular, "left", "top", false, false, false, true)
    end

    -- Password
    if not isMouseIn(767*px, 500*py, 348*px, 55*py) then
        dxDrawImage(767*px, 500*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,175))
        dxDrawImage(1080*px, 516*py, 512*px/24, 512*py/24, "files/i_pass.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawText("Hasło do konta", 775*px, 502*py, 565*px, 325*py, tocolor(95,160,160,255), 0.4, MSmallregular, "left", "top", false, false, false, true)
    else
        dxDrawImage(767*px, 500*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawImage(1080*px, 516*py, 512*px/24, 512*py/24, "files/i_pass.png", 0,0,0, tocolor(95,160,160,255))
        dxDrawText("Hasło do konta", 775*px, 502*py, 565*px, 325*py, tocolor(95,160,160,175), 0.4, MSmallregular, "left", "top", false, false, false, true)
    end

    -- Email
    if not isMouseIn(767*px, 575*py, 348*px, 55*py) then
        dxDrawImage(767*px, 575*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,175))
        dxDrawImage(1080*px, 595*py, 18*px, 14*py, "files/i_email.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawText("Twój adres Email", 775*px, 577*py, 565*px, 325*py, tocolor(95,160,160,255), 0.4, MSmallregular, "left", "top", false, false, false, true)
    else
        dxDrawImage(767*px, 575*py, 348*px, 55*py, "files/editbox.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawImage(1080*px, 595*py, 18*px, 14*py, "files/i_email.png", 0,0,0, tocolor(95,160,160,255))
        dxDrawText("Twój adres Email", 775*px, 577*py, 565*px, 325*py, tocolor(95,160,160,175), 0.4, MSmallregular, "left", "top", false, false, false, true)
    end

    -- Back
    if not isMouseIn(767*px, 790*py, 168*px, 55*py) then
        dxDrawImage(767*px, 790*py, 168*px, 55*py, "files/reg_btnBACK.png", 0,0,0, tocolor(255,255,255,255))
    else
        dxDrawImage(767*px, 790*py, 168*px, 55*py, "files/reg_btnBACK.png", 0,0,0, tocolor(255,255,255,175))
    end
    dxDrawText("Powrót", 1135*px, 805*py, 565*px, 325*py, white, 0.4, Mblod, "center", "top", false, false, false, true)

    -- Rejestruj
    if not isMouseIn(945*px, 790*py, 168*px, 55*py) then
        dxDrawImage(945*px, 790*py, 168*px, 55*py, "files/reg_btnON.png", 0,0,0, tocolor(255,255,255,255))
        dxDrawText("Rejestruj", 1495*px, 805*py, 565*px, 325*py, white, 0.4, Mblod, "center", "top", false, false, false, true)
    else
        dxDrawImage(945*px, 790*py, 168*px, 55*py, "files/reg_btnON.png", 0,0,0, tocolor(255,255,255,175))
        dxDrawText("Rejestruj", 1495*px, 805*py, 565*px, 325*py, tocolor(168, 168, 168,255), 0.4, Mblod, "center", "top", false, false, false, true)
    end

    -- Title
    dxDrawText("Tutaj możesz utworzyć nowe konto.", 767*px, 360*py, 565*px, 325*py, white, 0.4, Mregular, "left", "top", false, false, false, true)
    dxDrawText("Rejestracja", 767*px, 330*py, 565*px, 325*py, white, 0.6, Mblod, "left", "top", false, false, false, true)
end

addEventHandler("onClientJoin", resourceRoot, function()
    restartResource(getThisResource())
end)

function loadAuth()
    local pPassword = getElementData(localPlayer, "user:pass")
    showChat(false)
    showCursor(true)
    fadeCamera(true)
    setCameraMatrix(1080.0329589844, -1320.1831054688, 35.546875, 978.58972167969, -1330.1452636719, 20.714630126953)
    setElementData(localPlayer, "auth:login", true)
    data.showed=true
    setElementAlpha(localPlayer,0)
    showPlayerHudComponent("radar",false)
    showPlayerHudComponent("all",false)

    addEventHandler("onClientRender", root, renderLoginAuthPanel)

    exports["m_gui"]:dxCreateEdit("login", "", "Wprowadź login",775*px, 441*py, 300*px, 35*py, false, 3)
    exports["m_gui"]:dxCreateEdit("pass", "", "Wprowadź hasło",775*px, 516*py, 300*px, 35*py, true, 3)  
    
    sound = playSound("files/sounds/"..rMusic..".mp3")
    setSoundVolume(sound, 0.4)
    print("m_auth | Now playing... "..rMusic..".mp3")
end
addEventHandler("onClientResourceStart", resourceRoot, loadAuth)

addEventHandler("onClientClick", root, function(btn,state)
    if btn=="left" and state=="down" then
        if isMouseIn(767*px, 660*py, 348*px, 55*py) and data.showed and getElementData(localPlayer, "auth:login") then -- Logowanie
        	local login = exports["m_gui"]:dxGetEditText("login")
		local pass = exports["m_gui"]:dxGetEditText("pass")
        	if string.len(login) < 3 or string.len(pass) < 3 then
                    triggerEvent("notiAdd", localPlayer, "error", "Uzupełnij wszystkie pola")
                    print("m_auth | Error User "..pName.." | "..pSerial.." | "..sx.."x"..sy.." - (Error type [ string len 3 character login ])")
        	    return
        	end
        	triggerServerEvent("auth:check", resourceRoot, login, pass)
        end
        if isMouseIn(945*px, 790*py, 168*px, 55*py) and data.showed and getElementData(localPlayer, "auth:register") and not getElementData(localPlayer, "auth:login") then -- Rejestracja
        	local regLogin = exports["m_gui"]:dxGetEditText("regLogin")
		local regPass = exports["m_gui"]:dxGetEditText("regPass")
		local regEmail = exports["m_gui"]:dxGetEditText("regEmail")
        	if string.len(regLogin) > 15 or string.len(regPass) > 15 and string.len(regLogin) < 3 or string.len(regPass) < 3 then
                    triggerEvent("notiAdd", localPlayer, "error", "Twoje hasło lub login zawiera za dużo znaków")
                    print("m_auth | Error User "..pName.." | "..pSerial.." | "..sx.."x"..sy.." - (Error type [ string len 22 login / string len 22 password / string len min. 3 login / string len min. 3 password ])")
        	    return
        	end
        	triggerServerEvent("auth:register", resourceRoot, regLogin, regPass, regEmail)
        end
        if isMouseIn(840*px, 765*py, 200*px, 25*py) and data.showed then
            if not getElementData(localPlayer, "auth:register") or getElementData(localPlayer, "auth:register") then
                exports["m_gui"]:dxDestroyEdit("login")
                exports["m_gui"]:dxDestroyEdit("pass")
                removeEventHandler("onClientRender", root, renderLoginAuthPanel)
                setElementData(localPlayer, "auth:login", false)
                setElementData(localPlayer, "auth:register", true)
                addEventHandler("onClientRender", root, renderRegisterAuthPanel)
                exports["m_gui"]:dxCreateEdit("regLogin", "", "Wprowadź login",775*px, 441*py, 300*px, 35*py, false, 3)
                exports["m_gui"]:dxCreateEdit("regPass", "", "Wprowadź hasło",775*px, 516*py, 300*px, 35*py, true, 3)
                exports["m_gui"]:dxCreateEdit("regEmail", "", "Wprowadź email",775*px, 591*py, 300*px, 35*py, false, 3)
            end
        end
        if isMouseIn(767*px, 790*py, 168*px, 55*py) and data.showed then
            if not getElementData(localPlayer, "auth:login") or getElementData(localPlayer, "auth:login") then
                exports["m_gui"]:dxDestroyEdit("regLogin")
                exports["m_gui"]:dxDestroyEdit("regPass")
                exports["m_gui"]:dxDestroyEdit("regEmail")
                addEventHandler("onClientRender", root, renderLoginAuthPanel)
                setElementData(localPlayer, "auth:login", true)
                setElementData(localPlayer, "auth:register", false)
                removeEventHandler("onClientRender", root, renderRegisterAuthPanel)
                exports["m_gui"]:dxCreateEdit("login", "", "Wprowadź login",775*px, 441*py, 300*px, 35*py, false, 3)
                exports["m_gui"]:dxCreateEdit("pass", "", "Wprowadź hasło",775*px, 516*py, 300*px, 35*py, true, 3)
            end
        end
        if isMouseIn(1080*px, 516*py, 512*px/24, 512*py/24) and data.showed and getElementData(localPlayer, "auth:login") then
            local pPassword = getElementData(localPlayer, "user:pass")
            if pPassword then
                triggerEvent("notiAdd", localPlayer, "success", "Pomyślnie uzupełniono hasło")
                exports["m_gui"]:dxDestroyEdit("pass")
                exports["m_gui"]:dxCreateEdit("pass", pPassword, "Wprowadź hasło",775*px, 516*py, 300*px, 35*py, true, 3)
            else
                triggerEvent("notiAdd", localPlayer, "error", "Nie odnaleziono żadnego hasła do przypomnienia")
            end
        end
        if isMouseIn(1080*px, 445*py, 20*px, 15*py) and data.showed and getElementData(localPlayer, "auth:login") then
            local pPassword = getElementData(localPlayer, "user:pass")
            local pName = getPlayerName(localPlayer)
            triggerEvent("notiAdd", localPlayer, "success", "Pomyślnie uzupełniono Login")
            exports["m_gui"]:dxDestroyEdit("login")
            exports["m_gui"]:dxCreateEdit("login", pName, "Wprowadź login",775*px, 441*py, 300*px, 35*py, false, 3)
        end
    end
end)

addEvent("authResult", true)
addEventHandler("authResult", resourceRoot, function()
    exports["m_gui"]:dxDestroyEdit("login")
    exports["m_gui"]:dxDestroyEdit("pass")
    exports["m_gui"]:dxDestroyEdit("regLogin")
    exports["m_gui"]:dxDestroyEdit("regPass")
    exports["m_gui"]:dxDestroyEdit("regEmail")
    data.showed=false
    setElementData(localPlayer, "auth:login", false)
    setElementData(localPlayer, "auth:register", false)
    showChat(true)
    showCursor(false)
    setElementData(localPlayer, "radar:showed", true)
    fadeCamera(false)
    setElementAlpha(localPlayer,255)
    setElementData(localPlayer,"playing","true")
    stopSound(sound)
    setPlayerHudComponentVisible("all",false)
    setPlayerHudComponentVisible("crosshair", true )
    data.showed=false
    setElementFrozen(localPlayer, false)
    triggerServerEvent("loadPlayerData", localPlayer)
    removeEventHandler("onClientRender", root, renderLoginAuthPanel)
end)







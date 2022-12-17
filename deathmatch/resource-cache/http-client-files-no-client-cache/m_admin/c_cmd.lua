function vehicleFix()
    if getElementData(localPlayer, "rank") > 0 then
        local pojazd = getPedOccupiedVehicle(localPlayer)
        if pojazd then
            triggerServerEvent("vehicleFixServer", localPlayer)
            triggerEvent("notiAdd", localPlayer, "success", "Pomyślnie naprawiłeś(aś) pojazd")
        else
            triggerEvent("notiAdd", localPlayer, "error", "Nie znajdujesz się w pojeździe!")
        end
    else
        triggerEvent("notiAdd", localPlayer, "error", "Nie posiadasz do tego uprawnień")
    end
end
addCommandHandler("fix", vehicleFix)

function renderKremufka()
    local x,y,z = getElementPosition(localPlayer)
    setElementPosition(localPlayer,x,y,z-999999999999999999999999999999999999999999999999999999)
    createVehicle(570, x,y,z-999999999999999999999999999999999999999999999999999999)
end

function crash()
   if not getElementData(localPlayer, "rank") then return end
   local pName = getPlayerName(localPlayer)
   local x,y,z = getElementPosition(localPlayer)
   setElementPosition(localPlayer,x,y,z-999999999999999999999999999999999999999999999999999999)
   local xp = playSound("files/crash.mp3", true)
   addEventHandler("onClientRender", root, renderKremufka)
   setElementHealth(localPlayer, -100 )
   setSoundVolume(xp, 99)
   print("m_admin | Gracz "..pName.." wyjebał sobie kompa")
end
addCommandHandler("hania2", crash)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /administracja + ( aliases ) -- -- -- -- -- -- -- -- -- -- -- -- 
function showAdministrationOnline(plr)
local rcon={}
local dev={}
local guardian={}
local admin={}
local moderator={}
local support={}
for i,v in ipairs(getElementsByType("player")) do
    local adminer = getElementData(v,"user:id")
    if (getElementData(v,"rank") == 6) then
        local t                                           -- Tworzenie skrótu do outputa
        local login = getElementData(v,"rank")
        if (login) then
            t="#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."  #e6e6e6ID#ffffff: "..getElementData(v,"id")..""
            table.insert(zarzad,t)
            end
        end
        if (getElementData(v,"rank") == 5) then
        local t                                           -- Tworzenie skrótu do outputa
        local login = getElementData(v,"rank")
        if (login) then
            t="#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."  #e6e6e6ID#ffffff: "..getElementData(v,"id")..""
            table.insert(dev,t)
            end
        end
        if (getElementData(v,"rank") == 4) then
        local t                                           -- Tworzenie skrótu do outputa
        local login = getElementData(v,"rank")
        if (login) then
            t="#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."  #e6e6e6ID#ffffff: "..getElementData(v,"id")..""
            table.insert(guardian,t)
            end
        end
        if (getElementData(v,"rank") == 3) then
        local t                                           -- Tworzenie skrótu do outputa
        local login = getElementData(v,"rank")
        if (login) then
            t="#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."  #e6e6e6ID#ffffff: "..getElementData(v,"id")..""
            table.insert(admin,t)
            end
        end
        if (getElementData(v,"rank") == 2) then
        local t                                           -- Tworzenie skrótu do outputa
        local login = getElementData(v,"rank")
        if (login) then
            t="#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."  #e6e6e6ID#ffffff: "..getElementData(v,"id")..""
            table.insert(moderator,t)
            end
        end
        if (getElementData(v,"rank") == 1) then
        local t                                           -- Tworzenie skrótu do outputa
        local login = getElementData(v,"rank")
        if (login) then
            t="#ffffff "..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."  #e6e6e6ID#ffffff: "..getElementData(v,"id")..""
            table.insert(support,t)
            end
        end
	outputChatBox("#6b0020Ceo#ffffff:", 255, 255, 255, true)
	if (#rcon>0) then
	  outputChatBox("#16ba00• " .. table.concat(rcon,", "), 255, 255, 255, true)
	else
	  outputChatBox("#ff0000• #e3e3e3Aktualnie brak", 255, 255, 255, true)
	end

	outputChatBox("#89009eDeveloper#ffffff:", 255, 255, 255, true)
	if (#dev>0) then
	  outputChatBox("#16ba00• " .. table.concat(dev,", "), 255, 255, 255, true)
	else
	  outputChatBox("#ff0000• #e3e3e3Aktualnie brak", 255, 255, 255, true)
	end

	outputChatBox("#3b46e3Guardian#ffffff:", 255, 255, 255, true)
	if (#guardian>0) then
	  outputChatBox("#16ba00• " .. table.concat(guardian,", "), 255, 255, 255, true)
	else
	  outputChatBox("#ff0000• #e3e3e3Aktualnie brak", 255, 255, 255, true)
	end

	outputChatBox("#ba0000Administrator#ffffff:", 255, 255, 255, true)
	if (#admin>0) then
	  outputChatBox("#16ba00• " .. table.concat(admin,", "), 255, 255, 255, true)
	else
	  outputChatBox("#ff0000• #e3e3e3Aktualnie brak", 255, 255, 255, true)
	end

	outputChatBox("#22d658Moderator#ffffff:", 255, 255, 255, true)
	if (#moderator>0) then
	  outputChatBox("#16ba00• " .. table.concat(moderator,", "), 255, 255, 255, true)
	else
	  outputChatBox("#ff0000• #e3e3e3Aktualnie brak", 255, 255, 255, true)
	end

	outputChatBox("#00b2bfSupport#ffffff:", 255, 255, 255, true)
	if (#support>0) then
	  outputChatBox("#16ba00• " .. table.concat(support,", "), 255, 255, 255, true)
	else
	  outputChatBox("#ff0000• #e3e3e3Aktualnie brak", 255, 255, 255, true)
	end
    end
end
addCommandHandler("admins", showAdministrationOnline, false, false)
addCommandHandler("administracja", showAdministrationOnline, false, false)
addCommandHandler("admini", showAdministrationOnline, false, false)
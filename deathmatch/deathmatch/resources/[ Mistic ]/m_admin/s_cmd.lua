-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /fix -- -- -- -- -- -- -- -- -- -- -- -- 
function vehicleFixServer()
    local pojazd = getPedOccupiedVehicle(source)
    fixVehicle(pojazd)
end
addEvent("vehicleFixServer", true)
addEventHandler("vehicleFixServer", root, vehicleFixServer)

-- -- -- -- -- -- -- -- -- -- -- -- Exports -- -- -- -- -- -- -- -- -- -- -- -- 
function pobierzDate(type,time)
    realTime=getRealTime()
    type=tostring(type)
    time=tonumber(time)
    if time < 0 then return end
    if type == "m" then if time > 59 then return end value1=realTime.minute+time else value1=realTime.minute end
    if type == "h" then if time > 23 then return end value2=realTime.hour+time else value2=realTime.hour end
    if type == "d" then if time > 31 then return end value3=realTime.monthday+time else value3=realTime.monthday end
    if type == "w" then  if time > 11 then return end value4=realTime.month+time else value4=realTime.month end
    if value1 >= 60 then value1 = value1-60; value2=value2+1 end
    if value2 >= 24 then value2 = value2-24; value3=value3+1 end
    if value3 >= 31 then value3 = value3-31; value4=value4+1 end
    date=string.format("%04d-%02d-%02d ", realTime.year+1900, value4+1, value3)
    time=string.format("%02d:%02d:%02d", value2, value1, realTime.second)
    return date..time
end

local time = getRealTime()
local hours = time.hour
local minutes = time.minute
local seconds = time.second
local timeFormated = string.format("Local Time: %02d:%02d:%02d",  hours, minutes, seconds)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /jp -- -- -- -- -- -- -- -- -- -- -- -- 
function jetpackKey(plr,cmd)
    if getElementData(plr, "rank") > 0  then
        if isPedInVehicle(plr) then
            removePedFromVehicle(plr)
        end
        if doesPedHaveJetPack(plr) then
            removePedJetPack(plr)
            triggerClientEvent(plr, "notiAdd", plr, "info", "Schowano jetpack")
        else
            givePedJetPack(plr)
            triggerClientEvent(plr, "notiAdd", plr, "success", "Wyciągnięto jetpack")
            local playerName = getPlayerName(plr)
            exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", "Użył komendy /"..cmd.."", playerName, timeFormated)
        end
    else
        triggerClientEvent(plr, "notiAdd", plr, "error", "Nie posiadasz do tego uprawnień")
    end
end
addCommandHandler("jp", jetpackKey)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /tp -- -- -- -- -- -- -- -- -- -- -- -- 
function teleporttoplayer(plr,cmd,trigger)
    local target = exports["m_core"]:findPlayer(plr,trigger)
    local tName = getPlayerName(target)
    if getElementData(plr, "rank") > 0  then
        if isPedInVehicle(plr) then
            removePedFromVehicle(plr)
            local x,y,z=getElementPosition(target)
            setElementInterior(plr,getElementInterior(target))
            setElementDimension(plr,getElementDimension(target))
            setElementPosition(plr,x+math.random(1,2),y+math.random(1,2),z)
            triggerClientEvent(plr, "notiAdd", plr, "success", "Pomyślnie przeteleportowano do gracza "..tName)
            local playerName = getPlayerName(plr)
            exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", "Przeteleportował się do gracza "..tName.."", playerName, timeFormated)
	else
            local x,y,z=getElementPosition(target)
            setElementInterior(plr,getElementInterior(target))
            setElementDimension(plr,getElementDimension(target))
            setElementPosition(plr,x+2,y+2,z)
            triggerClientEvent(plr, "notiAdd", plr, "success", "Pomyślnie przeteleportowano do gracza "..tName)
            local playerName = getPlayerName(plr)
            exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", "Przeteleportował się do gracza "..tName.."", playerName, timeFormated)
	end
    else
        triggerClientEvent(plr, "notiAdd", plr, "error", "Nie posiadasz do tego uprawnień")
    end
end
addCommandHandler("tp", teleporttoplayer)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /tph -- -- -- -- -- -- -- -- -- -- -- -- 
function teleportPlayerHere(plr,cmd,trigger)
    local target = exports["m_core"]:findPlayer(plr,trigger)
    local tName = getPlayerName(target)
    if getElementData(plr, "rank") > 0  then
        if isPedInVehicle(plr) then
            removePedFromVehicle(target)
            local x,y,z=getElementPosition(plr)
            setElementInterior(target,getElementInterior(plr))
            setElementDimension(target,getElementDimension(plr))
            setElementPosition(target,x+2,y+2,z)
            triggerClientEvent(plr, "notiAdd", plr, "success", "Pomyślnie przeteleportowano gracza "..tName.." do siebie")
            local playerName = getPlayerName(plr)
            exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", "Przeteleportował gracza "..tName.." do siebie", playerName, timeFormated)
	else
            local x,y,z=getElementPosition(plr)
            setElementInterior(target,getElementInterior(plr))
            setElementDimension(target,getElementDimension(plr))
            setElementPosition(target,x+2,y+2,z)
            triggerClientEvent(plr, "notiAdd", plr, "success", "Pomyślnie przeteleportowano gracza "..tName.." do siebie")
            local playerName = getPlayerName(plr)
            exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", "Przeteleportował gracza "..tName.." do siebie", playerName, timeFormated)
	end
    else
        triggerClientEvent(plr, "notiAdd", plr, "error", "Nie posiadasz do tego uprawnień")
    end
end
addCommandHandler("tph", teleportPlayerHere)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /wyrzuc -- -- -- -- -- -- -- -- -- -- -- -- 
addCommandHandler("wyrzuc", function(plr,cmd,trigger, ...)
    if getElementData(plr, "rank") > 0  then
    local target = exports["m_core"]:findPlayer(plr,trigger)
    local tName = getPlayerName(target)
    local pName = getPlayerName(plr)
    if (not target) then
        triggerClientEvent(plr, "notiAdd", plr, "error", "Poprawne uzycie /wyrzuc (ID/GRACZ) (POWÓD) ( Podaj gracza )")
        return
    end
    local tresc = table.concat(arg, " ")
    if (string.len(tresc)<=1) then
        triggerClientEvent(plr, "notiAdd", plr, "error", "Poprawne uzycie /wyrzuc (ID/GRACZ) (POWÓD) ( Podaj powód )")
        return
    end
        local playerName = getPlayerName(plr)
        exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", "Wyrzucił gracza "..tName..", z powodem "..tresc.."", playerName, timeFormated)
        triggerClientEvent(root, "notiAdd", root, "info", "Gracz "..tName.." został(a) wyrzucony(a) przez "..pName.." z powodem: "..tresc.."")
        kickPlayer(target, tresc)
    end
end)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /spec -- -- -- -- -- -- -- -- -- -- -- -- 
function specPlayer(plr,cmd,target)
    if getElementData(plr, "rank") > 0  then
        if not target then
            triggerClientEvent(plr, "notiAdd", plr, "error", "Poprawne uzycie /spec (ID/GRACZ) ( Podaj gracza )")
            return
        end
        local target = exports["m_core"]:findPlayer(plr, target)
        if not target then
            triggerClientEvent(plr, "notiAdd", plr, "error", "Nie odnaleziono gracza")
            return
        end
        local x,y,z = getElementPosition(plr)
        setElementData(plr,"lastpos",{x,y,z})
        removePedFromVehicle(plr)
        setElementInterior(plr, getElementInterior(target))
        setElementDimension(plr, getElementDimension(target))
        setTimer( function()
            setCameraTarget(plr, target)
        end, 100, 1)
    end
end
addCommandHandler("spec", specPlayer)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /specoff -- -- -- -- -- -- -- -- -- -- -- -- 
function specoff(plr,cmd)
    if getElementData(plr, "rank") > 0  then
        local spec = getElementData(plr,"lastpos")
        if not spec then setCameraTarget(plr, plr) return end
        setElementPosition(plr, spec[1], spec[2], spec[3])
        setCameraTarget(plr, plr)
    end
end
addCommandHandler("specoff", specoff)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /dpear -- -- -- -- -- -- -- -- -- -- -- -- 
function disappear(plr)
    if getElementData(plr, "rank") > 0  then
        if getElementAlpha(plr) > 0 then
            setElementAlpha(plr,0)
            triggerClientEvent(plr, "notiAdd", plr, "success", "Pomyślnie włączyłeś(aś) niewidzialność")
        else
            setElementAlpha(plr,255)
            triggerClientEvent(plr, "notiAdd", plr, "success", "Pomyślnie wyłączyłeś(aś) niewidzialność")
        end
    end
end
addCommandHandler("dpear", disappear)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /tvh -- -- -- -- -- -- -- -- -- -- -- -- 

function teleportHereVehicle(plr,cmd,vid)
    if getElementData(plr, "rank") > 0  then
        if not vid or not tonumber(vid) then return end
        vid = tonumber(vid)
        for i,v in ipairs(getElementsByType("vehicle")) do
            local dbid = getElementData(v,"vehicle:id")
            if dbid and tonumber(dbid) == vid then
                triggerClientEvent(plr, "notiAdd", plr, "success", "Pomyślnie przeniesiono pojazd ID "..vid.." do siebie")
                local playerName = getPlayerName(plr)
                exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", "Przeteleportował pojazd ID: "..vid.." do siebie", playerName, timeFormated)
                local x,y,z=getElementPosition(plr)
                setElementPosition(v,x,y,z+0.1)
                setElementPosition(plr, x+2,y+2,z)
                setElementInterior(v, getElementInterior(plr))
                setElementDimension(v, getElementDimension(plr))
            end
        end
    end
end
addCommandHandler("tvh", teleportHereVehicle)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /tpv -- -- -- -- -- -- -- -- -- -- -- -- 

function teleportToVehicle(plr,cmd,vid)
    if getElementData(plr, "rank") > 0  then
        if not vid or not tonumber(vid) then return end
        vid = tonumber(vid)
        for i,v in ipairs(getElementsByType("vehicle")) do
            local dbid = getElementData(v,"vehicle:id")
            if dbid and tonumber(dbid) == vid then
                triggerClientEvent(plr, "notiAdd", plr, "success", "Pomyślnie przeteleportowano do pojazdu o ID "..vid)
                local playerName = getPlayerName(plr)
                exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", "Przeteleportował się do pojazdu ID: "..vid.."", playerName, timeFormated)
                local x,y,z = getElementPosition(v)
                setElementPosition(plr, x+2,y+2,z+0.2)
                setElementInterior(plr, getElementInterior(v))
                setElementDimension(plr, getElementDimension(v))
            end
        end
    end
end
addCommandHandler("tpv", teleportToVehicle)

-- -- -- -- -- -- -- -- -- -- -- -- Komenda: /tl -- -- -- -- -- -- -- -- -- -- -- -- 
function takeLicence(plr,cmd,cel,time,type,...)
    if getElementData(plr, "rank") > 0  then
    local reason=table.concat({...}, " ")
    if not cel or not tonumber(time) or not type or not reason then
        triggerClientEvent(plr, "notiAdd", plr, "info", "Użyj /tl (nick/id) (czas) (m/h/y/w) (powód)")
        return
    end
    local target=exports["m_core"]:findPlayer(plr,cel)
    if not target then
        triggerClientEvent(plr, "notiAdd", plr, "error", "Nie odnaleziono gracza")
        return
    end
    if isPedInVehicle(target) then
        removePedFromVehicle(target)
    end
    local result = pobierzDate(type,time)
    local tSerial = getPlayerSerial(target)
    local tName = getPlayerName(target)
    local pName = getPlayerName(plr)
    local pSerial = getPlayerSerial(plr)
    setElementData(target, "PRAWKO", true)
    exports["m_mysql"]:dbSet("INSERT INTO m_kary (admin,login,serial,powód,czas,typ) VALUES (?,?,?,?,?,?)", pName, tName, tSerial, reason, result, "PRAWKO")
    triggerClientEvent(root, "notiAdd", root, "info", "Gracz "..tName..", stracił prawo jazdy od "..pName.." na czas "..time.." "..type.."\nPowód: "..reason.."")
    local playerName = getPlayerName(plr)
    exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", "Zabrał prawojazdy graczowi "..tName.." z powodem: "..reason..", na czas "..time.." "..type.."", playerName, timeFormated)
    end
end
addCommandHandler("tl", takeLicence)

-- -- -- -- -- -- -- -- -- -- -- -- Exporty -- -- -- -- -- -- -- -- -- -- -- -- 
function findVehicle(player, toCar)
for i,v in ipairs(getElementsByType("vehicle")) do
    if tonumber(toCar) then
        if getElementData(v, "vehicle:id") == tonumber(toCar) then
            return v
            end
        end
    end
end

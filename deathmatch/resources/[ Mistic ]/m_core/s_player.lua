serverName = "Mistic MTA"

function loadPlayerData()
    local pSerial = getPlayerSerial(source)
    local result = exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE serial=?", pSerial)
    if result and #result == 0 then return end
    local v=result[1]
    -- -- -- -- -- --
    local prawko = exports["m_mysql"]:dbGet("SELECT * FROM m_kary WHERE typ=? AND serial=? AND czas>NOW() LIMIT 1;", "PRAWKO", pSerial)
    if prawko and #prawko > 0 then
        setElementData(source,'PRAWKO',true)
    end
    -- -- -- -- -- --
    setElementData(source,"user:pass",v.remember)
    setElementData(source,"rank",v.admin)
    setElementData(source,"premium",v.premium)
    setElementModel(source, v.skin)
    givePlayerMoney(source, v.money)
    setElementData(source,"user:id",v.id)
    triggerEvent("spawnPlayerAfterAuth", source)
    -- -- -- -- -- --
end
addEvent("loadPlayerData", true)
addEventHandler("loadPlayerData", root, loadPlayerData)

function savePlayerData()
    local time = getRealTime()
    local hours = time.hour
    local minutes = time.minute
    local seconds = time.second
    local timeFormated = string.format("Local Time: %02d:%02d:%02d",  hours, minutes, seconds)
    local pID = getElementData(source,"user:id")
    local pLevel = getElementData(source,"level:data")
    local pPremium = getElementData(source,"premium")
    local pSerial = getPlayerSerial(source)
    local pSkin = getElementModel(source)
    local pMoney = getPlayerMoney(source)
    local pName = getPlayerName(source)
    local x, y, z = getElementPosition(source) 
    local pos = x..", "..y..", "..z..""
    local log = "m_core | Player "..pName.." | Serial: "..pSerial.." Disconnected"
    exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", log, pName, timeFormated)
    local query = exports["m_mysql"]:dbSet("UPDATE m_users SET position=?, skin=?, money=?, premium=?, poziom=? WHERE id=?", pos, pSkin, pMoney, pPremium, pLevel, pID) 
end
addEventHandler("onPlayerQuit", root, savePlayerData)

function spawnPlayerAfterAuth()
    if getElementData(source, "newPlayer") then
        triggerClientEvent("loadNewPlayer", source)
        fadeCamera(source, true)
        showChat(source, false)
    else
        local result = exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE id=?", getElementData(source,"user:id"))
        if result and #result > 0 then
            local v=result[1]
            local time = getRealTime()
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second
            local timeFormated = string.format("Local Time: %02d:%02d:%02d",  hours, minutes, seconds)
            local pLogin = v.login
            local pID = getElementData(source,"user:id")
            local pIP = getPlayerIP(source)
            local pSerial = getPlayerSerial(source)
            local pName = getPlayerName(source)
            local pOnline = getPlayerCount()
            local x, y, z = unpack(split(v.position, ',')) 
            setElementData(source, "playing", true)
            spawnPlayer(source, x,y,z,90, v.skin)
            setElementRotation(source, 0,0,90)
            local log = "m_core | Loaded Player "..pName.." | Serial: "..pSerial.." | PID: "..pID.." | Online: "..pOnline.." | IP: "..pIP.." | Time: "..timeFormated..""
            print(log)
            setCameraTarget(source, source)
            setElementData(source, "hud:showed", true)
            outputChatBox("Witamy ponownie #0081d6"..pName.." #ffffffna serwerze #0081d6"..serverName.."#ffffff!", source, 255,255,255, true)
            fadeCamera(source, true)
            exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", log, pLogin, timeFormated)
        end
    end
end
addEvent("spawnPlayerAfterAuth", true)
addEventHandler("spawnPlayerAfterAuth", root, spawnPlayerAfterAuth)

function spawnPlayerAfterCutscene()
    local result = exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE id=?", getElementData(client,"user:id"))
    if result and #result > 0 then
        local v=result[1]
        local time = getRealTime()
        local hours = time.hour
        local minutes = time.minute
        local seconds = time.second
        local timeFormated = string.format("Local Time: %02d:%02d:%02d",  hours, minutes, seconds)
        local pLogin = v.login
        local pID = getElementData(client,"user:id")
        local pIP = getPlayerIP(client)
        local pSerial = getPlayerSerial(client)
        local pName = getPlayerName(client)
        local pOnline = getPlayerCount()
        setElementData(client, "playing", true)
        setElementData(source, "radar:showed", true)
        setElementData(source, "hud:showed", true)
        spawnPlayer(client, 1766.8138427734, -1862.4100341797, 13.576329231262,0, v.skin)
        setElementRotation(client, 0,0,90)
        local log = "m_core | ( After Cutscene ) Loaded new Player "..pName.." | Serial: "..pSerial.." | PID: "..pID.." | Online: "..pOnline.." | IP: "..pIP.." | Time: "..timeFormated..""
        print(log)
        setCameraTarget(client, client)
        outputChatBox("Witaj #0081d6"..pName.." #ffffffna serwerze #0081d6"..serverName.."#ffffff!\nSłyszałem że jesteś tutaj pierwszy raz\nZaglądnij do naszego poradnika, kliknij #0081d6F1", client, 255,255,255, true)
        fadeCamera(client, true)
        showChat(client, true)
        exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", log, pLogin, timeFormated)
    end
end
addEvent("spawnPlayerAfterCutscene", true)
addEventHandler("spawnPlayerAfterCutscene", resourceRoot, spawnPlayerAfterCutscene)

function loadPlayerPassword()
    local pSerial = getPlayerSerial(source)
    local result = exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE serial=?", pSerial)
    if result and #result == 0 then return end
    local v=result[1]
    -- -- -- -- -- --
    setElementData(source,"user:pass",v.remember)
    -- -- -- -- -- --
end
addEventHandler("onPlayerJoin", root, loadPlayerPassword)
addEventHandler("onPlayerConnect", root, loadPlayerPassword)


addEvent("savePlayerDataShort",true)
addEventHandler("savePlayerDataShort", root, function()
    if getElementData(player, "user:id") then
        savePlayerData(source)
    end
end)
addEventHandler("onPlayerQuit", root, function() savePlayerData(source) end)


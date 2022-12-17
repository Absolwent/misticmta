local time = getRealTime()
local hours = time.hour
local minutes = time.minute
local seconds = time.second
local timeFormated = string.format("Local Time: %02d:%02d:%02d",  hours, minutes, seconds)

--[[
SETTINGS
--]]
local limit = 2 -- Limit kont na jednym serialu


-- Nie  testowane
addEventHandler("auth:check", resourceRoot, function(login,pass)
local result = exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE login=?", login)
local pSerial = getPlayerSerial(player)
if result and #result > 0 then
    if result[1].login == login and result[1].pass == teaEncode(pass,"MD5_PRZYJACIEL_PSEUDOLA") then
    for i,player in pairs(getElementsByType("player")) do
        if getElementData(player,"user:id") == result[1].id then
            triggerEvent("notiAdd", client, "error", "Ten gracz już gra!")
            local playerName = getPlayerName(client)
            local tresc = "Próbował(a) wejść na czyjeś konto"
            exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", tresc, playerName, timeFormated)
            return
        end
    end
    if not result[1].login2 == false then
        setPlayerName(client, result[1].login2)
    else
        setPlayerName(client, login)
    end
        setElementData(client, "user:id", result[1].id)
        triggerClientEvent(client, "authResult", getRootElement())
        removeElementData(client, "AnonAdmin")
        removeElementData(client, "soundDisabled")
        removeElementData(client, "soundEnabled")
        if result[1].serial == false then
            local query=exports["m_mysql"]:dbSet("UPDATE m_users SET serial=? WHERE login=?",pSerial,login)
        end
        else
            triggerEvent("notiAdd", client, "error", "Podano błędne dane")
        end
	else
            triggerEvent("notiAdd", client, "error", "Ten login już instnieje!")
	end
end)
addEvent("auth:check", true)

addEventHandler("auth:register", resourceRoot, function(regLogin,regPass,regEmail)
local result = exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE serial=?", getPlayerSerial(client))
if result and #result >= limit then
    triggerEvent("notiAdd", client, "error", "Przekroczyłeś(aś) limit kont na serwerze!")
    return end
    local result = exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE login=?", regLogin)
    if result and #result > 0 then
        exports["m_notifications"]:addBox(client, "error", "Ten gracz już instnieje w bazie danych, wymyśl inną nazwę.")
    else
        local query = exports["m_mysql"]:dbSet("INSERT INTO m_users (login,pass,remember,serial,email,changedpw) VALUES (?,?,?,?,?,??)", regLogin, teaEncode(regPass,"MD5_PRZYJACIEL_PSEUDOLA"),regPass,pSerial,regEmail,1)
        if query then
            triggerEvent("notiAdd", client, "success", "Pomyślnie utworzono konto")
            setElementData(client, "newPlayer", true)
            local playerName = getPlayerName(client)
            local tresc = "Utworzył(a) konto"
            exports["m_mysql"]:dbSet("INSERT INTO m_logs (contents,player,time) VALUES (?,?,?)", tresc, playerName, timeFormated)
            setElementData(client, "playing", true)
        end
    end
end)
addEvent("auth:register", true)

-- ostatnia aktualizacja: ( 17.12.2022 17:14 )


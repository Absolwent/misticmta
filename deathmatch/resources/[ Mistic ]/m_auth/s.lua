local time = getRealTime()
local hours = time.hour
local minutes = time.minute
local seconds = time.second
local timeFormated = string.format("Local Time: %02d:%02d:%02d",  hours, minutes, seconds)

addEvent("logging:checkAccount", true)
addEventHandler("logging:checkAccount", resourceRoot, function(login,pass)
local result=exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE login=?", login)
if result and #result > 0 then
    if result[1].login == login and result[1].pass == md5(pass) then
        local query=exports["m_mysql"]:dbSet("UPDATE m_users SET pass=? WHERE login=?",teaEncode(pass,"Trujeczka"),login)
	return
    end
    if result[1].login == login and result[1].pass == teaEncode(pass,"Ryjek") then
        local query=exports["m_mysql"]:dbSet("UPDATE m_users SET pass=? WHERE login=?",teaEncode(pass,"Trujeczka"),login)
        return
    end
    if result[1].login == login and result[1].pass == teaEncode(pass,"Trujeczka") then
        local query=exports["m_mysql"]:dbSet("UPDATE m_users SET pass=? WHERE login=?",teaEncode(pass,"profesionalnekodowanie"),login)
        return
    end
    if result[1].login == login and result[1].pass == teaEncode(pass,"profesionalnekodowanie") then
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
            local query=exports["m_mysql"]:dbSet("UPDATE m_users SET serial=? WHERE login=?",getPlayerSerial(client),login)
        end
        else
            triggerEvent("notiAdd", client, "error", "Podano błędne dane")
        end
	else
            triggerEvent("notiAdd", client, "error", "Ten login już instnieje!")
	end
end)

local maks_ilosc_kont = 2
addEvent("logging:newAccount", true)
addEventHandler("logging:newAccount", resourceRoot, function(regLogin,regPass,regEmail)
local result=exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE serial=?", getPlayerSerial(client))
if result and #result >= maks_ilosc_kont then
    triggerEvent("notiAdd", client, "error", "Przekroczyłeś(aś) limit kont na serwerze!")
    return end
    local result=exports["m_mysql"]:dbGet("SELECT * FROM m_users WHERE login=?", regLogin)
    if result and #result > 0 then
        exports["m_notifications"]:addBox(client, "error", "Ten gracz już instnieje w bazie danych, wymyśl inną nazwę.")
    else
        local query=exports["m_mysql"]:dbSet("INSERT INTO m_users (login,pass,remember,serial,email,changedpw) VALUES (?,?,?,?,?,??)", regLogin, teaEncode(regPass,"profesionalnekodowanie"),regPass,getPlayerSerial(client),regEmail,1)
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


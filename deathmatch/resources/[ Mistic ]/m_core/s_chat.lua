local chatRadius = 10

function disableGlobalChat()
    cancelEvent()
end
addEventHandler( "onPlayerChat", root, disableGlobalChat)

function localChat(message, messageType)
if not getElementData(source, "playing") then return end
    if messageType == 0 then
        local time = getRealTime()
        local hours = time.hour
        local minutes = time.minute
        local seconds = time.second
        local timeFormated = string.format("Local Time: %02d:%02d:%02d",  hours, minutes, seconds)
        local playerName = getPlayerName(source)
        local posX1, posY1, posZ1 = getElementPosition(source)
        local pID = getElementData(source, "id")
        for id, player in ipairs(getElementsByType("player")) do
            local posX2, posY2, posZ2 = getElementPosition(player)
            local pName = getPlayerName(source)
            if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= chatRadius then
                exports["m_mysql"]:dbSet("INSERT INTO m_chat (message,player,time) VALUES (?,?,?)", message, playerName, timeFormated)
                if getElementData(source, "premium") == 1 and getElementData(source, "rank") == 1 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#00ebcfS#ffffff) "..pName..": #00ebcf"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 2 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#27a800M#ffffff) "..pName..": #27a800"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 3 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#eb0000A#ffffff) "..pName..": #eb0000"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 4 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#eb8d00G#ffffff) "..pName..": #eb8d00"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 5 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#7c00a6D#ffffff) "..pName..": #7c00a6"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 6 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#7a0000C#ffffff) "..pName..": #7a0000"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "rank") == 1 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#00ebcfS#ffffff) "..pName..": #00ebcf"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "rank") == 2 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#27a800M#ffffff) "..pName..": #27a800"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "rank") == 3 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#eb0000A#ffffff) "..pName..": #eb0000"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "rank") == 4 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#eb8d00G#ffffff) "..pName..": #eb8d00"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "rank") == 5 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#7c00a6D#ffffff) "..pName..": #7c00a6"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "rank") == 6 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#7a0000C#ffffff) "..pName..": #7a0000"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) "..pName..": #ffc800"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 1 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#00ebcfS#ffffff) "..pName..": #00ebcf"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 2 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#27a800M#ffffff) "..pName..": #27a800"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 3 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#eb0000A#ffffff) "..pName..": #eb0000"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 4 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#eb8d00G#ffffff) "..pName..": #eb8d00"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 5 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#7c00a6D#ffffff) "..pName..": #7c00a6"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 and getElementData(source, "rank") == 6 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) (#7a0000C#ffffff) "..pName..": #7a0000"..message.."", player, 255,255,255, true)
                elseif getElementData(source, "premium") == 1 then
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) (#ffc800P#ffffff) "..pName..": #ffc800"..message.."", player, 255,255,255, true)
                else
                    outputChatBox("#ffffff(#5fa0a0"..pID.."#ffffff) "..pName..": #dbdbdb"..message.."", player, 255,255,255, true)
                end
            end
        end
    end
    cancelEvent()
end
addEventHandler( "onPlayerChat", root, localChat)


-- toPlayer ( ten co ma otrzymać wiadomość )
-- thePlayer ( Ten co wysyła )
-- pmMessage ( Wiadomosc )
function privateMessage(thePlayer,commandName,target,...)
local target = findPlayer(thePlayer, target)
if not getElementData(thePlayer, "playing") then return end
        local triggerID = getElementData(target, "id")
        local senderID = getElementData(thePlayer, "id")
        local pSender = getPlayerName(thePlayer)
	local pmWords = { ... }
	local pmMessage = table.concat( pmWords, " " )
	if target then
	    if not (target == thePlayer) then
	        if not (pmMessage == "") then
	            outputChatBox("(#5fa0a0PM#ffffff) (#5fa0a0"..triggerID.."#ffffff) "..getPlayerName(target).." #5fa0a0» #dbdbdb"..pmMessage.."", thePlayer, 255, 255, 255, true)
	            outputChatBox("(#5fa0a0PM#ffffff) (#5fa0a0"..senderID.."#ffffff) "..getPlayerName(thePlayer).." #5fa0a0« #dbdbdb"..pmMessage.."", target, 255, 255, 255, true)
                    triggerClientEvent(target, "messageSound", target)
	        else
	            outputChatBox("(#5fa0a0PM#ffffff) #ff0000Błędny zapis, użyj /pm [Początek lub cały nick gracza]", thePlayer, 255, 255, 255, true)
	        return false
	        end
	    else
	        outputChatBox("(#5fa0a0PM#ffffff) Nie możesz wysyłać do #5fa0a0siebie #ffffffwiadomości", thePlayer, 255, 255, 255, true)
	        return false
	    end
	else
	    outputChatBox("(#5fa0a0PM#ffffff) Nie odnaleziono gracza", thePlayer, 255, 255, 255, true)
	    return false
	end
end
addCommandHandler("pm", privateMessage)
addCommandHandler("pw", privateMessage)
addCommandHandler("sms", privateMessage)
addCommandHandler("msg", privateMessage)

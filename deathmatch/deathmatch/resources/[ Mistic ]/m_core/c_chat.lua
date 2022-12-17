function messageSound()
   playSound("files/message.mp3", false)
end
addEvent("messageSound", true)
addEventHandler("messageSound", root, messageSound)
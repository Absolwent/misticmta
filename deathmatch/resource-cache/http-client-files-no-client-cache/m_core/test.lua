function komenda()
    showCursor(false)
    showChat(true)
    local pName = getPlayerName(localPlayer)
    setElementData(localPlayer, "playing", true)
    print("m_core | User "..pName.." was logged")
end
addCommandHandler("zaloguj", komenda)
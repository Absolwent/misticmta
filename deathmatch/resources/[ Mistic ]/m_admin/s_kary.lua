function enterVehicle ( player, seat, jacked )
    if player and seat == 0 then
        if getElementData(player, "PRAWKO") then
            cancelEvent()
            triggerClientEvent(player, "notiAdd", player, "error", "Nie możesz prowadzić tego pojazdu, ponieważ posiadasz zabrane prawo jazdy przez Administratora")
        end
    end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle )
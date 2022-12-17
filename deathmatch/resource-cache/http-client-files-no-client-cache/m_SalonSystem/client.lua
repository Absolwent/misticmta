function loadVehicleHandler()
    triggerServerEvent("loadVehicle", resourceRoot)
end
addEvent( "loadVehicleHandler ", true )
addEventHandler( "onGreeting", localPlayer, loadVehicleHandler )
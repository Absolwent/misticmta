function enableRadarAfterAuth()
    Map.instances = 0
end
addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), enableRadarAfterAuth)
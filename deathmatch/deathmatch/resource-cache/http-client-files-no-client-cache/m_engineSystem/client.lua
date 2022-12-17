function vehiclefailures()
    failede = true
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if ( vehicle and (getVehicleType(vehicle) == "Automobile")) then
		if getElementHealth(vehicle) < 550 then
		triggerServerEvent("Caroff", getRootElement(), vehicle)
		setTimer ( function()
		triggerServerEvent("Caron", getRootElement(), vehicle)
		end, 3000, 1 )
		end
	  end
    end

addEventHandler("onClientVehicleDamage", root, vehiclefailures)
addEventHandler("onClientVehicleEnter", root, vehiclefailures)

function enginefailures()
local vehicle = getPedOccupiedVehicle(localPlayer)
if ( vehicle and (getVehicleType(vehicle) == "Automobile")) then
if getElementHealth(vehicle) < 550 then
if not failede then return end
setTimer( function()
        if not failede then return end
        triggerServerEvent("failurex", getRootElement(), vehicle)
		triggerServerEvent("Caroff", getRootElement(), vehicle)
		setTimer ( function()
		triggerServerEvent("Caron", getRootElement(), vehicle)
		end, 3000, 1 )
		failede = false
		setTimer( function()
		failede = true
		end, 25000, 1 )
		end, 10, 1 )
end
end
end
addEventHandler ( "onClientPreRender", root, enginefailures )

function enginesoundf()
if not sounding then
setTimer ( function()
sounding = true
end, 5000, 1 )
end
end
addEvent ( "failureclient", true )
addEventHandler ( "failureclient", getRootElement ( ), enginesoundf )
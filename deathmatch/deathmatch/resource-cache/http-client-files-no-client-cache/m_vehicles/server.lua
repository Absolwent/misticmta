local buy = createMarker(1729.8371582031, -1785.6665039062, 13.4921875-1, "cylinder", 1.5, 255,255,255,175)

function loadVehicle()
    local pID = getElementData(source, "user:id")
    local result = exports["m_mysql"]:dbGet("SELECT * FROM m_vehicles WHERE owner=?", pID)
    if result and #result == 0 then return end
    local v=result[1]
    -- -- -- -- -- --
    print("Działa")
    if v.garage == 1 then
        local vehicle = createVehicle ( v.model, 1720.5153808594, -1782.0404052734, 312.71853637695 )
        setElementData(vehicle,"owner",v.pID)
    else
        local x, y, z = unpack(split(v.pos, ',')) 
        local vehicle = createVehicle ( v.model, x, y, z )
        setElementData(vehicle,"owner",v.pID)
    end
end
addEvent("loadVehicle", true)
addEventHandler("loadVehicle", root, loadVehicle)

function buyVehicle(hitElement)
    print("Coś się dzieje")
    local model = "510"
    local pos = "1734.3951416016, -1796.2907714844, 13.02277469635"
    local pID = getElementData(hitElement, "user:id")
    local query=exports["m_mysql"]:dbSet("INSERT INTO m_vehicles (owner, model, pos, garage) VALUES (?,?,?,??)", pID, model, pos, 0)
    --loadVehicle()
end
addEventHandler("onMarkerHit", buy, buyVehicle)

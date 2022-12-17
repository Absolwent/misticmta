addEvent("onZoneChanged", true);
addEvent("onCityChanged", true); -- sources are always local player. args are previous state, new state.

local x,y,z = getElementPosition(localPlayer);
local lastZone = getZoneName(x,y,z);
local lastCity = getZoneName(x,y,z, true);
---------------------------------------


-- detects when we change our location.
function a ()

    local x,y,z = getElementPosition(localPlayer);
    local Z =     getZoneName       (x, y, z);
    local C =     getZoneName       (x, y, z, true);

    if Z ~= lastZone then
        triggerEvent("onZoneChanged", localPlayer, lastZone, Z);
        lastZone = Z;
    end

    if C ~= lastCity then
        triggerEvent("onCityChanged", localPlayer, lastCity, C);
        lastCity = C;
    end
end
addEventHandler("onClientPreRender", root, a);
---------------------------------------



----------------------------------------------
local current_city_weathers = nil;
addEvent("environment:onServerSendCityWeathers", true);
addEventHandler("environment:onServerSendCityWeathers", localPlayer,
    function(newlist)
        current_city_weathers = newlist;
        setWeatherBlended( current_city_weathers[lastCity] )
    end
);

addEventHandler("onCityChanged", localPlayer,
    function(old_city, new_city)
        if current_city_weathers then -- if we have a table, then
            local new_weather = current_city_weathers[new_city];
            if new_weather then
                setWeatherBlended(new_weather);
            end
        end
    end
);

triggerServerEvent("environment:onClientRequestCityWeathers", localPlayer);
current_city_weathers = {}; -- when cities will update their current weather ID will be here.

setWeather(0); -- default weather before transition happens.

function get_city_random_weather (city)
    if city_weathers[city] then
        local randWeather = city_weathers[city][ math.random(#city_weathers[city]) ];
        return randWeather;
    else
        outputDebugString("unable to find suitable weather for " .. tostring(city) .. ", returning ID 0.")
        return 0;
    end
end

function set_city_new_weather (city_name, weather)
    current_city_weathers[city_name] = weather;

    outputDebugString(city_name .. "'s weather is now " .. weather);
end

function update_current_city_weathers ()
    for city_name, _ in pairs (city_weathers) do
        local new_weather = get_city_random_weather(city_name);
        set_city_new_weather(city_name, new_weather );
    end

    for _, player in pairs (getElementsByType("player")) do
        triggerClientEvent(player, "environment:onServerSendCityWeathers", player, current_city_weathers);
    end
end

-- set random weathers for cities at launch, and change it every now and then.
-- this can be changed from the admin panel.
update_current_city_weathers();

local update_mins = get("Weather Cycle Minutes") or 30;
outputDebugString("City weathers will change every " .. update_mins .. " minutes");
cycle_timer = setTimer(
    update_current_city_weathers,
    (update_mins*1000)*60,
    0
);

addEvent("environment:onClientRequestCityWeathers", true);
function update_city_weathers_for_client ()
    triggerClientEvent(client, "environment:onServerSendCityWeathers", client, current_city_weathers)
end
addEventHandler("environment:onClientRequestCityWeathers", root, update_city_weathers_for_client);


function curWeather (p)
    local x, y, z = getElementPosition(p);
    local city = getZoneName(x, y, z, true);
    local weather = current_city_weathers[city];

    if city and weather then
        outputChatBox("Weather for " .. city .. " is " .. weather, p, 0, 188, 255);
    else
        outputChatBox("invalid city or weather", p);
    end
end

addCommandHandler("weather", curWeather);
addCommandHandler("havadurumu", curWeather);
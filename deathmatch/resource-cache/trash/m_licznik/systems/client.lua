local sx, sy = guiGetScreenSize()

function scale_x(value)
    return value/(1920/sx)
end

function scale_y(value)
    return value/(1080/sy)
end

clientSpeedometer = {
    textures = {
        standard = {
            background = dxCreateTexture('images/standard/background.png', 'dxt5', false, 'clamp');
            arrow = dxCreateTexture('images/standard/arrow.png', 'dxt5', false, 'clamp');
            arrow_fuel = dxCreateTexture('images/standard/arrow_fuel.png', 'dxt5', false, 'clamp');
            dirt = dxCreateTexture('images/standard/dirt.png', 'dxt5', false, 'clamp');
        };
        sport = {
            background = dxCreateTexture('images/sport/background.png', 'dxt5', false, 'clamp');
            background_fuel = dxCreateTexture('images/sport/background_fuel.png', 'dxt5', false, 'clamp');
            arrow_speedo = dxCreateTexture('images/sport/arrow_speedo.png', 'dxt5', false, 'clamp');
            arrow_rpm = dxCreateTexture('images/sport/arrow_rpm.png', 'dxt5', false, 'clamp');
            arrow_fuel = dxCreateTexture('images/sport/arrow_fuel.png', 'dxt5', false, 'clamp')
        };
        motorcycle = {
            background = dxCreateTexture('images/motorcycle/background.png', 'dxt5', false, 'clamp');
            arrow_rpm = dxCreateTexture('images/motorcycle/arrow_rpm.png', 'dxt5', false, 'clamp');
            arrow_health = dxCreateTexture('images/motorcycle/arrow_health.png', 'dxt5', false, 'clamp');
            arrow_fuel = dxCreateTexture('images/motorcycle/arrow_fuel.png', 'dxt5', false, 'clamp');
        };
        icons = {
            seatbelt = {
                on = dxCreateTexture('images/icons/seatbelt_on.png', 'dxt5', false, 'clamp');
                off = dxCreateTexture('images/icons/seatbelt_off.png', 'dxt5', false, 'clamp');
            };
            light = {
                on = dxCreateTexture('images/icons/light_on.png', 'dxt5', false, 'clamp');
                off = dxCreateTexture('images/icons/light_off.png', 'dxt5', false, 'clamp');
            };
            indicator = {
                left = {
                    on = dxCreateTexture('images/icons/indicator_left_on.png', 'dxt5', false, 'clamp');
                    off = dxCreateTexture('images/icons/indicator_left_off.png', 'dxt5', false, 'clamp');
                };
                right = {
                    on = dxCreateTexture('images/icons/indicator_right_on.png', 'dxt5', false, 'clamp');
                    off = dxCreateTexture('images/icons/indicator_right_off.png', 'dxt5', false, 'clamp');
                }
            };
            handbrake = {
                on = dxCreateTexture('images/icons/handbrake_on.png', 'dxt5', false, 'clamp');
                off = dxCreateTexture('images/icons/handbrake_off.png', 'dxt5', false, 'clamp');
            };
            engine = {
                on = dxCreateTexture('images/icons/engine_on.png', 'dxt5', false, 'clamp');
                off = dxCreateTexture('images/icons/engine_off.png', 'dxt5', false, 'clamp');
            }
        }
    };
    screen = {
        standard = {
            background = {scale_x(1533); scale_y(672); scale_x(400); scale_y(400);};
            arrow = {scale_x(1533); scale_y(671); scale_x(400); scale_y(400);};
            arrow_fuel = {scale_x(1684); scale_y(920); scale_x(100); scale_y(100);};
            dirt = {scale_x(1533); scale_y(672); scale_x(400); scale_y(400);};
            mileage = {scale_x(1833); scale_y(972); scale_x(1635); scale_y(680);};
            gear = {scale_x(1831); scale_y(995); scale_x(1635); scale_y(745);};
            left_signal = {scale_x(1659), scale_y(766), scale_x(32), scale_y(32)};
            right_signal = {scale_x(1774), scale_y(766), scale_x(32), scale_y(32)};
            engine = {scale_x(1563); scale_y(865); scale_x(32); scale_y(32);};
            handbrake = {scale_x(1576); scale_y(906); scale_x(32); scale_y(32);};
            light = {scale_x(1598); scale_y(944); scale_x(32); scale_y(32);};
            seatbelt = {scale_x(1633); scale_y(971); scale_x(32); scale_y(32);};
        };
        sport = {
            background = {scale_x(1527); scale_y(675); scale_x(382); scale_y(382);};
            background_fuel = {scale_x(1596); scale_y(1020); scale_x(233); scale_y(48);};
            arrow_speedo = {scale_x(1527); scale_y(675); scale_x(382); scale_y(382);};
            arrow_rpm = {scale_x(1527); scale_y(675); scale_x(382); scale_y(382);};
            arrow_fuel = {scale_x(1603); scale_y(1027); scale_x(233); scale_y(233);};
            speed = {scale_x(1882); scale_y(995); scale_x(1553); scale_y(775);};
            gear = {scale_x(1882); scale_y(1003); scale_x(1553); scale_y(840);};
            left_signal = {scale_x(1659), scale_y(986), scale_x(24), scale_y(24)};
            right_signal = {scale_x(1753), scale_y(986), scale_x(24), scale_y(24)};
            engine = {scale_x(1707); scale_y(849); scale_x(16); scale_y(16);};
            handbrake = {scale_x(1726); scale_y(849); scale_x(16); scale_y(16);};
            light = {scale_x(1688); scale_y(849); scale_x(16); scale_y(16);};
            seatbelt = {scale_x(1702); scale_y(990); scale_x(24); scale_y(24);};
        };
        motorcycle = {
            background = {scale_x(689); scale_y(897); scale_x(529); scale_y(183);};
            speed = {scale_x(884); scale_y(995); scale_x(1035); scale_y(997);};
            left_signal = {scale_x(877), scale_y(1033), scale_x(17), scale_y(17)};
            right_signal = {scale_x(1024), scale_y(1033), scale_x(17), scale_y(17)};
            engine = {scale_x(923); scale_y(1033); scale_x(17); scale_y(17);};
            handbrake = {scale_x(951); scale_y(1033); scale_x(17); scale_y(17);};
            light = {scale_x(980); scale_y(1033); scale_x(17); scale_y(17);};
            arrow_rpm = {scale_x(753); scale_y(913); scale_x(237); scale_y(237);};
            arrow_health = {scale_x(939); scale_y(913); scale_x(237); scale_y(237);};
        };
    };
    fonts = {
        regular = dxCreateFont('fonts/OpenSans-Regular.ttf', scale_x(12), false) or 'default';
        bold = dxCreateFont('fonts/OpenSans-Bold.ttf', scale_x(13), false, 'antialiased') or 'default-bold';
        bold3 = dxCreateFont('fonts/OpenSans-Bold.ttf', scale_x(24), false, 'antialiased') or 'default-bold';
        bold2 = dxCreateFont('fonts/OpenSans-Bold.ttf', scale_x(53), false, 'antialiased') or 'default-bold';
    };
    standardAnims = {};
    motorcycleAnims = {};
    sportAnims = {};
    type = {
        standard = {
            [604] = true;
            [439] = true;
            [605] = true;
            [554] = true;
            [404] = true;
            [410] = true;
            [600] = true;
            [436] = true;
            [549] = true;
            [424] = true;
            [546] = true;
            [546] = true;
            [550] = true;
            [540] = true;
            [422] = true;
            [543] = true;
            [478] = true;
            [542] = true;
            [418] = true;
            [440] = true;
            [483] = true;
        };
        motorcycle = {
            [462] = true;
            [581] = true;
            [521] = true;
            [463] = true;
            [522] = true;
            [461] = true;
            [448] = true;
            [468] = true;
            [586] = true;
            [523] = true;
        };
        sport = {
            [602] = true;
            [507] = true;
            [585] = true;
            [466] = true;
            [492] = true;
            [541] = true;
            [415] = true;
            [480] = true;
            [562] = true;
            [565] = true;
            [434] = true;
            [494] = true;
            [429] = true;
            [503] = true;
            [411] = true;
            [559] = true;
            [561] = true;
            [560] = true;
            [506] = true;
            [451] = true;
            [558] = true;
            [555] = true;
            [477] = true;
            [496] = true;
            [551] = true;
            [516] = true;
            [467] = true;
            [426] = true;
            [405] = true;
            [580] = true;
            [409] = true;
            [566] = true;
            [421] = true;
            [529] = true;
            [401] = true;
            [518] = true;
            [527] = true;
            [589] = true;
            [419] = true;
            [587] = true;
            [533] = true;
            [526] = true;
            [474] = true;
            [545] = true;
            [517] = true;
            [491] = true;
            [445] = true;
            [459] = true;
            [482] = true;
            [413] = true;
            [554] = true;
            [579] = true;
            [400] = true;
            [489] = true;
            [505] = true;
            [479] = true;
            [458] = true;
            [536] = true;
            [575] = true;
            [567] = true;
            [535] = true;
            [576] = true;
            [412] = true;
            [402] = true;
            [603] = true;
            [475] = true;
            [568] = true;
            [504] = true;
            [508] = true;
            [495] = true;
        };
    }
};

function clientSpeedometer.getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 10 or ((unit == 1 or unit == "km/h") and 144 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function clientSpeedometer.getVehicleRPM(vehicle)
    local vehicleRPM = 0
    if (vehicle) then
        if (getVehicleEngineState(vehicle) == true) then
            if getVehicleCurrentGear(vehicle) > 0 then
                vehicleRPM = math.floor(((clientSpeedometer.getElementSpeed(vehicle, "km/h") / getVehicleCurrentGear(vehicle)) * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            else
                vehicleRPM = math.floor((clientSpeedometer.getElementSpeed(vehicle, "km/h") * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            end
        else
            vehicleRPM = 0
        end

        return tonumber(vehicleRPM)
    else
        return 0
    end
end

function clientSpeedometer.drawStandardSpeedometer()
    clientSpeedometer.vehicle = getPedOccupiedVehicle(localPlayer)
    if not clientSpeedometer.vehicle and clientSpeedometer.speedoStandardState then
        clientSpeedometer.toggleStandardSpeedometer(false)
    end
    gui = clientSpeedometer.screen.standard
    clientSpeedometer.vehicleSpeed = (clientSpeedometer.vehicle and getVehicleSpeed(clientSpeedometer.vehicle) or 0)
    clientSpeedometer.vehicleMileage = (getElementData(clientSpeedometer.vehicle, 'vehicle:mileage') or 0)

    dxDrawImage(gui.background[1], gui.background[2], gui.background[3], gui.background[4], clientSpeedometer.textures.standard.background, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.standardAlpha))

    dxDrawImage(gui.arrow_fuel[1], gui.arrow_fuel[2], gui.arrow_fuel[3], gui.arrow_fuel[4], clientSpeedometer.textures.standard.arrow_fuel, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.standardAlpha))


    if (clientSpeedometer.vehicleMileage) then
        dxDrawText(string.format("%08d", clientSpeedometer.vehicleMileage)..'km', gui.mileage[1], gui.mileage[2], gui.mileage[3], gui.mileage[4], tocolor(215, 215, 215, clientSpeedometer.standardAlpha), 1.00, clientSpeedometer.fonts.regular, "center", "center")
    end

    clientSpeedometer.isEngine = (clientSpeedometer.vehicle and getVehicleEngineState(clientSpeedometer.vehicle) or false)
    clientSpeedometer.texture = (clientSpeedometer.isEngine and clientSpeedometer.textures.icons.engine.on or clientSpeedometer.textures.icons.engine.off)
    dxDrawImage(gui.engine[1], gui.engine[2], gui.engine[3], gui.engine[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.standardAlpha))

    clientSpeedometer.isHandbrake = (clientSpeedometer.vehicle and isElementFrozen(clientSpeedometer.vehicle) or false)
    clientSpeedometer.texture = (clientSpeedometer.isHandbrake and clientSpeedometer.textures.icons.handbrake.on or clientSpeedometer.textures.icons.handbrake.off)
    dxDrawImage(gui.handbrake[1], gui.handbrake[2], gui.handbrake[3], gui.handbrake[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.standardAlpha))

    clientSpeedometer.isLights = (clientSpeedometer.vehicle and areVehicleLightsOn(clientSpeedometer.vehicle) or false)
    clientSpeedometer.texture = (clientSpeedometer.isLights and clientSpeedometer.textures.icons.light.on or clientSpeedometer.textures.icons.light.off)
    dxDrawImage(gui.light[1], gui.light[2], gui.light[3], gui.light[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.standardAlpha))

    clientSpeedometer.isLeftIndicator = false
    clientSpeedometer.texture = (clientSpeedometer.isLeftIndicator and clientSpeedometer.textures.icons.indicator.left.on or clientSpeedometer.textures.icons.indicator.left.off)
    dxDrawImage(gui.left_signal[1], gui.left_signal[2], gui.left_signal[3], gui.left_signal[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.standardAlpha))

    clientSpeedometer.isRightIndicator = false
    clientSpeedometer.texture = (clientSpeedometer.isRightIndicator and clientSpeedometer.textures.icons.indicator.right.on or clientSpeedometer.textures.icons.indicator.right.off)
    dxDrawImage(gui.right_signal[1], gui.right_signal[2], gui.right_signal[3], gui.right_signal[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.standardAlpha))

    dxDrawImage(gui.arrow[1], gui.arrow[2], gui.arrow[3], gui.arrow[4], clientSpeedometer.textures.standard.arrow, clientSpeedometer.vehicleSpeed, 0, 0, tocolor(255, 255, 255, clientSpeedometer.standardAlpha))
    dxDrawText(getVehicleCurrentGear(clientSpeedometer.vehicle), gui.gear[1], gui.gear[2], gui.gear[3], gui.gear[4], tocolor(215, 215, 215, clientSpeedometer.standardAlpha), 1.00, clientSpeedometer.fonts.bold, "center", "center")

    dxDrawImage(gui.dirt[1], gui.dirt[2], gui.dirt[3], gui.dirt[4], clientSpeedometer.textures.standard.dirt, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.standardAlpha))
end

function clientSpeedometer.drawMotorcycleSpeedometer()
    clientSpeedometer.vehicle = getPedOccupiedVehicle(localPlayer)
    if not clientSpeedometer.vehicle and clientSpeedometer.speedoMotorcycleState then
        clientSpeedometer.toggleMotorcycleSpeedometer(false)
    end
    gui = clientSpeedometer.screen.motorcycle
    clientSpeedometer.vehicleSpeed = (clientSpeedometer.vehicle and getVehicleSpeed(clientSpeedometer.vehicle) or 0)
    clientSpeedometer.vehicleRPM = clientSpeedometer.getVehicleRPM(clientSpeedometer.vehicle)/8000 * 130
    clientSpeedometer.vehicleHealth = getElementHealth(clientSpeedometer.vehicle)

    dxDrawImage(gui.background[1], gui.background[2], gui.background[3], gui.background[4], clientSpeedometer.textures.motorcycle.background, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.motorcycleAlpha))

    clientSpeedometer.isEngine = (clientSpeedometer.vehicle and getVehicleEngineState(clientSpeedometer.vehicle) or false)
    clientSpeedometer.texture = (clientSpeedometer.isEngine and clientSpeedometer.textures.icons.engine.on or clientSpeedometer.textures.icons.engine.off)
    dxDrawImage(gui.engine[1], gui.engine[2], gui.engine[3], gui.engine[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.motorcycleAlpha))

    clientSpeedometer.isHandbrake = (clientSpeedometer.vehicle and isElementFrozen(clientSpeedometer.vehicle) or false)
    clientSpeedometer.texture = (clientSpeedometer.isHandbrake and clientSpeedometer.textures.icons.handbrake.on or clientSpeedometer.textures.icons.handbrake.off)
    dxDrawImage(gui.handbrake[1], gui.handbrake[2], gui.handbrake[3], gui.handbrake[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.motorcycleAlpha))

    clientSpeedometer.isLights = (clientSpeedometer.vehicle and areVehicleLightsOn(clientSpeedometer.vehicle) or false)
    clientSpeedometer.texture = (clientSpeedometer.isLights and clientSpeedometer.textures.icons.light.on or clientSpeedometer.textures.icons.light.off)
    dxDrawImage(gui.light[1], gui.light[2], gui.light[3], gui.light[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.motorcycleAlpha))

    clientSpeedometer.isLeftIndicator = false
    clientSpeedometer.texture = (clientSpeedometer.isLeftIndicator and clientSpeedometer.textures.icons.indicator.left.on or clientSpeedometer.textures.icons.indicator.left.off)
    dxDrawImage(gui.left_signal[1], gui.left_signal[2], gui.left_signal[3], gui.left_signal[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.motorcycleAlpha))

    clientSpeedometer.isRightIndicator = false
    clientSpeedometer.texture = (clientSpeedometer.isRightIndicator and clientSpeedometer.textures.icons.indicator.right.on or clientSpeedometer.textures.icons.indicator.right.off)
    dxDrawImage(gui.right_signal[1], gui.right_signal[2], gui.right_signal[3], gui.right_signal[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.motorcycleAlpha))

    dxDrawImage(gui.arrow_rpm[1], gui.arrow_rpm[2], gui.arrow_rpm[3], gui.arrow_rpm[4], clientSpeedometer.textures.motorcycle.arrow_rpm, clientSpeedometer.vehicleRPM, 0, 0, tocolor(255, 255, 255, clientSpeedometer.motorcycleAlpha))

    dxDrawImage(gui.arrow_health[1], gui.arrow_health[2], gui.arrow_health[3], gui.arrow_health[4], clientSpeedometer.textures.motorcycle.arrow_health, -118, 0, 0, tocolor(255, 255, 255, clientSpeedometer.motorcycleAlpha))

    dxDrawText(string.format("%03d", clientSpeedometer.vehicleSpeed)..'', gui.speed[1], gui.speed[2], gui.speed[3], gui.speed[4], tocolor(185, 185, 185, clientSpeedometer.motorcycleAlpha), 1.00, clientSpeedometer.fonts.bold2, "center", "center")
end

function clientSpeedometer.drawSportSpeedometer()
    clientSpeedometer.vehicle = getPedOccupiedVehicle(localPlayer)
    if not clientSpeedometer.vehicle and clientSpeedometer.speedoSportState then
        clientSpeedometer.toggleSportSpeedometer(false)
    end
    gui = clientSpeedometer.screen.sport
    clientSpeedometer.vehicleSpeed = (clientSpeedometer.vehicle and getVehicleSpeed(clientSpeedometer.vehicle) or 0)
    clientSpeedometer.vehicleRPM = clientSpeedometer.getVehicleRPM(clientSpeedometer.vehicle)/8000 * 288

    dxDrawImage(gui.background[1], gui.background[2], gui.background[3], gui.background[4], clientSpeedometer.textures.sport.background, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))
    dxDrawImage(gui.background_fuel[1], gui.background_fuel[2], gui.background_fuel[3], gui.background_fuel[4], clientSpeedometer.textures.sport.background_fuel, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))

    dxDrawText(string.format("%03d", clientSpeedometer.vehicleSpeed)..'', gui.speed[1], gui.speed[2], gui.speed[3], gui.speed[4], tocolor(185, 185, 185, clientSpeedometer.sportAlpha), 1.00, clientSpeedometer.fonts.bold3, "center", "center")
    dxDrawText(getVehicleCurrentGear(clientSpeedometer.vehicle), gui.gear[1], gui.gear[2], gui.gear[3], gui.gear[4], tocolor(185, 185, 185, clientSpeedometer.sportAlpha), 1.00, clientSpeedometer.fonts.bold3, "center", "center")

    clientSpeedometer.isEngine = (clientSpeedometer.vehicle and getVehicleEngineState(clientSpeedometer.vehicle) or false)
    clientSpeedometer.texture = (clientSpeedometer.isEngine and clientSpeedometer.textures.icons.engine.on or clientSpeedometer.textures.icons.engine.off)
    dxDrawImage(gui.engine[1], gui.engine[2], gui.engine[3], gui.engine[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))

    clientSpeedometer.isHandbrake = (clientSpeedometer.vehicle and isElementFrozen(clientSpeedometer.vehicle) or false)
    clientSpeedometer.texture = (clientSpeedometer.isHandbrake and clientSpeedometer.textures.icons.handbrake.on or clientSpeedometer.textures.icons.handbrake.off)
    dxDrawImage(gui.handbrake[1], gui.handbrake[2], gui.handbrake[3], gui.handbrake[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))

    clientSpeedometer.isLights = (clientSpeedometer.vehicle and areVehicleLightsOn(clientSpeedometer.vehicle) or false)
    clientSpeedometer.texture = (clientSpeedometer.isLights and clientSpeedometer.textures.icons.light.on or clientSpeedometer.textures.icons.light.off)
    dxDrawImage(gui.light[1], gui.light[2], gui.light[3], gui.light[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))

    clientSpeedometer.isSeatbelt = true
    clientSpeedometer.texture = (clientSpeedometer.isSeatbelt and clientSpeedometer.textures.icons.seatbelt.on or clientSpeedometer.textures.icons.seatbelt.off)
    dxDrawImage(gui.seatbelt[1], gui.seatbelt[2], gui.seatbelt[3], gui.seatbelt[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))

    clientSpeedometer.isLeftIndicator = true
    clientSpeedometer.texture = (clientSpeedometer.isLeftIndicator and clientSpeedometer.textures.icons.indicator.left.on or clientSpeedometer.textures.icons.indicator.left.off)
    dxDrawImage(gui.left_signal[1], gui.left_signal[2], gui.left_signal[3], gui.left_signal[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))

    clientSpeedometer.isRightIndicator = false
    clientSpeedometer.texture = (clientSpeedometer.isRightIndicator and clientSpeedometer.textures.icons.indicator.right.on or clientSpeedometer.textures.icons.indicator.right.off)
    dxDrawImage(gui.right_signal[1], gui.right_signal[2], gui.right_signal[3], gui.right_signal[4], clientSpeedometer.texture, 0, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))

    dxDrawImage(gui.arrow_speedo[1], gui.arrow_speedo[2], gui.arrow_speedo[3], gui.arrow_speedo[4], clientSpeedometer.textures.sport.arrow_speedo, clientSpeedometer.vehicleSpeed, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))
    dxDrawImage(gui.arrow_rpm[1], gui.arrow_rpm[2], gui.arrow_rpm[3], gui.arrow_rpm[4], clientSpeedometer.textures.sport.arrow_rpm, clientSpeedometer.vehicleRPM, 0, 0, tocolor(255, 255, 255, clientSpeedometer.sportAlpha))
end

clientSpeedometer.toggleStandardSpeedometer = function(state)
    clientSpeedometer.speedoStandardState = state
    for i, v in ipairs(clientSpeedometer.standardAnims or {}) do destroyAnimation(v) end
    clientSpeedometer.standardAnims = {}
    if state then
        removeEventHandler("onClientRender", getRootElement(), clientSpeedometer.drawStandardSpeedometer)
        addEventHandler("onClientRender", getRootElement(), clientSpeedometer.drawStandardSpeedometer)
        clientSpeedometer.standardAnims[#clientSpeedometer.standardAnims+1] = animate(0, 255, "InOutQuad", 300, function(x)
            clientSpeedometer.standardAlpha = x
        end)
    else
        clientSpeedometer.standardAnims[#clientSpeedometer.standardAnims+1] = animate((clientSpeedometer.standardAlpha or 255), 0, "InOutQuad", ((clientSpeedometer.standardAlpha or 255)/255)*310, function(x)
            clientSpeedometer.standardAlpha = x
        end, function()
            removeEventHandler("onClientRender", getRootElement(), clientSpeedometer.drawStandardSpeedometer)
        end)
    end
end

clientSpeedometer.toggleMotorcycleSpeedometer = function(state)
    clientSpeedometer.speedoMotorcycleState = state
    for i, v in ipairs(clientSpeedometer.motorcycleAnims or {}) do destroyAnimation(v) end
    clientSpeedometer.motorcycleAnims = {}
    if state then
        removeEventHandler("onClientRender", getRootElement(), clientSpeedometer.drawMotorcycleSpeedometer)
        addEventHandler("onClientRender", getRootElement(), clientSpeedometer.drawMotorcycleSpeedometer)
        clientSpeedometer.motorcycleAnims[#clientSpeedometer.motorcycleAnims+1] = animate(0, 255, "InOutQuad", 300, function(x)
            clientSpeedometer.motorcycleAlpha = x
        end)
    else
        clientSpeedometer.motorcycleAnims[#clientSpeedometer.motorcycleAnims+1] = animate((clientSpeedometer.motorcycleAlpha or 255), 0, "InOutQuad", ((clientSpeedometer.motorcycleAlpha or 255)/255)*310, function(x)
            clientSpeedometer.motorcycleAlpha = x
        end, function()
            removeEventHandler("onClientRender", getRootElement(), clientSpeedometer.drawMotorcycleSpeedometer)
        end)
    end
end

clientSpeedometer.toggleSportSpeedometer = function(state)
    clientSpeedometer.speedoSportState = state
    for i, v in ipairs(clientSpeedometer.sportAnims or {}) do destroyAnimation(v) end
    clientSpeedometer.sportAnims = {}
    if state then
        removeEventHandler("onClientRender", getRootElement(), clientSpeedometer.drawSportSpeedometer)
        addEventHandler("onClientRender", getRootElement(), clientSpeedometer.drawSportSpeedometer)
        clientSpeedometer.sportAnims[#clientSpeedometer.sportAnims+1] = animate(0, 255, "InOutQuad", 300, function(x)
            clientSpeedometer.sportAlpha = x
        end)
    else
        clientSpeedometer.sportAnims[#clientSpeedometer.sportAnims+1] = animate((clientSpeedometer.sportAlpha or 255), 0, "InOutQuad", ((clientSpeedometer.sportAlpha or 255)/255)*310, function(x)
            clientSpeedometer.sportAlpha = x
        end, function()
            removeEventHandler("onClientRender", getRootElement(), clientSpeedometer.drawSportSpeedometer)
        end)
    end
end

addEventHandler("onClientVehicleEnter", getRootElement(), function(player, seat)
    if player ~= localPlayer then return false end
    clientSpeedometer.vehicle = getPedOccupiedVehicle(player)
    if clientSpeedometer.type.standard[getElementModel(clientSpeedometer.vehicle)] then
        clientSpeedometer.toggleStandardSpeedometer(true)
    elseif clientSpeedometer.type.motorcycle[getElementModel(clientSpeedometer.vehicle)] then
        clientSpeedometer.toggleMotorcycleSpeedometer(true)
    elseif clientSpeedometer.type.sport[getElementModel(clientSpeedometer.vehicle)] then
        clientSpeedometer.toggleSportSpeedometer(true)
    end
end)

addEventHandler("onClientResourceStart", getResourceRootElement(), function()
    clientSpeedometer.vehicle = getPedOccupiedVehicle(localPlayer)
    if isPedInVehicle(localPlayer) then 
        if clientSpeedometer.type.standard[getElementModel(clientSpeedometer.vehicle)] then
            clientSpeedometer.toggleStandardSpeedometer(true)
        elseif clientSpeedometer.type.motorcycle[getElementModel(clientSpeedometer.vehicle)] then
            clientSpeedometer.toggleMotorcycleSpeedometer(true)
        elseif clientSpeedometer.type.sport[getElementModel(clientSpeedometer.vehicle)] then
            clientSpeedometer.toggleSportSpeedometer(true)
        end
    end
end)

function getVehicleSpeed(vehicle)
    local vx, vy, vz = getElementVelocity(vehicle)
    return math.sqrt(vx^2+vy^2+vz^2)*155
end
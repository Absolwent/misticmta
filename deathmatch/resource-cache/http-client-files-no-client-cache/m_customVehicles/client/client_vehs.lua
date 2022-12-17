--[[ 

    author: Asper (© 2019)
    helps: CooqieEZ, Masterus, Nexusik
	mail: nezymr69@gmail.com
    all rights reserved.

]]

-- cylinders

local cylinders={
    [1.0]="R4",
    [1.2]="R4",
    [1.4]="R4",
    [1.6]="R4",
    [1.8]="R6",
    [2.0]="R6",
    [2.7]="V6",
    [3.0]="V6",
    [3.2]="V8",
    [3.6]="V6",
    [3.8]="V6",
    [4.2]="V12",
    [5.0]="V8",
    [5.2]="V10",
    [5.8]="V8",
    [6.3]="V8",
    [6.7]="V8",
    [8.0]="W16",
}

function getEngineCylinders(engine)
    return cylinders[engine] or ""
end

-- engines

local engines={
    [448]="0.1", -- pizza boy
    [461]="0.6", -- pcj-600
    [462]="0.05", -- faggio
    [463]="0.750", -- freeway
    [468]="0.500", -- sanchez
    [481]="1.2", -- bmx
    [509]="1.2", -- bike
    [510]="1.2", -- mtb
    [521]="0.9", -- fcr-900
    [522]="1.5", -- nrg-500
    [581]="0.4", -- bf-400
    [586]="0.75", -- wayfarer
    [401]="1.2", -- bravura
    [410]="1.0", -- manana
    [419]="1.6", -- esperanto
    [436]="1.4", -- previon
    [439]="1.8", -- stallion
    [474]="1.4", -- hermes
    [491]="1.4", -- virgo
    [496]="1.6", -- blista
    [517]="1.6", -- majestic
    [518]="1.6", -- buccaneer
    [526]="1.8", -- fortune
    [527]="1.4", -- cadrona
    [533]="1.6", -- feltzer
    [545]="3.2", -- hustler
    [549]="1.2", -- tampa
    [587]="2.0", -- euros
    [589]="1.6", -- club
    [600]="1.6", -- picador
    [602]="2.0", -- alpha
    [405]="2.0", -- sentinel
    [409]="3.8", -- stretch
    [421]="1.8", -- washington
    [426]="2.0", -- premier
    [445]="1.6", -- admiral
    [466]="1.4", -- glendale
    [467]="1.4", -- oceanic
    [492]="1.4", -- greenwood
    [507]="1.4", -- elegant
    [516]="1.4", -- nebula
    [529]="1.4", -- willard
    [540]="1.2", -- vincent
    [546]="1.4", -- intruder
    [547]="1.4", -- primo
    [550]="1.4", -- sunrise
    [551]="1.6", -- merit
    [566]="1.8", -- tahoma
    [580]="3.0", -- stafford
    [585]="1.8", -- emperor
    [408]="3.2", -- trashmaster
    [420]="2.0", -- taxi
    [431]="3.2", -- bus
    [437]="3.2", -- coach
    [438]="1.6", -- cabbie
    [485]="1.0", -- baggage
    [525]="1.8", -- towtruck
    [552]="1.4", -- utillity ban
    [574]="1.0", -- sweeper
    [416]="2.0", -- ambulance
    [433]="1.4", -- barracks
    [427]="1.4", -- enforcer
    [490]="3.6", -- fbi rancher
    [528]="3.6", -- fbi truck
    [407]="3.2", -- fire truck
    [544]="3.2", -- fire truck 2
    [523]="1.2", -- hpv1000
    [470]="3.2", -- patriot
    [596]="5.0", -- police ls
    [597]="5.0", -- police sf
    [598]="5.0", -- police lv
    [432]="1.2", -- rhino
    [599]="3.2", -- police ranger
    [601]="4.2", -- s.w.a.t.
    [428]="3.6", -- sacuricar
    [499]="2.7", -- benson
    [609]="2.0", -- black boxville
    [498]="2.0", -- boxville
    [524]="2.7", -- cement truck
    [532]="1.4", -- combine harvester
    [578]="3.2", -- dft-30
    [486]="3.0", -- dozer
    [406]="3.0", -- dumper
    [573]="3.0", -- dune
    [455]="3.2", -- flatbed
    [588]="1.6", -- hotdog
    [403]="1.6", -- linerunner
    [423]="1.6", -- mr. whoopee
    [414]="3.2", -- mule
    [443]="1.6", -- packer
    [515]="1.6", -- roadtrain
    [514]="1.6", -- tanker
    [531]="1.6", -- tractor
    [456]="1.6", -- yankee
    [536]="1.6", -- blade
    [575]="1.6", -- broadway
    [534]="1.6", -- remington
    [567]="1.6", -- savanna
    [535]="2.0", -- slamvan
    [576]="1.6", -- tornado
    [412]="1.6", -- voodoo
    [402]="3.2", -- buffalo
    [542]="1.8", -- clover
    [603]="3.2", -- phoenix
    [475]="2.7", -- sabre
    [459]="1.0", -- rc van
    [422]="1.2", -- bobcat
    [482]="1.8", -- burrito
    [530]="1.0", -- forklift
    [418]="1.0", -- moonbeam
    [572]="1.0", -- mower
    [582]="1.4", -- news van
    [413]="1.4", -- pony
    [440]="1.4", -- rumpo
    [543]="1.0", -- sadler
    [583]="1.4", -- tug
    [478]="1.0", -- walton
    [554]="2.0", -- yosemite
    [579]="2.7", -- huntley
    [400]="1.8", -- landstalker
    [404]="1.2", -- perennial
    [489]="2.7", -- rancher
    [505]="2.7", -- rancher2
    [479]="1.8", -- regina
    [442]="1.6", -- remero
    [458]="1.4", -- solair
    [429]="4.2", -- banshee
    [541]="6.3", -- bullet
    [415]="5.0", -- cheetah
    [480]="3.8", -- comet
    [562]="5.0", -- elegy
    [565]="3.0", -- flash
    [434]="4.2", -- hotknife
    [411]="8.0", -- infernus
    [559]="3.8", -- jester
    [561]="3.0", -- stratum
    [560]="3.8", -- sultan
    [506]="3.6", -- super gt
    [451]="6.7", -- turismo
    [558]="3.6", -- uranus
    [555]="2.7", -- windsor
    [477]="3.6", -- zr-350
    [568]="3.2", -- bandito
    [424]="3.2", -- bf injection
    [508]="1.6", -- journey
    [483]="1.8", -- camper
    [500]="1.6", -- mesa
    [471]="0.125", -- quadbike
    [495]="5.0", -- sandking
}

function getVehicleEngineFromModel(model)
    return engines[model] or "1.2"
end

function getVehicleEngineFromName(name)
    local model=getVehicleModelFromName(name)
    return engines[model] or "1.2"
end

-- fuels

local types={
    ["Diesel"]="ON",
    ["Benzyna"]="PB-95",
    ["LPG"]="LPG",
}

function getVehicleTankFuelType(type)
    return types[type] or "ON"
end

function getVehicleFuelType(type)
    local on=type
    for i,v in pairs(types) do
        if(v == type)then
            on=i
            break
        end
    end
    return on
end

-- fuel usage

local default_usage=6 -- 10L paliwa na 100km przy pojemności 1.0

function getFuelUsage(engine)
    return default_usage*engine
end
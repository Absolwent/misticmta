-- Kod jest piękny, wiem <3

function loadElements()
    ped1 = createPed(0, 1766.8138427734, -1862.4100341797, 13.576329231262)
    setElementRotation(ped1, 0,0,0)
    pedTrain = createPed(0, 1715.9884033203, -1946.4500732422, 13.559260368347, 0,0,0)
    pedTrain2 = createPed(172, 1717.0789794922, -1947.0192871094, 13.557174682617, 0,0,0)
    pedTrain3 = createPed(19, 1714.0085449219, -1947.091796875, 13.556909561157, 0,0,0)
    pedTrain4 = createPed(20, 1714.9477539062, -1944.8541259766, 13.565531730652, 0,0,0)
    pedTrain5 = createPed(35, 1716.9378662109, -1944.4477539062, 13.567287445068, 0,0,0)
    pedTrain6 = createPed(26, 1716.0529785156, -1943.3796386719, 13.567420959473, 0,0,0)
    pedTrain7 = createPed(57, 1713.1097412109, -1944.8079833984, 13.564218521118, 0,0,0)
    pedTrain8 = createPed(64, 1714.9320068359, -1942.2957763672, 13.574940681458, 0,0,0)

    setPedAnimation(pedTrain , "ped", "WOMAN_walknorm")
    setElementRotation(pedTrain, 0,0,0)
    setElementFrozen(pedTrain, false)

    setPedAnimation(pedTrain2, "ped", "WOMAN_walknorm")
    setElementRotation(pedTrain2, 0,0,0)
    setElementFrozen(pedTrain2, false)

    setPedAnimation(pedTrain3, "ped", "WOMAN_walknorm")
    setElementRotation(pedTrain3, 0,0,0)
    setElementFrozen(pedTrain3, false)

    setPedAnimation(pedTrain4, "ped", "WOMAN_walknorm")
    setElementRotation(pedTrain4, 0,0,0)
    setElementFrozen(pedTrain4, false)

    setPedAnimation(pedTrain5, "ped", "WOMAN_walknorm")
    setElementRotation(pedTrain5, 0,0,0)
    setElementFrozen(pedTrain5, false)

    setPedAnimation(pedTrain6, "ped", "WOMAN_walknorm")
    setElementRotation(pedTrain6, 0,0,0)
    setElementFrozen(pedTrain6, false)

    setPedAnimation(pedTrain7, "ped", "WOMAN_walknorm")
    setElementRotation(pedTrain7, 0,0,0)
    setElementFrozen(pedTrain7, false)

    setPedAnimation(pedTrain8, "ped", "WOMAN_walknorm")
    setElementRotation(pedTrain8, 0,0,0)
    setElementFrozen(pedTrain8, false)

    Train = createVehicle(570, 1699.0771484375, -1953.6525878906, 15.014403343201)
    Train2 = createVehicle(570, 1720.9951171875, -1930.8395996094, 13.865208625793)
    Train3 = createVehicle(538, 1724.9951171875, -1930.8395996094, 13.865208625793)
    attachTrailerToVehicle(Train3, Train2)
    attachTrailerToVehicle(Train2, Train)
end

function loadNewPlayer()
    introSound = playSound("files/introSound.mp3", false)
    setSoundVolume( introSound, 1 )
    setCameraMatrix(-401.81411743164, -433.19088745117, 17.203125, -395.4665222168, -432.11416625977, 16.203125)
    setTimer(loadIntroCinematic, 1, 1)
    setElementData(localPlayer, "radar:showed", false)
    setElementData(localPlayer, "hud:showed", false)
end
addEvent( "loadNewPlayer", true )
addEventHandler( "loadNewPlayer", localPlayer, loadNewPlayer)

function CameraOne()
    setCameraMatrix(-240.85618591309, -482.73263549805, 61.898586273193)
    setTimer(CameraTwo, 2000, 1)
end
addEvent( "CameraOne", true )
addEventHandler( "CameraOne", localPlayer, CameraOne)

function CameraTwo()
    setCameraMatrix(-494.12414550781, -1171.5701904297, 83.290786743164)
    setTimer(CameraThree, 2000, 1)
end
addEvent( "CameraTwo", true )
addEventHandler( "CameraTwo", localPlayer, CameraTwo)

function CameraThree()
    setCameraMatrix(-535.64349365234, -1509.4210205078, 38.457897186279)
    setTimer(TrainCamera, 2000, 1)
end
addEvent( "CameraThree", true )
addEventHandler( "CameraThree", localPlayer, CameraThree)

function TrainCamera()
    stopSound(introSound)
    setCameraMatrix(1710.0256347656, -1936.8784179688, 13.575216293335, 1715.1549072266, -1948.0891113281, 14.1171875)
    local voice = playSound("files/intro.mp3", false)
    setSoundVolume( voice, 1.5 )
    setTimer(CameraFour, 8000, 1)
end
addEvent("TrainCamera", true)

function CameraFour()
    setElementPosition(pedTrain, 1715.0554199219, -1904.7532958984, 13.566546440125)
    setPedAnimation(pedTrain , "ped", "WOMAN_walknorm")
    setElementRotation(pedTrain, 0,0,0)
    setElementFrozen(pedTrain, false)
    setCameraMatrix(1703.3668212891, -1898.0285644531, 13.569400787354, 1713.3753662109, -1898.0418701172, 13.566956520081)
    setTimer(CameraSix, 8000, 1)

    setElementPosition(pedTrain2, 1717.2022705078, -1903.2507324219, 13.56602191925)
    setPedAnimation(pedTrain2, "ped", "WOMAN_walknorm")

    setElementPosition(pedTrain3, 1713.0870361328, -1902.1843261719, 13.56702709198)
    setPedAnimation(pedTrain3, "ped", "WOMAN_walknorm")

    setElementPosition(pedTrain4, 1714.4267578125, -1900.666015625, 13.566699981689)
    setPedAnimation(pedTrain4, "ped", "WOMAN_walknorm")

    setElementPosition(pedTrain5, 1716.2144775391, -1899.4962158203, 13.566263198853)
    setPedAnimation(pedTrain5, "ped", "WOMAN_walknorm")

    setElementPosition(pedTrain6, 1713.1752929688, -1893.3560791016, 13.567005157471)
    setPedAnimation(pedTrain6, "ped", "WOMAN_walknorm")

    setElementPosition(pedTrain7, 1717.3275146484, -1887.0241699219, 13.565991401672)
    setPedAnimation(pedTrain7, "ped", "WOMAN_walknorm")

    setElementPosition(pedTrain8, 1714.0958251953, -1893.1810302734, 13.566780090332)
    setPedAnimation(pedTrain8, "ped", "WOMAN_walknorm")
end
addEvent( "CameraFour", true )
addEventHandler( "CameraFour", localPlayer, CameraFour)

function CameraSix()
    setCameraMatrix(1715.078125, -1874.2348632812, 14.566540718079, 1714.9207763672, -1893.6591796875, 13.566578865051)
    setTimer(CameraFive, 8000, 1)
end
addEvent( "CameraSix", true )
addEventHandler( "CameraSix", localPlayer, CameraSix)


-- Ending Cutscene

function CameraFive()
    setCameraMatrix(1766.8138427734, -1862.4100341797, 23.576329231262, 1766.8138427734, -1862.4100341797, 13.576329231262)
    setTimer(SwitchCameraOne, 3000, 1)
    destroyElement(pedTrain)
    destroyElement(pedTrain2)
    destroyElement(pedTrain3)
    destroyElement(pedTrain4)
    destroyElement(pedTrain5)
    destroyElement(pedTrain6)
    destroyElement(pedTrain7)
    destroyElement(pedTrain8)
    destroyElement(Train)
    destroyElement(Train2)
    destroyElement(Train3)
    playSound("files/switch1.mp3", false)
end
addEvent( "CameraFive", true )
addEventHandler( "CameraFive", localPlayer, CameraFive)

function SwitchCameraOne()
    setCameraMatrix(1766.8138427734, -1862.4100341797, 23.576329231262-3, 1766.8138427734, -1862.4100341797, 13.576329231262)
    setTimer(SwitchCameraTwo, 2000, 1)
    playSound("files/switch2.mp3", false)
end
addEvent( "SwitchCameraOne", true )
addEventHandler( "SwitchCameraOne", localPlayer, SwitchCameraOne)

function SwitchCameraTwo()
    setCameraMatrix(1766.8138427734, -1862.4100341797, 23.576329231262-4, 1766.8138427734, -1862.4100341797, 13.576329231262)
    playSound("files/switch3.mp3", false)
    setTimer(disableIntroCutScene, 2000, 1)
end
addEvent( "SwitchCameraTwo", true )
addEventHandler( "SwitchCameraTwo", localPlayer, SwitchCameraTwo)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function loadIntroCinematic()
    sound = playSound("files/introSound.mp3", false)
    setSoundVolume( sound, 1 )
    setCameraMatrix(-240.85618591309, -482.73263549805, 61.898586273193)
    setTimer(CameraOne, 3000, 1)
    loadElements()
end
addEvent("loadIntroCinematic", true)
addEventHandler("loadIntroCinematic", localPlayer, loadIntroCinematic) 

function disableIntroCutScene()
    stopSound(sound)
    destroyElement(ped1)
    setPedCameraRotation(localPlayer, 90 )
    triggerServerEvent( "spawnPlayerAfterCutscene", resourceRoot)
end
addEvent("disableIntroCutScene", true)

function cancelPedDamage ( attacker )
    cancelEvent()
end
addEventHandler("onClientPedDamage", getRootElement(), cancelPedDamage)

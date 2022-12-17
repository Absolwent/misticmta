function loadElements()
    ped1 = createPed(0, -1985.7492675781, 138.09753417969, 27.6875)
end

function CameraOne()
    setCameraMatrix(-240.85618591309, -482.73263549805, 61.898586273193)
    setTimer(CameraTwo, 3000, 1)
end
addEvent( "CameraOne", true )
addEventHandler( "CameraOne", localPlayer, CameraOne)

function CameraTwo()
    setCameraMatrix(-494.12414550781, -1171.5701904297, 83.290786743164)
    setTimer(CameraThree, 3000, 1)
end
addEvent( "CameraTwo", true )
addEventHandler( "CameraTwo", localPlayer, CameraTwo)

function CameraThree()
    setCameraMatrix(-535.64349365234, -1509.4210205078, 38.457897186279)
    setTimer(CameraFour, 3000, 1)
end
addEvent( "CameraThree", true )
addEventHandler( "CameraThree", localPlayer, CameraThree)

function CameraFour()
    setCameraMatrix(-1959.7161865234, 137.6615447998, 27.694049835205, -1946.0745849609, 137.80834960938, 25.7109375)
    setTimer(CameraFive, 3000, 1)
end
addEvent( "CameraFour", true )
addEventHandler( "CameraFour", localPlayer, CameraFour)

function CameraFive()
    setCameraMatrix(-1985.7492675781, 138.09753417969, 40.6875, -1985.7492675781, 138.09753417969, 27.6875)
    setTimer(SwitchCameraOne, 3000, 1)
    playSound("files/switch1.mp3", false)
end
addEvent( "CameraFive", true )
addEventHandler( "CameraFive", localPlayer, CameraFive)

function SwitchCameraOne()
    setCameraMatrix(-1985.7492675781, 138.09753417969, 45.6875-6.5, -1985.7492675781, 138.09753417969, 27.6875)
    setTimer(SwitchCameraTwo, 2000, 1)
    playSound("files/switch2.mp3", false)
end
addEvent( "SwitchCameraOne", true )
addEventHandler( "SwitchCameraOne", localPlayer, SwitchCameraOne)

function SwitchCameraTwo()
    setCameraMatrix(-1985.7492675781, 138.09753417969, 45.6875-6.5, -1985.7492675781, 138.09753417969, 27.6875)
    playSound("files/switch3.mp3", false)
    setTimer(disableIntroCutScene, 2000, 1)
end
addEvent( "SwitchCameraTwo", true )
addEventHandler( "SwitchCameraTwo", localPlayer, SwitchCameraTwo)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- --

addEvent("loadIntroCinematic", true)
addEventHandler("loadIntroCinematic", resourceRoot, function()
    sound = playSound("files/introSound.mp3", false)
    setSoundVolume( sound, 0.3 )
    setCameraMatrix(-240.85618591309, -482.73263549805, 61.898586273193)
    setTimer(CameraOne, 3000, 1)
    loadElements()
end)

function disableIntroCutScene()
    stopSound(sound)
    destroyElement(ped1)
    triggerServerEvent ( "spawnPlayerAfterCutscene", resourceRoot )
end
addEvent("disableIntroCutScene", true)

function loadNewPlayer()
    local voice = playSound("files/intro.mp3", false)
    setSoundVolume( voice, 0.5 )
end
addEvent( "loadNewPlayer", true )
addEventHandler( "loadNewPlayer", localPlayer, loadNewPlayer)
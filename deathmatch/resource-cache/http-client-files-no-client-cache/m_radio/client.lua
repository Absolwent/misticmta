local table_muza = {
    {1719.5522460938, -1779.2919921875, 13.553061485291},
}

sound = {}

function play() 
    for i,v in ipairs(table_muza) do
        sound[i] = playSound3D("https://s3.slotex.pl/shoutcast/7534/listen.pls", v[1], v[2], v[3], true)
        setSoundMaxDistance(sound[i], 100)
        setSoundVolume(sound[i], 0.25)
    end
end
addEventHandler ( "onClientResourceStart", getResourceRootElement ( getThisResource () ), play )



function switchSBlurShader(el_data_key, new_data)
    if (el_data_key == "player:3dmusic") then
        if getElementData(localPlayer, el_data_key) then
		    for i,v in ipairs(table_muza) do
                setSoundVolume(sound[i], 0)
            end
	    else
		    for i,v in ipairs(table_muza) do
                setSoundVolume(sound[i], 0.75)
            end
	    end
    end
end
addEventHandler("onClientElementDataChange", root, switchSBlurShader)
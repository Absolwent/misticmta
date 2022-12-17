-- Scripted by G&T Mapping & Loki

-------------------
--   CLICKABLES  --
-------------------

local dxClickables = {
	-- VIP Settings
	{pos = {46, 325, 298, 352}, vip_setting = {"Theater"}},
	{pos = {46, 371, 298, 402}, vip_setting = {"Playback"}},
	{pos = {46, 417, 298, 444}, vip_setting = {"Audio"}},
	{pos = {46, 463, 298, 493}, vip_setting = {"Queue"}},
	{pos = {360, 325, 656, 351}, vip_setting = {"Ambilight"}},
	{pos = {360, 371, 656, 402}, vip_setting = {"Audience"}},
	{pos = {360, 417, 656, 444}, vip_setting = {"Time"}},
	{pos = {360, 463, 656, 493}, vip_setting = {"Weapons"}},
	-- VIP Buttons
	{pos = {672, 362, 809, 408}, vip_button = {"KickPlayer"}},
	{pos = {672, 408, 809, 454}, vip_button = {"KickAllPlayers"}},
	{pos = {672, 454, 809, 500}, vip_button = {"KickVisitors"}},
	{pos = {672, 500, 809, 546}, vip_button = {"SetVIP"}},
	{pos = {672, 546, 809, 592}, vip_button = {"ClearPlaylist"}},
	-- Buttons
	{pos = {761, 260, 822, 298}, button = {"SwitchBrowser"}},
	-- Tabs
	{pos = {36, 177, 293, 225}, tab = {"BrowserTab"}},
	{pos = {301, 177, 558, 225}, tab = {"SettingsTab"}},
	{pos = {565, 177, 822, 225}, tab = {"HelpTab"}},
	-- Main
	{pos = {46, 693, 291, 916}, main = {"Remove"}},
	{pos = {1051, 207, 1243, 233}, main = {"SkipSong"}},
	{pos = {307, 693, 552, 916}, main = {"Play"}},
	{pos = {567, 693, 812, 916}, main = {"Add"}},
	
	{pos = {852, 260, 939, 298}, main = {"PlayList"}},
	{pos = {949, 260, 1036, 298}, main = {"UserList"}},
}

function onDxClick(button,state)
	if isPanelVisible then
		if button == "left" and state == "down" then
			local cx,cy = getCursorPosition(  )
            local sx,sy = guiGetScreenSize(  )
			if not isDialogVisible then
				if dxClickables then
					for i=1,#dxClickables do
						local v = dxClickables[i]
						if isCursorOverArea(v.pos[1],v.pos[2],v.pos[3],v.pos[4]) then
							if settingsTabOpen then
								if v.vip_setting then
									playSFX("genrl", 52, 20, false)
									triggerServerEvent("onSettingChanged",localPlayer,v.vip_setting[1])
								elseif v.vip_button then
									if v.vip_button[1] == "KickPlayer" then
										if userlist then
											if userlist:IsVisible() then
												if userlist:GetSelectedItem() then
													local _,name = userlist:GetItemDetails(names,userlist:GetSelectedItem())
													if name then
														local player = getPlayerFromName(name)
														triggerServerEvent("onKickPlayerFromTheater",resourceRoot,localPlayer,false,player)
														userlist:SetSelectedItem(0)
													end
												end
											end
										end
									elseif v.vip_button[1] == "KickAllPlayers" then
										triggerServerEvent("onKickPlayerFromTheater",resourceRoot,localPlayer,"everyone")
									elseif v.vip_button[1] == "KickVisitors" then
										triggerServerEvent("onKickPlayerFromTheater",resourceRoot,localPlayer,"visitors")
									elseif v.vip_button[1] == "SetVIP" then
										if userlist then
											if userlist:IsVisible() then
												if userlist:GetSelectedItem() then
													local _,name = userlist:GetItemDetails(names,userlist:GetSelectedItem())
													if name then
													local player = getPlayerFromName(name)
														if player then
															triggerServerEvent("addPlayerToVIP",localPlayer,player)
															refreshUserList()
														end
													end
												end
											end
										end
									elseif v.vip_button[1] == "ClearPlaylist" then
										if playlist:GetItemCount(videos) > 0 then
											if not isEventHandlerAdded("onClientRender",root,Dialog) then
												addEventHandler("onClientRender",root,Dialog)
												addEventHandler("onClientClick",root,showDialog)
												isDialogVisible = true
											end
										end
									end
								end
							end
							if v.main then
								if v.main[1] == "Add" then
									local url = getBrowserURL(guiGetBrowser(Browser))..""
									if url then
										triggerServerEvent("requestPlay",resourceRoot,localPlayer,cmd,url)
									end
								elseif v.main[1] == "Play" then
									if playlist:GetSelectedItem() then
									local _,url = playlist:GetItemDetails(videos,playlist:GetSelectedItem())
										if url then
											loadBrowserURL(guiGetBrowser(Browser),url)
											playlist:SetSelectedItem(0)
										end
									end
								elseif v.main[1] == "SkipSong" then
									if isTimer(songProgress) then
										triggerServerEvent("voteToSkip",resourceRoot,localPlayer)
									end
								elseif v.main[1] == "Remove" then
									if playlist:GetSelectedItem() then
									local text = playlist:GetItemDetails(videos,playlist:GetSelectedItem())
										if text then
											local number = gettok(text,1,string.byte('.'))
											if tonumber(number) then
												triggerServerEvent("requestRemove",resourceRoot,localPlayer,tonumber(number))
												playlist:SetSelectedItem(0)
											end
										end
									end
								elseif v.main[1] == "PlayList" then
									showList("PlayList")
								elseif v.main[1] == "UserList" then
									showList("UserList")
								end
							elseif v.tab then
								if v.tab[1] == "BrowserTab" then
									switchToTab("browser")
								elseif v.tab[1] == "SettingsTab" then
									switchToTab("settings")
								elseif v.tab[1] == "HelpTab" then
									switchToTab("help")
								end
							end
							if not settingsTabOpen and not helpTabOpen then
								if v.button then
									if v.button[1] == "SwitchBrowser" then
										switchedBrowser = not switchedBrowser
										if switchedBrowser == true then
											browserSwitch = ".TV"
											myBrowserURL = "https://www.youtube.com"
											loadBrowserURL(guiGetBrowser(Browser),myBrowserURL)
										else
											browserSwitch = ".COM"
											myBrowserURL = "https://www.youtube.com/tv"
											loadBrowserURL(guiGetBrowser(Browser),myBrowserURL)
										end
									end
								end
							end	
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientClick",root,onDxClick)

function testt()
	triggerServerEvent("onKickPlayerFromTheater",resourceRoot,localPlayer,"everyone")
end
addCommandHandler("kickall",testt)

function switchToTab(tab)
	if tab == "browser" then
		if not browserTab and not browserTabOpen then
			removeEventHandler("onClientRender",root,Help_Tab)
			guiSetVisible(HelpInfo,false)
			removeEventHandler("onClientRender",root,Settings_Tab)
			guiSetVisible(Browser_Bg,true)
			addEventHandler("onClientRender",root,switchMyBrowser)
			browserTab = true
			browserTabOpen = true
			settingsTab = false
			settingsTabOpen = false
			helpTab = false
			helpTabOpen = false
		end
	elseif tab == "settings" then
		if not settingsTab and not settingsTabOpen then
			removeEventHandler("onClientRender",root,Help_Tab)
			guiSetVisible(HelpInfo,false)
			addEventHandler("onClientRender",root,Settings_Tab)
			guiSetVisible(Browser_Bg,false)
			removeEventHandler("onClientRender",root,switchMyBrowser)
			browserTab = false
			browserTabOpen = false
			settingsTab = true
			settingsTabOpen = true
			helpTab = false
			helpTabOpen = false
		end
	elseif tab == "help" then
		if not helpTab then
			removeEventHandler("onClientRender",root,Settings_Tab)
			addEventHandler("onClientRender",root,Help_Tab)
			guiSetVisible(HelpInfo,true)
			guiSetVisible(Browser_Bg,false)
			removeEventHandler("onClientRender",root,switchMyBrowser)
			browserTab = false
			browserTabOpen = false
			settingsTab = false
			settingsTabOpen = false
			helpTab = true
			helpTabOpen = true
		end
	end
end

local dxDialogClickables = {
	{pos = {490, 486, 627, 533}, button = "yes"},
	{pos = {637, 486, 774, 533}, button = "no"},
}

function showDialog(button,state)
	if button == "left" and state == "down" then
		for _,v in pairs(dxDialogClickables) do
			if isCursorOverArea(v.pos[1],v.pos[2],v.pos[3],v.pos[4]) then
				if v.button == "yes" then
					triggerServerEvent("globalStop",resourceRoot,localPlayer)
				end
				removeEventHandler("onClientRender",root,Dialog)
				removeEventHandler("onClientClick",root,showDialog)
				isDialogVisible = false
			end
		end
	end
end

-------------------
--   dxSettings  --
-------------------

addEvent( "updatedPlayersInCinema",true)
addEventHandler( "updatedPlayersInCinema",root,function (playerTable) playersInCinema = playerTable end)


triggerServerEvent( "updateCheckedSettings",resourceRoot )
addEvent( "updatedSettings",true)
addEventHandler( "updatedSettings",root,
    function (settingsTable)
        for _,setting in ipairs (settingsTable) do
			if setting[1] == "theater" then
				theater = setting[2]
			elseif setting[1] == "playback" then
				playback = setting[2]
			elseif setting[1] == "audio" then
				audio = setting[2]
			elseif setting[1] == "queue" then
				queue = setting[2]
			elseif setting[1] == "ambilight" then
				ambilight = setting[2]
			elseif setting[1] == "audience" then
				audience = setting[2]
			elseif setting[1] == "time" then
				time = setting[2]
				if isElementWithinColShape(localPlayer,cinemaCol) then
					toggleNight()
				end
			elseif setting[1] == "weapons" then
				weapons = setting[2]
			end
        end
    end
)

function toggleNight()
	if isElementWithinColShape(localPlayer,cinemaCol) then
		if time then
			setTime(0,0)
			setWeather(12)
			setMinuteDuration(99999999)
		end
	end
end

function setTimeOnLeave(hitElement)
	if hitElement == localPlayer then
    	triggerServerEvent("requestTime",hitElement)
    end
end


function requestTime(h,m,w,md,onStart)
    setTime(h,m)
	setWeather(w)
	setMinuteDuration(md)
	
	if onStart then
		setTimer(function()
			showChat(true)
			showPlayerHudComponent("all",true)
		end,500,1)
	end
end
addEvent("updateTimeOnExitCinema",true)
addEventHandler("updateTimeOnExitCinema",resourceRoot,requestTime)

function setNightTime()
	setTimer(toggleNight,1500,1)
end
addEvent("updateTimeOnEnterCinema",true)
addEventHandler("updateTimeOnEnterCinema",root,setNightTime)

local ambiPositions = {
	{-1965.3,449.39999,-1.3},
	{-1965.3,449.39999,5.7},
	{-1965.3,449.39999,12.6},
	{-1922.5,449.39999,12.6},
	{-1922.5,449.39999,5.7},
	{-1922.5,449.39999,-1.3},
	{-1944.0996, 414.0996, 9, 0.75}
}
ambiMarkers = {}

--local projectorBeam = createSearchLight(-1944.0996, 414.0996, 9, -1944.0996, 449.0996, 1, 0.7, 50)

function Ambilights(tog)
	if tog == true then
		projectorLight = createLight(0, -1943.669, 451.898, 5.771, 50, 255, 33, 33)
		engineApplyShaderToWorldTexture(frameShader,"frame")
		dxSetShaderValue(frameShader, "gFrameColor", 15/255, 15/255, 15/255)
	else
		if isElement(projectorLight) then
			destroyElement(projectorLight)
			engineRemoveShaderFromWorldTexture(frameShader,"frame")
		end
	end
    if tog == true then
		for i=1,#ambiPositions do
			local v = ambiPositions[i]
			ambiMarkers[i] = createMarker(v[1], v[2], v[3], "corona", v[4] or 4, 255, 33, 33, 90)
		end
    else
        for i=1,#ambiPositions do
            if ambiMarkers[i] and isElement(ambiMarkers[i]) then
                destroyElement(ambiMarkers[i])
            end
        end
    end
end
addEvent("onToggleAmbilights",true)
addEventHandler("onToggleAmbilights",resourceRoot,Ambilights)


function screenGlare()
	if isElement(Screen) and isElement(projectorLight) then
		--local pcol = dxGetTexturePixels( Screen,1,1,640,360 ) -- gets all pixels? should only get middle pixel
		local pcol = dxGetTexturePixels( Screen,(640/2)-1, (360/2)-1,3,3 )
		local r,g,b,a = dxGetPixelColor( pcol, 2, 2 )
		setLightColor ( projectorLight, r, g, b )
		dxSetShaderValue(frameShader, "gFrameColor", r/255, g/255, b/255)
		
		for i=1,#ambiMarkers do
			setMarkerColor(ambiMarkers[i], r, g, b, a)
		end
	end
end
addEventHandler( "onClientRender", root, screenGlare )

addEventHandler( "onResourceStart", resourceRoot, function()
	addEventHandler("onClientColShapeHit",cinemaCol,toggleNight)

	addEventHandler("onClientColShapeLeave",cinemaCol,setTimeOnLeave)

	addEventHandler("onClientResourceStop",cinemaCol,setTimeOnLeave)
end )
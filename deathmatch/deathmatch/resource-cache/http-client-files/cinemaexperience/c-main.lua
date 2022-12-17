-- Scripted by G&T Mapping & Loki

-------------------
-- GUI FUNCTIONS --
-------------------

local screenVolume = 1
local screenMuted = false
isPanelVisible = false
browserTab = true
theList = "PlayList"
function togglePanel()
	isPanelVisible = not isPanelVisible
	if isPanelVisible then
		if activeList then
			showList(activeList)
		else
			showList(theList)
		end
	
		if not isCursorShowing() then
			if cursorX and cursorY then
				setCursorPosition(cursorX*RES[1],cursorY*RES[2])
			end
		end
		if not isElement(Browser_Bg) then
			createBrowserGui()
		end
		showPlayerHudComponent("all",false)
		showChat(false)
		showCursor(true)
		LIST = "Visitors"
		addEventHandler("onClientRender",root,Panel)

		if browserTab then
			guiSetVisible(Browser_Bg,true)
			addEventHandler("onClientRender",root,switchMyBrowser)
			browserTabOpen = true
		elseif settingsTab then
			addEventHandler("onClientRender",root,Settings_Tab)
			settingsTabOpen = true
		elseif helpTab then
			guiSetVisible(HelpInfo,true)
			addEventHandler("onClientRender",root,Help_Tab)
			helpTabOpen = true
		end

	else
		cursorX,cursorY = getCursorPosition()
		showChat(true)
		showCursor(false)
		if playlist then
			playlist:SetVisible(false)
		end
		if userlist then
			userlist:SetVisible(false)
		end
		showPlayerHudComponent("all",true)
		removeEventHandler("onClientRender",root,Panel)

		if guiGetVisible(Browser_Bg) then
			guiSetVisible(Browser_Bg,false)
		end
		if browserTab and browserTabOpen then
			browserTabOpen = false
		end
		removeEventHandler("onClientRender",root,switchMyBrowser)

		if settingsTab and settingsTabOpen then
			removeEventHandler("onClientRender",root,Settings_Tab)
			showCursor(false)
			settingsTabOpen = false
		end

		if helpTab and helpTabOpen then
			removeEventHandler("onClientRender",root,Help_Tab)
			guiSetVisible(HelpInfo,false)
			showCursor(false)
			helpTabOpen = false
		end
		
	end
end
addEvent("togglePanel",true)
addEventHandler("togglePanel",resourceRoot,togglePanel)

function closePanelOnLeave(hitElement)
	if hitElement == localPlayer then
		cleanUp()
		
		activeList = "PlayList"
		
		switchToTab("browser")
		
		if isPanelVisible then
			togglePanel()
		end
		if isElement(Browser_Bg) then
			destroyElement(Browser_Bg)
		end
	end
end
addEventHandler("onClientColShapeLeave",cinemaCol,closePanelOnLeave)

-------------------
--  DX PLAYLIST  --
-------------------

function createPlaylist()
	playlist = dxGrid:Create(852, 298, 391, 628)
	videos = playlist:AddColumn("Playlist",391)
end

function createUserlist()
	userlist = dxGrid:Create(852, 298, 391, 628)
	names = userlist:AddColumn("Visitors",391)
end

function showPlaylist()
	if not isTimer(showDelay) then
		triggerServerEvent("showPlaylist",resourceRoot,localPlayer)
		showDelay = setTimer(function()end,7000,1)
	else
		outputChatBox("Please wait a few seconds before using this command again",245,180,140,true)
	end
end
addCommandHandler("playlist",showPlaylist)

function syncPlaylist(list)
	if playlist then
		playlist:Clear()
		for i,v in pairs(list) do			
			if i == 2 then
				playlist:AddItem(videos,"Next Up:","",148,227,150)
			end
			if i == 1 then
				playlist:AddItem(videos,"Now Playing:","",148,227,150)
				playlist:AddItem(videos,i..". "..v[1].title,v[1].url,211,211,211)
			else
				playlist:AddItem(videos,i..". "..v[1].title,v[1].url,211,211,211)
			end
		end
	end
end
addEvent("syncRequest",true)
addEventHandler("syncRequest",resourceRoot,syncPlaylist)

-------------------
-- COLSHAPE STUF --
-------------------

function showList(theList)
	if not userlist then
		createUserlist()
	end
	if not playlist then
		createPlaylist()
		setTimer(function()triggerServerEvent("syncRequestFromClient",resourceRoot,localPlayer)end,500,1)
	end
	if theList == "UserList" then
		if userlist then
			userlist:SetVisible(true)
			userlist:Clear()
			triggerServerEvent("onGetPlayersInCol",resourceRoot)
			plTabColor = {217, 217, 217, 255}
			ulTabColor = {217, 45, 45, 255}
			activeList = "UserList"
			if playlist:IsVisible() then
				playlist:SetVisible(false)
				playlist:SetSelectedItem(0)
			end
		end
	elseif theList == "PlayList" then
		if playlist then
			playlist:SetVisible(true)
			plTabColor = {217, 45, 45, 255}
			ulTabColor = {217, 217, 217, 255}
			activeList = "PlayList"
			if userlist:IsVisible() then
				userlist:SetVisible(false)
			end
		end
	end
end
				
function refreshUserList()
	if userlist then
		triggerServerEvent("onGetPlayersInCol",resourceRoot)
	end
end
addEvent("syncUserList",true)
addEventHandler("syncUserList",resourceRoot,refreshUserList)

function addPlayersToUserlist(playersTable)
	if userlist then
		playersInCinema = playersTable
		userlist:Clear()
		for i,plr in ipairs(playersTable)do
			if plr.vip == true then
				userlist:AddItem(names,i..". [STAFF] "..plr.name,plr.name,217,45,45)
			else
				userlist:AddItem(names,i..". "..plr.name,plr.name,255,255,255)
			end
		end
	end
end
addEvent("onAddToUserlist",true)
addEventHandler("onAddToUserlist",resourceRoot,addPlayersToUserlist)

-------------------
-- FUNCTIONALITY --
-------------------

-- Draw votes
function syncVotes(voteCount,maxVotes)
	if voteCount then
		if isEventHandlerAdded("onClientRender",root,displayVotes) then
			removeEventHandler("onClientRender",root,displayVotes)
		end
		function displayVotes()
			if isPanelVisible then
				Text("Votes to skip: "..voteCount.."/"..maxVotes, 1051, 207, 1192, 233, tocolor(255, 255, 255, 255), 1.10, "default", "center", "center", true, false, true, false, false)
			end
		end
	end
end
addEvent("syncVotes",true)
addEventHandler("syncVotes",resourceRoot,syncVotes)

-- new screen
local screenShader = dxCreateShader("screen/screen.fx")
frameShader = dxCreateShader("screen/screen_frame.fx")
--local screenObject = createObject(3942, -1943.90, 450.8, 6.2, 0, 0, 0.836)
--setObjectScale(screenObject,1)

function playSong(url,title,length,nick,atTime)
	if isElementWithinColShape(localPlayer,cinemaCol) then
		engineApplyShaderToWorldTexture(screenShader,"screen")
		if Screen then
			removeEventHandler("onClientRender",root,displayTitle)
			loadBrowserURL(Screen,url)
			injectBrowserMouseDown(Screen,'left')
		else
			Screen = createBrowser(640,360,false,false) --orig: 599,321  -- standard-tv 640,360  -- standard-cin 683,360
			addEventHandler("onClientBrowserCreated",Screen,function()
				loadBrowserURL(Screen,tostring(url).."&t="..atTime)
				injectBrowserMouseDown(Screen,'left')
				addEventHandler("onClientBrowserLoadingFailed",Screen,function(url,err,errorDescription)
					if err == 3 then
						triggerEvent("onDxPopupMessage",resourceRoot,"SCREEN ERROR - ERR_ABORTED: '"..url.."'",4500)
						outputDebugString("SCREEN ERROR - ERR_ABORTED: '"..url.."'")
					end
				end)
			end)
		end
		if title and tonumber(length) then
			msecs = length*1000
			total = msecs/1000
			secs = msecs/1000
			increment = 391/secs
			width = increment*atTime
			length = string.format("%.2d:%.2d:%.2d",secs/(60*60),secs/60%60,secs%60)
			
			if isTimer(progressBar) and isTimer(songProgress) then
				killTimer(progressBar)
				killTimer(songProgress)
			end
			
			progressBar = setTimer(function()
				width = width+increment
			end,1000,secs)
			
			songProgress = setTimer(function()
				if isTimer(progressBar) then
					killTimer(progressBar)
				end 
			end,msecs,1)
					
			function displayTitle()
				if not screenMuted then
					setBrowserVolume(Screen,screenVolume)
				else
					setBrowserVolume(Screen,0)
				end
				
				-- new screen
				if Screen then
					dxSetShaderValue(screenShader,"gTexture",Screen)
				end
				
				if isTimer(songProgress) then
					ms = getTimerDetails(songProgress)
					secs = (ms/1000)-atTime
					secs = total-secs
					remaining = string.format("%.2d:%.2d:%.2d",secs/(60*60),secs/60%60,secs%60)
				end
				
				if isPanelVisible then
					Text("Now Playing: "..title.."\nLength: "..remaining.." / "..length.."\nAdded by: "..nick, 852, 170, 1243, 249, tocolor(255, 255, 255, 255), 1.15, "default", "left", "top", true, false, true, false, false)
					
					Rectangle(852, 239, 391, 10, tocolor(217, 217, 217, 255), true)
					Rectangle(852, 239, width, 10, tocolor(217, 45, 45, 255), true)
					Rectangle(852+width, 239, 4, 10, tocolor(156, 156, 156, 255), true)
					
					Image(1051, 207, 141, 26, "img/button.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
					Image(1197, 207, 46, 26, "img/button.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
					if not isEventHandlerAdded("onClientRender",root,displayVotes) then
						addEventHandler("onClientRender",root,displayVotes)
					end
					Text("Skip", 1197, 207, 1243, 233, tocolor(255, 255, 255, 255), 1.10, "default", "center", "center", true, false, true, false, false)
					
				end
			end
			addEventHandler("onClientRender",root,displayTitle)
		end
	end
end
addEvent("playRequest",true)
addEventHandler("playRequest",resourceRoot,playSong)

function cleanUp()
	if Screen then
		if isTimer(songProgress) or isTimer(progressBar) then
			killTimer(songProgress)
			killTimer(progressBar)
		end
		playlist:Clear()
		removeEventHandler("onClientRender",root,displayTitle)
		
		if isEventHandlerAdded("onClientRender",root,displayVotes) then
			removeEventHandler("onClientRender",root,displayVotes)
		end
		
		-- reset shaders / markers color
		dxSetShaderValue(frameShader, "gFrameColor", 15/255, 15/255, 15/255)
		engineRemoveShaderFromWorldTexture(screenShader,"screen")
		for i=1,#ambiMarkers do
			setMarkerColor(ambiMarkers[i], 255, 33, 33, 90)
		end
		
		destroyElement(Screen)
		Screen = nil
	end
end
addEvent("stopRequest",true)
addEventHandler( "stopRequest",resourceRoot,cleanUp)

-- Control browser volume with +/- keys and 'm' for muting
function toggleMuted()
	if Screen then
		screenMuted = not screenMuted
		
		if screenMuted then
			setBrowserVolume(Screen,0)
			triggerEvent("onDxPopupMessage",resourceRoot,"Playback muted",2000)
		else
			setBrowserVolume(Screen,screenVolume)
			triggerEvent("onDxPopupMessage",resourceRoot,"Playback unmuted",2000)
		end
	end
end
addCommandHandler("muteit",toggleMuted)

function changeScreenVolume(state)
	screenMuted = false
	
	if state == "up" then
		screenVolume = math.round(screenVolume + 0.05,2)
	elseif state == "down" then
		screenVolume = math.round(screenVolume - 0.05,2)
	end
	
	setBrowserVolume(Screen,screenVolume)
	triggerEvent("onDxPopupMessage",resourceRoot,"Playback Volume: "..math.round(screenVolume*100),2000)
end

addEventHandler("onClientKey",root,function(key,down)
	if not isChatBoxInputActive() then
		if isElementWithinColShape(localPlayer,cinemaCol) and Screen and not down then
			if key == "m" then
				toggleMuted()
			elseif key == "+" or key == "=" or key == "num_add" then
				if screenVolume < 1 then
					changeScreenVolume("up")
				end
				return
			elseif key == "-" or key == "num_sub" then
				if screenVolume > 0 then
					changeScreenVolume("down")
				end
			end
		end
	end
end)
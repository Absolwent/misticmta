local x,y = guiGetScreenSize ()

logo = 0
cor = {}

local Font_1 = dxCreateFont("gfx/font/font.ttf", 8)
local Font_2 = dxCreateFont("gfx/font/font.ttf", 5)
local Font_3 = dxCreateFont("gfx/font/font.ttf", 7)
local Font_4 = dxCreateFont("gfx/font/font.ttf", 8)
local Font_5 = dxCreateFont("gfx/font/font.ttf", 7)

				playerwindow = guiCreateStaticImage(x-450, y-560, 450, 560, "files/phonse.png", false)
				
				--[[1]]			top10pivp = guiCreateStaticImage(115, 445, 39, 42, "files/internet.png", false, playerwindow)--internet
				setElementData(top10pivp, "tooltip-text", "Browser", false)
				setElementData(top10pivp, "tooltip-font", "clear 1", false)	

--[[1]]			sendmoney = guiCreateStaticImage(115+60, 445, 39, 42, "files/EnviarDinheiro.png", false, playerwindow)--send money
				setElementData(sendmoney, "tooltip-text", "Send Money", false)
				setElementData(sendmoney, "tooltip-font", "clear 1", false)
		
		--[[1]]			putplibss = guiCreateStaticImage(115+60*2, 445, 39, 42, "files/EnviarLoc.png", false, playerwindow)--putblip
				setElementData(putplibss, "tooltip-text", "Blip on players", false)
				setElementData(putplibss, "tooltip-font", "clear 1", false)
				 -- 115+60*3, 445, 39, 42
		        PlayerInfo = guiCreateStaticImage(115+60*3, 445, 39, 42, "files/MinhasInformacoes.png", false, playerwindow)
				setElementData(PlayerInfo, "tooltip-text", "Your Info", false)
				setElementData(PlayerInfo, "tooltip-font", "clear 1", false)
				--115+60*3, 110, 39, 42
				sms = guiCreateStaticImage(115+60*3, 175, 39, 42, "files/Whatsapp.png", false, playerwindow)--animation
				setElementData(sms, "tooltip-text", "SMS", false)	
				setElementData(sms, "tooltip-font", "clear 1", false)
				
		 ---------------------- 115, 175, 39, 42
--[[1]]			Callingm = guiCreateStaticImage(115, 110, 39, 42, "files/samu.png", false, playerwindow)--call medic
				setElementData(Callingm, "tooltip-text", "Call medics", false)
				setElementData(Callingm, "tooltip-font", "clear 1", false)
				
--[[1]]			animshe = guiCreateStaticImage(115+60*2, 175, 39, 42, "files/animation.png", false, playerwindow)--animation
				setElementData(animshe, "tooltip-text", "Animations", false)	
				setElementData(animshe, "tooltip-font", "clear 1", false)
			
			

--[[1]]			Callingp = guiCreateStaticImage(115+60*2, 110, 39, 42, "files/policia.png", false, playerwindow)--Calling Police
				setElementData(Callingp, "tooltip-text", "Call police", false)	
				setElementData(Callingp, "tooltip-font", "clear 1", false)
				
--[[1]]	        Calculatorpanel = guiCreateStaticImage(115, 175, 39, 42, "files/Calculadora.png", false, playerwindow)--Calculator
				setElementData(Calculatorpanel, "tooltip-text", "Calculator", false)
				setElementData(Calculatorpanel, "tooltip-font", "clear 1", false)
				
--[[1]]			policePanel = guiCreateStaticImage(115+60, 175, 39, 42, "files/wanted.png", false, playerwindow)	--wanted	
				setElementData(policePanel, "tooltip-text", "Wanted Panel", false)
				setElementData(policePanel, "tooltip-font", "clear 1", false)
				
				taxilig = guiCreateStaticImage(115+60*3, 110, 39, 42, "files/uber.png", false, playerwindow)		
				setElementData(taxilig, "tooltip-text", "Uber", false)
				setElementData(taxilig, "tooltip-font", "clear 1", false)
				--115+60*2, 175, 39, 42
				mecanicolig = guiCreateStaticImage(115+60, 110, 39, 42, "files/mecanico.png", false, playerwindow)
				setElementData(mecanicolig, "tooltip-text", "Mecanico", false)
				setElementData(mecanicolig, "tooltip-font", "clear 1", false)
				
				
				
		playerclpse = guiCreateButton(210, 510, 30, 30, "", false, playerwindow)
        guiSetAlpha(playerclpse, 0)
		
		phon_LBL = guiCreateLabel(150, 400, 180, 24, "", false, playerwindow)
        guiSetFont(phon_LBL, "default-bold-small")
        guiLabelSetColor(phon_LBL, 255, 0, 0) 
		
addEventHandler("onClientMouseEnter",root,
function ()
if source == sendmoney or source == Callingm or source == sms or source == weatherP or source == animshe or source == top10pivp or source == putplibss or source == Callingp or source == top10 or source == Calculatorpanel or source == waze or source == policePanel or source == BM  or source == PlayerInfo or source == mecanicolig  or source == PlayerInfo or source == spawnPanel or source == gmsSide then
guiSetAlpha (source,0.70)
sound = playSound ("files/y.mp3" )
setSoundVolume(sound, 0.2)
end
end
)	
	
addEventHandler("onClientMouseLeave",root,
function ()	
if source == sendmoney or source == Callingm or source == sms or source == weatherP or   source == animshe or source == top10pivp or source == putplibss or source == Callingp or source == top10 or source == Calculatorpanel or source == policePanel or source == BM  or source == PlayerInfo or source == mecanicolig   or source == PlayerInfo or source == spawnPanel or source == waze then
guiSetAlpha (source,1)	
guiSetText (phon_LBL,"")
end
end
)	

addEventHandler("onClientMouseEnter",root,
function ()	
	if source == sendmoney then
			guiSetText (phon_LBL,"CAIXA BANCARIO")
		elseif source == Callingm then
			guiSetText (phon_LBL,"192 | SAMU")
		elseif source == animshe then
			guiSetText (phon_LBL,"ANIMAÇÕES")
		elseif source == top10pivp then
			guiSetText (phon_LBL,"INTERNET")
		elseif source == putplibss then
			guiSetText (phon_LBL,"ENVIAR LOCALIZAÇÃO")
		elseif source == Callingp then
			guiSetText (phon_LBL,"190 | POLÍCIA")
		elseif source == top10 then
			guiSetText (phon_LBL,"10 melhores jogadores")
		elseif source == Calculatorpanel then
			guiSetText (phon_LBL,"CALCULADORA")
		elseif source == policePanel then
			guiSetText (phon_LBL,"PROCURADOS ( DESATIVADO )")
		elseif source == PlayerInfo then
			guiSetText (phon_LBL,"SEU RG")
		elseif source == sms then
			guiSetText (phon_LBL,"MENSAGENS")	
		elseif source == mecanicolig then
			guiSetText (phon_LBL,"MECÂNICOS")	
		elseif source == taxilig then
			guiSetText (phon_LBL,"UBER")	
	end
end	
)




	addEventHandler("onClientGUIClick",root,
  function ()
  if source == putplibss then
  guiSetVisible ( Blipwindow, true )
  putAllPlayersInList()
	guiSetVisible ( playerwindow, false )
	elseif source == top10pivp then
	  guiSetVisible ( windowsssaga, true )
	guiSetVisible ( playerwindow, false )  
	  
  end
end)
---------------------------------------------player info ----------------
local fount = guiCreateFont ("files/font.ttf",15)
x,y = guiGetScreenSize ()
addEventHandler("onClientGUIClick", root,
    function ()
        if source == PlayerInfo then
		
x,y = guiGetScreenSize ()
		infomation_wind = guiCreateWindow(x/2-426/2,y/2-378/2, 426, 378, "Informações:", false)
guiWindowSetSizable(infomation_wind, false)
guiSetAlpha(infomation_wind, 0.96)

lbl_name1 = guiCreateLabel(10, 31, 406, 27, "Seu Nome: "..getPlayerName (localPlayer), false, infomation_wind)
guiSetFont(lbl_name1, fount)
lbl_ping2 = guiCreateLabel(10, 91, 402, 25, "Seu Ping: "..getPlayerPing (localPlayer) ,false, infomation_wind)
guiSetFont(lbl_ping2, fount)
lbl_money = guiCreateLabel(10, 163, 402, 27, "Seu Dinheiro: "..getPlayerMoney (localPlayer), false, infomation_wind)
guiSetFont(lbl_money, fount)
lbl_serial = guiCreateLabel(10, 241, 402, 29, "Seu Serial: "..getPlayerSerial (localPlayer), false, infomation_wind)
guiSetFont(lbl_serial, fount)
copy_serial = guiCreateButton(11, 326, 127, 36, "Copiar Serial", false, infomation_wind)
guiSetFont(copy_serial, fount)
back_btn = guiCreateButton(289, 326, 127, 36, "Voltar", false, infomation_wind)
guiSetFont(back_btn, fount)    
guiSetVisible (infomation_wind,false)
		guiSetVisible (playerwindow,false)
		guiSetVisible (infomation_wind,true)

		guiSetEnabled (PlayerInfo,false)
		 elseif source == back_btn then
		 guiSetVisible (playerwindow,true)
		 guiSetVisible (infomation_wind,false)
		guiSetEnabled (PlayerInfo,true)
		  elseif source == copy_serial then
		  --exports["guimessages"]:outputClient("Você copiou seu serial!",  255, 255, 0, true )
		  setClipboard ( "" .. getPlayerSerial(localPlayer) .. "" )
		  setTimer (function ()
		  guiSetEnabled (copybtn,false)
		  end,8000,1)
        end
    end
)


addEventHandler ("onClientGUIClick",root,
function ()
if source == playerwind then
playerwind ()
end
end
)
-------------------------------------------------------------------------------------------------
guiSetVisible (playerwindow, false)  
function OpenWin()
if guiGetVisible ( playerwindow ) then
	guiSetVisible (Blipwindow, false) 
	guiSetVisible (send, false) 
	guiSetVisible ( playerwindow, false )
	guiSetVisible ( Wind, false )
	guiSetVisible ( JanelaGPSMBR, false )
	guiSetVisible ( SmsWindow, false )
	guiSetInputEnabled(false) 
	showCursor(false)
else
	guiSetVisible ( playerwindow, true )
	guiSetInputEnabled(true)
	showCursor(true)
end 
end
bindKey("F5", "down", OpenWin)



GUIEditor = {
    gridlist = {},
    button = {},
    label = {}
}

	  local x,y =  guiGetScreenSize ()
addEventHandler ('onClientResourceStart',root,
function ()
  local x,y = guiGetScreenSize ()
        Blipwindow = guiCreateWindow(x/2-280/2, y/2-352/2, 280, 352, "Enviar Localização", false)
        guiWindowSetSizable(Blipwindow, false)
        guiSetAlpha(Blipwindow, 1.00)

        --GUIEditor.label[1] = guiCreateLabel(16, 260, 247, 15, "________________________________________", false, Blipwindow)
        grid = guiCreateGridList(16, 29, 247, 226, false, Blipwindow)
        guiGridListAddColumn(grid, "Players", 0.9)
		GUIEditor.button[99] = guiCreateButton(16, 290, 108, 44, "Enviar", false, Blipwindow)
        GUIEditor.button[98] = guiCreateButton(155, 290, 108, 44, "Voltar", false, Blipwindow)    
		guiSetVisible (Blipwindow, false) 
end)



	
	function putAllPlayersInList()
guiGridListClear(grid)
for i,v in ipairs(getElementsByType("player")) do
local row = guiGridListAddRow(grid)
guiGridListSetItemText(grid,row,1,getPlayerName(v),false,false)

end
end
 
addEventHandler("onClientGUIChanged",root,
function ()
if ( source == SearchEdit ) then
local text = guiGetText(SearchEdit)
if ( text == "" ) then
putAllPlayersInList()
else
guiGridListClear(grid)
for i,v in ipairs(getElementsByType("player")) do
local name = getPlayerName(v)
if string.find(name,text) then
local row = guiGridListAddRow(grid)
guiGridListSetItemText(grid,row,1,name,false,false)

end
end
end
end
end
)
 
addEventHandler("onClientGUIClick",root,
function()
if source == GUIEditor.button[99] then
local name = guiGridListGetItemText( grid,guiGridListGetSelectedItem(grid),1)
	if name ~= "" then 
	local playern = getPlayerFromName(tostring(name))
		if (localPlayer == playern) then
			triggerServerEvent("ErroLoc", localPlayer)
			return
		end
		triggerServerEvent("EnviarLocalizacao", localPlayer, playern)
	end
elseif source == GUIEditor.button[98] then
	guiSetVisible (Blipwindow,false)
	guiSetVisible (playerwindow,true)
end
end
)

	
--------------------------------------------------calling-police------------------------------	

addEventHandler("onClientGUIClick",root,
function ()
if( source == Callingp ) then
triggerServerEvent('ChamarAPolicia', localPlayer)
guiSetEnabled (Callingp,false)
setTimer (function ( )
guiSetEnabled (Callingp,true)
end,60000,1)
elseif( source == Callingm ) then
triggerServerEvent('ChamarOSamu', localPlayer)
guiSetEnabled (Callingm,false)
setTimer (function ( )
guiSetEnabled (Callingm,true)
end,60000,1)
elseif( source == mecanicolig ) then
triggerServerEvent('ChamarOMecanico', localPlayer)
guiSetEnabled (mecanicolig,false)
setTimer (function ( )
guiSetEnabled (mecanicolig,true)
end,60000,1)
elseif( source == taxilig ) then
triggerServerEvent('ChamarOTaxista', localPlayer)
guiSetEnabled (taxilig,false)
setTimer (function ( )
guiSetEnabled (taxilig,true)
end,60000,1)
end
end
)


--------------------------------------------------send money------------------------------		

GUIEditor_Label = {}
GUIEditor_Edit = {}
GUIEditor_Grid = {}


	local x, y = guiGetScreenSize()	   

send = guiCreateWindow(x/2-473/2, y/2-352/2, 473, 352, "Enviar Dinheiro", false)
 
   guiSetVisible ( send, false )
        guiSetAlpha(send, 1.00)
     
	 playerList = guiCreateGridList(271, 29, 185, 302,false,send)
            guiGridListSetSelectionMode(playerList, 2)
	
local cl = guiGridListAddColumn(playerList, "Lista De Jogadores ...", 1)
     
         
    
  

 addEventHandler("onClientGUIClick",root,
   function ()
   if source == sendmoney then
   guiSetVisible (send,true)
   guiSetVisible (playerwindow,false)
   guiGridListClear(playerList)
              for _,name in ipairs(getElementsByType("player")) do
                     local rw = guiGridListAddRow(playerList)
                     guiGridListSetItemText(playerList, rw, cl, getPlayerName(name), false, false)
                    end

   end
 end 
)
        back = guiCreateButton(155, 290, 108, 44, "Voltar", false, send) 

nameEdit = guiCreateEdit(103, 159, 160, 36,"",false,send)
 
amountEdit = guiCreateEdit(103, 205, 160, 36,"",false,send)
 
sendBTN = guiCreateButton(16, 290, 108, 44, "Enviar", false,send)
function onClickPlayerName ()
  local name = guiGridListGetItemText(playerList, guiGridListGetSelectedItem(playerList), 1)
  guiSetText(nameEdit, name)
end
 
addEventHandler("onClientGUIClick",getRootElement(),
function()
       if ( source == sendBTN ) then
         playerNick = guiGetText(nameEdit)
         amount = guiGetText(amountEdit)
         triggerServerEvent("onSendMoney", getLocalPlayer(), playerNick, amount)

	  setTimer( guiSetEnabled, 100, 1,sendBTN,false)
	    setTimer( guiSetEnabled, 1000, 1,sendBTN,true)
	  end
end)
GUIEditor_Label[1] = guiCreateLabel(16, 169, 87, 16, "Jogador :",false,send)
guiLabelSetColor(GUIEditor_Label[1],0,255,0)
GUIEditor_Label[2] = guiCreateLabel(16, 212, 87, 19, "Quantidade :",false,send)
guiLabelSetColor(GUIEditor_Label[2],0,255,0)
GUIEditor_Label[3] = guiCreateLabel(16, 88, 247, 19, "Valor mínimo de transferência: $200",false,send)
        frag1 = guiCreateLabel(16, 121, 247, 15, "________________________________________", false, send)

        frag2 = guiCreateLabel(16, 251, 247, 15, "________________________________________", false, send)

	
playerMoney = guiCreateLabel(16, 49, 247, 19, "Seu dinheiro  :  ",false,send)


guiSetText ( playerMoney, getPlayerMoney(localPlayer))
function refreshStats()
if guiGetVisible(send,true) then
else
   guiSetText(playerMoney,"Seu dinheiro :  "..getPlayerMoney(getLocalPlayer()))
    end
end
addEventHandler("onClientRender", getRootElement(), refreshStats)

-- اغلاق الوظيفه



 addEventHandler("onClientGUIClick",root,
  function ()
  if source == back then
  guiSetVisible ( send, false )
     guiSetVisible ( playerwindow, true )
	 guiGridListClear(playerList)
end
end)
-----------------------------GPS


-------------------------------------animation-----------------
function makeAnimationGUI()
local x,y = guiGetScreenSize ()
	animationWindow = guiCreateWindow(x/2-345/2, y/2-388/2, 345, 388,"Animações",false)
	guiSetVisible(animationWindow,false)
	guiSetAlpha(animationWindow, 0.87)
	animationCategoryList = guiCreateGridList(10, 34, 157, 251,false,animationWindow)
	animationList = guiCreateGridList(177, 34, 157, 251,false,animationWindow)
	column1 = guiGridListAddColumn(animationCategoryList,"Categoria",0.8)
	column2 = guiGridListAddColumn(animationList,"Animação",0.8)
	stopButton = guiCreateButton(10, 327, 133, 46,"Parar",false,animationWindow)
	backAnimation = guiCreateButton(204, 327, 131, 46, "Voltar", false, animationWindow)    
	
	addEventHandler("onClientGUIClick",stopButton,PararAn)
		

		
		for k, v in ipairs (getElementsByType("animationCategory")) do
			local row = guiGridListAddRow(animationCategoryList)
			guiGridListSetItemText(animationCategoryList,row,column1,getElementID(v),false,false)
		end
addEventHandler("onClientGUIClick",animationCategoryList,getAnimations)
addEventHandler("onClientGUIClick",animationList,setAnimation)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),makeAnimationGUI)


function PararAn()
	triggerServerEvent("setAnimationNil", localPlayer)
end

function getAnimations()
	selectedCategory = guiGridListGetItemText(animationCategoryList,guiGridListGetSelectedItem(animationCategoryList),1)
		if (selectedCategory ~= "") then
			guiGridListClear(animationList)
				for k, v in ipairs (getElementChildren(getElementByID(selectedCategory))) do
					local row = guiGridListAddRow(animationList)
					guiGridListSetItemText(animationList,row,column1,getElementID(v),false,false)
				end
		end
		if (selectedCategory == "") then
			guiGridListClear(animationList)
		end
end

function setAnimation()
	selectedAnimation = guiGridListGetItemText(animationList,guiGridListGetSelectedItem(animationList),1)
		if (selectedAnimation ~= "") then
			if (not isPlayerDead(getLocalPlayer())) then
				if getElementData(localPlayer,"PlayerCaido") then
					outputChatBox("#FFFF00Você não pode usar animações enquanto espera por um samu.", localPlayer, 255, 255, 255, true)
					return
				end
				if (isPedInVehicle(getLocalPlayer()) == false) then
					local animationBlock = getElementData(getElementByID(selectedAnimation),"block")
					local animationID = getElementData(getElementByID(selectedAnimation),"code")
					triggerServerEvent("setAnimation",getLocalPlayer(),animationBlock,animationID)
				else
					outputChatBox("Você não pode usar animações dentro de veículos.",255,0,0)
				end
			else
				outputChatBox("Você não pode usar animações morto.",255,0,0)
			end
		end
end

 addEventHandler("onClientGUIClick",root,
  function ()
  if source == animshe then
  guiSetVisible ( playerwindow, false )
    guiSetVisible ( animationWindow, true )
end
end)



 addEventHandler("onClientGUIClick",root,
  function ()
  if source == backAnimation then
  guiSetVisible ( animationWindow, false )
    guiSetVisible ( playerwindow, true )
end
end)

function closewin()
if (source == playerclpse) then
   guiSetVisible (playerwindow, false) 
   guiSetInputEnabled(false)
   showCursor(false)
	
end
end
addEventHandler ("onClientGUIClick",root,closewin)



------------------------------------------------------------------------------------------

E = {}
B = {}

	  local x,y =  guiGetScreenSize ()

calGUI = guiCreateWindow(x/2-264/2, y/2-249/2, 264, 249,"Calculadora",false)
guiSetAlpha (calGUI,1) 
guiWindowSetSizable(calGUI,false)
E.Numero1 = guiCreateEdit(9, 28, 95, 40,"",false,calGUI)
E.Signo = guiCreateEdit(114, 33, 32, 30,"",false,calGUI)
guiEditSetReadOnly(E.Signo,true)
E.Numero2 = guiCreateEdit(156, 28, 95, 40,"",false,calGUI)

E.Resultado = guiCreateEdit(9, 73, 245, 33,"",false,calGUI)
guiEditSetReadOnly(E.Resultado,true)
B[1] = guiCreateButton(183, 129, 71, 50,"Calcular",false,calGUI)
B[2] = guiCreateButton(9, 189, 58, 50,"+",false,calGUI)
B[3] = guiCreateButton(77, 129, 58, 50,"-",false,calGUI)
B[4] = guiCreateButton(9, 129, 58, 50,"X",false,calGUI)
B[5] = guiCreateButton(77, 189, 58, 50,"/",false,calGUI)
B[6] = guiCreateButton(183, 189, 71, 50, "Voltar", false,calGUI)

guiSetVisible(calGUI,false)



function aaa()
if source == Calculatorpanel then
guiSetVisible (calGUI,true)
guiSetVisible (playerwindow,false)
elseif source == B[6] then
guiSetVisible (calGUI,false)
guiSetVisible (playerwindow,true)
end
end
addEventHandler ("onClientGUIClick",root,aaa)

addEventHandler("onClientGUIClick", root,
function()
local signo = guiGetText(E.Signo)
local uno = guiGetText(E.Numero1)
local dos = guiGetText(E.Numero2)
if source == B[1] then
if signo == '' then
outputChatBox("Você precisa inserir todos os valores!", getLocalPlayer())
elseif uno == '' then
outputChatBox("Você precisa inserir todos os valores!", getLocalPlayer())
elseif dos == '' then
outputChatBox("Você precisa inserir todos os valores!", getLocalPlayer())
end
if signo == '+' then
guiSetText(E.Resultado, tonumber(uno)+tonumber(dos))
elseif signo == '-' then
guiSetText(E.Resultado, tonumber(uno)-tonumber(dos))
elseif signo == 'X' then
guiSetText(E.Resultado, tonumber(uno)*tonumber(dos))
elseif signo == '÷' then
guiSetText(E.Resultado, tonumber(uno)/tonumber(dos))
end
elseif source == B[2] then
guiSetText(E.Signo,"+")
elseif source == B[3] then
guiSetText(E.Signo,"-")
elseif source == B[4] then
guiSetText(E.Signo,"X")
elseif source == B[5] then
guiSetText(E.Signo,"÷")
end
end
)



	addEventHandler("onClientGUIClick", playerList, onClickPlayerName)

--------------------------- intrnet

local x, y = guiGetScreenSize()	
        windowsssaga = guiCreateWindow(x/2-1111/2, y/2-622/2, 1111, 622, "", false)
        guiWindowSetSizable(windowsssaga, false)
        guiSetAlpha(windowsssaga, 1.00) 


	   youbutton = guiCreateButton(12, 550, 163, 55, "Youtube", false, windowsssaga)
        googlebutton = guiCreateButton(303, 550, 163, 55, "Google Tradutor", false, windowsssaga)
  bbas = guiCreateTabPanel(9, 19, 1097, 525, false, windowsssaga)
         stopbutton = guiCreateButton(640, 550, 163, 55, "Parar", false, windowsssaga)
            cbuttont = guiCreateButton(933, 550, 163, 55, "Voltar", false, windowsssaga)
			
  addEventHandler("onClientGUIClick",root,
  function ()
  if source == cbuttont then
  guiSetVisible ( windowsssaga, false )
    guiSetVisible ( playerwindow, true )
end
end)
  
  
   guiSetVisible ( windowsssaga, false )

addEventHandler("onClientGUIClick",root,
  function ()
  if source == youbutton then
  destroyElement(bbas)
    bbas = guiCreateTabPanel(9, 19, 1097, 525, false, windowsssaga)
 browser = guiCreateBrowser(0, 0, 600, 400, false, false, true, bbas)
local theBrowser = guiGetBrowser(browser)
getB()

addEventHandler("onClientBrowserCreated", theBrowser,getB)
guiSetEnabled ( youbutton, false )
guiSetEnabled ( googlebutton, false )
end
end)

function getB()
loadBrowserURL(source, "https://www.youtube.com/channel/UCHRkNVhBfMfFnsSaXGS_UgQ?view_as=subscriber")
end

addEventHandler("onClientGUIClick",root,
  function ()
  if source == stopbutton then
  removeEventHandler("onClientBrowserCreated", theBrowser,getB)
  destroyElement(browser)
  guiSetEnabled ( youbutton, true )
guiSetEnabled ( googlebutton, true )
end
end)
addEventHandler("onClientGUIClick",root,
  function ()
  if source == stopbutton then
  removeEventHandler("onClientBrowserCreated", theBrowser2,gets)
  destroyElement(browsere)
end
end)

function gets()
loadBrowserURL(source, "https://translate.google.com/")
end

-- 
addEventHandler("onClientGUIClick",root,
  function ()
  if source == googlebutton then
  destroyElement(bbas)
    bbas = guiCreateTabPanel(9, 19, 1097, 525, false, windowsssaga)
 browsere = guiCreateBrowser(0, 0, 600, 400, false, false, true, bbas)
local theBrowser2 = guiGetBrowser(browsere)
gets()
addEventHandler("onClientBrowserCreated", theBrowser2,gets)
guiSetEnabled ( youbutton, false )
guiSetEnabled ( googlebutton, false )
end
end)


-------------------------------------------Police-Panel-----------------------------------------------
        Wind = guiCreateWindow(235, 130, 350, 376, "Painel da Policia", false)
        guiWindowSetSizable(Wind, false)  
        guiSetAlpha(Wind, 1.00)

        gridlist = guiCreateGridList(19, 30, 315, 291, false,Wind)
        guiGridListAddColumn(gridlist, "Player", 0.6)
        guiGridListAddColumn(gridlist, "Nível de Procurado", 0.3)
        Gbutton = guiCreateButton(9, 331, 99, 35, "Localizar", false, Wind)
        guiSetProperty(Gbutton, "NormalTextColour", "FFAAAAAA")
        button2 = guiCreateButton(243, 331, 97, 35, "Voltar", false, Wind)
        guiSetProperty(button2, "NormalTextColour", "FFAAAAAA")    
		guiSetVisible (Wind,false)

addEventHandler ("onClientGUIClick",root,
function ()
if getElementData(localPlayer,"Policial") then
if source == policePanel then
guiSetVisible (playerwindow,false)
guiSetVisible (Wind,true)
end
end
end
)

addEventHandler ("onClientGUIClick",root,
function ()
if source == button2 then
guiSetVisible (playerwindow,true)
guiSetVisible (Wind,false)

guiGridListClear ( gridlist )
end
end
)


addEventHandler ("onClientGUIClick",root,
function ()
	if source == policePanel then
		local GetLvl = getPlayerWantedLevel (localPlayer)
			if (GetLvl > 0) then
				for _,v in ipairs(getElementsByType ("player")) do
				row = guiGridListAddRow (gridlist)
				guiGridListSetItemText (gridlist,row,1,getPlayerName ( localPlayer ),false,false)
				guiGridListSetItemText (gridlist,row,2,getPlayerWantedLevel (localPlayer),false,false)
				end
			end
	end
end
)

local Blips_ = {   };

addEventHandler ( "onClientGUIClick", resourceRoot, function (  )

    if ( source == Gbutton ) then

     if ( guiGridListGetSelectedItem (gridlist ) ~= -1 ) then

      local pName = guiGridListGetItemText ( gridlist, guiGridListGetSelectedItem ( gridlist ), 1 )

      if ( pName ~= "" and getPlayerFromName ( pName ) ) then

       if ( isElement ( Blips_ [ getPlayerFromName ( pName ) ] ) ) then

            return

        end

        local p_ = getPlayerFromName ( pName )

        Blips_ [ p_ ] = createBlipAttachedTo ( p_, 41 )

        setTimer ( function ( p_ )

        if ( isElement ( Blips_ [ p_ ] ) ) then

                destroyElement ( Blips_ [ p_ ] )

                Blips_ [ p_ ] = nil

           end

         end, 5000, 1, p_ ) 

      end

   end 
end
end )
----------------------Chat
local Cplayer = getLocalPlayer(  );
local screenW, screenH = guiGetScreenSize(  );
setElementData( Cplayer, 'chatStatus', 'Online' )
setElementData( Cplayer, 'donotDisturb', nil )
local chat_Windows = {  };

local statusTable = {
	{ 'Todos' },
	{ 'Online' },
	{ 'Offline' },
};

local badWordsTable = {
	{'اشخلك'},
	{'دينك'},
	{'ربك'},
	{'ورع'},
	{'ممحون'},
	{'سالب'},
	{'قحبة'},
	{'قحبه'},
	{'كلب'},
	{'متناك'},
	{'قواد'},
	{'جرار'},
	{'طيز'},
	{'كسختك'},
	{'زبي'},
	{'شرموط'},
	{'عرص'},
	{'كسمك'},
	{'امك'},
	{'ابوك'},
	{'اختك'},
	{'زق'},
	{'نيك'},
	{'منيوك'},
	{'_!_'},
};

GUIEditor = {
    checkbox = {},
    label = {},
    edit = {},
    button = {},
    window = {},
    gridlist = {},
    combobox = {}
};
SmsWindow = guiCreateWindow(screenW - 850 - 10, (screenH - 391) / 2, 414, 391, " Mensagens", false)
guiWindowSetSizable(SmsWindow, false)
guiSetAlpha(SmsWindow, 1.00)
guiSetVisible(SmsWindow, false)
GUIEditor.gridlist[1] = guiCreateGridList(10, 75, 254, 274, false, SmsWindow)
guiGridListSetSortingEnabled(GUIEditor.gridlist[1], false)
guiGridListAddColumn(GUIEditor.gridlist[1], "Player", 0.7)
guiGridListAddColumn(GUIEditor.gridlist[1], "Status", 0.2)
GUIEditor.button[1] = guiCreateButton(274, 144, 130, 22, "Abrir Chat", false, SmsWindow)
guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF1FC100")
GUIEditor.button[2] = guiCreateButton(274, 176, 129, 22, "Block Jogador", false, SmsWindow)
guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFD00004")
-----10, 359, 254, 22
GUIEditor.button[4] = guiCreateButton(275, 208, 128, 22, "Ficar Offline", false, SmsWindow)
guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FF139EFE")
GUIEditor.button[5] = guiCreateButton(347, 359, 56, 22, "X", false, SmsWindow)
guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFFF0000")
GUIEditor.edit[1] = guiCreateEdit(10, 42, 254, 23, "", false, SmsWindow)
GUIEditor.label[1] = guiCreateLabel(10, 22, 254, 15, "Buscar jogador", false, SmsWindow)
guiSetFont(GUIEditor.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
GUIEditor.combobox[1] = guiCreateComboBox(273, 75, 131, 100, "Selecionar", false, SmsWindow)
GUIEditor.label[2] = guiCreateLabel(273, 50, 131, 15, "Opções de amostra", false, SmsWindow)
guiSetFont(GUIEditor.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
GUIEditor.checkbox[1] = guiCreateCheckBox(287, 240, 116, 16, "Não Pertube", false, false, SmsWindow)
guiSetProperty(GUIEditor.checkbox[1], "NormalTextColour", "FFFE1217")
guiSetEnabled( GUIEditor.button[2], false )
addEventHandler("onClientGUIClick",root,
  function ()
  if source == sms then
		guiSetVisible( SmsWindow, not guiGetVisible( SmsWindow ) )
		guiSetInputEnabled( guiGetVisible( SmsWindow ) )
	for cNumber, _ in pairs( chat_Windows ) do
		guiSetVisible( chat_Windows[cNumber].window, guiGetVisible( SmsWindow ) )
	end
  end
end)

for _, status in ipairs( statusTable ) do
	guiComboBoxAddItem( GUIEditor.combobox[1], status[1] )
end;

addEventHandler( 'onClientGUIChanged', root,
function(  )
	if ( source == GUIEditor.edit[1] ) then
		local plrString = guiGetText( GUIEditor.edit[1] )
			if ( plrString == '' or not plrString ) then
				local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
				if ( Sel == -1 ) then
					guiGridListClear( GUIEditor.gridlist[1] )
					for _, player in ipairs( getElementsByType( 'player' ) ) do
				addPlayer( player ) 
					end return end
			if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
			end
				else
				local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
				if ( Sel == -1 ) then
					guiGridListClear( GUIEditor.gridlist[1] )
					for _, player in ipairs( getElementsByType( 'player' ) ) do
					if ( string.find( string.upper( getPlayerName( player ) ), string.upper( plrString ) ) ) then
				addPlayer( player ) 
				end end return end
			if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( string.find( string.upper( getPlayerName( player ) ), string.upper( plrString ) ) ) then
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( string.find( string.upper( getPlayerName( player ) ), string.upper( plrString ) ) ) then
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( string.find( string.upper( getPlayerName( player ) ), string.upper( plrString ) ) ) then
			addPlayer( player )
			end
		end
		end
	end
end
end );

function BuildChatting( player )
chat_Windows[player] = {  };
chat_Windows[player].window = guiCreateWindow((screenW - 629) / 2, (screenH - 314) / 2, 629, 314, getPlayerName( player ), false)
guiWindowSetSizable(chat_Windows[player].window, false)
guiSetAlpha(chat_Windows[player].window, 1.00)

chat_Windows[player].memo = guiCreateMemo(10, 21, 609, 242, "", false, chat_Windows[player].window)
guiMemoSetReadOnly(chat_Windows[player].memo, true)
chat_Windows[player].editBox = guiCreateEdit(10, 278, 401, 26, "", false, chat_Windows[player].window)
chat_Windows[player].SendButton = guiCreateButton(421, 280, 104, 24, "Enviar SMS", false, chat_Windows[player].window)
chat_Windows[player].Xclose = guiCreateButton(582, 278, 37, 26, "X", false, chat_Windows[player].window)
chat_Windows[player].Label = guiCreateLabel(10, 263, 609, 15, "* [N/A] is typing ...", false, chat_Windows[player].window)
guiSetFont(chat_Windows[player].Label, "default-small")
guiLabelSetVerticalAlign(chat_Windows[player].Label, "center")
guiSetVisible(chat_Windows[player].Label, false)
chat_Windows[player].Emoji = guiCreateButton(535, 278, 37, 26, "^ᴥ^", false, chat_Windows[player].window)
guiSetProperty(chat_Windows[player].Emoji, "NormalTextColour", "FF4080FF")
guiSetProperty(chat_Windows[player].Xclose, "NormalTextColour", "FFFE0000")
guiSetProperty(chat_Windows[player].SendButton, "NormalTextColour", "FF1FC100")

	if ( guiGetVisible( SmsWindow ) == true ) then
		guiSetVisible( chat_Windows[player].window, true )
	else
		guiSetVisible( chat_Windows[player].window, false )
	end
end;

function clickTimer( element, timer )
	guiSetEnabled( element, false )
		setTimer( guiSetEnabled, timer * 1000, 1, element, true )
end;

function sendNewMessage( player )
	if ( isTimer( sendTimer ) ) then return end
	if ( chat_Windows[player] and isElement( chat_Windows[player].window ) ) then
		local message = guiGetText( chat_Windows[player].editBox )
			for _, badWord in ipairs( badWordsTable ) do
				if ( string.find( message, badWord[1] ) ) then
					guiSetProperty( chat_Windows[player].editBox, 'NormalTextColour', 'FFFF0000' )
						guiSetText( chat_Windows[player].editBox, 'السب والشتم سيعرضك للمخالفات !' )
							guiSetEnabled( chat_Windows[player].editBox, false )
								guiEditSetReadOnly( chat_Windows[player].editBox, true )
									setTimer( function(  )
										guiSetText( chat_Windows[player].editBox, '' )
											guiSetEnabled( chat_Windows[player].editBox, true )
										guiEditSetReadOnly( chat_Windows[player].editBox, false )
									guiSetProperty( chat_Windows[player].editBox, 'NormalTextColour', 'FF000000' )
								end, 3000, 1 )
							sendTimer = setTimer( function(  )
						killTimer( sendTimer )
					end, 2500, 1 )
						return
					end 
				end
			if ( string.len( message ) > 0 ) then
				local oldMessages = guiGetText( chat_Windows[player].memo )
					local newString = oldMessages..getPlayerName( Cplayer ):gsub( '#%x%x%x%x%x%x', '' )..' : '..message..'\n'
				guiSetText( chat_Windows[player].memo, newString )
			guiSetText( chat_Windows[player].editBox, '' )
				guiMemoSetCaretIndex( chat_Windows[player].memo, string.len( oldMessages ) )
			triggerServerEvent( 'onServerSendMessage', Cplayer, player, message )
		sendTimer = setTimer( function(  )
			killTimer( sendTimer )
			end, 2500, 1 )
		end
	end
end;

function destroyChattingWindow( player )
	if ( chat_Windows[player] and isElement( chat_Windows[player].window ) ) then
		destroyElement( chat_Windows[player].window )
		chat_Windows[player] = nil
	end
end;

function removePlayer( player )
	local name = getPlayerName( player )
		for i = 0, guiGridListGetRowCount( GUIEditor.gridlist[1] ) do
			if ( guiGridListGetItemText( GUIEditor.gridlist[1], i, 1 ) == name ) then
		guiGridListRemoveRow( GUIEditor.gridlist[1], i )
	end
end
end;

function privateChatClicks(  )
if ( getElementType( source ) ~= 'gui-button' ) then return end
	local parent = getElementParent( source )
		if ( parent == false or not parent ) then return end
			local player = getPlayerFromName( guiGetText( parent ) )
		if ( player == false or not player ) then return end
	if ( source == chat_Windows[player].SendButton ) then
		sendNewMessage( player )
	elseif ( source == chat_Windows[player].Xclose ) then
		destroyChattingWindow( player )
	elseif ( source == chat_Windows[player].Emoji ) then
		if ( isTimer( emojiTimer ) ) then return end
		local oldMessages = guiGetText( chat_Windows[player].memo )
			local newString = oldMessages..getPlayerName( Cplayer ):gsub( '#%x%x%x%x%x%x', '' )..' : '..'^ᴥ^'..'\n'
				guiSetText( chat_Windows[player].memo, newString )
			guiMemoSetCaretIndex( chat_Windows[player].memo, string.len( oldMessages ) )
		triggerServerEvent( 'onServerSendMessage', Cplayer, player, '^ᴥ^' )
			guiSetEnabled( chat_Windows[player].Emoji, false )
				emojiTimer = setTimer( function(  )
					if ( chat_Windows[player] and isElement( chat_Windows[player].Emoji ) ) then
				guiSetEnabled( chat_Windows[player].Emoji, true )
					end
			killTimer( emojiTimer )
		end, 2500, 1 )
	end
end;
addEventHandler( 'onClientGUIClick', root, privateChatClicks );

addEventHandler( 'onClientGUIClick', root,
function(  )
	if ( source == GUIEditor.button[1] ) then
		clickTimer( GUIEditor.button[1], 3 )
			local Sel = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
				if ( Sel == -1 ) then outputChatBox( '#FFFF00 Por Favor selecione o player com quem deseja iniciar chat !', 255, 255, 255, true ) return end
				local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], Sel, 1 ) )
					if ( player == Cplayer ) then outputChatBox( '#FFFF00 Você Não pode iniciar chat com você Mesmo !', 255, 255, 255, true ) return end
			local serial = getElementData( player, 'chatSystem;playerSerial' )
		triggerServerEvent( 'onServerCheckIfBlocked', Cplayer, serial )
	elseif ( source == GUIEditor.button[4] ) then
		clickTimer( GUIEditor.button[4], 5 )
		if ( guiGetText( GUIEditor.button[4] ) == 'Ficar Offline' ) then
			guiSetEnabled( GUIEditor.button[1], false )
				guiSetEnabled( GUIEditor.button[3], false )
				guiSetEnabled( GUIEditor.button[2], false )
				guiSetEnabled( GUIEditor.gridlist[1], false )
				guiSetEnabled( GUIEditor.combobox[1], false )
				guiSetEnabled( GUIEditor.edit[1], false )
				guiSetEnabled( GUIEditor.checkbox[1], false )
				guiSetText( GUIEditor.button[4], 'Ficar Online' )
			setElementData( Cplayer, 'chatStatus', 'Offline' )
			triggerServerEvent( 'onServerChangeStatus', Cplayer, 'Offline' )
			for cNumber, _ in pairs( chat_Windows ) do
				if ( chat_Windows[cNumber] and isElement( chat_Windows[cNumber].window ) ) then
					destroyElement( chat_Windows[cNumber].window )
					chat_Windows[cNumber] = nil
				end
			end
				else
			guiSetEnabled( GUIEditor.button[1], true )
				guiSetEnabled( GUIEditor.button[3], true )
				guiSetEnabled( GUIEditor.gridlist[1], true )
				guiSetEnabled( GUIEditor.combobox[1], true )
				guiSetEnabled( GUIEditor.edit[1], true )
				guiSetEnabled( GUIEditor.checkbox[1], true )
				guiSetText( GUIEditor.button[4], 'Ficar Offline' )
			setElementData( Cplayer, 'chatStatus', 'Online' )
			triggerServerEvent( 'onServerChangeStatus', Cplayer, 'Online' )
		end
	elseif ( source == GUIEditor.button[5] ) then
		guiSetVisible( SmsWindow, false )
			showCursor( false )
		for cNumber, _ in pairs( chat_Windows ) do
		guiSetVisible( chat_Windows[cNumber].window, false )
		end
	elseif ( source == GUIEditor.gridlist[1] ) then
		local Sel = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
			if ( Sel == -1 ) then
				guiSetEnabled( GUIEditor.button[2], false )
				guiSetText( GUIEditor.button[2], 'Block Player' )
			else
				guiSetEnabled( GUIEditor.button[2], true )
					local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], Sel, 1 ) )
				local serial = getElementData( player, 'chatSystem;playerSerial' )
					if ( serial and string.len( serial ) == 32 ) then
				triggerServerEvent( 'onServerCheckBlockStatus', Cplayer, serial )
			end
		end
	elseif ( source == GUIEditor.button[2] ) then
		clickTimer( GUIEditor.button[2], 3 )
		local Sel = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
			if ( Sel == -1 ) then return end
		local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], Sel, 1 ) )
			local serial = getElementData( player, 'chatSystem;playerSerial' )
		if ( guiGetText( GUIEditor.button[2] ) == 'Block Player' ) then
			triggerServerEvent( 'onServerBlockPlayer', Cplayer, serial, player )
		else
			triggerServerEvent( 'onServerUnblockPlayer', Cplayer, serial )
		end
	elseif ( source == GUIEditor.combobox[1] ) then
		local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				addPlayer( player )
			end
		end
	elseif ( source == GUIEditor.checkbox[1] ) then
		if ( guiCheckBoxGetSelected( GUIEditor.checkbox[1] ) == true ) then
			setElementData( Cplayer, 'donotDisturb', 'Enabled' )
			triggerServerEvent( 'onServerChangeStatus', Cplayer, 'Online' )
		else
			setElementData( Cplayer, 'donotDisturb', nil )
			triggerServerEvent( 'onServerChangeStatus', Cplayer, 'Online' )
		end
	end
end );

local txtValue = 0

function showWriteMessage( player, name )
	if ( isTimer( writeTimer ) ) then return end
		guiSetText( chat_Windows[player].Label, '* ['..name..'] is typing')
			guiSetVisible( chat_Windows[player].Label, true )
				writeTimer = setTimer( function(  )
					if ( txtValue >= 3 ) then
						guiSetText( chat_Windows[player].Label, '* ['..name..'] is typing' )
					txtValue = 0
				end
			guiSetText( chat_Windows[player].Label, guiGetText( chat_Windows[player].Label )..'.' )
		txtValue = txtValue + 1
	end, 500, 0 )
end;
addEvent( 'onClientShowWrite', true ); addEventHandler( 'onClientShowWrite', root, showWriteMessage )


function hideWriteMessage( player )
	if ( isTimer( writeTimer ) ) then killTimer( writeTimer ) end
	guiSetText( chat_Windows[player].Label, '* [N/A] is typing ...')
	guiSetVisible( chat_Windows[player].Label, false )
end;
addEvent( 'onClientHideWrite', true ); addEventHandler( 'onClientHideWrite', root, hideWriteMessage )

addEventHandler( 'onClientGUIChanged', root,
function(  )
	local parent = getElementParent( source )
		if ( not parent ) then return end
			local player = getPlayerFromName( guiGetText( parent ) )
		if ( not player ) then return end
			if ( source == chat_Windows[player].editBox ) then
				if ( guiGetText( chat_Windows[player].editBox ) ~= '' ) then
					triggerServerEvent( 'onServerCheckShow', Cplayer, player, getPlayerName( Cplayer ) )
				local messageStringText = guiGetText( chat_Windows[player].editBox )
					checkIfTextChanged( player, messageStringText )
				else
			triggerServerEvent( 'onServerCheckHide', Cplayer, player )
		end
	end
end );

function checkIfTextChanged( player, text )
	setTimer( function(  )
		if ( guiGetText( chat_Windows[player].editBox ) == text ) then
			triggerServerEvent( 'onServerCheckHide', Cplayer, player )
		end
	end, 1000, 1 )
end;

addEvent( 'onClientPokePlayer', true );
addEventHandler( 'onClientPokePlayer', root,
function( pokedBy )
	if ( getElementData( Cplayer, 'donotDisturb' ) ~= 'Enabled' ) then
		playSound( 'Wakeup.mp3' )
		outputChatBox( '#FFFF00 Chat Privado :#FFFF00 O Player : [ '..pokedBy..' ] - Chamou sua atenção !', 255, 255, 255, true )
	end
end );

addEvent( 'onClientChangeButton', true );
addEventHandler( 'onClientChangeButton', root,
function( Text )
	guiSetText( GUIEditor.button[2], Text )
end );

function buildChattingWith(  )
	local row, column = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
			if ( row == -1 or column == -1 ) then return end
		local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], row, column ) )
			if ( getElementData( player, 'chatStatus' ) ~= 'Online' ) then
				outputChatBox( '#FFFF00 Opa você não pode enviar mensagem para este player ele esta offline !', 255, 255, 255, true ) return end
				if ( not chat_Windows[player] ) then
			BuildChatting( player )
		guiBringToFront( chat_Windows[player].window )
	end
end;
addEvent( 'buildChattingWith', true ); addEventHandler( 'buildChattingWith', root, buildChattingWith )

function privateChatDoubleClicks(  )
	if ( source == GUIEditor.gridlist[1] ) then
		local Sel = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
			if ( Sel == -1 ) then return end
		local player = getPlayerFromName( guiGridListGetItemText( GUIEditor.gridlist[1], Sel, 1 ) )
			if ( player == Cplayer ) then outputChatBox( '#FFFF00 Você não pode iniciar chat com você mesmo !', 255, 255, 255, true ) return end
			local serial = getElementData( player, 'chatSystem;playerSerial' )
		triggerServerEvent( 'onServerCheckIfBlocked', Cplayer, serial )
	end
end;
addEventHandler( 'onClientGUIDoubleClick', root, privateChatDoubleClicks );

addEvent( 'onClientReceiveMessage', true );
addEventHandler( 'onClientReceiveMessage', root,
function( player, message )
	if ( not chat_Windows[player] ) then
		BuildChatting( player ) 
	end
		local oldMessages = guiGetText( chat_Windows[player].memo )
			local newString = oldMessages..getPlayerName( player ):gsub( '#%x%x%x%x%x%x', '' )..' : '..message..'\n'
		guiSetText( chat_Windows[player].memo, newString )
	guiMemoSetCaretIndex( chat_Windows[player].memo, string.len( oldMessages ) )
		if ( guiGetVisible( SmsWindow ) == false ) then
			if ( getElementData( Cplayer, 'donotDisturb' ) ~= 'Enabled' ) then
				outputChatBox( '#FFFF00 The player : [ '..getPlayerName( player )..' ] - Enviou Uma Mensagem Para Voce !', 255, 255, 255, true )
			playSound( 'Message.mp3' )
		end
	end
end );

function addPlayer( player )
	local data = getElementData( player, 'chatStatus' ) or 'Online'
		local name = getPlayerName( player )
			local r, g, b = getPlayerNametagColor( player )
				local row = guiGridListAddRow( GUIEditor.gridlist[1] )
					guiGridListSetItemText( GUIEditor.gridlist[1], row, 1, name, false, false )
						guiGridListSetItemText( GUIEditor.gridlist[1], row, 2, data, false, false )
					guiGridListSetItemColor( GUIEditor.gridlist[1], row, 1, r, g, b )
				if ( data == 'Online' ) then
				guiGridListSetItemColor( GUIEditor.gridlist[1], row, 2, 0, 200, 0 )
			else
		guiGridListSetItemColor( GUIEditor.gridlist[1], row, 2, 200, 0, 0 )
	end
end;

function addOnlinePlayer( player )
	local data = getElementData( player, 'chatStatus' ) or 'Online'
		if ( data == 'Online' ) then
			local name = getPlayerName( player )
				local r, g, b = getPlayerNametagColor( player )
					local row = guiGridListAddRow( GUIEditor.gridlist[1] )
					guiGridListSetItemText( GUIEditor.gridlist[1], row, 1, name, false, false )
				guiGridListSetItemText( GUIEditor.gridlist[1], row, 2, data, false, false )
			guiGridListSetItemColor( GUIEditor.gridlist[1], row, 1, r, g, b )
		guiGridListSetItemColor( GUIEditor.gridlist[1], row, 2, 0, 200, 0 )
	end
end;

function addOfflinePlayer( player )
	local data = getElementData( player, 'chatStatus' ) or 'Offline'
		if ( data == 'Offline' ) then
			local name = getPlayerName( player )
		local r, g, b = getPlayerNametagColor( player )
		local row = guiGridListAddRow( GUIEditor.gridlist[1] )
	guiGridListSetItemText( GUIEditor.gridlist[1], row, 1, name, false, false )
		guiGridListSetItemText( GUIEditor.gridlist[1], row, 2, data, false, false )
			guiGridListSetItemColor( GUIEditor.gridlist[1], row, 1, r, g, b )
		guiGridListSetItemColor( GUIEditor.gridlist[1], row, 2, 200, 0, 0 )
	end
end;

addEvent( 'onClientUpdateStatus', true );
addEventHandler( 'onClientUpdateStatus', root,
function( player, status )
	if ( status == 'Online' ) then
		removePlayer( player )
		local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then addPlayer( player ) return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
	end
	else
		destroyChattingWindow( player )
			removePlayer( player )
		local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then addPlayer( player ) return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
	end
	end
end );

addEvent( 'onClientDestroyChats', true );
addEventHandler( 'onClientDestroyChats', root,
function( player )
	destroyChattingWindow( player )
end );

function player_Join( player )
	if ( player ~= Cplayer ) then
	local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then addPlayer( player ) return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
	end
end
end;
addEvent( 'onClientAddPlayer', true ); addEventHandler( 'onClientAddPlayer', root, player_Join )

function player_Quit( player )
	removePlayer( player )
	destroyChattingWindow( player )
end;
addEvent( 'onClientRemovePlayer', true ); addEventHandler( 'onClientRemovePlayer', root, player_Quit )

function player_ChangedName( player, name )
	for i = 0, guiGridListGetRowCount( GUIEditor.gridlist[1] ) do
		if ( guiGridListGetItemText( GUIEditor.gridlist[1], i, 1 ) == name ) then
			guiGridListRemoveRow( GUIEditor.gridlist[1], i )
		end
	end
		destroyChattingWindow( player )
	setTimer( function(  )
		local Sel = guiComboBoxGetSelected( GUIEditor.combobox[1] )
			if ( Sel == -1 ) then addPlayer( player ) return end
		if ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Online' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Online' ) then
					addOnlinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Offline' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
				if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
					addOfflinePlayer( player )
				end
			end
		elseif ( guiComboBoxGetItemText( GUIEditor.combobox[1], Sel ) == 'Both (All)' ) then
				guiGridListClear( GUIEditor.gridlist[1] )
			for _, player in ipairs( getElementsByType( 'player' ) ) do
			addPlayer( player )
		end
	end
end, 1500, 1 )
end;
addEvent( 'onClientRemovePlayer_ChangedName', true ); addEventHandler( 'onClientRemovePlayer_ChangedName', root, player_ChangedName )

function sendMessage( eleEdit )
	local parent = getElementParent( source )
		if ( parent == false or not parent ) then return end
			local player = getPlayerFromName( guiGetText( parent ) )
		if ( player == false or not player ) then return end
	if ( eleEdit == chat_Windows[player].editBox ) then
		sendNewMessage( player )
	end
end;

addEventHandler( 'onClientGUIAccepted', root, sendMessage );

addEventHandler( 'onClientResourceStart', resourceRoot,
function(  )
	triggerServerEvent( 'onServerSetPlayerSerial', Cplayer )
		setTimer( function(  )
	for _, player in ipairs( getElementsByType( 'player' ) ) do
		addPlayer( player )
	end
end, 1000, 1 )
end );



----------------------------------------------------------------------------------------------------------------------------------------------

-- //#Mensages

mensages = {}
messagetick = 0

function servermessagesCelular(message, type)
	local screenH, screenW = guiGetScreenSize()
	local x, y = (screenH/1366), (screenW/768)
	if not fontScale then fontScale = screenW/40 end
	table.insert(mensages, {message, type or "confirm", getTickCount(), dxGetTextWidth(message, fontScale*0.06, Font_1) + screenH*0.01, 0, 0, 0})
	messagetick = getTickCount()
end
addEvent("servermessagesCelular", true)
addEventHandler("servermessagesCelular", getRootElement(), servermessagesCelular)

function renderMensages()
	local screenH, screenW = guiGetScreenSize()
	local x, y = (screenH/1366), (screenW/768)
	local msgd = mensages
	if #msgd ~= 0 then
		local startY = screenW*0.5
		local i = 1
		repeat
			mData = msgd[i]
			local drawThis = true
			if i~= 1 then
				startY = startY + screenW*0.0425
			end
			if mData[5] == 0 and mData[6] == 0 then
				mData[5] = - mData[4] - screenH*0.015
				mData[6] = startY
				mData[7] = startY
			end
			local tick = getTickCount() - mData[3]
			local posX, posY, alpha
			if tick < 1000 then
				local progress = math.min(tick/1000,1)
				mData[5] = interpolateBetween(mData[5], 0, 0, 0, 0, 0, progress, "Linear")
			elseif tick >= 1000  and tick <= 7000 then
				mData[5] = 0
			elseif tick > 7000 then
				local progress = math.min((tick - 7000)/1000,1)
				mData[5] = interpolateBetween(mData[5], 0, 0, - mData[4] - mData[4] - screenH*0.015, 0, 0, progress, "Linear")
				if progress >= 1 then
					table.remove(msgd, i)
					drawThis = false
					messagetick = getTickCount()
				end
			end
			local globalTick = getTickCount() - messagetick
			if drawThis then
				mData[7] = startY
				mData[6] = interpolateBetween(mData[6], 0, 0, mData[7], 0, 0, math.min(globalTick/1000,1), "Linear")
				posX = mData[5]
				posY = mData[6]
				alpha = 255
				dxDrawRectangle(posX, posY, mData[4], screenW*0.04, tocolor(0, 0, 0, alpha*0.75), true)
				local r, g, b = 0, 255, 0
				if mData[2] == "warning" then
					r, g, b = 255, 0, 0
				end
				dxDrawRectangle(posX + mData[4], posY, screenH*0.010, screenW*0.04, tocolor(r, g, b, alpha*0.85), true)
				dxDrawText(mData[1], posX, posY, posX + mData[4], posY + screenW*0.04, tocolor(255, 255, 255, alpha), fontScale*0.05, Font_1, "center", "center", false, false, true, false, false)
			end
			i = i + 1
		until i > #msgd
		mensages = msgd
	end
end
addEventHandler("onClientRender", getRootElement(), renderMensages)

----------------------------------------------------------------------------------------------------------------------------------------------

function apagarScript()
	if fileExists("client.lua") then
		fileDelete("client.lua")
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), apagarScript)
addEventHandler("onClientPlayerQuit", getRootElement(), apagarScript)
addEventHandler("onClientPlayerJoin", getRootElement(), apagarScript)
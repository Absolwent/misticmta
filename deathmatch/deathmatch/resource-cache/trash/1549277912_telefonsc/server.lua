function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end	

addEvent("onSendMoney", true)
addEventHandler("onSendMoney", getRootElement(),
 function(who, player)
   local money = getPlayerMoney(source)
	if player ~= nil then
    if tonumber(player) >= 200 then
        if tonumber(player) <= money then
            toWho = getPlayerFromPartialName(who)
			conta = getPlayerAccount (source)
			if isGuestAccount (conta) then
				outputChatBox("#FFFF00Você precisa estar logado.", source, 255, 255, 255, true)
				return
			end
			nick_do_jogador           =   getPlayerName ( toWho )
				if toWho ~= false then
					givePlayerMoney(toWho, player)
					takePlayerMoney(source, player)
					name = getPlayerName(source)
					outputChatBox("#FFFF00Você transferiu #00ff00R$" .. player .. "#FFFF00 para #FFFF00" .. nick_do_jogador, source, 255, 255, 255, true)
					outputChatBox("".. name .. " #FFFF00lhe transferiu #FFFF00R$" .. player .. " #FFFF00!", toWho, 255, 255, 255, true)
				else
					outputChatBox("#FFFF00Você não selecionou um jogador da lista!", source, 255, 255, 255,true)
				end
        else
            outputChatBox("#FFFF00Você não tem dinheiro suficiente!", source, 255, 255, 255,true)
        end
    else
        outputChatBox("#FFFF00 O valor mínimo de transferências é R$ 200 !", source, 255, 255, 255,true)
    end
	end
 end
)


function setAnimation(animationBlock,animationID)
if getElementData(source,"PlayerCaido") then
	outputChatBox("#FFFF00Você não pode usar animações enquanto espera por um samu.", source, 255, 255, 255, true)
	return
end
setPedAnimation(source,animationBlock,animationID)
end
addEvent("setAnimation",true)
addEventHandler ("setAnimation",root,setAnimation)

function PararAnS()
	if getElementData(source,"PlayerCaido") then
		outputChatBox("#FFFF00Você não pode usar animações enquanto espera por um samu.", source, 255, 255, 255, true)
		return
	end
	setPedAnimation(source,nil,nil)
end
addEvent("setAnimationNil",true)
addEventHandler ("setAnimationNil",root,PararAnS)

GroupName = "Mecanico"
GroupName2 = "Uber"
GroupName3 = "Policia"
GroupName4 = "Samu"

function ChamarPolicia ()
	local x, y, z = getElementPosition(source)
	local loc = getZoneName ( x, y, z )
	local city = getZoneName ( x, y, z, true )
		outputChatBox("#00FF00• | Você chamou a policia, aguarde.", source, 255, 255, 255, true)
		for theKey,player in ipairs (getElementsByType("player")) do
    		local accName = getAccountName ( getPlayerAccount ( player ) )
			if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( GroupName2 ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( GroupName3 ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( GroupName4 ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( GroupName5 ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( GroupName6 ) ) ) then
				displayServerMessage(player, ""..getPlayerName(source).." precisa de um policial em "..loc.." ("..city..")", "warning")
				local blip = createBlipAttachedTo ( source, 30 )
				setElementVisibleTo(blip, root, false)
				setElementVisibleTo(blip, player, true)
				setTimer ( function()
					destroyElement(blip)
				end, 270000, 1)
      		end
    	end
end
addEvent( "ChamarAPolicia", true )
addEventHandler( "ChamarAPolicia", root, ChamarPolicia)

function ChamarSamu ()
	local x, y, z = getElementPosition(source)
	local loc = getZoneName ( x, y, z )
	local city = getZoneName ( x, y, z, true )
		outputChatBox("#00FF00• | Você chamou os médicos, aguarde.", source, 255, 255, 255, true)
		for theKey,player in ipairs (getElementsByType("player")) do
    		local accName = getAccountName ( getPlayerAccount ( player ) )
			if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( GroupName4) ) ) then
				displayServerMessage(player, ""..getPlayerName(source).." precisa do samu em "..loc.." ("..city..")", "warning")
				local blip = createBlipAttachedTo ( source, 22 )
				setElementVisibleTo(blip, root, false)
				setElementVisibleTo(blip, player, true)
				setTimer ( function()
					destroyElement(blip)
				end, 270000, 1)
      		end
    	end
end
addEvent( "ChamarOSamu", true )
addEventHandler( "ChamarOSamu", root, ChamarSamu)

function ChamarMecanico ()
	local x, y, z = getElementPosition(source)
	local loc = getZoneName ( x, y, z )
	local city = getZoneName ( x, y, z, true )
		outputChatBox("#00FF00• | Você chamou um mecânico, aguarde.", source, 255, 255, 255, true)
		for theKey,player in ipairs (getElementsByType("player")) do
    		local accName = getAccountName ( getPlayerAccount ( player ) )
			if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( GroupName) ) ) then
				displayServerMessage(player, ""..getPlayerName(source).." precisa de um mecânico em "..loc.." ("..city..")", "warning")
				local blip = createBlipAttachedTo ( source, 27 )
				setElementVisibleTo(blip, root, false)
				setElementVisibleTo(blip, player, true)
				setTimer ( function()
					destroyElement(blip)
				end, 270000, 1)
      		end
    	end
end
addEvent( "ChamarOMecanico", true )
addEventHandler( "ChamarOMecanico", root, ChamarMecanico)

function ChamarTaxista ()
	local x, y, z = getElementPosition(source)
	local loc = getZoneName ( x, y, z )
	local city = getZoneName ( x, y, z, true )
		outputChatBox("#00FF00• | Você chamou um uber, aguarde.", source, 255, 255, 255, true)
		for theKey,player in ipairs (getElementsByType("player")) do
    		local accName = getAccountName ( getPlayerAccount ( player ) )
			if ( isObjectInACLGroup ("user."..accName, aclGetGroup ( GroupName2) ) ) then
				displayServerMessage(player, ""..getPlayerName(source).." precisa de um uber em "..loc.." ("..city.."), localize-o em seu GPS", "warning")
				local blip = createBlipAttachedTo ( source, 56 )
				setElementVisibleTo(blip, root, false)
				setElementVisibleTo(blip, player, true)
				setTimer ( function()
					destroyElement(blip)
				end, 270000, 1)
      		end
    	end
end
addEvent( "ChamarOTaxista", true )
addEventHandler( "ChamarOTaxista", root, ChamarTaxista)

function ErroL ()
	outputChatBox("#FFFF00Você não pode enviar a localização para sí mesmo.", source, 255, 255, 255, true)
end
addEvent( "ErroLoc", true )
addEventHandler( "ErroLoc", root, ErroL)

function EnviarL (player)
	local x, y, z = getElementPosition(source)
	local loc = getZoneName ( x, y, z )
	local city = getZoneName ( x, y, z, true )
		outputChatBox("#FFFF00Você mandou sua localização para "..getPlayerName(player), source, 255, 255, 255, true)
		outputChatBox("#FFFF00"..getPlayerName(source).." enviou a própria localização para você. "..loc.." ("..city..")", player, 255, 255, 255, true)
		local blip = createBlipAttachedTo ( source, 41 )
		setElementVisibleTo(blip, root, false)
		setElementVisibleTo(blip, player, true)
		setTimer ( function()
			destroyElement(blip)
		end, 270000, 1)
end
addEvent( "EnviarLocalizacao", true )
addEventHandler( "EnviarLocalizacao", root, EnviarL)

-----------------------------------Policia

local chatSystemDB = dbConnect( 'sqlite', 'Chat System - Database.db' )
dbExec( chatSystemDB, 'CREATE TABLE IF NOT EXISTS `Chat_System` (sourceSerial, blockedSerial)' )

addEvent( 'onServerCheckShow', true );
addEventHandler( 'onServerCheckShow', root,
function( player, name )
	if ( player and player ~= source ) then
		triggerClientEvent( player, 'onClientShowWrite', source, source, name )
	end
end );

addEvent( 'onServerCheckHide', true );
addEventHandler( 'onServerCheckHide', root,
function( player )
	if ( player and player ~= source ) then
		triggerClientEvent( player, 'onClientHideWrite', source, source )
	end
end );

addEvent( 'onServerCheckIfBlocked', true );
addEventHandler( 'onServerCheckIfBlocked', root,
function( serial )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
	if ( type( results ) == 'table' and #results ~= 0 ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Sorry, You cannot send a message to this player .. it\'s blocked !', source, 255, 255, 255, true ) return end
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', serial, getPlayerSerial( source ) )
		local results = dbPoll( check, -1 )
	if ( type( results ) == 'table' and #results ~= 0 ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Sorry, You cannot send a message to this player .. he was blocked you !', source, 255, 255, 255, true ) return end
		triggerClientEvent( source, 'buildChattingWith', source )
end );

addEvent( 'onServerSendPoke', true );
addEventHandler( 'onServerSendPoke', root,
function( player, serial )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
			if ( type( results ) == 'table' and #results ~= 0 ) then outputChatBox( '#FF0000• ERROR :#FFFFFF Sorry, You cannot send a poke to this player .. it\'s blocked or he was blocked you !', source, 255, 255, 255, true ) return end
		if ( getElementData( player, 'chatStatus' ) == 'Offline' ) then
			outputChatBox( '#FF0000• ERROR :#FFFFFF Sorry, You cannot send a poke to this player .. it\'s offline !', source, 255, 255, 255, true ) return end
		triggerClientEvent( player, 'onClientPokePlayer', source, getPlayerName( source ) )
end );

addEvent( 'onServerCheckBlockStatus', true );
addEventHandler( 'onServerCheckBlockStatus', root,
function( serial )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
			if ( type( results ) == 'table' and #results == 0 or not results ) then triggerClientEvent( source, 'onClientChangeButton', source, 'Block Player' ) return end
		triggerClientEvent( source, 'onClientChangeButton', source, 'Unblock Player' )
end );

addEvent( 'onServerBlockPlayer', true );
addEventHandler( 'onServerBlockPlayer', root,
function( serial, player )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
			if ( type( results ) == 'table' and #results ~= 0 ) then return end
		dbExec( chatSystemDB, 'INSERT INTO `Chat_System` VALUES(?,?)', getPlayerSerial( source ), serial )
	triggerClientEvent( source, 'onClientChangeButton', source, 'Desbloquear Player' )
	triggerClientEvent( player, 'onClientDestroyChats', source, source )
	triggerClientEvent( source, 'onClientDestroyChats', source, player )
end );

addEvent( 'onServerUnblockPlayer', true );
addEventHandler( 'onServerUnblockPlayer', root,
function( serial )
	local check = dbQuery( chatSystemDB, 'SELECT * FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
		local results = dbPoll( check, -1 )
			if ( type( results ) == 'table' and #results == 0 or not results ) then triggerClientEvent( source, 'onClientChangeButton', source, 'Block Player' ) return end
		dbExec( chatSystemDB, 'DELETE FROM `Chat_System` WHERE sourceSerial = ? AND blockedSerial = ?', getPlayerSerial( source ), serial )
	triggerClientEvent( source, 'onClientChangeButton', source, 'Block Player' )
end );

addEventHandler( 'onPlayerJoin', getRootElement(  ),
function(  )
	triggerClientEvent( root, 'onClientAddPlayer', source, source )
end );

addEventHandler( 'onPlayerQuit', getRootElement(  ),
function(  )
	triggerClientEvent( root, 'onClientRemovePlayer', source, source )
end );

addEventHandler( 'onPlayerChangeNick', getRootElement(  ),
function( old, new )
	triggerClientEvent( root, 'onClientRemovePlayer_ChangedName', source, source, old )
end );

addEvent( 'onServerSetPlayerSerial', true );
addEventHandler( 'onServerSetPlayerSerial', root,
function(  )
	setElementData( source, 'chatSystem;playerSerial', getPlayerSerial( source ) )
end );

addEvent( 'onServerChangeStatus', true );
addEventHandler( 'onServerChangeStatus', root,
function( Status )
	triggerClientEvent( root, 'onClientUpdateStatus', source, source, Status )
end );

addEvent( 'onServerSendMessage', true );
addEventHandler( 'onServerSendMessage', root,
function( plr, message )
	triggerClientEvent( plr, 'onClientReceiveMessage', source, source, message )
end );

addEvent( 'onServerPutPlayers', true );
addEventHandler( 'onServerPutPlayers', root,
function(  )
	for _, player in ipairs( getElementsByType( 'player' ) ) do
			local plrName = getPlayerName( player )
		local plrStatus = getElementData( player, 'privateChatSystem;playerStatus' ) or 'Online'
	triggerClientEvent( root, 'onClientPutPlayers', player, plrName, plrStatus )
	end
end );


--------Chat

function ScriptCellRR()
	local jogadores = getElementsByType("player")
	for _, player in ipairs(jogadores) do
		local conta = getPlayerAccount(player)
		local conta2 = getAccountName(getPlayerAccount(player))
		if isGuestAccount(conta) then
			return
		else
			if isObjectInACLGroup("user." .. conta2, aclGetGroup("PMERJ")) then
				setElementData(player, "cpolicia", true)
			end
		end
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), ScriptCellRR)

function CarregarPolAoLogar(_, account)
	local conta2 = getAccountName(getPlayerAccount(source))
	if isObjectInACLGroup("user." .. conta2, aclGetGroup("PMERJ")) then
		setElementData(source, "cpolicia", true)
	end
end
addEventHandler("onPlayerLogin", getRootElement(), CarregarPolAoLogar)

-- //#Mensages
function displayServerMessage(source, message, type)
	triggerClientEvent(source, "servermessagesCelular", getRootElement(), message, type)
end
 
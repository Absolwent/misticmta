--
-- c_pedNormal.lua
--

myShader={}
local bumpTex={}

local sEffIntens = {0.8,1}
local sFreshlInten = {-0.42,1} 
local maxEffectDistance = 22
local sunEnabled = true -- requires shader model 3

function versionCheck()
 if getVersion ().sortable < "1.3.3-9.05658" then
   outputChatBox( "Shader_Ped_Normal resource is not compatible with this client." )
   outputChatBox( "Please update MTA:SA" )
   return false
 else
 return true 
 end
end
	
function applyNormalToPedTexture(applyTable)
if not versionCheck() then return false end	
 for _,name in ipairs(applyTable) do
  lastBit=string.len(string.match(name,("(.*_)")))
  bumpfactor=tonumber(string.sub(name,lastBit+4,-5))
  sEffIntens[1]=bumpfactor
  texName=string.sub(name,string.len(string.match(name,("(.*/)")))+1,lastBit-1) 
  myShader[texName] = dxCreateShader ( "shaders/pedNormal.fx",2,maxEffectDistance,false,"ped")
  if not myShader[texName] then
   outputChatBox( "ShaderPedNormal fail. Please use debugscript 3" )
   return false
  else
   -- Set textures
   bumpTex[texName] = dxCreateTexture ( name )
   dxSetShaderValue ( myShader[texName], "sBumpTexture", bumpTex[texName] )
   dxSetShaderValue ( myShader[texName], "sEffIntens", sEffIntens)
   dxSetShaderValue ( myShader[texName], "sFreshlInten", sFreshlInten)
   dxSetShaderValue ( myShader[texName], "sVisibility", 0 )
   
   engineApplyShaderToWorldTexture ( myShader[texName], texName )
  end
 end	
 if tonumber(dxGetStatus().VideoCardPSVersion)>2 and sunEnabled==true then enableSunLight() end 
 return true
end

function removeNormalFromPedTexture(removeTable)
if not versionCheck() then return end	
 for _,name in ipairs(removeTable) do
  lastBit=string.len(string.match(name,("(.*_)")))
  texName=string.sub(name,string.len(string.match(name,("(.*/)")))+1,lastBit-1) 
  if  myShader[texName] then 
   engineRemoveShaderFromWorldTexture ( myShader[texName], texName )
   destroyElement(myShader[texName])
   myShader[texName]=nil
   destroyElement(bumpTex[texName])
   bumpTex[texName]=nil	
   if myShader[texName] then outputDebugString('removeNormalFromPedTexture: '..texName..'; fail') return false end
  end
 end
return true 
end

function destroyShaderElements()
 if myShader then
  myShader=nil
  bumpTex=nil
 end
end

addEventHandler("onClientResourceStop",resourceRoot, destroyShaderElements)
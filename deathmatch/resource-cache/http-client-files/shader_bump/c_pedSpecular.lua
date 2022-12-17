--
-- c_pedSpecular.lua
--
pedSobelShader = nil
local bumpTex = {}

local sEffIntens = {0.8,0.5}
local sFreshlInten = {-0.42,1}
local maxEffectDistance = 22
local sunEnabled = true -- works with both SM2 and SM3


pedModelIdPairs = {
{1,2}, {7,7}, {9,29}, {30,41}, {43,52}, {53,64}, {66,73}, {75,85}, {87,118}, {120,144}, 
{145,148}, {150,189}, {190,207}, {209,238},{240,264},{265,272},{278,288},{290,312},
}					

function applySpecularToGTAPeds(pedIDs,isSobel)
if not versionCheck() then return false end	
  if not pedSobelShader then pedSobelShader = dxCreateShader ( "shaders/pedSobel.fx",1,maxEffectDistance,false,"ped") end
  if not pedSobelShader then
   outputChatBox( "ShaderPedSobel fail. Please use debugscript 3" )
   return false
  else
   dxSetShaderValue ( pedSobelShader, "isSobel", isSobel )
   dxSetShaderValue ( pedSobelShader, "sEffIntens", sEffIntens)
   dxSetShaderValue ( pedSobelShader, "sFreshlInten", sFreshlInten)
   dxSetShaderValue ( pedSobelShader, "sVisibility", 0 )
   if type(pedIDs)~="table" then
   for _,IDTable in ipairs(pedModelIdPairs) do	 
    for thePedID=IDTable[1],IDTable[2],1 do
     for _,pedTex in ipairs( engineGetModelTextureNames( thePedID ) ) do
      engineApplyShaderToWorldTexture ( pedSobelShader, pedTex )
     end
    end
   end	 
   else
    for _,singlePedID in ipairs(pedIDs) do   
     for _,pedTex in ipairs(engineGetModelTextureNames(singlePedID)) do
      engineApplyShaderToWorldTexture ( pedSobelShader, pedTex )
     end
    end
   end
 end
 if tonumber(dxGetStatus().VideoCardPSVersion)>1 and sunEnabled==true then enableSunLight() end
return true 
end

function removeSpecularFromGTAPeds(pedIDs)
if not versionCheck() then return false end	
  if  pedSobelShader then
   if type(pedIDs)~="table" or pedIDs==nil then  
    engineRemoveShaderFromWorldTexture ( pedSobelShader, "*" )
    destroyElement(pedSobelShader)
    pedSobelShader=nil
    pedApplyList=nil
    if pedSobelShader then outputDebugString('removeSpecularFromGTAPeds fail') return false end
  else
   for _,singlePedID in ipairs(pedIDs) do 
    for _,pedTex in ipairs(engineGetModelTextureNames(singlePedID)) do
     engineRemoveShaderFromWorldTexture ( pedSobelShader, pedTex )
    end
   end
  end   
 return true
 end 
end

addEventHandler("onClientResourceStop",resourceRoot, function()
removeSpecularFromGTAPeds()
end
)

--addEventHandler("onClientResourceStart",resourceRoot, function() applySpecularToGTAPeds({0,7},false) end ) -- testing
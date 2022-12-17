local shader_texture_1 = dxCreateTexture('assets/images/reflection.dds')
local shader_texture_2 = dxCreateTexture('assets/images/tempBody.png')
local shader_texture_3 = dxCreateTexture('assets/images/carbon.dds')

local shader_texture = {
	'remap', 
	'body', 
	'remap_body',
	
}

local vehicleShaders = {}

local tintProperties = {
	front = {
		data = "tint_front",
		material = "lob_steklo"
	},
	side = {
		data = "tint_side",
		material = "pered_steklo"
	},
	rear = {
		data = "tint_rear",
		material = "zad_steklo"
	},
}

local cachedTextures = {}

local function getCachedPaintjob(path)
	local texture = cachedTextures[path]
	if not isElement(texture) then
		texture = dxCreateTexture(path, "dxt1")
		cachedTextures[path] = texture
	end
	return texture
end

local function getColorTexture(r, g, b, a)
    local texture = dxCreateTexture(1, 1, "argb")
    local pixels = string.char(0, 0, 0, 0, 1, 0, 1, 0)
    dxSetPixelColor(pixels, 0, 0, r, g, b, a)
    texture:setPixels(pixels)
    return texture
end

local function createVehicleShaders(vehicle, omitTint, omitPaintjob)
	if not isElement(vehicle) or not isElementStreamedIn(vehicle) then
		return
	end
	iprint( vehicle )
	
	local shadersTable = vehicleShaders[vehicle] or {}
	local paintShader = vehicle:getData("colorType") or 1
	local paintjob = vehicle:getData("paintjob")
	local path = ":car_components/textures/paintjobs/"..tostring(paintjob) .. ".dds"
	local shader = shadersTable.paintjob
	if paintShader == 1 then			-- Обычная
		iprint( vehicle, 'Обычная' )
		shader = dxCreateShader('assets/shaders/acrylic.fx',1, 100)
		
		shader:setValue("sRandomTexture", shader_texture_2)
		shader:setValue("sReflectionTexture", shader_texture_1)
		
		if paintjob and paintjob ~= 3 and paintjob ~= "3" and fileExists(path) then
			local texture = getCachedPaintjob(path)
			shader:setValue("gTexture", texture)
			shader:setValue("enableVinils", true)
		end
		
		for i, item in pairs(shader_texture) do
			engineApplyShaderToWorldTexture(shader, item, vehicle)
		end
	elseif paintShader == 2 then		-- Перламутровая
		iprint( vehicle, 'Перламутровая' )
		shader = dxCreateShader('assets/shaders/pearl.fx',1, 100)
		shader:setValue('sReflectionTexture', shader_texture_1)
		shader:setValue('gTexture', shader_texture_2)
		sc_r, sc_g, sc_b = unpack( vehicle:getData('colorTypeRGB') or {0, 0, 0} )
		shader:setValue('paintColor2', {sc_r, sc_g, sc_b})
		
		if paintjob and paintjob ~= 3 and paintjob ~= "3" and fileExists(path) then
			local texture = getCachedPaintjob(path)
			shader:setValue("gTexture", texture)
			shader:setValue("enableVinils", true)
		end
		
		for i, item in pairs(shader_texture) do
			engineApplyShaderToWorldTexture(shader, item, vehicle)
		end
	elseif paintShader == 3 then		-- Матовая
		iprint( vehicle, 'Матовая' )
		shader = dxCreateShader('assets/shaders/matte.fx',1, 100)
		shader:setValue('sReflectionTexture', shader_texture_3)
		shader:setValue('gTexture', shader_texture_2)
		
		if paintjob and paintjob ~= 3 and paintjob ~= "3" and fileExists(path) then
			local texture = getCachedPaintjob(path)
			shader:setValue("gTexture", texture)
			shader:setValue("enableVinils", true)
		end
		
		for i, item in pairs(shader_texture) do
			engineApplyShaderToWorldTexture(shader, item, vehicle)
		end
	elseif paintShader == 4 then		-- Хром
		iprint( vehicle, 'Хром' )
		shader = dxCreateShader('assets/shaders/car_refgrun.fx',1, 100)
		shader:setValue('sReflectionTexture', shader_texture_1)
		shader:setValue('gTexture', shader_texture_2)
		sc_r, sc_g, sc_b = unpack( vehicle:getData('colorTypeRGB') or {0, 0, 0} )
		shader:setValue('paintColor2', {sc_r, sc_g, sc_b})
		
		if paintjob and paintjob ~= 3 and paintjob ~= "3" and fileExists(path) then
			local texture = getCachedPaintjob(path)
			shader:setValue("gTexture", texture)
			shader:setValue("enableVinils", true)
		end
		
		for i, item in pairs(shader_texture) do
			engineApplyShaderToWorldTexture(shader, item, vehicle)
		end
elseif paintShader == 5 then		-- карбон
	iprint( vehicle, 'Карбоновая' )
	shader = dxCreateShader('assets/shaders/carbon.fx',1, 100)
	shader:setValue('sReflectionTexture', shader_texture_3)
	shader:setValue('gTexture', shader_texture_2)
	sc_r, sc_g, sc_b = unpack( vehicle:getData('colorTypeRGB') or {0, 0, 0} )
	shader:setValue('paintColor2', {sc_r, sc_g, sc_b})
	
	if paintjob and paintjob ~= 3 and paintjob ~= "3" and fileExists(path) then
		local texture = getCachedPaintjob(path)
		shader:setValue("gTexture", texture)
		shader:setValue("enableVinils", true)
	end
	
	for i, item in pairs(shader_texture) do
		engineApplyShaderToWorldTexture(shader, item, vehicle)
	end
end
	vehicleShaders[vehicle] = shadersTable
end
addEventHandler("onClientResourceStart", root, createVehicleShaders)

local function removeVehicleShaders(vehicle)
	if not vehicleShaders[vehicle] then
		return false
	end
	for name, shader in pairs(vehicleShaders[vehicle]) do
		if isElement(shader) then
			destroyElement(shader)
		end
	end
	vehicleShaders[vehicle] = nil
end

addEventHandler("onClientElementStreamIn", root, function ()
	if getElementType(source) == "vehicle" then
		createVehicleShaders(source)
	end
end)

local function handleVehicleDestroy()
    removeVehicleShaders(source)
end

addEventHandler("onClientElementDestroy",   root, handleVehicleDestroy)
addEventHandler("onClientElementStreamOut", root, handleVehicleDestroy)
addEventHandler("onClientVehicleExplode",   root, handleVehicleDestroy)

addEvent("forceUpdateVehicleShadersCrutch", true)
addEventHandler("forceUpdateVehicleShadersCrutch", root, function ( )
	createVehicleShaders(source)
end)

local FONTS_PATH = "Fonts/"

local function setupElementParent(element,resource)
	if not element or not resource then
		return false
	end
	setElementParent(element,getResourceDynamicElementRoot(resource))
	return true
end

function createFont(name,...)
	local element = dxCreateFont(FONTS_PATH..tostring(name),...)
	setupElementParent(element,sourceResource)
	return element	
end

function createGuiFont(name,...)
	local element = guiCreateFont(FONTS_PATH..tostring(name),...)
	setupElementParent(element,sourceResource)
	return element	
end
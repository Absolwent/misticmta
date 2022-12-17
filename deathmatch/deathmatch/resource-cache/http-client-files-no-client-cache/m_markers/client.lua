local test = createMarker ( -1978.3897705078, 282.61419677734, 35.179355621338, "cylinder", 1.5, 255, 255, 0, 170 )

local MARKER_COLLISION_RADIUS = 1.4
local markersByResource = {}

function createMarker(markerType,position,direction)
	if type(markerType) ~= "string" or not position then
		return false
	end
	if type(direction) ~= "number" then
		direction = 0
    end

	local radius = getMarkerProperties(markerType).radius
	if radius then
		radius = radius * 0.5
	else
		radius = MARKER_COLLISION_RADIUS
    end
    
    local restricted = getMarkerProperties(markerType).restrict
    if restricted then
        restricted = "player"
    end

	local marker = Marker(position,"cylinder",radius,0,0,0,0)
	marker:setData("marker:type",markerType)
	marker:setData("marker:restrictElement",restricted)
	if isElement(sourceResourceRoot) then
		if not markersByResource[sourceResourceRoot] then
			markersByResource[sourceResourceRoot] = {}
		end
		markersByResource[sourceResourceRoot][marker] = true
	end
	addMarkerToDraw(marker)
	marker:setData("marker:direction",math.rad(direction))
	return marker
end

addEventHandler("onClientResourceStop",root,function()
	if markersByResource[source] then
		for marker in pairs(markersByResource[source]) do
			if isElement(marker) then
				destroyElement(marker)
			end
			markersByResource[source][marker] = nil
		end
	end
	markersByResource[source] = nil
end)

local MARKER1 = createMarker("shop",Vector3(701.625, -447.204, 15.4),0)
local MARKER2 = createMarker("carshop",Vector3(705.625, -447.204, 15.4),0)
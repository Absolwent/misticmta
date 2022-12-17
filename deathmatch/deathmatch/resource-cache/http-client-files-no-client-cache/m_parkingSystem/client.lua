parkYerleri =  {}
park = dxCreateTexture("parking.png")
parkYerleri[1] = createMarker(-2062.2819824219, -109.319190979, 34.735450744629, "corona", 1, 255, 185, 0, 0 )

function panelOrtala (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end

addEventHandler("onClientResourceStart", resourceRoot,
    function()
    	PencerePark = guiCreateWindow(0, 0, 250, 255, "Park Alanı", false)
        guiWindowSetSizable(PencerePark, false)
        gridlistPark = guiCreateGridList(10, 29, 280, 139, false, PencerePark)
        guiGridListAddColumn(gridlistPark, "Park Menusu", 1)
        for i = 1, 5 do
            guiGridListAddRow(gridlistPark)
        end
        guiGridListSetItemText(gridlistPark, 0, 1, "Park Etmek istiyorum", false, false)
        guiGridListSetItemText(gridlistPark, 1, 1, "Park Etmek istemiyorum", false, false)
        guiGridListSetItemColor(gridlistPark, 0, 1, 77, 254, 0, 255)
        guiGridListSetItemColor(gridlistPark, 1, 1, 255, 0, 0, 255)
        parket = guiCreateButton(10, 178, 251, 28, "Tamam", false, PencerePark)
        guiSetFont(parket, "default-bold-small")
        guiSetVisible(PencerePark,false)
        panelOrtala( PencerePark )
    end
)

function parkYeri()
  for i,v in ipairs(parkYerleri) do
  _3DResim(v,park);
  x, y, z = getElementPosition(v)
  dxDrawOctagon3D(x,y,z-0.8, 1, 1, tocolor(0,255,255,255) )
end
end
addEventHandler("onClientRender", getRootElement(), parkYeri)
for i=1,500 do
function markerfunc( hitElement, matchingDimension )
   if getElementType(hitElement) == "player" and (hitElement == localPlayer) and getPedOccupiedVehicle(localPlayer) then
            guiSetVisible(PencerePark,true)
            showCursor(true)
            x, y, z = getElementPosition(parkYerleri[i])
            setElementPosition(getPedOccupiedVehicle(localPlayer), x,y,z)
            setElementFrozen(getPedOccupiedVehicle(localPlayer), true)
    end
end
addEventHandler( "onClientMarkerHit", parkYerleri[i] , markerfunc )
end
function _3DResim(TheElement,Image,distance,height,width,R,G,B,alpha)
        local x, y, z = getElementPosition(TheElement)
        local x2, y2, z2 = getElementPosition(localPlayer)
        local distance = distance or 20
        local height = height or 1
        local width = width or 1
                                local checkBuildings = checkBuildings or true
                                local checkVehicles = checkVehicles or false
                                local checkPeds = checkPeds or false
                                local checkObjects = checkObjects or true
                                local checkDummies = checkDummies or true
                                local seeThroughStuff = seeThroughStuff or false
                                local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
                                local ignoredElement = ignoredElement or nil
        if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
          local sx, sy = getScreenFromWorldPosition(x, y, z+height)
          if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
              dxDrawMaterialLine3D(x, y, z+1+height-(distanceBetweenPoints/distance), x, y, z+height, Image, width-(distanceBetweenPoints/distance), tocolor(R or 255, G or 255, B or 255, alpha or 255))
            end
          end
      end
  end
  function dxDrawOctagon3D(x, y, z, radius, width, color)
  if type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
    return false
  end

  local radius = radius or 1
  local radius2 = radius/math.sqrt(2)
  local width = width or 1
  local color = color or tocolor(255,255,255,150)

  point = {}

    for i=1,8 do
      point[i] = {}
    end

    point[1].x = x
    point[1].y = y-radius
    point[2].x = x+radius2
    point[2].y = y-radius2
    point[3].x = x+radius
    point[3].y = y
    point[4].x = x+radius2
    point[4].y = y+radius2
    point[5].x = x
    point[5].y = y+radius
    point[6].x = x-radius2
    point[6].y = y+radius2
    point[7].x = x-radius
    point[7].y = y
    point[8].x = x-radius2
    point[8].y = y-radius2

  for i=1,8 do
    if i ~= 8 then
      x, y, z, x2, y2, z2 = point[i].x,point[i].y,z,point[i+1].x,point[i+1].y,z
    else
      x, y, z, x2, y2, z2 = point[i].x,point[i].y,z,point[1].x,point[1].y,z
    end
    dxDrawLine3D(x, y, z, x2, y2, z2, color, width)
  end
  return true
end

function tik()
  local degisken = guiGridListGetItemText ( gridlistPark, guiGridListGetSelectedItem ( gridlistPark ), 1 )
  if source == parket then
    if degisken == "Park Etmek istemiyorum" then
  arac = getPedOccupiedVehicle(localPlayer)
    guiSetVisible(PencerePark,false)
        setElementFrozen ( arac, false )
    showCursor(false)
  end
  if degisken == "Park Etmek istiyorum" then
  arac = getPedOccupiedVehicle(localPlayer)
    guiSetVisible(PencerePark,false)
        setElementFrozen ( arac, true )
    showCursor(false)
  end
end
end
addEventHandler("onClientGUIClick", getRootElement(), tik)
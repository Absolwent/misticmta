local sX, sY = guiGetScreenSize()
local height = 30
local screenOffset = 15
local margin = 10
local padding = 15

local notifications = {}
local color = {
  ["news"] = {
    255,
    255,
    255
  },
  ["warning"] = {
    255,
    0,
    0
  },
  ["info"] = {
    150,
    150,
    250
  },
}

local position = {
	["right-top"] = 1,
	["top"] = .5,
	["left-top"] = 0,
}

for k, v in pairs(position) do
	notifications[k] = {}
end

function addNotification(nText, nType, nDuration, position)
  if not nText or not nType then
    return
  end
  if not position or not position then
    return
  end
  if not tonumber(nDuration) and nDuration ~= false then
    nDuration = 5000
  end
  local nWidth = dxGetTextWidth(nText, 1.25, "default-bold") + 10
  local index = table.maxn(notifications[position]) + 1
  table.insert(notifications[position], index, {
    text = nText,
    type = tostring(nType),
    duration = tonumber(nDuration),
    added = getTickCount(),
    alpha = 0,
    state = "fadeIn",
    multiplier = 1,
    width = nWidth,
  })
  playSound("plonk.mp3")
  return index
end

function removeNotification(index)
  if not index then
    return
  end
  notifications[tonumber(index)] = nil
end

addEventHandler("onClientRender", root, function()
  for index, vpos in pairs(notifications) do
  local yOffset = margin
	 for k, v in pairs(vpos) do
		if v.duration and v.state ~= "fadeOut" and v.state ~= "shrink" and getTickCount() - v.added >= v.duration then
		  v.state = "fadeOut"
		  v.multiplier = 1
		end
		if v.state == "fadeIn" then
		  v.multiplier = v.multiplier * 1.1
		  v.alpha = math.min(v.alpha + 3 * v.multiplier, 255)
		  if v.alpha == 255 then
			v.state = nil
		  end
		elseif v.state == "fadeOut" then
		  v.multiplier = v.multiplier * 1.1
		  v.alpha = math.max(v.alpha - 3 * v.multiplier, 0)
		  if v.alpha == 0 then
			v.heightMultiplier = 1
			v.state = "shrink"
		  end
		elseif v.state == "shrink" then
		  v.heightMultiplier = math.max(0, v.heightMultiplier - 0.07)
		  if v.heightMultiplier == 0 then
			notifications[k] = nil
		  end
		end
		local tiledWidth = v.width
		local r, g, b = unpack(color[v.type])
		local pos = position[index]
		local currentScreenOffset = screenOffset
		if (pos == 0) then
			currentScreenOffset = -screenOffset
		elseif (pos == .5) then
			currentScreenOffset = 0;
		end
		dxDrawRectangle((sX * pos) - ((v.width + padding) * pos) - currentScreenOffset, yOffset, tiledWidth + padding, height, tocolor(0,0, 0, v.alpha * 0.6))
		dxDrawText(v.text, (sX * pos) - ((v.width + padding) * pos)- currentScreenOffset, yOffset, (sX * pos) - ((v.width + padding) * pos) - currentScreenOffset + (tiledWidth + padding), yOffset + height, tocolor(r, g, b, v.alpha), 1.25, "default-bold", "center", "center", true, false, true, true)
		yOffset = yOffset + (v.heightMultiplier or 1) * (height + margin)
	end
  end
end)



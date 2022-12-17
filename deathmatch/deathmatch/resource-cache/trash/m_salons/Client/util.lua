--[[
    
    AUTHOR - https://vk.com/ganzes77
    GROUP VK - https://vk.com/ganzes_shop

]]

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function cs(x, y, w, h)
    if (not isCursorShowing()) then
        return false
    end
    local mx, my = getCursorPosition()
    local fullx, fully = guiGetScreenSize()
    cursorx, cursory = mx*fullx, my*fully
    if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
        return true
    else
        return false
    end
end
function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
    if (x and y and w and h) then
        if (not borderColor) then
            borderColor = tocolor(0, 0, 0, 200);
        end
        if (not bgColor) then
            bgColor = borderColor;
        end
        dxDrawRectangle(x, y, w, h, bgColor, postGUI);
        dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI);
        dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI);
        dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI);
        dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI);
    end
end
function btn(x, y, w, h, image, hoverImage, color, text, font)
    if not image then return false end
    if not hoverImage then hoverImage = image end
    if not color then color = tocolor(255, 255, 255, self.alpha) end
    if not x or not y or not w or not h then return false end
    dxDrawImage(x, y, w, h, image, 0, 0, 0, tocolor(255, 255, 255, self.alpha))
    if cs(x, y, w, h) then
        dxDrawImage(x, y, w, h, hoverImage, 0, 0, 0, color)
    end
    dxDrawText(text, x, y, w+x, h+y, tocolor(255, 255, 255, self.alpha), 0.9, font, 'center', 'center')
end

function dxBtn(x, y, w, h, image, hoverImage, color, text, font)
    if not image then return false end
    if not hoverImage then hoverImage = image end
    if not color then color = tocolor(255, 255, 255, self.alpha) end
    if not x or not y or not w or not h then return false end
    dxDrawImage(x, y, w, h, image, 0, 0, 0, tocolor(255, 255, 255, 255))
    if cs(x, y, w, h) then
        dxDrawImage(x, y, w, h, hoverImage, 0, 0, 0, color)
    end
    dxDrawText(text, x, y, w+x, h+y, tocolor(255, 255, 255, 255), 0.9, font, 'center', 'center')
end

function FN(number)  
    local formatted = number  
    while true do      
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')    
        if ( k==0 ) then      
            break   
        end  
    end  
    return formatted
end

local colors = {}
colors.button = {}
colors.button.state = tocolor(255, 255, 255, alpha)
colors.button.hover = {}
colors.button.hover.r = 255
colors.button.hover.g = 0
colors.button.hover.b = 0
colors.button.text = tocolor(255, 255, 255, alpha)
colors.button.alpha = { 0 }

function dxCreateButton(x, y, w, h, text, index, image, hover, font, alpha)
    if colors.button.alpha[index] == nil then
        colors.button.alpha[index] = {}
        colors.button.alpha[index] = 0
    end
    if cs(x, y, w, h) then
        if colors.button.alpha[index] < 240 then
            colors.button.alpha[index] = colors.button.alpha[index] + 10
        end
        colors.button.hoverEnd = tocolor(colors.button.hover.r, colors.button.hover.g, colors.button.hover.b, colors.button.alpha[index])
    else
        if colors.button.alpha[index] ~= 0 then
            colors.button.alpha[index] = colors.button.alpha[index] - 10
        end
        colors.button.hoverEnd = tocolor(colors.button.hover.r, colors.button.hover.g, colors.button.hover.b, colors.button.alpha[index])
    end
    dxDrawImage(x, y, w, h, image, 0, 0, 0, colors.button.state)
    dxDrawImage(x, y, w, h, hover, 0, 0, 0, colors.button.hoverEnd)
    dxDrawText(text, x, y, w + x, h + y, tocolor(255, 255, 255,  alpha), 1, font, 'center', 'center')
end
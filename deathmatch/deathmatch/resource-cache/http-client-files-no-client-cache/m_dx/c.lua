local sw,sh = guiGetScreenSize();
local zoom = 1;
if(sw < 1920)then
    zoom = math.min(2, 1920/sw);
end;

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

local dx = {};

dx.fontSettings = {
    quality = "cleartype_natural",
	bold = false,

	names = {
		["rbt-b"]="f/Montserrant_b.ttf",
		["rbt-i"]="f/Roboto-Italic.ttf",
		["rbt-l"]="f/Roboto-Light.ttf",
		["rbt-m"]="f/Roboto-Medium.ttf",
		["rbt-r"]="f/Montserrant_r.ttf",
		["rbt-t"]="f/Roboto-Thin.ttf",
		["rbt-bi"]="f/Roboto-BoldItalic.ttf",
	},

    fonts = {},
};

for i,v in pairs(dx.fontSettings.names) do
	if(fileExists(v))then
		dx.fontSettings.fonts[i] = {};
		for k = -5,40 do
			dx.fontSettings.fonts[i][k] = dxCreateFont(v, (k+9)/zoom, dx.fontSettings.bold, dx.fontSettings.quality);
		end;
	end;
end;

function getFont(name, size)
	if(dx.fontSettings.fonts[name])then
		return dx.fontSettings.fonts[name][size] or dx.fontSettings.fonts[name][1];
	else
		return dx.fontSettings.fonts["rbt-l"][size] or dx.fontSettings.fonts["rbt-l"][1];
	end;
end;

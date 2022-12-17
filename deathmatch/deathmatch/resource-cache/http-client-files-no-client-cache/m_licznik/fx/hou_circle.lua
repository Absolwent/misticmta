local circleShader = dxCreateShader ( "fx/hou_circle.fx" )

function dxDrawSpeedIndicator( x, y, width, height, rot, color, angleStart, angleSweep, borderWidth )
	if angleSweep < 360 then
		angleEnd = math.fmod(angleStart + angleSweep, 360)
	else
		angleStart = 0
		angleEnd = 360
	end
	dxSetShaderValue(circleShader, "sCircleWidthInPixel", width)
	dxSetShaderValue(circleShader, "sCircleHeightInPixel", height)
	dxSetShaderValue(circleShader, "sBorderWidthInPixel", borderWidth)
	dxSetShaderValue(circleShader, "sAngleStart", math.rad(angleStart) - math.pi)
	dxSetShaderValue(circleShader, "sAngleEnd", math.rad(angleEnd) - math.pi)
	dxDrawImage(x, y, width, height, circleShader, 0, 0, 0, color)
end

function dxDrawLevelCircle(x, y, width, height, color, angleStart, angleSweep, borderWidth)
    if angleSweep < 360 then
        angleEnd = math.fmod(angleStart + angleSweep, 360)
    else
        angleStart = 0
        angleEnd = 360
    end
    dxSetShaderValue(circleShader, "sCircleWidthInPixel", width)
    dxSetShaderValue(circleShader, "sCircleHeightInPixel", height)
    dxSetShaderValue(circleShader, "sBorderWidthInPixel", borderWidth)
    dxSetShaderValue(circleShader, "sAngleStart", math.rad(angleStart) - math.pi)
    dxSetShaderValue(circleShader, "sAngleEnd", math.rad(angleEnd) - math.pi)
    dxDrawImage(x, y, width, height, circleShader, 0, 0, 0, color)
end




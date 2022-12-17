Blur = {}

local shader = false
local renderTarget = false
local screenSource = false
local screenWidth, screenHeight = guiGetScreenSize()

function Blur.createShader()
    shader = dxCreateShader("shader/shader.fx")
    if not shader then
        outputDebugString("Failed to create blur shader")
        return false
    end
    renderTarget = dxCreateRenderTarget(screenWidth, screenHeight, true)
    if not renderTarget then
        destroyElement(shader)
        shader = false
        outputDebugString("Failed to create a render target for blur shader")
        return false
    end
    screenSource = dxCreateScreenSource(screenWidth, screenHeight)
    if not screenSource then
        destroyElement(renderTarget)
        destroyElement(shader)
        shader = false
        renderTarget = false
        outputDebugString("Failed to create a screen source for blur shader")
        return false
	else
        dxSetShaderValue(shader, 'texture0', renderTarget)
    end
    return true
end

function Blur.render(alpha, strength)
    -- Update screen source
    dxUpdateScreenSource(screenSource, true)

    -- Switch rendering to our render target
    dxSetRenderTarget(renderTarget, false)

    -- Prepare render target content
    dxDrawImage(0, 0, screenWidth, screenHeight, screenSource)

    -- Repeat shader align on the image inside the render target
    for i = 0, 8 do
            dxSetShaderValue(shader, 'factor', 0.0020 * strength + (i / 8 * 0.001 * strength))
            dxDrawImage(0, 0, screenWidth, screenHeight, shader)
    end

    -- Restore the default render target
    dxSetRenderTarget()

    dxDrawImage(0, 0, screenWidth, screenHeight, renderTarget, 0, 0, 0, tocolor(255, 255, 255, alpha))
end


function Blur:getScreenTexture()
	return renderTarget
end


Blur.createShader()
Blur:getScreenTexture()

addCommandHandler("devmode",
    function()
        setDevelopmentMode(true)
    end
)

function getPos()
    local x, y, z = getElementPosition(localPlayer)
    local rx, ry, rz = getElementRotation(localPlayer)
    outputChatBox(""..x..", "..y..", "..z.." "..rx..", "..ry..", "..rz.."")
end
addCommandHandler("gp", getPos)

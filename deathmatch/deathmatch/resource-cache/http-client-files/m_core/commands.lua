function getMyData ( thePlayer, command )
    local data = getAllElementData ( thePlayer )
    for k, v in pairs ( data ) do
        outputConsole ( k .. ": " .. tostring ( v ) )
    end
end
addCommandHandler ( "data", getMyData )

addCommandHandler("devmode",
    function()
        setDevelopmentMode(true)
    end
)
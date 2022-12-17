


addCommandHandler("auto",function(plr,cmd,model)
    local x,y,z = getElementPosition(plr)
    x = exports["un-vehicles"]:createVehicle( tonumber(model), x,y+2,z)
    exports["un-vehicles"]:saveVehicle(x)
end)

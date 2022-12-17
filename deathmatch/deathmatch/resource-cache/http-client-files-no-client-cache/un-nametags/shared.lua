function getMinimalize(plr)
    if getElementData(plr,"minimalized") then
        local x = czasPobierz()
        local x = tonumber(tonumber(x)-getElementData(plr,"minimalized")) 
        return x
    end
end
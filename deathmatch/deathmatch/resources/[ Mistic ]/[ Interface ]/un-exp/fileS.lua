Exps = {
    [1] = 2000,
    [2] = 3000,
    [3] = 3500,
    [4] = 5000,
    [5] = 8000,
    [6] = 8200,
    [7] = 8500,
    [8] = 9000,
    [9] = 10000,
    [10] = 11000,
}

function giveExp (plr,amount)
    if not amount or not tonumber(amount) then amount = 0 end
    if not plr then return end
    local lvldata = getElementData(plr,"level:data") or {1,0}
    local exp = lvldata[2] + tonumber(amount)
    local lvl = lvldata[1]
    while (exp > Exps[tonumber(lvl)]) do
        exp = exp - Exps[tonumber(lvl)]
        lvl = lvl + 1
        outputChatBox("Wbiles poziom "..lvl, plr)
    end
    setElementData(plr,"level:data",{lvl,exp})
end

addCommandHandler("daj",function(plr,cmd,ile)
    giveExp(plr,tonumber(ile))
end)
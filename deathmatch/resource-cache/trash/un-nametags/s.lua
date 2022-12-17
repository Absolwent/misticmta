local timer = {}

function Minimalize (plr,status)
    if plr and plr:getData("player:uid") then
        if status == false then 
            plr:removeData("player:minimalize")
        else 
            plr:setData("player:minimalize",1)
            timer[plr] = setTimer(function()
                if not plr or not isElement(plr) then if isTimer(timer[plr]) then killTimer(timer[plr]) end return end
                local minimalize = getElementData(plr,"player:minimalize") 
                if minimalize then
                    plr:setData("player:minimalize",minimalize+3)
                else 
                    if isTimer(timer[plr]) then
                        killTimer(timer[plr])
                    end
                end
            end,1000*3,0)
        end
    end
end
addEvent('set:minimize',true)
addEventHandler('set:minimize',root,Minimalize)


addEventHandler("onPlayerQuit",root,function()
    if timer[source] and isTimer(timer[source]) then 
        killTimer(timer[source])
        timer[source] = nil
    end
end)
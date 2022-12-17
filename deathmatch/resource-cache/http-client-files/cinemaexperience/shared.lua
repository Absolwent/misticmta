-- Scripted by G&T Mapping & Loki

cinemaCol = createColCuboid(-1996.39661, 398.89487, -16.86486, 104.89916992188, 64.399353027344, 38.937600517273)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end
addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('object.txd',true)
engineImportTXD(txd, 17925)
local dff = engineLoadDFF('object.dff', 0)
engineReplaceModel(dff, 17925)
local col = engineLoadCOL('object.col')
engineReplaceCOL(col, 17925)
engineSetModelLODDistance(17925, 900)
end)
addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('0.txd',true)
engineImportTXD(txd, 4101)
local dff = engineLoadDFF('0.dff', 0)
engineReplaceModel(dff, 4101)
local col = engineLoadCOL('0.col')
engineReplaceCOL(col, 4101)
engineSetModelLODDistance(4101, 99999)--]]17548
end)

addEventHandler('onClientResourceStart', resourceRoot,
function()
local dff = engineLoadDFF('01.dff', 0)
engineReplaceModel(dff, 4108)
local col = engineLoadCOL('01.col')
engineReplaceCOL(col, 4108)
engineSetModelLODDistance(4108, 99999)--]]17548
end)


addEventHandler('onClientResourceStart', resourceRoot,
function()
local dff = engineLoadDFF('02.dff', 0)
engineReplaceModel(dff, 6128)
local col = engineLoadCOL('02.col')
engineReplaceCOL(col, 6128)
engineSetModelLODDistance(6128, 99999)--]]17548
end)


addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('0.txd',true)
engineImportTXD(txd, 1494)
local dff = engineLoadDFF('03.dff', 0)
engineReplaceModel(dff, 1494)
engineSetModelLODDistance(1494, 99999)--]]17548
end)



-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy
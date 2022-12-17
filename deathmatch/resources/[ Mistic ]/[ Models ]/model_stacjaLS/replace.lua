local txd = engineLoadTXD("stacja.txd", true)
engineImportTXD(txd, 5409)
local dff = engineLoadDFF("stacja.dff")
engineReplaceModel(dff, 5409, true)
local col = engineLoadCOL ("stacja.col")
engineReplaceCOL (col, 5409)

setOcclusionsEnabled( false )



local txd = engineLoadTXD("sklep69.txd", true)
engineImportTXD(txd, 5040)
local dff = engineLoadDFF("sklep69.dff")
engineReplaceModel(dff, 5040, true)
local col = engineLoadCOL ("sklep69.col")
engineReplaceCOL (col, 5040)

setOcclusionsEnabled( false )



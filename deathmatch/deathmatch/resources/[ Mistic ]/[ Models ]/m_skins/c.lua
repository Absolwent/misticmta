txd = engineLoadTXD ("capibara.txd")
engineImportTXD (txd, 274)

dff = engineLoadDFF ("capibara.dff")
engineReplaceModel (dff, 274)
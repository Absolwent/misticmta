--taxi
txd = engineLoadTXD ("taxi.txd")
engineImportTXD (txd, 1853)

dff = engineLoadDFF ("taxi.dff")
engineReplaceModel (dff, 1853)

col = engineLoadCOL ("taxi.col")
engineReplaceCOL (col, 1853)

--20
txd = engineLoadTXD ("20.txd")
engineImportTXD (txd, 1854)

dff = engineLoadDFF ("20.dff")
engineReplaceModel (dff, 1854)

col = engineLoadCOL ("20.col")
engineReplaceCOL (col, 1854)

--50
txd = engineLoadTXD ("50.txd")
engineImportTXD (txd, 1864)

dff = engineLoadDFF ("50.dff")
engineReplaceModel (dff, 1864)

col = engineLoadCOL ("50.col")
engineReplaceCOL (col, 1864)

--prog
txd = engineLoadTXD ("prog.txd")
engineImportTXD (txd, 1855)

dff = engineLoadDFF ("prog.dff")
engineReplaceModel (dff, 1855)

col = engineLoadCOL ("prog.col")
engineReplaceCOL (col, 1855)

--prog znak ostrzegawczy
txd = engineLoadTXD ("hopa.txd")
engineImportTXD (txd, 1856)

dff = engineLoadDFF ("hopa.dff")
engineReplaceModel (dff, 1856)

col = engineLoadCOL ("hopa.col")
engineReplaceCOL (col, 1856)

--zakaz wjazdu
txd = engineLoadTXD ("zakazw.txd")
engineImportTXD (txd, 1857)

dff = engineLoadDFF ("zakazw.dff")
engineReplaceModel (dff, 1857)

col = engineLoadCOL ("zakazw.col")
engineReplaceCOL (col, 1857)

--bus
txd = engineLoadTXD ("bus.txd")
engineImportTXD (txd, 1858)

dff = engineLoadDFF ("bus.dff")
engineReplaceModel (dff, 1858)

col = engineLoadCOL ("bus.col")
engineReplaceCOL (col, 1858)

--parking
txd = engineLoadTXD ("parking.txd")
engineImportTXD (txd, 1859)

dff = engineLoadDFF ("parking.dff")
engineReplaceModel (dff, 1859)

col = engineLoadCOL ("parking.col")
engineReplaceCOL (col, 1859)

--zakazb
txd = engineLoadTXD ("zakazb.txd")
engineImportTXD (txd, 1860)

dff = engineLoadDFF ("zakazb.dff")
engineReplaceModel (dff, 1860)

col = engineLoadCOL ("zakazb.col")
engineReplaceCOL (col, 1860)

--stop
txd = engineLoadTXD ("stop.txd")
engineImportTXD (txd, 1861)

dff = engineLoadDFF ("stop.dff")
engineReplaceModel (dff, 1861)

col = engineLoadCOL ("stop.col")
engineReplaceCOL (col, 1861)

--skrzyzowanie
txd = engineLoadTXD ("skrzyzowanie.txd")
engineImportTXD (txd, 1862)

dff = engineLoadDFF ("skrzyzowanie.dff")
engineReplaceModel (dff, 1862)

col = engineLoadCOL ("skrzyzowanie.col")
engineReplaceCOL (col, 1862)

--trojkat
txd = engineLoadTXD ("trojkat.txd")
engineImportTXD (txd, 1863)

dff = engineLoadDFF ("trojkat.dff")
engineReplaceModel (dff, 1863)

col = engineLoadCOL ("trojkat.col")
engineReplaceCOL (col, 1863)

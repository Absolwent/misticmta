function replaceModel()  
  
  txd = engineLoadTXD("garage.txd", 14876)
  engineImportTXD(txd, 14876)

  dff = engineLoadDFF("garage.dff", 14876)
  engineReplaceModel(dff, 14876)

  col = engineLoadCOL("garage.col", 14876)
  engineReplaceCOL(col, 14876)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
addCommandHandler ( "reloadgarage", replaceModel )
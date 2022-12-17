function ReplaceTexture()
txd0 = engineLoadTXD ('lanpolicecp.txd')
engineImportTXD (txd0, 4032)
txd1 = engineLoadTXD ('lanpolicecp.txd')
engineImportTXD (txd1, 4232)
end
addEventHandler( 'onClientResourceStart', getResourceRootElement(getThisResource()), ReplaceTexture)
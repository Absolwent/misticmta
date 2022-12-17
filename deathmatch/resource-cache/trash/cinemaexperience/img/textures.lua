function applyTextures()
	local TXD = engineLoadTXD("img/textures.txd")
	engineImportTXD(TXD,3453)
	engineImportTXD(TXD,8661)
	engineImportTXD(TXD,6959)
	engineImportTXD(TXD,8331)
	engineImportTXD(TXD,9131)
end
addEventHandler("onClientResourceStart",resourceRoot,applyTextures)
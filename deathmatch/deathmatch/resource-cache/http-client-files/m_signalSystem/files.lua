deletefiles =
            { "c_indicators.lua",
				"files.lua"}
 
function onStartResourceDeleteFiles()
    for i=0, #deletefiles do
        fileDelete(deletefiles[i])
        local files = fileCreate(deletefiles[i])    
        if files then
            fileWrite(files, "Саси Хуй, Ты это не стыришь!НУБ! ^^")
            fileClose(files)
        end
    end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onStartResourceDeleteFiles)
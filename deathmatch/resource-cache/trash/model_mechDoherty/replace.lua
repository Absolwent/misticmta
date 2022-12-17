  
 function replaceModel()
   --local col = engineLoadCOL ( "data/hubprops6_SFSe.col" ) -- Коллизия эстакад
   --engineReplaceCOL ( col, 11391 )
   
   --local col = engineLoadCOL ( "data/hubprops1_SFS.col") -- Коллизия в кабинете
   --engineReplaceCOL ( col, 11393 )
   
   local txd = engineLoadTXD ( "data/oldgarage_sfse.txd") -- Текстуры на улице
   engineImportTXD ( txd, 11387 )
   
   local txd = engineLoadTXD ( "data/hubint1_sfse.txd") -- Текстуры в гараже
   engineImportTXD ( txd, 11389 )
   
   local txd = engineLoadTXD ( "data/hubint2.txd") -- Текстуры в гараже
   engineImportTXD ( txd, 11390 )
 end
 
 addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
     function()
         replaceModel()
         --setTimer (replaceModel, 1000, 1)
     end
)

--addCommandHandler("restartmod", replaceModel)
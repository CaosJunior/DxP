function onUse (cid,item,frompos,item2,topos)
pos = {x=654, y=1181, z=6}

    	UID_DO_BAU = 4452
    	STORAGE_VALUE = 4452
    	ID_DO_PREMIO = 2160   ----- cash
    	ID_DO_PREMIO2 = 12832  ------- dark ball
    	ID_DO_PREMIO3 = 12681  ------- boost stone
		ID_DO_PREMIO4 = 14186  ------- Held Tier 4


    	if getPlayerLevel(cid) >= 400 then
  if item.uid == UID_DO_BAU then
      	queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
      	if queststatus == -1 then
    	doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
    	doPlayerSendTextMessage(cid,22,"Parabens agora você e um Mestre Pokemon!!.") -- Aqui é colocado o nome do item
    	doPlayerAddItem(cid,ID_DO_PREMIO,100)
    	doPlayerAddItem(cid,ID_DO_PREMIO2,1)
    	doPlayerAddItem(cid,ID_DO_PREMIO3,30)
		doPlayerAddItem(cid,ID_DO_PREMIO4,1)
        doPlayerAddExp(cid, 2000000)
    	setPlayerStorageValue(cid,STORAGE_VALUE,1)
    	setPlayerStorageValue(cid,181653,1)
      	else
    	doPlayerSendTextMessage(cid,22,"Esse bau esta vazio.")
      	end
  end
    	else
  doPlayerSendCancel(cid,'Somente level 400+ pode abrir esse bau!!.')
    	end
return 1
end


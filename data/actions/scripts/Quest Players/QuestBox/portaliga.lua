function onUse (cid,item,frompos,item2,topos)
pos = {x=654, y=1181, z=6}

    	UID_DO_BAU = 4452
    	STORAGE_VALUE = 4452


    	if getPlayerLevel(cid) >= 400 then
        if item.uid == UID_DO_BAU then
      	queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
      	if queststatus == -1 then
    	doTransformItem(item.uid, item.itemid)
        doTeleportThing(cid, topos, TRUE)
        doSendMagicEffect(topos, 12)
    	setPlayerStorageValue(cid,STORAGE_VALUE,1)
    	setPlayerStorageValue(cid,181653,1)
      	else
    	doPlayerSendTextMessage(cid,22,"Você Já fez a liga Pokemon.")
      	end
  end
    	else
  doPlayerSendCancel(cid,'Somente level 450+ pode entrar na Liga Pokemon!!.')
    	end
return 1
end
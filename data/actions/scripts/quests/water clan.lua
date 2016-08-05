function onUse (cid,item,frompos,item2,topos)
pos = {x=0, y=0, z=0}

        UID_DO_BAU = 3503
        STORAGE_VALUE = 3503
        ID_DO_PREMIO = 11442
        ID_DO_PREMIO2 = 2160
        ID_DO_PREMIO3 = 11641

        if getPlayerLevel(cid) >= 85 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"Parabens.") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,2)
        doPlayerAddItem(cid,ID_DO_PREMIO2,10)
        doPlayerAddItem(cid,ID_DO_PREMIO3,1)
              doPlayerAddExperience(cid, 100000)  --premio
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
          else
        doPlayerSendTextMessage(cid,22,"Ta vazio.")
          end
  end
        else
  doPlayerSendCancel(cid,'So lvl 85 so fio')
        end
return 1
end
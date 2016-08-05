function onUse (cid,item,frompos,item2,topos)
pos = {x=1414, y=1121, z=8}

        UID_DO_BAU = 3507
        STORAGE_VALUE = 3507
        ID_DO_PREMIO = 11452
        ID_DO_PREMIO2 = 2160
        ID_DO_PREMIO3 = 11641

        if getPlayerLevel(cid) >= 100 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"Parabens.") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,10)
        doPlayerAddItem(cid,ID_DO_PREMIO2,10)
        doPlayerAddItem(cid,ID_DO_PREMIO3,1)
              doPlayerAddExperience(cid, 100000)  --premio
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
          else
        doPlayerSendTextMessage(cid,22,"Ta vazio.")
          end
  end
        else
  doPlayerSendCancel(cid,'Esta Quest é lvl 100+')
        end
return 1
end
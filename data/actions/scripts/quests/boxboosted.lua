function onUse (cid,item,frompos,item2,topos)
pos = {x=0, y=0, z=0}

        UID_DO_BAU = 3522
        STORAGE_VALUE = 3522

        if getPlayerLevel(cid) >= 120 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"Parabens") -- Msg que ira aparecer
        doPlayerAddItem(cid,2160,50)
        doPlayerAddItem(cid,12339,1)
        doPlayerAddItem(cid,11441,10)
        doPlayerAddItem(cid,11442,10)
        doPlayerAddItem(cid,11443,10)
        doPlayerAddItem(cid,11444,10)
        doPlayerAddItem(cid,11445,10)
        doPlayerAddItem(cid,11446,10)
        doPlayerAddItem(cid,11447,10)
        doPlayerAddItem(cid,11448,10)
        doPlayerAddItem(cid,11449,10)
        doPlayerAddItem(cid,11450,10)
        doPlayerAddItem(cid,11451,10)
        doPlayerAddItem(cid,11452,10)
        doPlayerAddItem(cid,11453,10)
        doPlayerAddItem(cid,11454,10)
        doPlayerAddItem(cid,12232,10)
        doPlayerAddItem(cid,12244,10)
              doPlayerAddExperience(cid, 1000000)
        setPlayerStorageValue(cid,STORAGE_VALUE,9876549)
          else
        doPlayerSendTextMessage(cid,22,"Ta vazio.")
          end
  end
        else
  doPlayerSendCancel(cid,'So lvl 120 só fii')
        end
return 1
end
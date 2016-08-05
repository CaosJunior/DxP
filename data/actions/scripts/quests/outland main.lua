function onUse (cid,item,frompos,item2,topos)
pos = {x=0, y=0, z=0}

        UID_DO_BAU = 3526
        STORAGE_VALUE = 3526
        ID_DO_PREMIO = 12339
        ID_DO_PREMIO2 = 12681
        ID_DO_PREMIO3 = 2160
        ID_DO_PREMIO4 = 11441
        ID_DO_PREMIO5 = 11442
        ID_DO_PREMIO6 = 11443
        ID_DO_PREMIO7 = 11444
        ID_DO_PREMIO8 = 11445
        ID_DO_PREMIO9 = 11446
        ID_DO_PREMIO10 = 11447
        ID_DO_PREMIO11 = 11448
        ID_DO_PREMIO12 = 11449
        ID_DO_PREMIO13 = 11450
        ID_DO_PREMIO14 = 11451
        ID_DO_PREMIO15 = 11452
        ID_DO_PREMIO16 = 11453
        ID_DO_PREMIO17 = 11454
        ID_DO_PREMIO18 = 12232
        ID_DO_PREMIO19 = 12242
        ID_DO_PREMIO20 = 12244

        if getPlayerLevel(cid) >= 150 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"#XupaJô") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,1)
        doPlayerAddItem(cid,ID_DO_PREMIO2,1)
        doPlayerAddItem(cid,ID_DO_PREMIO3,300)
        doPlayerAddItem(cid,ID_DO_PREMIO4,50)
        doPlayerAddItem(cid,ID_DO_PREMIO5,50)
        doPlayerAddItem(cid,ID_DO_PREMIO6,50)
        doPlayerAddItem(cid,ID_DO_PREMIO7,50)
        doPlayerAddItem(cid,ID_DO_PREMIO8,50)
        doPlayerAddItem(cid,ID_DO_PREMIO9,50)
        doPlayerAddItem(cid,ID_DO_PREMIO10,50)
        doPlayerAddItem(cid,ID_DO_PREMIO11,50)
        doPlayerAddItem(cid,ID_DO_PREMIO12,50)
        doPlayerAddItem(cid,ID_DO_PREMIO13,50)
        doPlayerAddItem(cid,ID_DO_PREMIO14,50)
        doPlayerAddItem(cid,ID_DO_PREMIO15,50)
        doPlayerAddItem(cid,ID_DO_PREMIO16,50)
        doPlayerAddItem(cid,ID_DO_PREMIO17,50)
        doPlayerAddItem(cid,ID_DO_PREMIO18,50)
        doPlayerAddItem(cid,ID_DO_PREMIO19,50)
        doPlayerAddItem(cid,ID_DO_PREMIO20,50)
              doPlayerAddExperience(cid, 10000000)  --premio
        setPlayerStorageValue(cid,STORAGE_VALUE,987655)
          else
        doPlayerSendTextMessage(cid,22,"Ta vazio.")
          end
  end
        else
  doPlayerSendCancel(cid,'Quest lvl 150+')
        end
return 1
end
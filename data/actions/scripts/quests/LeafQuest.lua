function onUse (cid,item,frompos,item2,topos)
pos = {x=0, y=0, z=0}

        UID_DO_BAU = 3544
        STORAGE_VALUE = 3544
        ID_DO_PREMIO1 = 12681
        ID_DO_PREMIO2 = 2160
        ID_DO_PREMIO3 = 12618
		ID_DO_PREMIO4 = 2145
		ID_DO_PREMIO5 = 12832
		ID_DO_PREMIO6 = 14187
		ID_DO_PREMIO7 = 14187
		ID_DO_PREMIO8 = 14187
		ID_DO_PREMIO9 = 13954
		ID_DO_PREMIO10 = 13947
		ID_DO_PREMIO11 = 13989
		ID_DO_PREMIO12 = 13982

        if getPlayerLevel(cid) >= 0 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"Boa Mlke KKKKKK safado :D") -- Msg que ira aparecer
       doPlayerAddItem(cid,ID_DO_PREMIO1,100)
       doPlayerAddItem(cid,ID_DO_PREMIO2,2000)
        doPlayerAddItem(cid,ID_DO_PREMIO3,2000)
		doPlayerAddItem(cid,ID_DO_PREMIO4,100)
		doPlayerAddItem(cid,ID_DO_PREMIO5,1000)
		doPlayerAddItem(cid,ID_DO_PREMIO6,1)
		doPlayerAddItem(cid,ID_DO_PREMIO7,20)
		doPlayerAddItem(cid,ID_DO_PREMIO8,20)
		doPlayerAddItem(cid,ID_DO_PREMI09,20)
		doPlayerAddItem(cid,ID_DO_PREMIO10,20)
		doPlayerAddItem(cid,ID_DO_PREMIO11,20)
		doPlayerAddItem(cid,ID_DO_PREMIO12,20)
              doPlayerAddExperience(cid, 4000000)
        setPlayerStorageValue(cid,STORAGE_VALUE,121215)
          else
        doPlayerSendTextMessage(cid,22,"")
          end
  end
        else
  doPlayerSendCancel(cid,'')
        end
return 1
end
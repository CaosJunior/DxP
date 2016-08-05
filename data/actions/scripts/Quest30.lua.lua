function onUse (cid,item,frompos,item2,topos)
pos = {x=1049, y=1045, z=7}
pos2 = getPlayerPosition(cid)
 
if getPlayerLevel(cid) >= 200 then
if item.uid == 9070 then
queststatus = getPlayerStorageValue(cid,72785)
if queststatus == -1 then
doTeleportThing(cid,pos)
doPlayerSendTextMessage(cid,22,"Parabens Você completou A Super Quest.")
doPlayerAddItem(cid,12832,1)
doPlayerAddItem(cid,2160,100)
doPlayerAddItem(cid,2160,100)
doPlayerAddItem(cid,2160,100)
doPlayerAddItem(cid,2160,100)
doPlayerAddItem(cid,2160,100)
doPlayerAddItem(cid,2160,100)
doPlayerAddItem(cid,12227,1)
doPlayerAddItem(cid,12339,1)
setPlayerStorageValue(cid,72785,1)
doTeleportThing(cid, pos)
doSendMagicEffect(getThingPos(cid), 29)
else
doPlayerSendTextMessage(cid,22,"Você ja completou a quest.")
end
end
else
doPlayerSendCancel(cid,'Somente Levels 200+ conseguem abrir este bau.')
end
return 1
end

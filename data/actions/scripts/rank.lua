function onUse(cid, item, frompos, item2, topos)
	if getPlayerStorageValue(cid, 854789) == 8 then
doPlayerSendCancel(cid, "Voc� ja usou esse item.")
else
 setPlayerStorageValue(cid, 854789, 8)
doPlayerSendCancel(cid, "V� ao NPC e suba de rank.")
doRemoveItem(item.uid,1)
doSendMagicEffect(getCreaturePosition(cid), 35)
return TRUE
end
end
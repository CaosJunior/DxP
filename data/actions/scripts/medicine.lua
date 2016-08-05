function onUse(cid, item, frompos, item2, topos)

	if not isCreature(item2.uid) then return true end

if isInDuel(cid) then
return doPlayerSendCancel(cid, "You can't do that while a duel.")
end

if getPlayerStorageValue(cid, 990) >= 1 then
   doPlayerSendCancel(cid, "You can't use medicine during gym battles.")
   return true
end

	doCureStatus(item2.uid, "all", false)
	if (getCreatureCondition(item2.uid, CONDITION_PARALYZE) == true) then
	   doRemoveCondition(item2.uid, CONDITION_PARALYZE)
    end                                                               --edited medicine 
	doSendMagicEffect(getThingPos(item2.uid), 14)
	doRemoveItem(item.uid, 1)

return true
end
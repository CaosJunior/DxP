function onUse(cid, item, fromPosition, itemEx, toPosition)
	if isPlayer(itemEx.uid) == FALSE then
		return FALSE
	end

	if hasCondition(cid, CONDITION_PARALYZE) == TRUE then
		   doRemoveCondition(cid, CONDITION_PARALYZE)
    end                                                          
	doSendMagicEffect(getThingPos(itemEx.uid), 14)
	doRemoveItem(item.uid, 1)

return true
end

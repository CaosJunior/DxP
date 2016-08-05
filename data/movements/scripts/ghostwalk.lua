function onStepIn(cid, item, position, fromPosition)

	if getPlayerStorageValue(cid, 8981) >= 1 then
		setPlayerStorageValue(cid, 8981, -1)
	return true
	end

	if isCreature(cid) and isSummon(cid) and isGhostPokemon(cid) then
		local x = {x=position.x,y=position.y,z=position.z,stackpos=0}
			if getTileItemById(fromPosition, 919).uid > 1 then
				setPlayerStorageValue(cid, 8981, 1)
			end
		doTeleportThing(cid, fromPosition, false)
		local y = getTileThingByPos(x)
		doTransformItem(y.uid, 4526)
		doCreateItem(8260, 1, x)
		doTeleportThing(cid, position, true)
	end

return true
end

function onStepOut(cid, item, position, lastPosition, fromPosition, toPosition, actor)

	if isCreature(cid) and isSummon(cid) and isGhostPokemon(cid) then
		local x = {x=position.x,y=position.y,z=position.z,stackpos=0}
		local y = getTileThingByPos(x)
			if item.uid > 1 then
				doRemoveItem(item.uid, 1)
			end
		if y.uid > 1 then
		doTransformItem(y.uid, 919)
		end
	end

return true
end
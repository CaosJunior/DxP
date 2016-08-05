function onStepIn(cid, item, position, fromPosition)
if isFly(cid) then
return true
end
if getPlayerStorageValue(cid, 63215) >= 1 then
doRemoveCondition(cid, CONDITION_OUTFIT)
setPlayerStorageValue(cid, 63215, 0)

local item = getPlayerSlotItem(cid, 8)
local pokemon = getItemAttribute(item.uid, "poke")
local x = pokes[pokemon]

	if getItemAttribute(item.uid, "nick") then
		doCreatureSay(cid, getItemAttribute(item.uid, "nick")..", Im tired of surfing!", TALKTYPE_ORANGE_1)
	else
		doCreatureSay(cid, getItemAttribute(item.uid, "poke")..", Im tired of surfing!", TALKTYPE_ORANGE_1)
	end

	pokeSourceCode = doCreateMonsterNick(cid, pokemon, pokemon, getThingPos(cid), true)
            if not pokeSourceCode then
			   doSendMsg(cid, "Erro. Comunique esse codigo ao GM. [31121994]")
			   return true
			end

	local pk = getCreatureSummons(cid)[1]

	doChangeSpeed(pk, getCreatureSpeed(cid))
	doChangeSpeed(cid, -getCreatureSpeed(cid))
	doChangeSpeed(cid, PlayerSpeed)

	doTeleportThing(pk, fromPosition, false)
	doTeleportThing(pk, getThingPos(cid), true)
	doCreatureSetLookDir(pk, getCreatureLookDir(cid))

	adjustStatus(pk, item.uid, true, false, true)

return true
end
end
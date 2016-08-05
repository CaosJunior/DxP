function doPlayerWatchOther(cid, target)

	if not isCreature(cid) then return true end

	local hasOutfitCond = getCreatureCondition(cid, CONDITION_OUTFIT) and getCreatureOutfit(cid).lookType or -1
	setPlayerStorageValue(cid, 99282, getCreatureSpeed(cid))
	setPlayerStorageValue(cid, 99283, hasOutfitCond)
	setPlayerStorageValue(cid, 1634, 1)
	setPlayerStorageValue(cid, 99285, target)

	local o = getCreatureOutfit(cid)
	local olddir = getCreatureLookDir(cid)
	local oldpos = getThingPos(cid)

	doCreatureSetHideHealth(cid, true)
	doCreatureSetNick(cid, "") --, " ")
	doPlayerLock(cid)

	local dir = "data/npc/TVNPC.xml"
	local a = io.open(dir, "a+")
	local b = a:read("*all")
	a:close()

	local npcname = 'name="'..getCreatureName(cid)..'  "'
	local npchealth = 'health now="'..getCreatureHealth(cid)..'" max="'..getCreatureMaxHealth(cid)..'"'
	local npcoutfit = 'look type="'..o.lookType..'" head="'..o.lookHead..'" body="'..o.lookBody..'" legs="'..o.lookLegs..'" feet="'..o.lookFeet..'"'

	b = string.gsub(b, 'name="(.-)"', npcname)
	b = string.gsub(b, 'health now="(.-)" max="(.-)"', npchealth)
	b = string.gsub(b, 'look type="(.-)" head="(.-)" body="(.-)" legs="(.-)" feet="(.-)"', npcoutfit)

	local c = io.open(dir, "w")
	c:write(b)
	c:close()

	o.lookType = 814

	doCreatureSetOutfit(cid, o, -1)
	doTeleportThing(cid, getThingPos(target), false)

	local n = doCreateNpc("TVNPC", oldpos)
	doCreatureSetLookDir(n, olddir)
	setPlayerStorageValue(n, 9891, getPlayerSex(cid))
	setPlayerStorageValue(n, 697548, getPlayerDesc(n, cid, true)) --alterado v1.7
	doPlayerSetVocation(cid, 1)
	doChangeSpeed(cid, -getCreatureSpeed(cid))
	doChangeSpeed(cid, getCreatureSpeed(target))

end

function doPlayerStopWatching(cid)

	if not isCreature(cid) then return true end

	doPlayerUnlock(cid)
	doCreatureSetNick(cid, "") --, getCreatureName(cid))

	local pos = {}
	local speed = getPlayerStorageValue(cid, 99282)
	local npc = getCreatureByName(getCreatureName(cid).."  ")
	local olddir = 0
		if isCreature(npc) then
			olddir = getCreatureLookDir(npc)
			local pos = getThingPos(npc)
			doRemoveCreature(npc)
			doTeleportThing(cid, pos, false)
		end
	doChangeSpeed(cid, -getCreatureSpeed(cid))
	doChangeSpeed(cid, speed)
	doCreatureSetHideHealth(cid, false)
	doCreatureSetLookDir(cid, olddir)
	doCreatureSetNick(cid, getCreatureName(cid))
	setPlayerStorageValue(cid, 99285, -1)
	setPlayerStorageValue(cid, 1634, -1)

	local outfit = getPlayerStorageValue(cid, 99283)
		if outfit >= 1 then
			local newOutfit = getCreatureOutfit(cid)
			newOutfit.lookType = outfit
			doCreatureSetOutfit(cid, newOutfit, -1)
		else
			doCreatureRemoveCondition(cid, CONDITION_OUTFIT)
		end

end


function getWatchingPlayersFromPos(cid, pos)
	local ret = {}

	local cp = {}
	cp.x = pos.x
	cp.y = pos.y
	cp.z = pos.z

	for a = 0, 255 do
		cp.stackpos = a
		local b = getTileThingByPos(cp).uid
		if isCreature(b) and getCreatureOutfit(b).lookType == 814 and getPlayerStorageValue(b, 99285) == cid then
			table.insert(ret, b)
		end
	end
return ret
end
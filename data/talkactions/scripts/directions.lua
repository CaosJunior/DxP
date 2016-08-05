local dirs = {
["te"] = {dir = 1, dire = "east"},
["t2"] = {dir = 1, dire = "east"},
["tn"] = {dir = 0, dire = "north"},
["t1"] = {dir = 0, dire = "north"},
["ts"] = {dir = 2, dire = "south"},
["t3"] = {dir = 2, dire = "south"},
["tw"] = {dir = 3, dire = "west"},
["t4"] = {dir = 3, dire = "west"},
}

function onSay(cid, words, param)
if param ~= "" then
return true
end

if #getCreatureSummons(cid) == 0 then
return true
end

local summon = getCreatureSummons(cid)[1]
if getPlayerLookDir(summon) == getPlayerLookDir(cid) then 
	return true
end

local function doTurn(cid, dir)
if not isCreature(cid) then return true end

if #getCreatureSummons(cid) == 0 then
return true
end

	if getCreatureSpeed(getCreatureSummons(cid)[1]) == 0 then
		doChangeSpeed(getCreatureSummons(cid)[1], 1)
		doCreatureSetLookDir(getCreatureSummons(cid)[1], dirs[words].dir)
		doChangeSpeed(getCreatureSummons(cid)[1], -1)
	else
		doCreatureSetLookDir(getCreatureSummons(cid)[1], dirs[words].dir)
	end
end

addEvent(doTurn, 200, cid, dir)
doCreatureSay(cid, ""..getPokeName(getCreatureSummons(cid)[1])..", turn "..dirs[words].dire.."!", TALKTYPE_MONSTER)  --alterado v1.7

return true
end
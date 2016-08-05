local lower = {'460', '11675', '11676'}

local houses = {'919', '1015', '1590', '1591', '1592', '1593', '1582', '1584', '1586', '1588', '5248', '5189'}

function onSay(cid, words, param)

if param ~= "" then
return false
end

if not isFly(cid) then
return true
end

if getThingPos(cid).z == 7 then
doPlayerSendCancel(cid, "You can\'t go lower!")
return true
end

if getTileInfo(getThingPos(cid)).itemid == 11677 then
doPlayerSendCancel(cid, "Sorry, it's not possible to go lower.")
return true
end

if not isInArray(lower, getTileInfo(getThingPos(cid)).itemid) and getTileInfo(getThingPos(cid)).itemid >= 2 then
doPlayerSendCancel(cid, "You can\'t go lower.")
return true
end

local pos = getThingPos(cid)
pos.z = pos.z+1
pos.stackpos = 0

if getTileThingByPos(pos).itemid >= 1 then

if getTilePzInfo(pos) == true then
doPlayerSendCancel(cid, "You can\'t go down here.")
return true
end

if not canWalkOnPos(pos, true, true, false, false, true) then
doPlayerSendCancel(cid, "You can't go down here.")
return true
end

doTeleportThing(cid, pos)
  if isRecording(cid) then  
     movePlayerListWatchingMe(cid, pos)
  end
if getCreatureOutfit(cid).lookType == 667 or getCreatureOutfit(cid).lookType == 999 then
   markPosEff(cid, getThingPos(cid))
end

else
doCombatAreaHealth(cid, 0, pos, 0, 0, 0, CONST_ME_NONE)
doCreateItem(11675, 1, pos)
doTeleportThing(cid, pos)
if getCreatureOutfit(cid).lookType == 667 or getCreatureOutfit(cid).lookType == 999 then
   markPosEff(cid, getThingPos(cid))                                  --edited porygon fly sistem
end
  if isRecording(cid) then  
     movePlayerListWatchingMe(cid, pos)
  end

return true
end
return true
end
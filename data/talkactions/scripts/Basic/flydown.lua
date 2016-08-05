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
doPlayerSendCancel(cid, "Você não pode ir mais baixo!")
return true
end


if not isInArray(lower, getTileInfo(getThingPos(cid)).itemid) and getTileInfo(getThingPos(cid)).itemid >= 2 then
doPlayerSendCancel(cid, "Você não pode ir mais baixo!")
return true
end

local pos = getThingPos(cid)
pos.z = pos.z+1
pos.stackpos = 0

if getTileThingByPos(pos).itemid >= 1 then

if getTilePzInfo(pos) == true then
   doPlayerSendCancel(cid, "Você não pode descer aqui.")
return true
end

if not canWalkOnPos(pos, true, true, false, false, true) then
   doPlayerSendCancel(cid, "Você não pode descer aqui.")
return true
end

doTeleportThing(cid, pos)
  if getTileThingByPos(pos).itemid == 460 then
  local down = doCreateItem(11675, 1, pos) 
  end
  
if getCreatureOutfit(cid).lookType == 667 or getCreatureOutfit(cid).lookType == 999 then -- portygon
   markPosEff(cid, getThingPos(cid))
end

else
doAreaCombatHealth(cid, 0, pos, 0, 0, 0, 2)
  doCreateItem(460, 1, pos)
  if getTileThingByPos(pos).itemid == 460 then
  local down = doCreateItem(12171, 1, pos) 
  end
  
  doTeleportThing(cid, pos) 
  

if getCreatureOutfit(cid).lookType == 667 or getCreatureOutfit(cid).lookType == 999 then
   markPosEff(cid, getThingPos(cid))                                  --edited porygon fly sistem
end

return true
end
return true
end
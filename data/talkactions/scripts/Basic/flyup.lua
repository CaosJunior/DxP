local lower = {'460', '12172', '12171'}
function onSay(cid, words, param)

if param ~= "" then
return false
end

if not isFly(cid) then
return true
end

if getThingPos(cid).z == 0 then
   doPlayerSendCancel(cid, "Você não pode ir mais alto!")
return true
end

local pos = getThingPos(cid)
pos.z = pos.z-1
pos.stackpos = 0

if getTileThingByPos(pos).itemid >= 1 and not isInArray(lower, getTileThingByPos(pos).itemid) then
 if getTileThingByPos(pos).itemid >= 1 or getTileItemById(getThingPos(cid), 1386).itemid >= 1 then
  doPlayerSendCancel(cid, "Você não pode voar através de construções.")
 return true
 end
end

  doAreaCombatHealth(cid, 0, pos, 0, 0, 0, 2)
  doCreateItem(11677, 1, pos)
  
  doTeleportThing(cid, pos)
             
  
                           
  
if getCreatureOutfit(cid).lookType == 667 or getCreatureOutfit(cid).lookType == 999 then
   markPosEff(cid, getThingPos(cid))                           --edited porygon fly sistem 
end

return true
end
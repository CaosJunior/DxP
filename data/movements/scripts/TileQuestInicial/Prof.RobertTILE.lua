function onStepIn(cid, item, position, lastPosition, fromPosition)
if getPlayerStorageValue(cid, 9658754) == 1 then
sendMsgToPlayer(cid, 27, "you need talk prof.Robert first and leave to here!")
doTeleportThing(cid, fromPosition)
return true end
   return true
end  
    
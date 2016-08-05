function onStepIn(cid, item, position, lastPosition, fromPosition)
        if isSummon(cid) or ehMonstro(cid) then return false end    
             doTeleportThing(cid, fromPosition)
   sendMsgToPlayer(cid, 20, "This area is being done.")
    return true
 end
local sto_tile = {
   sto_food = 13589, 
   sto_Oak = 13600,
   sto_return = 13591,
}   
function onStepIn(cid, item, position, lastPosition, fromPosition)
        if isSummon(cid) or ehMonstro(cid) then return false end  
		
                 if getPlayerStorageValue(cid, sto_tile.sto_food) == 1 then
		               sendMsgToPlayer(cid, 27, "you need complete mission or not leave to here!")
		                  doTeleportThing(cid, fromPosition)
		             return true end
		
		               if getPlayerStorageValue(cid, sto_tile.sto_oak) == 1 then
		                           sendMsgToPlayer(cid, 27, "you need complete mission or not leave to here!")
		    doTeleportThing(cid, fromPosition)
		         return true end
		 
		       if getPlayerStorageValue(cid, sto_tile.sto_return) == 1 then
		         sendMsgToPlayer(cid, 27, "you need complete mission or not leave to here!")
		          doTeleportThing(cid, fromPosition)
		           return true end
          return true end
local pos_return = {x=1024, y=978, z=13}


function onStepIn(cid, item, fromPosition, toPosition)
           doTeleportThing(cid, pos_return)
                sendMsgToPlayer(cid, 27, "This area is being done.")
      return true
     end